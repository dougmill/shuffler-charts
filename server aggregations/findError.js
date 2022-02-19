db.getCollection("matches").aggregate(

  // Pipeline
  [
    // Stage 1
    {
      $match: { $and: [{ date: { $gt: "2019-05-02T00:00:00.000Z" } }, { date: { $lt: "2019-05-09T00:00:00.000Z" } }] }
    },

    // Stage 2
    {
      $match: {
        "gameStats.0.handsDrawn": { $exists: true },
        bestOf: NumberInt(3),
        toolRunFromSource: { $ne: true }
      }
    },

    // Stage 3
    {
      $sort: { date: NumberInt(1) }
    },

    // Stage 4
    {
      $limit: NumberInt(2000)
    },

    // Stage 5
    {
      $project: {
        _id: NumberInt(0),
        date: NumberInt(1),
        gameStats: NumberInt(1),
        toolVersion: NumberInt(1),
        deckList: "$playerDeck.mainDeck"
      }
    },

    // Stage 6
    {
      $unwind: {
        path : "$gameStats",
        includeArrayIndex: "gameIndex"
      }
    },

    // Stage 7
    {
      $project: {
        date: NumberInt(1),
        deckList: {
          $cond: [{ $eq: ["$gameIndex", NumberInt(0)] }, "$deckList", "$gameStats.deck.mainDeck"]
        },
        deckSize: "$gameStats.deckSize",
        handsDrawn: "$gameStats.handsDrawn",
        gameIndex: NumberInt(1),
        sideboard: "$gameStats.sideboardChanges",
        toolVersion: NumberInt(1),
      }
    },

    // Stage 8
    {
      $match: {
        deckList: { $exists: true },
        deckSize: NumberInt(60),
        toolVersion: { $gte: NumberInt(131605) },
        handsDrawn: { $ne: [] },
        $expr: {
          $eq: [
            { $size: "$deckList" },
            {
              $size: {
                // Find unique card ids. Have to work around the fact that the various set operators only work with an
                // array of expressions, not an expression that evaluates to an array. So, using $reduce.
                $reduce: {
                  input: "$deckList",
                  initialValue: [],
                  in: {
                    $setUnion: ["$$value", ["$$this.id"]]
                  }
                }
              }
            }
          ]
        }
      }
    },

    // Stage 9
    {
      $project: {
        date: NumberInt(1),
        deckList: NumberInt(1),
        handsDrawn: NumberInt(1),
        gameIndex: NumberInt(1),
        sideboard: NumberInt(1),
        toolVersion: NumberInt(1),
      }
    },

  ]

  // Created with Studio 3T, the IDE for MongoDB - https://studio3t.com/

);
