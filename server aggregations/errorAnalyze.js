db.getCollection("error").aggregate(

  // Pipeline
  [
    // Stage 1
    {
      $addFields: {
        sideboard: {
          added: {
            $map: {
              input: "$sideboard.added",
              as: "card",
              in: { $toInt: "$$card" }
            }
          },
          removed: {
            $map: {
              input: "$sideboard.removed",
              as: "card",
              in: { $toInt: "$$card" }
            }
          }
        },
        deckArray: {
          $reduce: {
            input: "$deckList",
            initialValue: [],
            in: {
              $concatArrays: ["$$value", {
                $map: {
                  input: { $range: [NumberInt(0), "$$this.quantity"] },
                  as: "ignored",
                  in: { $toInt: "$$this.id" }
                }
              }]
            }
          }
        },
        cardEstimationWeights: {
          $reduce: {
            input: "$deckList",
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
        }
      }
    },

    // Stage 2
    {
      $addFields: {
        stats: {
          $map: {
            // The various quantities of cards that I'm interested in. 0 is used to indicate doing the estimation
            // and will be filtered out later. Index is meaningless for this one.
            input: [NumberInt(0)],
            as: "numCards",
            in: {
              numCards: "$$numCards",
              distribution: {
                $map: {
                  // The outer index, number of mulligans from 0 to 6 inclusive.
                  input: { $range: [NumberInt(0), NumberInt(7)] },
                  as: "mulligans",
                  in: {
                    $map: {
                      // Middle index, position in the decklist of the first relevant card. If only 1 card is
                      // relevant, can range from 0 all the way to 59 inclusive. Each additional relevant card
                      // reduces the maximum position by 1.
                      input: {
                        $range: [NumberInt(0), { $subtract: [NumberInt(61), { $max: ["$$numCards", NumberInt(1)] }] }]
                      },
                      as: "position",
                      in: {
                        // Should this game count for this combination of numCards, mulligans, and position? And if
                        // doing estimation, what fractions should be counted for this position?
                        $cond: {
                          // numCards = 0 means doing estimation
                          if: { $eq: ["$$numCards", NumberInt(0)] },
                          then: {
                            $cond: {
                              // If the game didn't have this many mulligans, don't count it for anything.
                              if: { $lte: [{ $size: "$handsDrawn" }, "$$mulligans"] },
                              then: [NumberInt(0), NumberInt(0)],
                              else: {
                                // How many copies of the card at this position were drawn?
                                $let: {
                                  vars: {
                                    numDrawn: {
                                      // Get the hand for this mulligan, and count how many cards drawn match what's
                                      // at this position.
                                      $size: {
                                        $filter: {
                                          input: { $arrayElemAt: ["$handsDrawn", "$$mulligans"] },
                                          as: "card",
                                          cond: {
                                            $eq: ["$$card", { $arrayElemAt: ["$deckArray", "$$position"] }]
                                          }
                                        }
                                      }
                                    }
                                  },
                                  // Take the number of copies drawn, and use the previously calculated weights to
                                  // spread them out among all copies that they could be.
                                  in: [
                                    {
                                      $subtract: [
                                        NumberInt(1),
                                        {
                                          $multiply: [
                                            "$$numDrawn",
                                            { $arrayElemAt: ["$cardEstimationWeights", "$$position"] }
                                          ]
                                        }
                                      ]
                                    },{
                                      $multiply: [
                                        "$$numDrawn",
                                        { $arrayElemAt: ["$cardEstimationWeights", "$$position"] }
                                      ]
                                    }
                                  ]
                                }
                              }
                            }
                          },
                          // Not doing estimation, need to generate an array with a 1 in the spot for the number of
                          // copies actually drawn.
                          else: {
                            $map: {
                              // Inner index, number of relevant cards drawn. Can be up to either the number of
                              // relevant cards in the deck or the size of the hand, whichever is smaller.
                              input: {
                                $range: [
                                  NumberInt(0),
                                  {
                                    $min: [
                                      { $add: ["$$numCards", NumberInt(1)] },
                                      { $subtract: [NumberInt(8), "$$mulligans"] }
                                    ]
                                  }
                                ]
                              },
                              as: "numDrawn",
                              in: {
                                // Should this game count for this combination of numCards, mulligans, position, and
                                // numDrawn?
                                $switch: {
                                  branches: [
                                    // If the game didn't have this many mulligans, don't count it for anything.
                                    {
                                      case: { $lte: [{ $size: "$handsDrawn" }, "$$mulligans"] },
                                      then: NumberInt(0)
                                    },
                                    // If the position/numCards combination covers a reliably identifiable set of
                                    // cards, and the numDrawn index matches, then count this game here.
                                    {
                                      case: {
                                        $and: [
                                          // A reliably identifiable set of cards has different cards at and before
                                          // its start position.
                                          {
                                            $ne: [
                                              { $arrayElemAt: ["$deckArray", "$$position"] },
                                              {
                                                $arrayElemAt: [
                                                  "$deckArray",
                                                  { $subtract: ["$$position", NumberInt(1)] }
                                                ]
                                              }
                                            ]
                                          },{
                                            // A reliably identifiable set of cards has different cards at and after
                                            // its end position.
                                            $ne: [
                                              {
                                                $arrayElemAt: [
                                                  "$deckArray",
                                                  { $add: ["$$position", "$$numCards", NumberInt(-1)] }
                                                ]
                                              },{
                                                $arrayElemAt: [
                                                  "$deckArray",
                                                  { $add: ["$$position", "$$numCards"] }
                                                ]
                                              }
                                            ]
                                          },{
                                            // Was the right number of the right cards drawn?
                                            $eq: [
                                              "$$numDrawn",
                                              // Get the hand for this mulligan, and count how many cards drawn
                                              // match the numCards cards at and after this position.
                                              {
                                                $size: {
                                                  $filter: {
                                                    input: { $arrayElemAt: ["$handsDrawn", "$$mulligans"] },
                                                    as: "card",
                                                    cond: {
                                                      $in: [
                                                        "$$card",
                                                        { $slice: ["$deckArray", "$$position", "$$numCards"] }
                                                      ]
                                                    }
                                                  }
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
    },

    // Stage 3
    {
      $unwind: {
        path : "$stats",
      }
    },

    // Stage 4
    {
      $addFields: {
        distribution: {
          $map: {
            input: { $arrayElemAt: ["$stats.distribution", NumberInt(0)] },
            as: "arr",
            in: { $arrayElemAt: ["$$arr", NumberInt(1)] }
          }
        },
        sum: {
          $sum: {
            $map: {
              input: { $arrayElemAt: ["$stats.distribution", NumberInt(0)] },
              as: "arr",
              in: { $arrayElemAt: ["$$arr", NumberInt(1)] }
            }
          }
        }
      }
    },

    // Stage 5
    {
      $match: {
        $or: [
          { "sum": { $lt: 6.95 } },
          { "sum": { $gt: 7.05 } }
        ]
      }
    },

    // Stage 6
    {
      $sort: {
        sum: NumberInt(1)
      }
    },

    // Stage 7
    {
      $addFields: {
        lands: {
          $size: {
            $filter: {
              input: { $arrayElemAt: ["$handsDrawn", NumberInt(0)] },
              as: "card",
              cond: {
                $and: [
                  {
                    $in: ["$$card", { $slice: ["$deckArray", NumberInt(24)] }]
                  },
                  {
                    $not: { $in: ["$$card", { $slice: ["$deckArray", NumberInt(24), NumberInt(60)] }] }
                  }
                ]
              }
            }
          }
        },
        missing: {
          $filter: {
            input: { $arrayElemAt: ["$handsDrawn", NumberInt(0)] },
            as: "card",
            cond: { $not: { $in: ["$$card", "$deckArray"] } }
          }
        },
        cards: {
          $concatArrays: [
            "$deckArray",
            { $arrayElemAt: ["$handsDrawn", NumberInt(0)] },
            "$sideboard.added",
            "$sideboard.removed"
          ]
        }
      }
    },

    // Stage 8
    {
      $lookup: {
        from: "cards",
        localField: "cards",
        foreignField: "_id",
        as: "cards"
      }
    },

    // Stage 9
    {
      $addFields: {
        deckNames: {
          $map: {
            input: "$deckArray",
            as: "card",
            in: {
              $let: {
                vars: {
                  theCard: {
                    $arrayElemAt: [
                      {
                        $filter: {
                          input: "$cards",
                          as: "cardObj",
                          cond: { $eq: ["$$cardObj._id", "$$card"] }
                        }
                      },
                      NumberInt(0)
                    ]
                  }
                },
                in: "$$theCard.name"
              }
            }
          }
        },
        drawnNames: {
          $map: {
            input: { $arrayElemAt: ["$handsDrawn", NumberInt(0)] },
            as: "card",
            in: {
              $let: {
                vars: {
                  theCard: {
                    $arrayElemAt: [
                      {
                        $filter: {
                          input: "$cards",
                          as: "cardObj",
                          cond: { $eq: ["$$cardObj._id", "$$card"] }
                        }
                      },
                      NumberInt(0)
                    ]
                  }
                },
                in: "$$theCard.name"
              }
            }
          }
        },
        sideboardNames: {
          added: {
            $map: {
              input: "$sideboard.added",
              as: "card",
              in: {
                $let: {
                  vars: {
                    theCard: {
                      $arrayElemAt: [
                        {
                          $filter: {
                            input: "$cards",
                            as: "cardObj",
                            cond: { $eq: ["$$cardObj._id", "$$card"] }
                          }
                        },
                        NumberInt(0)
                      ]
                    }
                  },
                  in: "$$theCard.name"
                }
              }
            }
          },
          removed: {
            $map: {
              input: "$sideboard.removed",
              as: "card",
              in: {
                $let: {
                  vars: {
                    theCard: {
                      $arrayElemAt: [
                        {
                          $filter: {
                            input: "$cards",
                            as: "cardObj",
                            cond: { $eq: ["$$cardObj._id", "$$card"] }
                          }
                        },
                        NumberInt(0)
                      ]
                    }
                  },
                  in: "$$theCard.name"
                }
              }
            }
          }
        },
        missingNames: {
          $map: {
            input: "$missing",
            as: "card",
            in: {
              $let: {
                vars: {
                  theCard: {
                    $arrayElemAt: [
                      {
                        $filter: {
                          input: "$cards",
                          as: "cardObj",
                          cond: { $eq: ["$$cardObj._id", "$$card"] }
                        }
                      },
                      NumberInt(0)
                    ]
                  }
                },
                in: "$$theCard.name"
              }
            }
          }
        }
      }
    },

    // Stage 10
    {
      $addFields: {
        missingByName: {
          $size: {
            $filter: {
              input: "$missingNames",
              as: "name",
              cond: {
                $not: { $in: ["$$name", "$deckNames"] }
              }
            }
          }
        }
      }
    },

    // Stage 10
    {
      $match: {
        lands: NumberInt(0),
//        missingByName: { $ne: NumberInt(0) },
//        "handsDrawn.0": { $size: NumberInt(7) }
      }
    }

  ]

  // Created with Studio 3T, the IDE for MongoDB - https://studio3t.com/

);
