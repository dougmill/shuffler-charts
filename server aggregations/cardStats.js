db.getCollection("matches").aggregate(

    // Pipeline
    [
        // Stage 1
        {
            // TODO rewrite to check for range from max of handStats to 10 minutes ago
            $match: { $and: [{ date: { $gt: "2019-01-01T00:00:00.000Z" } }, { date: { $lt: "2019-02-29T00:00:00.000Z" } }] }
        },

        // Stage 2
        {
            $match: {
                "gameStats.0.libraryLands": { $exists: true },
            }
        },

        // Stage 3
        {
            $sort: { date: 1 }
        },

        // Stage 4
        {
            $limit: 2000
        },

        // Stage 5
        {
            $project: {
                _id: 0,
                date: 1,
                bestOf: 1,
                shuffling: { $cond: [{ $and: [{ $eq: ["$eventId", "Play"] }, { $gt: ["$date", "2019-02-14T15:00:00.000Z"] }] }, "smoothed", "standard"] },
                gameStats: 1,
                toolVersion: 1
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
            $match: {
                $expr: {
                    $lte: [{ $size: "$gameStats.handLands" }, 4]
                },
                $and: [{
                    "gameStats.shuffledOrder": { $ne: 3 }
                },{
                    "gameStats.shuffledOrder": { $ne: null }
                },{
                    "gameStats.shuffledOrder": { $ne: [] }
                },{
                    $or: [{
                        "gameStats.deckSize": { $in: [40, 41, 42] },
                        $and: [{
                            "gameStats.landsInDeck": { $gte: 14 }
                        },{
                            "gameStats.landsInDeck": { $lte: 20 }
                        }]
                    },{
                        "gameStats.deckSize": { $in: [60, 61, 62] },
                        $and: [{
                            "gameStats.landsInDeck": { $gte: 18 }
                        },{
                            "gameStats.landsInDeck": { $lte: 28 }
                        }]
                    }]
                },{
                    $or: [{
                        "gameIndex": 0
                    },{
                        "toolVersion": { $exists: true }
                    },{
                        "date": { $lt: "2019-02-14T15:00:00.000Z" }
                    }]
                }]
            }
        },

        // Stage 8
        {
            $project: {
                date: 1,
                deckSize: "$gameStats.deckSize",
                bestOf: 1,
                shuffling: 1,
                cardsKnown: { $size: "$gameStats.shuffledOrder" },
                // starting from: { "2": {"1234": [1,2], "45": [3,4]}, "3": {}, "4": {} }
                positionSets: {
                    // becomes [{"k": "2", "v": {"1234": [1,2], "45": [3,4]}}, {"k": "3", "v": {}}, {"k": "4", "v": {}}]
                    $objectToArray: "$gameStats.multiCardPositions"
                }
            }
        },

        // Stage 9
        {
            $unwind: "$positionSets" // now {"k": "2", "v": {"1234": [1,2], "45": [3,4]}}
        },

        // Stage 10
        {
            $match: {
                "positionSets.v": { $ne: {} }
            }
        },

        // Stage 11
        {
            $project: {
                date: 1,
                deckSize: 1,
                bestOf: 1,
                shuffling: 1,
                copies: { $toInt: "$positionSets.k" },
                cardsKnown: 1,
                positionSets: {
                    $let: {
                        vars: {
                            positionsObjects: {
                                $map: {
                                    input: { $objectToArray: "$positionSets.v" }, // [{"k": "1234", "v": [1,2]}, {"k": "45", "v": [3,4]}]
                                    as: "positions", // {"k": "1234", "v": [1,2]}
                                    in: {
                                        type: "all",
                                        positions: "$$positions.v"
                                    }
                                }
                                // out [{"type": "all", "positions": [1,2]}, {"type": "all", "positions": [3,4]}]
                            }
                        },
                        in: {
                            $concatArrays: ["$$positionsObjects", [{
                                type: "first",
                                positions: {$arrayElemAt: ["$$positionsObjects.positions", 0]},
                            }]]
                        }
                    }
                    // out [{"type": "all", "positions": [1,2]}, {"type": "all", "positions": [3,4]}, {"type": "first", "positions": [1,2]}]
                }
            }
        },

        // Stage 12
        {
            $unwind: "$positionSets" // now {"type": "all", "positions": [1,2]}
        },

        // Stage 13
        {
            $group: {
                _id: {
                    deckSize: "$deckSize",
                    bestOf: "$bestOf",
                    shuffling: "$shuffling",
                    copies: "$copies",
                    type: "$positionSets.type"
                },
                date: { $max: "$date" },
                positionSets: {
                    $push: { positions: "$positionSets.positions", "known": "$cardsKnown" } // now [{"positions": [1,2], "known": 5}, {"positions": [3,4], "known": 5}]
                }
            }
        },

        // Stage 14
        {
            $project: {
                date: 1,
                distribution: {
                    // for each position in the shuffled deck
                    $map: {
                        input: {$range: [1, {$add: ["$_id.deckSize", 1]}]},
                        as: "position",
                        in: {
                            // for each possible number of copies revealed
                            $map: {
                                input: {$range: [0, {$add: ["$_id.copies", 1]}]},
                                as: "copies",
                                in: {
                                    $let: {
                                        vars: {
                                            matches: {
                                                $filter: {
                                                    input: "$positionSets", // starting from: [{"positions": [1,2], "known": 5}, {"positions": [3,4], "known": 5}]
                                                    as: "positions", // {"positions": [1,2], "known": 5}
                                                    cond: {
                                                        $eq: ["$$copies", {
                                                            // count how many of the copies are at or before the position being checked
                                                            $size: {
                                                                $filter: {
                                                                    input: "$$positions.positions",
                                                                    as: "cardPosition",
                                                                    cond: {
                                                                        $lte: ["$$cardPosition", "$$position"]
                                                                    }
                                                                }
                                                            }
                                                        }]
                                                    }
                                                }
                                            }
                                        },
                                        in: [
                                            {
                                                // count how many times it happened, disregarding cases where not enough cards were revealed
                                                $size: {
                                                    $filter: {
                                                        input: "$$matches.known", // starting from: [{"positions": [1,2], "known": 5}, {"positions": [3,4], "known": 5}]
                                                        as: "known", // 5
                                                        cond: {
                                                            $lte: ["$$position", "$$known"]
                                                        }
                                                    }
                                                }
                                            },
                                            {
                                                // also count how many times this position just ran out of known cards
                                                $size: {
                                                    $filter: {
                                                        input: "$$matches.known", // starting from: [{"positions": [1,2], "known": 5}, {"positions": [3,4], "known": 5}]
                                                        as: "known", // 5
                                                        cond: {
                                                            $eq: ["$$position", { $add: ["$$known", 1] }]
                                                        }
                                                    }
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
        },

        // Stage 15
        {
            $lookup: {
                from: "card_stats",
                localField: "_id",
                foreignField: "_id",
                as: "stats"
            }
        },

        // Stage 16
        {
            $project: {
                date: 1,
                distribution: {
                    $cond: [{ $eq: [{ $size: "$stats" }, 0] }, "$distribution", {
                        $map: {
                            input: { $zip: { inputs: ["$distribution", { $arrayElemAt: ["$stats.distribution", 0] }] } },
                            as: "positionStats",
                            in: {
                                $map: {
                                    input: { $zip: { inputs: [{ $arrayElemAt: ["$$positionStats", 0] }, { $arrayElemAt: ["$$positionStats", 1] }] } },
                                    as: "countStats",
                                    in: {
                                        $map: {
                                            input: { $zip: { inputs: [{ $arrayElemAt: ["$$countStats", 0] }, { $arrayElemAt: ["$$countStats", 1] }] } },
                                            as: "stats",
                                            in: { $sum: "$$stats" }
                                        }
                                    }
                                }
                            }
                        }
                    }]
                }
            }
        },

        // Stage 17
        {
            $out: "card_stats"
        }
    ]

    // Created with Studio 3T, the IDE for MongoDB - https://studio3t.com/

);
