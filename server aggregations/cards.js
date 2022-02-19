db.getCollection("matches").aggregate(

  // For converting a single doc made from database.json into a doc per card.
  // Pipeline
  [
    // Stage 1
    {
      $project: {
        cards: {
          $filter: {
            input: {
              $map: {
                input: { $objectToArray: "$$ROOT" },
                as: "card",
                in: {
                  _id: {
                    $convert: {
                      input: "$$card.k",
                      to: "int",
                      onError: null
                    }
                  },
                  name: "$$card.v.name"
                }
              }
            },
            as: "card",
            cond: {
              $ne: ["$$card._id", null]
            }
          }
        }
      }
    },

    // Stage 2
    {
      $unwind: {
        path: "$cards"
      }
    },

    // Stage 3
    {
      $replaceRoot: { newRoot: "$cards" }
    },

    // Stage 4
    {
      $out: "cards"
    },
  ]

  // Created with Studio 3T, the IDE for MongoDB - https://studio3t.com/

);
