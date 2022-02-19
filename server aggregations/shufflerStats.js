db.getCollection("matches").aggregate(

	// Pipeline
	[
		// Stage 1
		{
			// TODO rewrite to check for range from max of handStats to 10 minutes ago
			$match: {
			  $and: [{ date: { $gt: "2019-01-31T00:00:00.000Z" } }, { date: { $lt: "2019-05-29T00:00:00.000Z" } }],
        "gameStats.0.handsDrawn": { $exists: true },
        // The March 2019 update to Arena changed the format of most logged decklists, requiring a hotfix update to Tool
        // to handle it. Any games recorded by the previous version of Tool after Arena updated almost certainly have
        // missing or incorrect decklists, so filter them out.
        $or: [
          // Version 2.2.21 had the fix.
          { toolVersion: { $gte: NumberInt(131605) } },
          // Before the Arena update is also ok.
          { date: { $lt: "2019-03-27T12:00:00.000Z" } }
        ],
        // When Tool is run from source, it may contain experimental or in-development changes that have not been fully
        // tested and reviewed to ensure they do not produce inaccurate or incorrectly formatted data.
        toolRunFromSource: { $ne: true },
        // userid of the opponent in tutorial/color challenge matches starts with the player's userid. These matches
        // have stacked decks, not real shuffling, so filter them out.
        $expr: {
			    $eq: [
            { $indexOfBytes: ["$opponent.userid", "$player.userid"] },
            NumberInt(-1)
          ]
        }
			}
		},

    // Stage 2
    {
      $sort: { date: NumberInt(1) }
    },

    // Stage 3
    {
      $limit: NumberInt(1000)
    },

		// Stage 4
		{
      // By this point, we have the (at most) 1000 earliest matches that both are in the target date range and have
      // shuffler data. Now trim out the non relevant fields.
			$project: {
			  _id: NumberInt(0),
				date: NumberInt(1),
        bestOf: NumberInt(1),
        eventId: NumberInt(1),
        gameStats: NumberInt(1),
				toolVersion: NumberInt(1),
        mulliganType: {
			    $cond: {
			      if: { $or: [{ $eq: ["$eventId", "Lore_WAR3_Singleton"] }, { $gt: ["$date", "2019-07-02T15:00:00.000Z"] }] },
            then: "london",
            else: "vancouver"
          }
        },
        // Older logs had the card id as a quoted string in deck definitions. Other places, and deck definitions in
        // newer logs, have it as an int. Convert here to standardize for later stages.
        originalDeck: {
			    mainDeck: {
            $map: {
              // Accurately reflecting the order and exact card ids of decklists was originally not a design requirement
              // for Tool. Eventually a separate field was added to explicitly save that information, allowing changes
              // to the existing fields without losing it.
              input: { $ifNull: ["$playerDeck.arenaMain", "$playerDeck.mainDeck"] },
              as: "card",
              in: {
                id: { $toInt: "$$card.id" },
                quantity: "$$card.quantity"
              }
            }
          },
          sideboard: {
            $map: {
              input: { $ifNull: ["$playerDeck.arenaSide", "$playerDeck.sideboard"] },
              as: "card",
              in: {
                id: { $toInt: "$$card.id" },
                quantity: "$$card.quantity"
              }
            }
          }
        },
        shuffledOrderLengths: {
			    $map: {
			      input: "$gameStats",
            as: "game",
            in: { $size: { $ifNull: ["$$game.shuffledOrder", []] } }
          }
        },
        sideboardAdditions: {
			    $reduce: {
			      input: { $slice: ["$gameStats", NumberInt(1), { $size: { $ifNull: ["$gameStats", []] } }] },
            initialValue: [[]],
            in: {
			        $concatArrays: [
			          "$$value",
                [
                  {
                    $concatArrays: [
                      { $arrayElemAt: ["$$value", NumberInt(-1)] },
                      {
                        $map: {
                          input: "$$this.sideboardChanges.added",
                          as: "card",
                          in: { $toInt: "$$card" }
                        }
                      }
                    ]
                  }
                ]
              ]
            }
          }
        },
        sideboardRemovals: {
          $reduce: {
            input: { $slice: ["$gameStats", NumberInt(1), { $size: { $ifNull: ["$gameStats", []] } }] },
            initialValue: [[]],
            in: {
              $concatArrays: [
                "$$value",
                [
                  {
                    $concatArrays: [
                      { $arrayElemAt: ["$$value", NumberInt(-1)] },
                      {
                        $map: {
                          input: "$$this.sideboardChanges.removed",
                          as: "card",
                          in: { $toInt: "$$card" }
                        }
                      }
                    ]
                  }
                ]
              ]
            }
          }
        }
      }
		},

		// Stage 5
		{
      // gameStats is where all the shuffler data is.
			$unwind: {
			  path : "$gameStats",
				includeArrayIndex: "gameIndex"
			}
		},

		// Stage 6
    {
      $match: {
        // The overwhelming majority of games have either 40 or 60 card decks. Track only those games to keep space
        // requirements down.
        "gameStats.deckSize": { $in: [NumberInt(40), NumberInt(60)] },
        // Occasionally a game is conceded before even the first opening hand is drawn. Filter out such games.
        "gameStats.handsDrawn": { $ne: [] },
        // There was a brief period where the latest build (a prerelease) might in some circumstances not stop recording
        // cards when it got to an unknown one. Filter out any affected games.
        "gameStats.shuffledOrder": { $ne: null },
        $and: [
          {
            // The February 2019 update broke Tool's sideboard tracking. The Tool release that fixed it also added the
            // toolVersion field. Filter out any game that is a) after the Feb update, b) potentially sideboarded, and
            // c) before the sideboard tracking fix. Inverting those conditions, this keeps games that are before the
            // Feb update, the first game in a match, or after the sideboard tracking fix.
            $or: [
              {
                "gameIndex": NumberInt(0)
              },{
                "toolVersion": { $exists: true }
              },{
                "date": { $lt: "2019-02-14T15:00:00.000Z" }
              }
            ],
          },
          // Tool versions 2.5.9 and 2.5.10, and 3.0.0 through 3.0.8 had completely nonfunctional sideboarding tracking,
          // filter out affected games.
          {
            $or: [
              {
                "gameIndex": NumberInt(0)
              },{
                $and: [
                  { "toolVersion": { $nin: [NumberInt(132361), NumberInt(132362)] } },
                  {
                    $or: [
                      { "toolVersion": { $lt: NumberInt(196608) } },
                      { "toolVersion": { $gt: NumberInt(196616) } }
                    ]
                  }
                ]
              }
            ]
          },
          {
            // There should be vanishingly few games with the same card in multiple places in the decklist, but check
            // anyway just in case. Keep only games with the same number of unique cards as entries in the decklist.
            $expr: {
              $eq: [
                { $size: { $ifNull: ["$originalDeck.mainDeck", []] } },
                {
                  $size: {
                    $ifNull: [
                      {
                        // Find unique card ids. Have to work around the fact that the various set operators only work
                        // with an array of expressions, not an expression that evaluates to an array. So, using $reduce.
                        $reduce: {
                          input: "$originalDeck.mainDeck",
                          initialValue: [],
                          in: {
                            $setUnion: ["$$value", ["$$this.id"]]
                          }
                        }
                      },
                      []
                    ]
                  }
                }
              ]
            }
          },
          {
            // A small portion of games have incomplete hand data, whether due to an unrecognized card or some other
            // reason. Check that all recorded hands are the correct size.
            $expr: {
              $eq: [
                // Require 0 incorrect hand sizes.
                NumberInt(0),
                {
                  // Count how many hands have the wrong size.
                  $size: {
                    $ifNull: [
                      {
                        $filter: {
                          input: { $range: [NumberInt(0), { $size: { $ifNull: ["$gameStats.handsDrawn", []] } }] },
                          as: "index",
                          cond: {
                            $ne: [
                              // Expected size of this hand.
                              {
                                // Vancouver mulligan draws 1 less each time, London does not.
                                $cond: {
                                  if: {
                                    $or: [
                                      { $eq: ["$mulliganType", "vancouver"] },
                                      // Tool's recording of the final kept hand wasn't updated for London mulligan
                                      // until version 3.0.6.
                                      {
                                        $and: [
                                          { $lt: ["$toolVersion", NumberInt(196614)] },
                                          { $eq: [{ $add: ["$$index", NumberInt(1)] }, { $size: { $ifNull: ["$gameStats.handsDrawn", []] } }] }
                                        ]
                                      }
                                    ]
                                  },
                                  then: { $subtract: [NumberInt(7), "$$index"] },
                                  else: NumberInt(7)
                                }
                              },
                              // Actual recorded size of this hand.
                              { $size: { $ifNull: [{ $arrayElemAt: ["$gameStats.handsDrawn", "$$index"] }, []] } }
                            ]
                          }
                        }
                      },
                      []
                    ]
                  }
                }
              ]
            }
          }
        ]
      }
    },

    // Stage 7
    {
      $addFields: {
        // It is possible for the decklist to change, even drastically, in sideboarding. The sideboarded decklist is now
        // included in the stats for games 2 and 3, replace the base decklist with it for those games.
        deck: {
          $switch: {
            branches: [
              {
                case: { $eq: ["$gameIndex", NumberInt(0)] },
                then: "$originalDeck"
              }, {
                case: { $eq: [{ $type: "$gameStats.deck" }, "object"] },
                then: {
                  // Accurately reflecting the order and exact card ids of decklists was originally not a design
                  // requirement for Tool. Eventually a separate field was added to explicitly save that information,
                  // allowing changes to the existing fields without losing it. $originalDeck handling for that is done
                  // before this point.
                  mainDeck: { $ifNull: ["$gameStats.deck.arenaMain", "$gameStats.deck.mainDeck"] },
                  sideboard: { $ifNull: ["$gameStats.deck.arenaSide", "$gameStats.deck.sideboard"] }
                }
              }
            ],
            // This is only reached for games 2 and 3 that don't have sideboarded decklists, in which case we want to
            // pass through the lack of it.
            default: "$gameStats.deck"
          }
        },
        // While full details of the sideboarded decklist including order were not recorded at first, the additions and
        // removals done in sideboarding were, and not all of the checks and stats require order information.
        unorderedDeck: {
          $switch: {
            branches: [
              { case: { $eq: ["$gameIndex", NumberInt(0)] }, then: "$originalDeck" },
              { case: { $eq: [{ $type: "$gameStats.deck" }, "object"] }, then: "$gameStats.deck" },
            ],
            default: {
              mainDeck: {
                $let: {
                  vars: {
                    cardIdsAdded: {
                      $setDifference: [
                        { $arrayElemAt: ["$sideboardAdditions", "$gameIndex"] },
                        {
                          $map: {
                            input: "$originalDeck.mainDeck",
                            as: "card",
                            in: "$$card.id"
                          }
                        }
                      ]
                    }
                  },
                  in: {
                    $filter: {
                      input: {
                        $concatArrays: [
                          {
                            $map: {
                              input: "$originalDeck.mainDeck",
                              as: "card",
                              in: {
                                id: "$$card.id",
                                quantity: {
                                  $subtract: [
                                    {
                                      $add: [
                                        "$$card.quantity",
                                        {
                                          $size: {
                                            $ifNull: [
                                              {
                                                $filter: {
                                                  input: { $arrayElemAt: ["$sideboardAdditions", "$gameIndex"] },
                                                  as: "added",
                                                  cond: { $eq: ["$$added", "$$card.id"] }
                                                }
                                              },
                                              []
                                            ]
                                          }
                                        }
                                      ]
                                    },
                                    {
                                      $size: {
                                        $ifNull: [
                                          {
                                            $filter: {
                                              input: { $arrayElemAt: ["$sideboardRemovals", "$gameIndex"] },
                                              as: "removed",
                                              cond: { $eq: ["$$removed", "$$card.id"] }
                                            }
                                          },
                                          []
                                        ]
                                      }
                                    }
                                  ]
                                }
                              }
                            }
                          },
                          {
                            $map: {
                              input: "$$cardIdsAdded",
                              as: "id",
                              in: {
                                id: "$$id",
                                quantity: {
                                  $subtract: [
                                    {
                                      $size: {
                                        $ifNull: [
                                          {
                                            $filter: {
                                              input: { $arrayElemAt: ["$sideboardAdditions", "$gameIndex"] },
                                              as: "added",
                                              cond: { $eq: ["$$added", "$$id"] }
                                            }
                                          },
                                          []
                                        ]
                                      }
                                    },
                                    {
                                      $size: {
                                        $ifNull: [
                                          {
                                            $filter: {
                                              input: { $arrayElemAt: ["$sideboardRemovals", "$gameIndex"] },
                                              as: "removed",
                                              cond: { $eq: ["$$removed", "$$id"] }
                                            }
                                          },
                                          []
                                        ]
                                      }
                                    }
                                  ]
                                }
                              }
                            }
                          }
                        ]
                      },
                      as: "card",
                      cond: { $gt: ["$$card.quantity", NumberInt(0)] }
                    }
                  }
                }
              }
            }
          }
        },
        deckSize: "$gameStats.deckSize",
        landsInDeck: "$gameStats.landsInDeck",
        handsDrawn: {
          // Tool's recording of the final kept hand wasn't updated for London mulligan until version 3.0.6.
          $cond: {
            if: {
              $or: [
                { $gte: ["$toolVersion", NumberInt(196614)] },
                { $eq: ["$mulliganType", "vancouver"] },
                { $eq: [{ $size: { $ifNull: ["$gameStats.handsDrawn", []] } }, NumberInt(1)] }
              ]
            },
            then: "$gameStats.handsDrawn",
            else: {
              $concatArrays: [
                { $slice: ["$gameStats.handsDrawn", { $subtract: [{ $size: { $ifNull: ["$gameStats.handsDrawn", []] } }, NumberInt(1)] }] },
                [{ $slice: ["$gameStats.shuffledOrder", NumberInt(7)] }]
              ]
            }
          }
        },
        handLands: {
          // Lands in hand numbers for the final kept hand likewise were not updated for London mulligan until version
          // 3.0.6.
          $cond: {
            if: {
              $or: [
                { $gte: ["$toolVersion", NumberInt(196614)] },
                { $eq: ["$mulliganType", "vancouver"] },
                { $eq: [{ $size: { $ifNull: ["$gameStats.handLands", []] } }, NumberInt(1)] }
              ]
            },
            then: "$gameStats.handLands",
            else: {
              $concatArrays: [
                {
                  $slice: [
                    "$gameStats.handLands",
                    { $subtract: [{ $size: { $ifNull: ["$gameStats.handLands", []] } }, NumberInt(1)] }
                  ]
                },
                [{
                  $add: [
                    { $arrayElemAt: ["$gameStats.handLands", NumberInt(-1)] },
                    {
                      $arrayElemAt: [
                        "$gameStats.libraryLands",
                        { $subtract: [{ $size: { $ifNull: ["$gameStats.handLands", []] } }, NumberInt(2)] }
                      ]
                    }
                  ]
                }]
              ]
            }
          }
        },
        shuffledOrder: "$gameStats.shuffledOrder",
        libraryLands: {
          // Lands in library numbers likewise were not updated for London mulligan until version 3.0.6.
          $cond: {
            if: {
              $or: [
                { $gte: ["$toolVersion", NumberInt(196614)] },
                { $eq: ["$mulliganType", "vancouver"] },
                { $eq: [{ $size: { $ifNull: ["$gameStats.handsDrawn", []] } }, NumberInt(1)] }
              ]
            },
            then: "$gameStats.libraryLands",
            else: {
              $map: {
                input: {
                  $slice: [
                    "$gameStats.libraryLands",
                    { $subtract: [{ $size: { $ifNull: ["$gameStats.handsDrawn", []] } }, NumberInt(1)] },
                    NumberInt(100)
                  ]
                },
                as: "lands",
                in: {
                  $subtract: [
                    "$$lands",
                    {
                      $arrayElemAt: [
                        "$gameStats.libraryLands",
                        { $subtract: [{ $size: { $ifNull: ["$gameStats.handsDrawn", []] } }, NumberInt(2)] }
                      ]
                    }
                  ]
                }
              }
            }
          }
        },
        multiCardPositions: "$gameStats.multiCardPositions"
      }
    },

    // Stage 8
    {
      $project: {
        gameStats: NumberInt(0)
      }
    },

    // Stage 9
    {
      $match: {
        // Occasionally a game has corrupted data. Check that the revealed cards as recorded are actually possible.
        $expr: {
          $let: {
            // Check each of the drawn hands, and the kept hand plus known portion of library
            vars: {
              toCheck: { $concatArrays: ["$handsDrawn", ["$shuffledOrder"]] },
              cardIdsInDeck: {
                $map: {
                  input: "$unorderedDeck.mainDeck",
                  as: "card",
                  in: "$$card.id"
                }
              }
            },
            in: {
              $and: [
                {
                  // First, check that everything seen actually is in the deck.
                  $reduce: {
                    // For each set of cards to be checked.
                    input: "$$toCheck",
                    // Assume at first that it's valid.
                    initialValue: true,
                    in: {
                      $cond: {
                        // If valid so far, keep checking.
                        if: "$$value",
                        then: {
                          $reduce: {
                            // For each card in the set...
                            input: "$$this",
                            // Assume at first that it's valid.
                            initialValue: true,
                            in: {
                              $cond: {
                                // If valid so far, keep checking.
                                if: "$$value",
                                then: { $in: ["$$this", "$$cardIdsInDeck"] },
                                // Already not valid, just return.
                                else: false
                              }
                            }
                          }
                        },
                        // Already not valid, just return.
                        else: false
                      }
                    }
                  }
                },
                {
                  $reduce: {
                    // For each card in the decklist, check that the number seen is not higher than what's in the deck.
                    input: "$unorderedDeck.mainDeck",
                    // Assume at first that it's valid.
                    initialValue: true,
                    in: {
                      $cond: {
                        // If valid so far, keep checking.
                        if: "$$value",
                        then: {
                          $let: {
                            vars: { cardInDeck: "$$this" },
                            in: {
                              $reduce: {
                                // For each set of cards to be checked...
                                input: "$$toCheck",
                                // Assume at first that it's valid.
                                initialValue: true,
                                in: {
                                  $cond: {
                                    // If valid so far, keep checking.
                                    if: "$$value",
                                    then: {
                                      // Find number of copies seen, compare to number in deck.
                                      $lte: [
                                        {
                                          $size: {
                                            $ifNull: [
                                              {
                                                $filter: {
                                                  input: "$$this",
                                                  as: "card",
                                                  cond: { $eq: ["$$card", "$$cardInDeck.id"] }
                                                }
                                              },
                                              []
                                            ]
                                          }
                                        },
                                        "$$cardInDeck.quantity"
                                      ]
                                    },
                                    // Already not valid, just return.
                                    else: false
                                  }
                                }
                              }
                            }
                          }
                        },
                        // Already not valid, just return.
                        else: false
                      }
                    }
                  }
                }
              ]
            }
          }
        }
      }
    },

    // Stage 10
    {
      $addFields: {
        // Is the decklist for this game reliable for position-in-decklist based statistics?
        decklistOk: {
          $and: [
            // Sideboarded decklist order was not recorded at first.
            { $ne: [{ $type: "$deck" }, "missing"] },
            {
              // From Tool version 2.2.25 until 2.5.9, and again from 2.14.3 until 3.0.0, sideboard tracking in a match
              // "removed duplicates", counting all versions of a card as the same, causing some issues with gameplay
              // tracking.
              $or: [
                // If first game, no sideboarding so no issue.
                { $eq: ["$gameIndex", NumberInt(0)] },
                // If before 2.2.25, bug not yet introduced.
                { $lt: ["$toolVersion", NumberInt(131609)] },
                // If 2.5.9 or later and before 2.14.3, bug fixed.
                { $and: [{ $gte: ["$toolVersion", NumberInt(132361)] }, { $lt: ["$toolVersion", NumberInt(134659)] }] },
                // If 3.0.0 or later, bug fixed again.
                { $gte: ["$toolVersion", NumberInt(196608)] },
                // Many decks don't have multiple versions of any single card anyway, would be a shame to drop all those
                // games needlessly. Check if the totals for each card match before and after sideboarding.
                {
                  $let: {
                    vars: {
                      original: { $concatArrays: ["$originalDeck.mainDeck", "$originalDeck.sideboard"] },
                      sideboarded: { $concatArrays: ["$deck.mainDeck", "$deck.sideboard"] }
                    },
                    in: {
                      $reduce: {
                        // For each card entry in the overall deck...
                        input: "$$original",
                        // Assume at first that it's valid.
                        initialValue: true,
                        in: {
                          $cond: {
                            // If valid so far, keep checking.
                            if: "$$value",
                            then: {
                              $let: {
                                vars: { card: "$$this" },
                                in: {
                                  $eq: [
                                    {
                                      // Count up totals of this card for the original deck.
                                      $reduce: {
                                        input: "$$original",
                                        initialValue: NumberInt(0),
                                        in: {
                                          $cond: {
                                            if: { $eq: ["$$card.id", "$$this.id"] },
                                            then: { $add: ["$$value", "$$this.quantity"] },
                                            else: "$$value"
                                          }
                                        }
                                      }
                                    },
                                    {
                                      // Count up totals of this card for the sideboarded deck.
                                      $reduce: {
                                        input: "$$sideboarded",
                                        initialValue: NumberInt(0),
                                        in: {
                                          $cond: {
                                            if: { $eq: ["$$card.id", "$$this.id"] },
                                            then: { $add: ["$$value", "$$this.quantity"] },
                                            else: "$$value"
                                          }
                                        }
                                      }
                                    }
                                  ]
                                }
                              }
                            },
                            // Already not valid, just return.
                            else: false
                          }
                        }
                      }
                    }
                  }
                }
              ]
            }
          ]
        },
        // Is the recorded library data reliable?
        shuffledOrderOk: {
          // From version 2.2.25 until 2.5.9, shuffler tracking information was not reset between games in a match. If
          // shuffled order was revealed at least as far as the previous game it would get overwritten in the process,
          // but otherwise the left over portion would get incorrectly recorded as happening in the new game too.
          $or: [
            // If first game, no leftover data so no issue.
            { $eq: ["$gameIndex", NumberInt(0)] },
            // If before 2.2.25, bug not yet introduced.
            { $lt: ["$toolVersion", NumberInt(131609)] },
            // If 2.5.9 or later, bug fixed.
            { $gte: ["$toolVersion", NumberInt(132361)] },
            // Many games did go long enough to overwrite the previous game's data, would be a shame to drop all those
            // games needlessly.
            {
              $gt: [
                { $arrayElemAt: ["$shuffledOrderLengths", "$gameIndex"] },
                { $arrayElemAt: ["$shuffledOrderLengths", { $subtract: ["$gameIndex", NumberInt(1)] }] }
              ]
            }
          ]
        },
        shuffling: {
          $switch: {
            branches: [
              {
                case: {
                  $and: [
                    { $eq: ["$bestOf", NumberInt(1)] },
                    { $eq: ["$eventId", "Play"] },
                    { $gt: ["$date", "2019-02-14T15:00:00.000Z"] }
                  ]
                },
                then: "smoothed"
              },
              { case: { $eq: ["$bestOf", NumberInt(1)] }, then: "hand" }
            ],
            default: "normal"
          }
        },
        // To enable tracking changes over time, keep separate records for each week. Split the weeks at 3 PM UTC
        // Thursday afternoon, the usual time new updates are released, and join the fragment of a week following the
        // Tool release that started recording opening hands with the following week.
        week: {
          $max: [
            {
              $toInt: {
                $ceil: {
                  $divide: [
                    // Feb 7 is the Thursday following the first full week of opening hands being recorded.
                    {
                      $subtract: [
                        { $dateFromString: { dateString: "$date" } },
                        { $dateFromString: { dateString: "2019-02-07T15:00:00.000Z" } }
                      ]
                    },
                    // Number of milliseconds in a week. 7 * 24 * 60 * 60 * 1000
                    NumberInt(604800000)
                  ]
                }
              }
            },
            // Anything before Feb 7 is week 0.
            NumberInt(0)
          ]
        },
      }
    },

    // Stage 11
    {
      $project: {
        date: NumberInt(1),
        gameIndex: NumberInt(1),
        // So that all the filtering and transforms above only have to be done once per game, do all the types of
        // statistics at once, then $unwind it to get separate output docs.
        stats: {
          // To allow each entry to omit itself or produce multiple entries, make them arrays and concat.
          $concatArrays: [
            // First, lands drawn in opening hands.
            {
              $cond: {
                // If lands in deck is outside the 14-20 (Limited) or 10-28 (Constructed) ranges, omit the game.
                if: {
                  $cond: {
                    if: { $eq: ["$deckSize", NumberInt(40)] },
                    then: { $or: [{ $lt: ["$landsInDeck", NumberInt(14)] }, { $gt: ["$landsInDeck", NumberInt(20)] }] },
                    else: { $or: [{ $lt: ["$landsInDeck", NumberInt(10)] }, { $gt: ["$landsInDeck", NumberInt(28)] }] }
                  }
                },
                then: [],
                else: [
                  // Lands are in the target range, output a doc.
                  {
                    group: {
                      deckSize: "$deckSize",
                      landsInDeck: "$landsInDeck",
                      bestOf: "$bestOf",
                      shuffling: "$shuffling",
                      mulliganType: "$mulliganType",
                      week: "$week",
                      type: "handLands"
                    },
                    data: "$handLands"
                  }
                ]
              }
            },
            // Second, lands in the library.
            {
              $cond: {
                // If lands in deck is outside the 14-20 (Limited) or 10-28 (Constructed) ranges, or if shuffled order
                // information is not reliable, omit the game.
                if: {
                  $or: [
                    {
                      $cond: {
                        if: { $eq: ["$deckSize", NumberInt(40)] },
                        then: {
                          $or: [{ $lt: ["$landsInDeck", NumberInt(14)] }, { $gt: ["$landsInDeck", NumberInt(20)] }]
                        },
                        else: {
                          $or: [{ $lt: ["$landsInDeck", NumberInt(10)] }, { $gt: ["$landsInDeck", NumberInt(28)] }]
                        }
                      }
                    },
                    { $not: "$shuffledOrderOk" }
                  ]
                },
                then: [],
                else: [
                  // Lands are in the target range and shuffled order is reliable, output a doc.
                  {
                    group: {
                      deckSize: "$deckSize",
                      landsInDeck: "$landsInDeck",
                      bestOf: "$bestOf",
                      shuffling: "$shuffling",
                      mulliganType: "$mulliganType",
                      week: "$week",
                      type: "libraryLands"
                    },
                    data: {
                      mulligans: { $subtract: [{ $size: { $ifNull: ["$handsDrawn", []] } }, NumberInt(1)] },
                      landsDrawn: { $arrayElemAt: ["$handLands", NumberInt(-1)] },
                      libraryLands: { $slice: ["$libraryLands", NumberInt(10)] }
                    }
                  }
                ]
              }
            },
            // Third, position-based cards in hand for several block sizes.
            {
              // If decklist order is not reliable, omit the game.
              $cond: {
                if: { $not: "$decklistOk" },
                then: [],
                else: {
                  // The decklist format was not designed with this kind of analysis in mind, so it's a bit inconvenient
                  // to work with. Additionally, the fact that copies of a card cannot be distinguished from each other
                  // means that every card included in the range to be analyzed must have ALL of its copies in the
                  // range. Fortunately, copies of a card are nearly always grouped together by Arena - "nearly" because
                  // importing a decklist with the same card listed in multiple places will have them separated in the
                  // resulting deck, but even just opening the deck and saving it again - without altering it - will
                  // combine them into one. The format of the decklist is:
                  //      [{ id: 68310, quantity: 4 },
                  //       { id: 68096, quantity: 2},
                  //       ...]
                  $let: {
                    vars: {
                      // Using the example decklist, this will be [68310, 68310, 68310, 68310, 68096, 68096, ...].
                      // Having this form greatly simplifies position-based checks.
                      deckArray: {
                        $reduce: {
                          input: "$deck.mainDeck",
                          initialValue: [],
                          in: {
                            $concatArrays: ["$$value", {
                              $map: {
                                input: { $range: [NumberInt(0), "$$this.quantity"] },
                                as: "ignored",
                                in: "$$this.id"
                              }
                            }]
                          }
                        }
                      },
                      // This is used in estimations to get stats for every position from *every* game, on the
                      // assumption of a correct shuffler where any drawn copy of a card would be equally likely to be
                      // any of the copies that went into the shuffler. In such estimations, each card drawn has its 1
                      // game split evenly among the positions it could have come from - card weight per position is
                      // 1/quantity in decklist.
                      cardEstimationWeights: {
                        $reduce: {
                          input: "$deck.mainDeck",
                          initialValue: [],
                          in: {
                            $concatArrays: ["$$value", {
                              $map: {
                                input: { $range: [NumberInt(0), "$$this.quantity"] },
                                as: "ignored",
                                in: { $divide: [NumberInt(1), "$$this.quantity"] }
                              }
                            }]
                          }
                        }
                      },
                      // The date of the match in seconds form, used for partitioning data into buckets to ensure
                      // independence.
                      dateSeconds: {
                        $toLong: {
                          $divide: [{ $toLong: { $dateFromString: { dateString: "$date" } } }, NumberInt(1000)]
                        }
                      }
                    },
                    in: {
                      // Output an array of objects, each one structured as:
                      //    {
                      //      group: {
                      //        deckSize: <40 or 60>,
                      //        numCards: <total number of cards, accounting for quantity, that are considered relevant
                      //                  at each position, or 0 for estimations that assume a card is equally likely to
                      //                  be any of its copies>,
                      //        bestOf: <1 or 3>,
                      //        shuffling: <normal, hand, or smoothed>,
                      //        mulliganType: <vancouver or london>,
                      //        independent: <true or false for whether games are grouped in buckets suitable for
                      //                     statistical analysis>
                      //        week: <weeks since Feb 7>,
                      //        type: "cardPositions"
                      //      },
                      //      data: [ // index is number of mulligans
                      //        [ // index is 0-based position in the decklist of the first relevant card
                      //          [ // index is number of relevant cards in the drawn hand
                      //            <0 or 1 for whether this game matches, or a fraction if doing estimations and the
                      //            card has multiple copies>
                      //          ]
                      //        ]
                      //      ]
                      //    }
                      $map: {
                        // The various quantities of cards that I'm interested in. 0 is used to indicate doing the
                        // estimation. Index is meaningless for this one.
                        input: {
                          $cond: {
                            if: { $eq: ["$deckSize", NumberInt(40)] },
                            then: [
                              { numCards: NumberInt(0), buckets: NumberInt(1) },
                              { numCards: NumberInt(1), buckets: NumberInt(1) },
                              { numCards: NumberInt(1), buckets: NumberInt(40) },
                              { numCards: NumberInt(2), buckets: NumberInt(1) },
                              { numCards: NumberInt(2), buckets: NumberInt(39) },
                              { numCards: NumberInt(3), buckets: NumberInt(1) },
                              { numCards: NumberInt(3), buckets: NumberInt(38) },
                              { numCards: NumberInt(4), buckets: NumberInt(1) },
                              { numCards: NumberInt(4), buckets: NumberInt(37) },
                              { numCards: NumberInt(15), buckets: NumberInt(1) },
                              { numCards: NumberInt(15), buckets: NumberInt(26) },
                              { numCards: NumberInt(16), buckets: NumberInt(1) },
                              { numCards: NumberInt(16), buckets: NumberInt(25) },
                              { numCards: NumberInt(17), buckets: NumberInt(1) },
                              { numCards: NumberInt(17), buckets: NumberInt(24) },
                              { numCards: NumberInt(18), buckets: NumberInt(1) },
                              { numCards: NumberInt(18), buckets: NumberInt(23) }
                            ],
                            else: [
                              { numCards: NumberInt(0), buckets: NumberInt(1) },
                              { numCards: NumberInt(1), buckets: NumberInt(1) },
                              { numCards: NumberInt(1), buckets: NumberInt(60) },
                              { numCards: NumberInt(2), buckets: NumberInt(1) },
                              { numCards: NumberInt(2), buckets: NumberInt(59) },
                              { numCards: NumberInt(3), buckets: NumberInt(1) },
                              { numCards: NumberInt(3), buckets: NumberInt(58) },
                              { numCards: NumberInt(4), buckets: NumberInt(1) },
                              { numCards: NumberInt(4), buckets: NumberInt(57) },
                              { numCards: NumberInt(22), buckets: NumberInt(1) },
                              { numCards: NumberInt(22), buckets: NumberInt(39) },
                              { numCards: NumberInt(23), buckets: NumberInt(1) },
                              { numCards: NumberInt(23), buckets: NumberInt(38) },
                              { numCards: NumberInt(24), buckets: NumberInt(1) },
                              { numCards: NumberInt(24), buckets: NumberInt(37) },
                              { numCards: NumberInt(25), buckets: NumberInt(1) },
                              { numCards: NumberInt(25), buckets: NumberInt(36) }
                            ]
                          }
                        },
                        as: "entry",
                        in: {
                          group: {
                            deckSize: "$deckSize",
                            numCards: "$$entry.numCards",
                            bestOf: "$bestOf",
                            shuffling: "$shuffling",
                            mulliganType: "$mulliganType",
                            independent: { $ne: ["$$entry.buckets", NumberInt(1)] },
                            week: "$week",
                            type: "cardPositions"
                          },
                          data: {
                            $map: {
                              // The outer index, number of mulligans from 0 to 6 inclusive.
                              input: { $range: [NumberInt(0), NumberInt(7)] },
                              as: "mulligans",
                              in: {
                                $map: {
                                  // Middle index, position in the decklist of the first relevant card. If only 1 card
                                  // is relevant, can range from 0 all the way to 39 or 59 inclusive. Each additional
                                  // relevant card reduces the maximum position by 1.
                                  input: {
                                    $range: [
                                      NumberInt(0),
                                      {
                                        $subtract: [
                                          { $add: ["$deckSize", NumberInt(1)] },
                                          { $max: ["$$entry.numCards", NumberInt(1)] }
                                        ]
                                      }
                                    ]
                                  },
                                  as: "position",
                                  in: {
                                    // Should this game count for this combination of numCards, mulligans, position, and
                                    // number of buckets?
                                    // And if doing estimation, what fractions should be counted for this position?
                                    $switch: {
                                      branches: [
                                        {
                                          // For proper statistical analysis, data points should be as independent as
                                          // possible. If producing an entry for that (buckets != 1), then only count
                                          // this game for a single, effectively random, position.
                                          case: {
                                            $and: [
                                              { $ne: ["$$entry.buckets", NumberInt(1)] },
                                              { $ne: [{ $mod: ["$$dateSeconds", "$$entry.buckets"] }, "$$position"] }
                                            ]
                                          },
                                          then: {
                                            $map: {
                                              // Inner index, number of relevant cards drawn. Can be up to either the
                                              // number of relevant cards in the deck or the size of the hand, whichever
                                              // is smaller.
                                              input: {
                                                $range: [
                                                  NumberInt(0),
                                                  {
                                                    $add: [
                                                      {
                                                        $min: [
                                                          "$$entry.numCards",
                                                          {
                                                            $cond: {
                                                              if: { $eq: ["$mulliganType", "vancouver"] },
                                                              then: { $subtract: [NumberInt(7), "$$mulligans"] },
                                                              else: NumberInt(7)
                                                            }
                                                          }
                                                        ]
                                                      },
                                                      NumberInt(1)
                                                    ]
                                                  }
                                                ]
                                              },
                                              as: "numDrawn",
                                              in: NumberInt(0)
                                            }
                                          }
                                        },
                                        {
                                          // numCards = 0 means doing estimation
                                          case: { $eq: ["$$entry.numCards", NumberInt(0)] },
                                          then: {
                                            $cond: {
                                              // If the game didn't have this many mulligans, don't count it for anything.
                                              if: { $lte: [{ $size: { $ifNull: ["$handsDrawn", []] } }, "$$mulligans"] },
                                              then: [NumberInt(0), NumberInt(0)],
                                              else: {
                                                // How many copies of the card at this position were drawn?
                                                $let: {
                                                  vars: {
                                                    numDrawn: {
                                                      // Get the hand for this mulligan, and count how many cards drawn
                                                      // match what's at this position.
                                                      $size: {
                                                        $ifNull: [
                                                          {
                                                            $filter: {
                                                              input: { $arrayElemAt: ["$handsDrawn", "$$mulligans"] },
                                                              as: "card",
                                                              cond: {
                                                                $eq: ["$$card", { $arrayElemAt: ["$$deckArray", "$$position"] }]
                                                              }
                                                            }
                                                          },
                                                          []
                                                        ]
                                                      }
                                                    }
                                                  },
                                                  // Take the number of copies drawn, and use the previously calculated
                                                  // weights to spread them out among all copies that they could be.
                                                  in: [
                                                    {
                                                      $subtract: [
                                                        NumberInt(1),
                                                        {
                                                          $multiply: [
                                                            "$$numDrawn",
                                                            { $arrayElemAt: ["$$cardEstimationWeights", "$$position"] }
                                                          ]
                                                        }
                                                      ]
                                                    }, {
                                                      $multiply: [
                                                        "$$numDrawn",
                                                        { $arrayElemAt: ["$$cardEstimationWeights", "$$position"] }
                                                      ]
                                                    }
                                                  ]
                                                }
                                              }
                                            }
                                          }
                                        }
                                      ],
                                      // Not doing estimation, need to generate an array with a 1 in the spot for the
                                      // number of copies actually drawn.
                                      default: {
                                        $map: {
                                          // Inner index, number of relevant cards drawn. Can be up to either the number
                                          // of relevant cards in the deck or the size of the hand, whichever is
                                          // smaller.
                                          input: {
                                            $range: [
                                              NumberInt(0),
                                              {
                                                $add: [
                                                  {
                                                    $min: [
                                                      "$$entry.numCards",
                                                      {
                                                        $cond: {
                                                          if: { $eq: ["$mulliganType", "vancouver"] },
                                                          then: { $subtract: [NumberInt(7), "$$mulligans"] },
                                                          else: NumberInt(7)
                                                        }
                                                      }
                                                    ]
                                                  },
                                                  NumberInt(1)
                                                ]
                                              }
                                            ]
                                          },
                                          as: "numDrawn",
                                          in: {
                                            // Should this game count for this combination of numCards, mulligans,
                                            // position, and numDrawn?
                                            $switch: {
                                              branches: [
                                                // If the game didn't have this many mulligans, don't count it for
                                                // anything.
                                                {
                                                  case: { $lte: [{ $size: { $ifNull: ["$handsDrawn", []] } }, "$$mulligans"] },
                                                  then: NumberInt(0)
                                                },
                                                // If the position/numCards combination covers a reliably identifiable
                                                // set of cards, and the numDrawn index matches, then count this game
                                                // here.
                                                {
                                                  case: {
                                                    $and: [
                                                      // A reliably identifiable set of cards has different cards at and
                                                      // before its start position.
                                                      {
                                                        $ne: [
                                                          { $arrayElemAt: ["$$deckArray", "$$position"] },
                                                          {
                                                            $arrayElemAt: [
                                                              "$$deckArray",
                                                              { $subtract: ["$$position", NumberInt(1)] }
                                                            ]
                                                          }
                                                        ]
                                                      }, {
                                                        // A reliably identifiable set of cards has different cards at
                                                        // and after its end position.
                                                        $ne: [
                                                          {
                                                            $arrayElemAt: [
                                                              "$$deckArray",
                                                              { $add: ["$$position", "$$entry.numCards", NumberInt(-1)] }
                                                            ]
                                                          }, {
                                                            $arrayElemAt: [
                                                              "$$deckArray",
                                                              { $add: ["$$position", "$$entry.numCards"] }
                                                            ]
                                                          }
                                                        ]
                                                      }, {
                                                        // Was the right number of the right cards drawn?
                                                        $eq: [
                                                          "$$numDrawn",
                                                          // Get the hand for this mulligan, and count how many cards
                                                          // drawn match the numCards cards at and after this position.
                                                          {
                                                            $size: {
                                                              $ifNull: [
                                                                {
                                                                  $filter: {
                                                                    input: { $arrayElemAt: ["$handsDrawn", "$$mulligans"] },
                                                                    as: "card",
                                                                    cond: {
                                                                      $in: [
                                                                        "$$card",
                                                                        { $slice: ["$$deckArray", "$$position", "$$entry.numCards"] }
                                                                      ]
                                                                    }
                                                                  }
                                                                },
                                                                []
                                                              ]
                                                            }
                                                          }
                                                        ]
                                                      }
                                                    ]
                                                  },
                                                  then: NumberInt(1)
                                                }
                                              ],
                                              // This game does not match these index values, so don't count it here.
                                              default: NumberInt(0)
                                            }
                                          }
                                        }
                                      }
                                    }
                                  }
                                }
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            },
            // Finally, number of copies based cards in hand.
            {
              // If decklist number of copies not reliable, omit the game.
              $cond: {
                if: { $not: "$decklistOk" },
                then: [],
                else: {
                  // starting from: { "2": {"1234": [1,2], "45": [3,4]}, "3": {}, "4": {} }
                  $map: {
                    input: {
                      $filter: {
                        // becomes [{"k": "2", "v": {"1234": [1,2], "45": [3,4]}}, {"k": "3", "v": {}}, {"k": "4", "v": {}}]
                        input: { $objectToArray: "$multiCardPositions" },
                        as: "positionSets",
                        cond: { $ne: ["$$positionSets.v", {}] }
                      }
                    },
                    as: "positionSets",
                    in: {
                      group: {
                        deckSize: "$deckSize",
                        numCards: { $toInt: "$$positionSets.k" },
                        bestOf: "$bestOf",
                        shuffling: "$shuffling",
                        mulliganType: "$mulliganType",
                        week: "$week",
                        type: "cardCopies"
                      },
                      data: {
                        $map: {
                          input: { $range: [NumberInt(0), NumberInt(7)] },
                          as: "mulligans",
                          in: {
                            $cond: {
                              if: { $lte: [{ $size: { $ifNull: ["$handsDrawn", []] } }, "$$mulligans"] },
                              then: [],
                              else: {
                                $map: {
                                  // [{"k": "1234", "v": [1,2]}, {"k": "45", "v": [3,4]}]
                                  input: { $objectToArray: "$$positionSets.v" },
                                  // {"k": "1234", "v": [1,2]}
                                  as: "card",
                                  in: {
                                    $let: {
                                      vars: {
                                        cardId: { $toInt: "$$card.k" }
                                      },
                                      in: {
                                        // Get the hand for this mulligan, and count how many cards drawn match this card.
                                        $size: {
                                          $ifNull: [
                                            {
                                              $filter: {
                                                input: { $arrayElemAt: ["$handsDrawn", "$$mulligans"] },
                                                as: "cardDrawn",
                                                cond: {
                                                  $eq: ["$$cardDrawn", "$$cardId"]
                                                }
                                              }
                                            },
                                            []
                                          ]
                                        }
                                      }
                                    }
                                  }
                                }
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          ]
        }
      }
    },

    // Stage 12
    {
      $unwind: {
        path: "$stats"
      }
    },

    // Stage 13
    {
      $group: {
        _id: "$stats.group",
        date: { $max: "$date" },
        data: { $push: "$stats.data" },
        numGames: { $sum: NumberInt(1) },
        numMatches: { $sum: { $toInt: { $eq: ["$gameIndex", NumberInt(0)] } } }
      }
    },

    // Stage 14
    {
      $addFields: {
        data: {
          $switch: {
            branches: [
              {
                case: { $eq: ["$_id.type", "handLands"] },
                then: {
                  $map: {
                    input: { $range: [NumberInt(0), NumberInt(7)] },
                    as: "mulligans",
                    in: {
                      $map: {
                        input: {
                          $range: [
                            NumberInt(0),
                            {
                              $cond: {
                                if: { $eq: ["$_id.mulliganType", "vancouver"] },
                                then: { $subtract: [NumberInt(8), "$$mulligans"] },
                                else: NumberInt(8)
                              }
                            }
                          ]
                        },
                        as: "count",
                        in: {
                          $size: {
                            $ifNull: [
                              {
                                $filter: {
                                  // $data is collection of handLands arrays
                                  input: "$data",
                                  as: "hands",
                                  cond: {
                                    $eq: [{ $arrayElemAt: ["$$hands", "$$mulligans"] }, "$$count"]
                                  }
                                }
                              },
                              []
                            ]
                          }
                        }
                      }
                    }
                  }
                }
              },
              {
                case: { $eq: ["$_id.type", "libraryLands"] },
                then: {
                  $map: {
                    input: { $range: [NumberInt(0), NumberInt(7)] },
                    as: "mulligans",
                    in: {
                      $map: {
                        input: {
                          $range: [
                            NumberInt(0),
                            {
                              $cond: {
                                if: { $eq: ["_id.$mulliganType", "vancouver"] },
                                then: { $subtract: [NumberInt(8), "$$mulligans"] },
                                else: NumberInt(8)
                              }
                            }
                          ]
                        },
                        as: "landsInHand",
                        in: {
                          $map: {
                            input: { $range: [NumberInt(0), NumberInt(10)] },
                            as: "position",
                            in: {
                              $map: {
                                input: {
                                  $range: [
                                    NumberInt(0),
                                    {
                                      $min: [
                                        { $add: ["$$position", NumberInt(2)] },
                                        { $add: [{ $subtract: ["$_id.landsInDeck", "$$landsInHand"] }, NumberInt(1)] }
                                      ]
                                    }
                                  ]
                                },
                                as: "count",
                                in: {
                                  $let: {
                                    vars: {
                                      filtered: {
                                        $filter: {
                                          // $data is collection of objects as:
                                          // {
                                          //   mulligans: <0-6>,
                                          //   landsDrawn: <0-max>,
                                          //   libraryLands: <first 10 from libraryLands in match>
                                          // }
                                          input: "$data",
                                          as: "entry",
                                          cond: {
                                            $and: [
                                              { $eq: ["$$mulligans", "$$entry.mulligans"] },
                                              { $eq: ["$$landsInHand", "$$entry.landsDrawn"] }
                                            ]
                                          }
                                        }
                                      }
                                    },
                                    in: [
                                      {
                                        $size: {
                                          $ifNull: [
                                            {
                                              $filter: {
                                                input: "$$filtered",
                                                as: "entry",
                                                cond: {
                                                  $eq: [{ $arrayElemAt: ["$$entry.libraryLands", "$$position"] }, "$$count"]
                                                }
                                              }
                                            },
                                            []
                                          ]
                                        }
                                      },
                                      {
                                        $size: {
                                          $ifNull: [
                                            {
                                              $filter: {
                                                input: "$$filtered",
                                                as: "entry",
                                                cond: {
                                                  $and: [{
                                                    $eq: [{ $arrayElemAt: ["$$entry.libraryLands", NumberInt(-1)] }, "$$count"]
                                                  },{
                                                    $eq: [{ $size: { $ifNull: ["$$entry.libraryLands", []] } }, "$$position"]
                                                  }]
                                                }
                                              }
                                            },
                                            []
                                          ]
                                        }
                                      }
                                    ]
                                  }
                                }
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              },
              {
                case: { $eq: ["$_id.type", "cardPositions"] },
                then: {
                  $reduce: {
                    // $data is a collection of 3 dimensional arrays as:
                    //   [mulligans][position][numDrawn] => count of games.
                    // Output format is the same, just need to merge.
                    input: { $slice: ["$data", NumberInt(1), { $size: { $ifNull: ["$data", []] } }] },
                    initialValue: { $arrayElemAt: ["$data", NumberInt(0)] },
                    in: {
                      $map: {
                        // Pair up same-mulligans 2 dimensional middle arrays.
                        input: { $zip: { inputs: ["$$value", "$$this"] } },
                        as: "mulliganStats",
                        in: {
                          $map: {
                            // Pair up same-position 1 dimensional middle arrays.
                            input: {
                              $zip: {
                                inputs: [
                                  { $arrayElemAt: ["$$mulliganStats", NumberInt(0)] },
                                  { $arrayElemAt: ["$$mulliganStats", NumberInt(1)] }
                                ]
                              }
                            },
                            as: "positionStats",
                            in: {
                              $map: {
                                // Pair up the actual values that have all three indices matching.
                                input: {
                                  $zip: {
                                    inputs: [
                                      { $arrayElemAt: ["$$positionStats", NumberInt(0)] },
                                      { $arrayElemAt: ["$$positionStats", NumberInt(1)] }
                                    ]
                                  }
                                },
                                as: "countStats",
                                // Finally, add the paired-up values.
                                in: { $sum: "$$countStats" }
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              },
              {
                case: { $eq: ["$_id.type", "cardCopies"] },
                then: {
                  $map: {
                    input: { $range: [NumberInt(0), NumberInt(7)] },
                    as: "mulligans",
                    in: {
                      $map: {
                        // for each possible number of copies revealed
                        input: {
                          $range: [
                            NumberInt(0),
                            {
                              $min: [
                                { $add: ["$_id.numCards", NumberInt(1)] },
                                {
                                  $cond: {
                                    if: { $eq: ["_id.$mulliganType", "vancouver"] },
                                    then: { $subtract: [NumberInt(8), "$$mulligans"] },
                                    else: NumberInt(8)
                                  }
                                }
                              ]
                            }
                          ]
                        },
                        as: "count",
                        in: {
                          $sum: {
                            $map: {
                              // $data is collection of arrays as:
                              //   [mulligans][] => counts of cards drawn
                              input: "$data",
                              as: "entry",
                              in: {
                                $size: {
                                  $ifNull: [
                                    {
                                      $filter: {
                                        input: { $arrayElemAt: ["$$entry", "$$mulligans"] },
                                        as: "drawn",
                                        cond: {
                                          $eq: ["$$drawn", "$$count"]
                                        }
                                      }
                                    },
                                    []
                                  ]
                                }
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            ]
          }
        }
      }
    },

    // Stage 15
    {
      $lookup: {
				from: "shuffler_stats",
				localField: "_id",
				foreignField: "_id",
				as: "existing_stats"
			}
		},

		// Stage 16
		{
			$project: {
				date: NumberInt(1),
				data: {
					$cond: {
					  if: { $eq: [{ $size: { $ifNull: ["$existing_stats", []] } }, NumberInt(0)] },
            then: "$data",
            else: {
              $map: {
                input: { $zip: { inputs: ["$data", { $arrayElemAt: ["$existing_stats.data", NumberInt(0)] }] } },
                as: "mulliganStats",
                in: {
                  $map: {
                    input: { $zip: { inputs: [{ $arrayElemAt: ["$$mulliganStats", NumberInt(0)] }, { $arrayElemAt: ["$$mulliganStats", NumberInt(1)] }] } },
                    as: "stats2",
                    in: {
                      $cond: {
                        if: { $in: ["$_id.type", ["handLands", "cardCopies"]] },
                        then: { $sum: "$$stats2" },
                        else: {
                          $map: {
                            input: { $zip: { inputs: [{ $arrayElemAt: ["$$stats2", NumberInt(0)] }, { $arrayElemAt: ["$$stats2", NumberInt(1)] }] } },
                            as: "stats3",
                            in: {
                              $cond: {
                                if: { $eq: ["$_id.type", "cardPositions"] },
                                then: { $sum: "$$stats3" },
                                else: {
                                  $map: {
                                    input: { $zip: { inputs: [{ $arrayElemAt: ["$$stats3", NumberInt(0)] }, { $arrayElemAt: ["$$stats3", NumberInt(1)] }] } },
                                    as: "stats4",
                                    in: {
                                      $map: {
                                        input: { $zip: { inputs: [{ $arrayElemAt: ["$$stats4", NumberInt(0)] }, { $arrayElemAt: ["$$stats4", NumberInt(1)] }] } },
                                        as: "stats5",
                                        in: { $sum: "$$stats5" }
                                      }
                                    }
                                  }
                                }
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
					}
				},
        numGames: {
				  $cond: {
				    if: { $eq: [{ $size: { $ifNull: ["$existing_stats", []] } }, NumberInt(0)] },
            then: "$numGames",
            else: { $add: ["$numGames", { $arrayElemAt: ["$existing_stats.numGames", NumberInt(0)] }] }
				  }
        },
        numMatches: {
          $cond: {
            if: { $eq: [{ $size: { $ifNull: ["$existing_stats", []] } }, NumberInt(0)] },
            then: "$numMatches",
            else: { $add: ["$numMatches", { $arrayElemAt: ["$existing_stats.numMatches", NumberInt(0)] }] }
          }
        }
			}
		},

		// Stage 17
		{
			$out: "shuffler_stats"
		}

	],
  {
    "allowDiskUse" : true
  }
	// Created with Studio 3T, the IDE for MongoDB - https://studio3t.com/

);
