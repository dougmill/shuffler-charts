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
				"gameStats.shuffledOrder": { $ne: [] },
				$and: [{
					$or: [{
						"gameIndex": 0
					},{
						"toolVersion": { $exists: true }
					},{
						"date": { $lt: "2019-02-14T15:00:00.000Z" }
					}]
				},{
					$or: [{
						$and: [{
							"gameStats.deckSize": { $gte: 40 },
						},{
							"gameStats.deckSize": { $lte: 50 }
						},{
							"gameStats.landsInDeck": { $gte: 14 }
						},{
							"gameStats.landsInDeck": { $lte: 25 }
						}]
					},{
						$and: [{
							"gameStats.deckSize": { $gte: 60 },
						},{
							"gameStats.deckSize": { $lte: 70 }
						},{
							"gameStats.landsInDeck": { $gte: 18 }
						},{
							"gameStats.landsInDeck": { $lte: 32 }
						}]
					}]
				}]
			}
		},

		// Stage 8
		{
			$addFields: {
				shuffling: {
					$switch: {
						branches: [
							{ case: { $and: [{ $eq: ["$bestOf", 1] }, { $gt: ["$date", "2019-02-14T15:00:00.000Z"] }] }, then: ["smoothed"] },
							{ case: { $eq: ["$bestOf", 1] }, then: ["smoothed", "standard"] }
						],
						default: ["standard"]
					}
				}
			}
		},

		// Stage 9
		{
			$unwind: {
				path: "$shuffling"
			}
		},

		// Stage 10
		{
			$group: {
			    _id: {
			        deckSize: "$gameStats.deckSize",
			        landsInDeck: "$gameStats.landsInDeck",
			        bestOf: "$bestOf",
					shuffling: "$shuffling"
			    },
				date: { $max: "$date" },
			    handLands: {
			    	$push: {
			    		$switch: {
			    			branches: [
								{ case: { $or: [{ $eq: ["$bestOf", 3] }, { $gt: ["$date", "2019-02-14T15:00:00.000Z"] }] }, then: "$gameStats.handLands" },
								{ case: { $eq: ["$shuffling", "smoothed"] }, then: [{ $arrayElemAt: ["$gameStats.handLands", 0] }] }
							],
							default: {
								$concatArrays: [[-1], { $slice: ["$gameStats.handLands", 1, 7] }]
							}
						}
					}
			    }
			}
		},

		// Stage 11
		{
			$project: {
				date: 1,
			    distribution: {
			        $map: {
			            input: { $range: [7, 0, -1] },
			            as: "handSize",
			            in: {
			                $map: {
			                    input: { $range: [0, { $add: ["$$handSize", 1] }] },
			                    as: "count",
			                    in: {
			                        $size: {
			                        	$filter: {
											input: "$handLands",
			                        		as: "hand",
											cond: {
												$eq: [{ $arrayElemAt: ["$$hand", { $subtract: [7, "$$handSize"] }] }, "$$count"]
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

		// Stage 12
		{
			$lookup: {
				from: "hand_stats",
				localField: "_id",
				foreignField: "_id",
				as: "stats"
			}
		},

		// Stage 13
		{
			$project: {
				date: 1,
				distribution: {
					$cond: [{ $eq: [{ $size: "$stats" }, 0] }, "$distribution", {
						$map: {
							input: { $zip: { inputs: ["$distribution", { $arrayElemAt: ["$stats.distribution", 0] }] } },
							as: "handSizeStats",
							in: {
								$map: {
									input: { $zip: { inputs: [{ $arrayElemAt: ["$$handSizeStats", 0] }, { $arrayElemAt: ["$$handSizeStats", 1] }] } },
									as: "countStats",
									in: { $sum: "$$countStats" }
								}
							}
						}
					}]
				}
			}
		},

		// Stage 14
		{
			$out: "hand_stats"
		}

	]

	// Created with Studio 3T, the IDE for MongoDB - https://studio3t.com/

);
