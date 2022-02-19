db.getCollection("matches").aggregate(

	// Pipeline
	[
		// Stage 1
		{
			// TODO rewrite to check for range from max of land_stats to 10 minutes ago
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
			$group: {
			    _id: {
			    	deckSize: "$gameStats.deckSize",
					landsInDeck: "$gameStats.landsInDeck",
			        librarySize: "$gameStats.librarySize",
			        landsInLibrary: "$gameStats.landsInLibrary",
			        bestOf: "$bestOf",
					shuffling: "$shuffling"
			    },
				date: { $max: "$date" },
			    libraryLandSets: { $push: "$gameStats.libraryLands" }
			}
		},

		// Stage 9
		{
			$project: {
				date: 1,
			    distribution: {
			        $map: {
			            input: { $range: [0, "$_id.librarySize"] },
			            as: "position",
			            in: {
			                $map: {
			                    input: { $range: [0, { $cond: [{ $lt: ["$$position", "$_id.landsInLibrary"] }, { $add: ["$$position", 2] }, { $add: ["$_id.landsInLibrary", 1] }] }] },
			                    as: "count",
			                    in: [
			                    	{
										$size: {
											$filter: {
												input: "$libraryLandSets",
												as: "lands",
												cond: {
													$eq: [{ $arrayElemAt: ["$$lands", "$$position"] }, "$$count"]
												}
											}
										}
									},
									{
										$size: {
											$filter: {
												input: "$libraryLandSets",
												as: "lands",
												cond: {
													$and: [{
														$eq: [{ $arrayElemAt: ["$$lands", -1] }, "$$count"]
													},{
														$eq: [{ $size: "$$lands" }, "$$position"]
													}]
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
		},

		// Stage 10
		{
			$lookup: {
				from: "land_stats",
				localField: "_id",
				foreignField: "_id",
				as: "stats"
			}
		},

		// Stage 11
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

		// Stage 12
		{
			$out: "land_stats"
		}

	]

	// Created with Studio 3T, the IDE for MongoDB - https://studio3t.com/

);
