db.getCollection("land_stats").aggregate(

	// Pipeline
	[
		// Stage 1
		{
			$group: {
				_id: { librarySize: "$group.librarySize", landsInLibrary: "$group.landsInLibrary" },
				distributions: { $push: '$distribution' },
			}
		},

		// Stage 2
		{
			$project: {
				_id: 0,
			    group: '$_id',
			    distribution: {
			        $reduce: {
			            input: '$distributions',
			            initialValue: [],
			            in: {
			                $map: {
			                    input: { $zip: { inputs: ['$$this', '$$value'], useLongestLength: true, defaults: [[], []] } },
			                    as: 'positionStats',
			                    in: {
			                        $map: {
			                            input: {
			                                $zip: {
			                                    inputs: [{ $arrayElemAt: ['$$positionStats', 0] }, { $arrayElemAt: ['$$positionStats', 1] }],
			                                    useLongestLength: true,
			                                    defaults: [[], []]
			                                }
			                            },
			                            as: 'countStats',
			                            in: {
			                                $map: {
			                                    input: {
			                                        $zip: {
			                                            inputs: [ {'$arrayElemAt': ['$$countStats', 0] }, {'$arrayElemAt': ['$$countStats', 1] }],
			                                            useLongestLength: true,
			                                            defaults: [[], []]
			                                        }
			                                    },
			                                    as: 'stats',
			                                    in: { $sum: '$$stats' }
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

	]

	// Created with Studio 3T, the IDE for MongoDB - https://studio3t.com/

);
