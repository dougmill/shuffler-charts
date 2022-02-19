<?php

//require_once "D:/Games/MTG-Arena-Tool/vendor/autoload.php";
require_once(join(DIRECTORY_SEPARATOR,[__DIR__, '..', '..', 'vendor','autoload.php']));
require_once(join(DIRECTORY_SEPARATOR, [__DIR__, '..', 'get_mongo_client.php']));

if (!array_key_exists('password', $_GET) || !password_verify($_GET['password'], '$2y$10$xCIkRJrUUOuPEYSiFoPwxuOKKc95joTcK5xhmVK4wGd1xdoYgddUS')) {
  exit("Incorrect password");
}

//$client = (new MongoDB\Client);
$client = newMongoClient();
$mongo_matches = $client->tracker->matches;
$mongo_shuffler = $client->tracker->shuffler_stats;

$session = $client->startSession();

date_default_timezone_set('UTC');
// This is the same format as JavaScript uses for serializing to json, which is what's stored in the database. It's a
// string, but this format is designed so that string sort order is the same as date order. Look up ISO 8601 if you want
// to know more.
$dateFormat = 'Y\-m\-d\TH\:i\:s\.\0\0\0\Z';

$notStrictlyFalse = function($b) {
  return $b !== false;
};
$deleteConditions = array_filter([
  '$gte' => array_key_exists('deleteFromWeek', $_GET) ? (int)$_GET['deleteFromWeek'] : false,
  '$lte' => array_key_exists('deleteThroughWeek', $_GET) ? (int)$_GET['deleteThroughWeek'] : false
], $notStrictlyFalse);
$aggregateConditions = array_filter([
  '$gte' => array_key_exists('aggregateFromWeek', $_GET) ? (int)$_GET['aggregateFromWeek'] : false,
  '$lte' => array_key_exists('aggregateThroughWeek', $_GET) ? (int)$_GET['aggregateThroughWeek'] : false
], $notStrictlyFalse);
if (count($deleteConditions) > 0) {
  $mongo_shuffler->deleteMany(['_id.week' => $deleteConditions], ['session' => $session]);
}

$date_recorded = null;
if (count($deleteConditions) === 0 && count($aggregateConditions) === 0) {
  $date_recorded = $mongo_shuffler->findOne(['_id' => 'lastProcessed'], ['session' => $session])['date'];
}
if ($date_recorded === null) {
  $last_date_query = [
    [
      '$match' => array_filter([
        '_id' => ['$ne' => 'lastProcessed'],
        '_id.week' => count($aggregateConditions) > 0 ? $aggregateConditions : false
      ])
    ],
    [
      '$group' => [
        '_id' => NULL,
        'date' => [
          '$max' => '$date'
        ]
      ]
    ]
  ];
  $cursor = $mongo_shuffler->aggregate($last_date_query, ['session' => $session]);
  $date_recorded = '2019-01-25T00:00:00.000Z';
  foreach ($cursor as $document) {
    if ($document['date'] !== null) {
      $date_recorded = $document['date'];
    }
  }
}

// Want to process matches a) newer than any processed before, and b) old enough that any reasonable variation in clock
// time on the player's computer will not make a match be missed.

$mainFilter = [
  '$and' => [
    [
      'date' => [
        '$gt' => $date_recorded // placeholder
      ]
    ],
    [
      'date' => [
        '$lte' => $date_recorded // placeholder
      ]
    ]
  ],
  'gameStats.0.handsDrawn' => [
    '$exists' => TRUE
  ],
  '$or' => [
    [
      'toolVersion' => [
        '$gte' => 131605
      ]
    ],
    [
      'date' => [
        '$lt' => '2019-03-27T12:00:00.000Z'
      ]
    ]
  ],
  'toolRunFromSource' => [
    '$ne' => TRUE
  ],
  'player.userid' => [
    '$exists' => TRUE
  ],
  '$expr' => [
    '$eq' => [
      [
        '$indexOfBytes' => [
          '$opponent.userid',
          '$player.userid'
        ]
      ],
      -1
    ]
  ]
];
$targetMatchCount = array_key_exists('targetCount', $_GET) ? (int)$_GET['targetCount'] : 250;
// Limit to matches at least 10 minutes old unless params specify another limit, and limit time span to 1 week.
// 2019-02-07T15:00:00.000Z is end of week 0.
$cutoffTime = array_key_exists('aggregateThroughWeek', $_GET)
  ? strtotime('2019-02-07T15:00:00.000Z') + (int)$_GET['aggregateThroughWeek'] * 604800
  : time() - 600;
$maxTimeSpan = 604800;

// Limit to matches newer than the last processed match in the specified time span.
// 2019-01-31T15:00:00.000Z is the beginning of week 0.
$endTime = strtotime($date_recorded) + 1;
if (array_key_exists('aggregateFromWeek', $_GET)) {
  $endTime = max($endTime, strtotime('2019-01-31T15:00:00.000Z') + (int)$_GET['aggregateFromWeek'] * 604800);
}
$endStr = date($dateFormat, $endTime);
$timeSpan = 150;
$matchesFound = 0;
while ($matchesFound === 0 && $endTime < time()) {
  $timeSpan = min($timeSpan * 2, $maxTimeSpan);
  $startTime = $endTime;
  $startStr = $endStr;
  $endTime = $startTime + $timeSpan;
  $endStr = date($dateFormat, $endTime);
  $mainFilter['$and'][0]['date']['$gt'] = $startStr;
  $mainFilter['$and'][1]['date']['$lte'] = $endStr;
  $matchesFound = $mongo_matches->countDocuments($mainFilter, ['session' => $session]);
}
if ($matchesFound !== 0) {
  $timeSpan = min(intdiv($timeSpan * $targetMatchCount, $matchesFound), $maxTimeSpan);
}
$endTime = min($startTime + $timeSpan, $cutoffTime);
$endStr = date($dateFormat, $endTime);
$mainFilter['$and'][1]['date']['$lte'] = $endStr;

$shuffler_pipeline = [
  [
    '$match' => $mainFilter
  ],
  [
    '$sort' => [
      'date' => 1
    ]
  ],
  [
    '$limit' => $targetMatchCount
  ],
  [
    '$project' => [
      '_id' => 0,
      'date' => 1,
      'bestOf' => 1,
      'eventId' => 1,
      'gameStats' => 1,
      'toolVersion' => 1,
      'mulliganType' => [
        '$cond' => [
          'if' => [
            '$or' => [
              [
                '$eq' => [
                  '$eventId',
                  'Lore_WAR3_Singleton'
                ]
              ],
              [
                '$gt' => [
                  '$date',
                  '2019-07-02T15:00:00.000Z'
                ]
              ]
            ]
          ],
          'then' => 'london',
          'else' => 'vancouver'
        ]
      ],
      'originalDeck' => [
        'mainDeck' => [
          '$map' => [
            'input' => [
              '$ifNull' => [
                '$playerDeck.arenaMain',
                '$playerDeck.mainDeck'
              ]
            ],
            'as' => 'card',
            'in' => [
              'id' => [
                '$toInt' => '$$card.id'
              ],
              'quantity' => '$$card.quantity'
            ]
          ]
        ],
        'sideboard' => [
          '$map' => [
            'input' => [
              '$ifNull' => [
                '$playerDeck.arenaSide',
                '$playerDeck.sideboard'
              ]
            ],
            'as' => 'card',
            'in' => [
              'id' => [
                '$toInt' => '$$card.id'
              ],
              'quantity' => '$$card.quantity'
            ]
          ]
        ]
      ],
      'shuffledOrderLengths' => [
        '$map' => [
          'input' => '$gameStats',
          'as' => 'game',
          'in' => [
            '$size' => [
              '$ifNull' => [
                '$$game.shuffledOrder',
                []
              ]
            ]
          ]
        ]
      ],
      'sideboardAdditions' => [
        '$reduce' => [
          'input' => [
            '$slice' => [
              '$gameStats',
              1,
              [
                '$size' => [
                  '$ifNull' => [
                    '$gameStats',
                    []
                  ]
                ]
              ]
            ]
          ],
          'initialValue' => [
            []
          ],
          'in' => [
            '$concatArrays' => [
              '$$value',
              [
                [
                  '$concatArrays' => [
                    [
                      '$arrayElemAt' => [
                        '$$value',
                        -1
                      ]
                    ],
                    [
                      '$map' => [
                        'input' => '$$this.sideboardChanges.added',
                        'as' => 'card',
                        'in' => [
                          '$toInt' => '$$card'
                        ]
                      ]
                    ]
                  ]
                ]
              ]
            ]
          ]
        ]
      ],
      'sideboardRemovals' => [
        '$reduce' => [
          'input' => [
            '$slice' => [
              '$gameStats',
              1,
              [
                '$size' => [
                  '$ifNull' => [
                    '$gameStats',
                    []
                  ]
                ]
              ]
            ]
          ],
          'initialValue' => [
            []
          ],
          'in' => [
            '$concatArrays' => [
              '$$value',
              [
                [
                  '$concatArrays' => [
                    [
                      '$arrayElemAt' => [
                        '$$value',
                        -1
                      ]
                    ],
                    [
                      '$map' => [
                        'input' => '$$this.sideboardChanges.removed',
                        'as' => 'card',
                        'in' => [
                          '$toInt' => '$$card'
                        ]
                      ]
                    ]
                  ]
                ]
              ]
            ]
          ]
        ]
      ]
    ]
  ],
  [
    '$unwind' => [
      'path' => '$gameStats',
      'includeArrayIndex' => 'gameIndex'
    ]
  ],
  [
    '$match' => [
      'gameStats.deckSize' => [
        '$in' => [
          40,
          60
        ]
      ],
      'gameStats.handsDrawn' => [
        '$ne' => []
      ],
      'gameStats.shuffledOrder' => [
        '$ne' => NULL
      ],
      '$and' => [
        [
          '$or' => [
            [
              'gameIndex' => 0
            ],
            [
              'toolVersion' => [
                '$exists' => TRUE
              ]
            ],
            [
              'date' => [
                '$lt' => '2019-02-14T15:00:00.000Z'
              ]
            ]
          ]
        ],
        [
          '$or' => [
            [
              'gameIndex' => 0
            ],
            [
              '$and' => [
                [
                  'toolVersion' => [
                    '$nin' => [
                      132361,
                      132362
                    ]
                  ]
                ],
                [
                  '$or' => [
                    [
                      'toolVersion' => [
                        '$lt' => 196608
                      ]
                    ],
                    [
                      'toolVersion' => [
                        '$gt' => 196616
                      ]
                    ]
                  ]
                ]
              ]
            ]
          ]
        ],
        [
          '$expr' => [
            '$eq' => [
              [
                '$size' => [
                  '$ifNull' => [
                    '$originalDeck.mainDeck',
                    []
                  ]
                ]
              ],
              [
                '$size' => [
                  '$ifNull' => [
                    [
                      '$reduce' => [
                        'input' => '$originalDeck.mainDeck',
                        'initialValue' => [],
                        'in' => [
                          '$setUnion' => [
                            '$$value',
                            [
                              '$$this.id'
                            ]
                          ]
                        ]
                      ]
                    ],
                    []
                  ]
                ]
              ]
            ]
          ]
        ],
        [
          '$expr' => [
            '$eq' => [
              0,
              [
                '$size' => [
                  '$ifNull' => [
                    [
                      '$filter' => [
                        'input' => [
                          '$range' => [
                            0,
                            [
                              '$size' => [
                                '$ifNull' => [
                                  '$gameStats.handsDrawn',
                                  []
                                ]
                              ]
                            ]
                          ]
                        ],
                        'as' => 'index',
                        'cond' => [
                          '$ne' => [
                            [
                              '$cond' => [
                                'if' => [
                                  '$or' => [
                                    [
                                      '$eq' => [
                                        '$mulliganType',
                                        'vancouver'
                                      ]
                                    ],
                                    [
                                      '$and' => [
                                        [
                                          '$lt' => [
                                            '$toolVersion',
                                            196614
                                          ]
                                        ],
                                        [
                                          '$eq' => [
                                            [
                                              '$add' => [
                                                '$$index',
                                                1
                                              ]
                                            ],
                                            [
                                              '$size' => [
                                                '$ifNull' => [
                                                  '$gameStats.handsDrawn',
                                                  []
                                                ]
                                              ]
                                            ]
                                          ]
                                        ]
                                      ]
                                    ]
                                  ]
                                ],
                                'then' => [
                                  '$subtract' => [
                                    7,
                                    '$$index'
                                  ]
                                ],
                                'else' => 7
                              ]
                            ],
                            [
                              '$size' => [
                                '$ifNull' => [
                                  [
                                    '$arrayElemAt' => [
                                      '$gameStats.handsDrawn',
                                      '$$index'
                                    ]
                                  ],
                                  []
                                ]
                              ]
                            ]
                          ]
                        ]
                      ]
                    ],
                    []
                  ]
                ]
              ]
            ]
          ]
        ]
      ]
    ]
  ],
  [
    '$addFields' => [
      'deck' => [
        '$switch' => [
          'branches' => [
            [
              'case' => [
                '$eq' => [
                  '$gameIndex',
                  0
                ]
              ],
              'then' => '$originalDeck'
            ],
            [
              'case' => [
                '$eq' => [
                  [
                    '$type' => '$gameStats.deck'
                  ],
                  'object'
                ]
              ],
              'then' => [
                'mainDeck' => [
                  '$ifNull' => [
                    '$gameStats.deck.arenaMain',
                    '$gameStats.deck.mainDeck'
                  ]
                ],
                'sideboard' => [
                  '$ifNull' => [
                    '$gameStats.deck.arenaSide',
                    '$gameStats.deck.sideboard'
                  ]
                ]
              ]
            ]
          ],
          'default' => '$gameStats.deck'
        ]
      ],
      'unorderedDeck' => [
        '$switch' => [
          'branches' => [
            [
              'case' => [
                '$eq' => [
                  '$gameIndex',
                  0
                ]
              ],
              'then' => '$originalDeck'
            ],
            [
              'case' => [
                '$eq' => [
                  [
                    '$type' => '$gameStats.deck'
                  ],
                  'object'
                ]
              ],
              'then' => '$gameStats.deck'
            ]
          ],
          'default' => [
            'mainDeck' => [
              '$let' => [
                'vars' => [
                  'cardIdsAdded' => [
                    '$setDifference' => [
                      [
                        '$arrayElemAt' => [
                          '$sideboardAdditions',
                          '$gameIndex'
                        ]
                      ],
                      [
                        '$map' => [
                          'input' => '$originalDeck.mainDeck',
                          'as' => 'card',
                          'in' => '$$card.id'
                        ]
                      ]
                    ]
                  ]
                ],
                'in' => [
                  '$filter' => [
                    'input' => [
                      '$concatArrays' => [
                        [
                          '$map' => [
                            'input' => '$originalDeck.mainDeck',
                            'as' => 'card',
                            'in' => [
                              'id' => '$$card.id',
                              'quantity' => [
                                '$subtract' => [
                                  [
                                    '$add' => [
                                      '$$card.quantity',
                                      [
                                        '$size' => [
                                          '$ifNull' => [
                                            [
                                              '$filter' => [
                                                'input' => [
                                                  '$arrayElemAt' => [
                                                    '$sideboardAdditions',
                                                    '$gameIndex'
                                                  ]
                                                ],
                                                'as' => 'added',
                                                'cond' => [
                                                  '$eq' => [
                                                    '$$added',
                                                    '$$card.id'
                                                  ]
                                                ]
                                              ]
                                            ],
                                            []
                                          ]
                                        ]
                                      ]
                                    ]
                                  ],
                                  [
                                    '$size' => [
                                      '$ifNull' => [
                                        [
                                          '$filter' => [
                                            'input' => [
                                              '$arrayElemAt' => [
                                                '$sideboardRemovals',
                                                '$gameIndex'
                                              ]
                                            ],
                                            'as' => 'removed',
                                            'cond' => [
                                              '$eq' => [
                                                '$$removed',
                                                '$$card.id'
                                              ]
                                            ]
                                          ]
                                        ],
                                        []
                                      ]
                                    ]
                                  ]
                                ]
                              ]
                            ]
                          ]
                        ],
                        [
                          '$map' => [
                            'input' => '$$cardIdsAdded',
                            'as' => 'id',
                            'in' => [
                              'id' => '$$id',
                              'quantity' => [
                                '$subtract' => [
                                  [
                                    '$size' => [
                                      '$ifNull' => [
                                        [
                                          '$filter' => [
                                            'input' => [
                                              '$arrayElemAt' => [
                                                '$sideboardAdditions',
                                                '$gameIndex'
                                              ]
                                            ],
                                            'as' => 'added',
                                            'cond' => [
                                              '$eq' => [
                                                '$$added',
                                                '$$id'
                                              ]
                                            ]
                                          ]
                                        ],
                                        []
                                      ]
                                    ]
                                  ],
                                  [
                                    '$size' => [
                                      '$ifNull' => [
                                        [
                                          '$filter' => [
                                            'input' => [
                                              '$arrayElemAt' => [
                                                '$sideboardRemovals',
                                                '$gameIndex'
                                              ]
                                            ],
                                            'as' => 'removed',
                                            'cond' => [
                                              '$eq' => [
                                                '$$removed',
                                                '$$id'
                                              ]
                                            ]
                                          ]
                                        ],
                                        []
                                      ]
                                    ]
                                  ]
                                ]
                              ]
                            ]
                          ]
                        ]
                      ]
                    ],
                    'as' => 'card',
                    'cond' => [
                      '$gt' => [
                        '$$card.quantity',
                        0
                      ]
                    ]
                  ]
                ]
              ]
            ]
          ]
        ]
      ],
      'deckSize' => '$gameStats.deckSize',
      'landsInDeck' => '$gameStats.landsInDeck',
      'handsDrawn' => [
        '$cond' => [
          'if' => [
            '$or' => [
              [
                '$gte' => [
                  '$toolVersion',
                  196614
                ]
              ],
              [
                '$eq' => [
                  '$mulliganType',
                  'vancouver'
                ]
              ],
              [
                '$eq' => [
                  [
                    '$size' => [
                      '$ifNull' => [
                        '$gameStats.handsDrawn',
                        []
                      ]
                    ]
                  ],
                  1
                ]
              ]
            ]
          ],
          'then' => '$gameStats.handsDrawn',
          'else' => [
            '$concatArrays' => [
              [
                '$slice' => [
                  '$gameStats.handsDrawn',
                  [
                    '$subtract' => [
                      [
                        '$size' => [
                          '$ifNull' => [
                            '$gameStats.handsDrawn',
                            []
                          ]
                        ]
                      ],
                      1
                    ]
                  ]
                ]
              ],
              [
                [
                  '$slice' => [
                    '$gameStats.shuffledOrder',
                    7
                  ]
                ]
              ]
            ]
          ]
        ]
      ],
      'handLands' => [
        '$cond' => [
          'if' => [
            '$or' => [
              [
                '$gte' => [
                  '$toolVersion',
                  196614
                ]
              ],
              [
                '$eq' => [
                  '$mulliganType',
                  'vancouver'
                ]
              ],
              [
                '$eq' => [
                  [
                    '$size' => [
                      '$ifNull' => [
                        '$gameStats.handLands',
                        []
                      ]
                    ]
                  ],
                  1
                ]
              ]
            ]
          ],
          'then' => '$gameStats.handLands',
          'else' => [
            '$concatArrays' => [
              [
                '$slice' => [
                  '$gameStats.handLands',
                  [
                    '$subtract' => [
                      [
                        '$size' => [
                          '$ifNull' => [
                            '$gameStats.handLands',
                            []
                          ]
                        ]
                      ],
                      1
                    ]
                  ]
                ]
              ],
              [
                [
                  '$add' => [
                    [
                      '$arrayElemAt' => [
                        '$gameStats.handLands',
                        -1
                      ]
                    ],
                    [
                      '$arrayElemAt' => [
                        '$gameStats.libraryLands',
                        [
                          '$subtract' => [
                            [
                              '$size' => [
                                '$ifNull' => [
                                  '$gameStats.handLands',
                                  []
                                ]
                              ]
                            ],
                            2
                          ]
                        ]
                      ]
                    ]
                  ]
                ]
              ]
            ]
          ]
        ]
      ],
      'shuffledOrder' => '$gameStats.shuffledOrder',
      'libraryLands' => [
        '$cond' => [
          'if' => [
            '$or' => [
              [
                '$gte' => [
                  '$toolVersion',
                  196614
                ]
              ],
              [
                '$eq' => [
                  '$mulliganType',
                  'vancouver'
                ]
              ],
              [
                '$eq' => [
                  [
                    '$size' => [
                      '$ifNull' => [
                        '$gameStats.handsDrawn',
                        []
                      ]
                    ]
                  ],
                  1
                ]
              ]
            ]
          ],
          'then' => '$gameStats.libraryLands',
          'else' => [
            '$map' => [
              'input' => [
                '$slice' => [
                  '$gameStats.libraryLands',
                  [
                    '$subtract' => [
                      [
                        '$size' => [
                          '$ifNull' => [
                            '$gameStats.handsDrawn',
                            []
                          ]
                        ]
                      ],
                      1
                    ]
                  ],
                  100
                ]
              ],
              'as' => 'lands',
              'in' => [
                '$subtract' => [
                  '$$lands',
                  [
                    '$arrayElemAt' => [
                      '$gameStats.libraryLands',
                      [
                        '$subtract' => [
                          [
                            '$size' => [
                              '$ifNull' => [
                                '$gameStats.handsDrawn',
                                []
                              ]
                            ]
                          ],
                          2
                        ]
                      ]
                    ]
                  ]
                ]
              ]
            ]
          ]
        ]
      ],
      'multiCardPositions' => '$gameStats.multiCardPositions'
    ]
  ],
  [
    '$project' => [
      'gameStats' => 0
    ]
  ],
  [
    '$match' => [
      '$expr' => [
        '$let' => [
          'vars' => [
            'toCheck' => [
              '$concatArrays' => [
                '$handsDrawn',
                [
                  '$shuffledOrder'
                ]
              ]
            ],
            'cardIdsInDeck' => [
              '$map' => [
                'input' => '$unorderedDeck.mainDeck',
                'as' => 'card',
                'in' => '$$card.id'
              ]
            ]
          ],
          'in' => [
            '$and' => [
              [
                '$reduce' => [
                  'input' => '$$toCheck',
                  'initialValue' => TRUE,
                  'in' => [
                    '$cond' => [
                      'if' => '$$value',
                      'then' => [
                        '$reduce' => [
                          'input' => '$$this',
                          'initialValue' => TRUE,
                          'in' => [
                            '$cond' => [
                              'if' => '$$value',
                              'then' => [
                                '$in' => [
                                  '$$this',
                                  '$$cardIdsInDeck'
                                ]
                              ],
                              'else' => FALSE
                            ]
                          ]
                        ]
                      ],
                      'else' => FALSE
                    ]
                  ]
                ]
              ],
              [
                '$reduce' => [
                  'input' => '$unorderedDeck.mainDeck',
                  'initialValue' => TRUE,
                  'in' => [
                    '$cond' => [
                      'if' => '$$value',
                      'then' => [
                        '$let' => [
                          'vars' => [
                            'cardInDeck' => '$$this'
                          ],
                          'in' => [
                            '$reduce' => [
                              'input' => '$$toCheck',
                              'initialValue' => TRUE,
                              'in' => [
                                '$cond' => [
                                  'if' => '$$value',
                                  'then' => [
                                    '$lte' => [
                                      [
                                        '$size' => [
                                          '$ifNull' => [
                                            [
                                              '$filter' => [
                                                'input' => '$$this',
                                                'as' => 'card',
                                                'cond' => [
                                                  '$eq' => [
                                                    '$$card',
                                                    '$$cardInDeck.id'
                                                  ]
                                                ]
                                              ]
                                            ],
                                            []
                                          ]
                                        ]
                                      ],
                                      '$$cardInDeck.quantity'
                                    ]
                                  ],
                                  'else' => FALSE
                                ]
                              ]
                            ]
                          ]
                        ]
                      ],
                      'else' => FALSE
                    ]
                  ]
                ]
              ]
            ]
          ]
        ]
      ]
    ]
  ],
  [
    '$addFields' => [
      'decklistOk' => [
        '$and' => [
          [
            '$ne' => [
              [
                '$type' => '$deck'
              ],
              'missing'
            ]
          ],
          [
            '$or' => [
              [
                '$eq' => [
                  '$gameIndex',
                  0
                ]
              ],
              [
                '$lt' => [
                  '$toolVersion',
                  131609
                ]
              ],
              [
                '$and' => [
                  [
                    '$gte' => [
                      '$toolVersion',
                      132361
                    ]
                  ],
                  [
                    '$lt' => [
                      '$toolVersion',
                      134659
                    ]
                  ]
                ]
              ],
              [
                '$gte' => [
                  '$toolVersion',
                  196608
                ]
              ],
              [
                '$let' => [
                  'vars' => [
                    'original' => [
                      '$concatArrays' => [
                        '$originalDeck.mainDeck',
                        '$originalDeck.sideboard'
                      ]
                    ],
                    'sideboarded' => [
                      '$concatArrays' => [
                        '$deck.mainDeck',
                        '$deck.sideboard'
                      ]
                    ]
                  ],
                  'in' => [
                    '$reduce' => [
                      'input' => '$$original',
                      'initialValue' => TRUE,
                      'in' => [
                        '$cond' => [
                          'if' => '$$value',
                          'then' => [
                            '$let' => [
                              'vars' => [
                                'card' => '$$this'
                              ],
                              'in' => [
                                '$eq' => [
                                  [
                                    '$reduce' => [
                                      'input' => '$$original',
                                      'initialValue' => 0,
                                      'in' => [
                                        '$cond' => [
                                          'if' => [
                                            '$eq' => [
                                              '$$card.id',
                                              '$$this.id'
                                            ]
                                          ],
                                          'then' => [
                                            '$add' => [
                                              '$$value',
                                              '$$this.quantity'
                                            ]
                                          ],
                                          'else' => '$$value'
                                        ]
                                      ]
                                    ]
                                  ],
                                  [
                                    '$reduce' => [
                                      'input' => '$$sideboarded',
                                      'initialValue' => 0,
                                      'in' => [
                                        '$cond' => [
                                          'if' => [
                                            '$eq' => [
                                              '$$card.id',
                                              '$$this.id'
                                            ]
                                          ],
                                          'then' => [
                                            '$add' => [
                                              '$$value',
                                              '$$this.quantity'
                                            ]
                                          ],
                                          'else' => '$$value'
                                        ]
                                      ]
                                    ]
                                  ]
                                ]
                              ]
                            ]
                          ],
                          'else' => FALSE
                        ]
                      ]
                    ]
                  ]
                ]
              ]
            ]
          ]
        ]
      ],
      'shuffledOrderOk' => [
        '$or' => [
          [
            '$eq' => [
              '$gameIndex',
              0
            ]
          ],
          [
            '$lt' => [
              '$toolVersion',
              131609
            ]
          ],
          [
            '$gte' => [
              '$toolVersion',
              132361
            ]
          ],
          [
            '$gt' => [
              [
                '$arrayElemAt' => [
                  '$shuffledOrderLengths',
                  '$gameIndex'
                ]
              ],
              [
                '$arrayElemAt' => [
                  '$shuffledOrderLengths',
                  [
                    '$subtract' => [
                      '$gameIndex',
                      1
                    ]
                  ]
                ]
              ]
            ]
          ]
        ]
      ],
      'shuffling' => [
        '$switch' => [
          'branches' => [
            [
              'case' => [
                '$and' => [
                  [
                    '$eq' => [
                      '$bestOf',
                      1
                    ]
                  ],
                  [
                    '$eq' => [
                      '$eventId',
                      'Play'
                    ]
                  ],
                  [
                    '$gt' => [
                      '$date',
                      '2019-02-14T15:00:00.000Z'
                    ]
                  ]
                ]
              ],
              'then' => 'smoothed'
            ],
            [
              'case' => [
                '$eq' => [
                  '$bestOf',
                  1
                ]
              ],
              'then' => 'hand'
            ]
          ],
          'default' => 'normal'
        ]
      ],
      'week' => [
        '$max' => [
          [
            '$toInt' => [
              '$ceil' => [
                '$divide' => [
                  [
                    '$subtract' => [
                      [
                        '$dateFromString' => [
                          'dateString' => '$date'
                        ]
                      ],
                      [
                        '$dateFromString' => [
                          'dateString' => '2019-02-07T15:00:00.000Z'
                        ]
                      ]
                    ]
                  ],
                  604800000
                ]
              ]
            ]
          ],
          0
        ]
      ]
    ]
  ],
  [
    '$project' => [
      'date' => 1,
      'gameIndex' => 1,
      'stats' => [
        '$concatArrays' => [
          [
            '$cond' => [
              'if' => [
                '$cond' => [
                  'if' => [
                    '$eq' => [
                      '$deckSize',
                      40
                    ]
                  ],
                  'then' => [
                    '$or' => [
                      [
                        '$lt' => [
                          '$landsInDeck',
                          14
                        ]
                      ],
                      [
                        '$gt' => [
                          '$landsInDeck',
                          20
                        ]
                      ]
                    ]
                  ],
                  'else' => [
                    '$or' => [
                      [
                        '$lt' => [
                          '$landsInDeck',
                          10
                        ]
                      ],
                      [
                        '$gt' => [
                          '$landsInDeck',
                          28
                        ]
                      ]
                    ]
                  ]
                ]
              ],
              'then' => [],
              'else' => [
                [
                  'group' => [
                    'deckSize' => '$deckSize',
                    'landsInDeck' => '$landsInDeck',
                    'bestOf' => '$bestOf',
                    'shuffling' => '$shuffling',
                    'mulliganType' => '$mulliganType',
                    'week' => '$week',
                    'type' => 'handLands'
                  ],
                  'data' => '$handLands'
                ]
              ]
            ]
          ],
          [
            '$cond' => [
              'if' => [
                '$or' => [
                  [
                    '$cond' => [
                      'if' => [
                        '$eq' => [
                          '$deckSize',
                          40
                        ]
                      ],
                      'then' => [
                        '$or' => [
                          [
                            '$lt' => [
                              '$landsInDeck',
                              14
                            ]
                          ],
                          [
                            '$gt' => [
                              '$landsInDeck',
                              20
                            ]
                          ]
                        ]
                      ],
                      'else' => [
                        '$or' => [
                          [
                            '$lt' => [
                              '$landsInDeck',
                              10
                            ]
                          ],
                          [
                            '$gt' => [
                              '$landsInDeck',
                              28
                            ]
                          ]
                        ]
                      ]
                    ]
                  ],
                  [
                    '$not' => '$shuffledOrderOk'
                  ]
                ]
              ],
              'then' => [],
              'else' => [
                [
                  'group' => [
                    'deckSize' => '$deckSize',
                    'landsInDeck' => '$landsInDeck',
                    'bestOf' => '$bestOf',
                    'shuffling' => '$shuffling',
                    'mulliganType' => '$mulliganType',
                    'week' => '$week',
                    'type' => 'libraryLands'
                  ],
                  'data' => [
                    'mulligans' => [
                      '$subtract' => [
                        [
                          '$size' => [
                            '$ifNull' => [
                              '$handsDrawn',
                              []
                            ]
                          ]
                        ],
                        1
                      ]
                    ],
                    'landsDrawn' => [
                      '$arrayElemAt' => [
                        '$handLands',
                        -1
                      ]
                    ],
                    'libraryLands' => [
                      '$slice' => [
                        '$libraryLands',
                        10
                      ]
                    ]
                  ]
                ]
              ]
            ]
          ],
          [
            '$cond' => [
              'if' => [
                '$not' => '$decklistOk'
              ],
              'then' => [],
              'else' => [
                '$let' => [
                  'vars' => [
                    'deckArray' => [
                      '$reduce' => [
                        'input' => '$deck.mainDeck',
                        'initialValue' => [],
                        'in' => [
                          '$concatArrays' => [
                            '$$value',
                            [
                              '$map' => [
                                'input' => [
                                  '$range' => [
                                    0,
                                    '$$this.quantity'
                                  ]
                                ],
                                'as' => 'ignored',
                                'in' => '$$this.id'
                              ]
                            ]
                          ]
                        ]
                      ]
                    ],
                    'cardEstimationWeights' => [
                      '$reduce' => [
                        'input' => '$deck.mainDeck',
                        'initialValue' => [],
                        'in' => [
                          '$concatArrays' => [
                            '$$value',
                            [
                              '$map' => [
                                'input' => [
                                  '$range' => [
                                    0,
                                    '$$this.quantity'
                                  ]
                                ],
                                'as' => 'ignored',
                                'in' => [
                                  '$divide' => [
                                    1,
                                    '$$this.quantity'
                                  ]
                                ]
                              ]
                            ]
                          ]
                        ]
                      ]
                    ],
                    'dateSeconds' => [
                      '$toLong' => [
                        '$divide' => [
                          [
                            '$toLong' => [
                              '$dateFromString' => [
                                'dateString' => '$date'
                              ]
                            ]
                          ],
                          1000
                        ]
                      ]
                    ]
                  ],
                  'in' => [
                    '$map' => [
                      'input' => [
                        '$cond' => [
                          'if' => [
                            '$eq' => [
                              '$deckSize',
                              40
                            ]
                          ],
                          'then' => [
                            [
                              'numCards' => 0,
                              'buckets' => 1
                            ],
                            [
                              'numCards' => 1,
                              'buckets' => 1
                            ],
                            [
                              'numCards' => 1,
                              'buckets' => 40
                            ],
                            [
                              'numCards' => 2,
                              'buckets' => 1
                            ],
                            [
                              'numCards' => 2,
                              'buckets' => 39
                            ],
                            [
                              'numCards' => 3,
                              'buckets' => 1
                            ],
                            [
                              'numCards' => 3,
                              'buckets' => 38
                            ],
                            [
                              'numCards' => 4,
                              'buckets' => 1
                            ],
                            [
                              'numCards' => 4,
                              'buckets' => 37
                            ],
                            [
                              'numCards' => 15,
                              'buckets' => 1
                            ],
                            [
                              'numCards' => 15,
                              'buckets' => 26
                            ],
                            [
                              'numCards' => 16,
                              'buckets' => 1
                            ],
                            [
                              'numCards' => 16,
                              'buckets' => 25
                            ],
                            [
                              'numCards' => 17,
                              'buckets' => 1
                            ],
                            [
                              'numCards' => 17,
                              'buckets' => 24
                            ],
                            [
                              'numCards' => 18,
                              'buckets' => 1
                            ],
                            [
                              'numCards' => 18,
                              'buckets' => 23
                            ]
                          ],
                          'else' => [
                            [
                              'numCards' => 0,
                              'buckets' => 1
                            ],
                            [
                              'numCards' => 1,
                              'buckets' => 1
                            ],
                            [
                              'numCards' => 1,
                              'buckets' => 60
                            ],
                            [
                              'numCards' => 2,
                              'buckets' => 1
                            ],
                            [
                              'numCards' => 2,
                              'buckets' => 59
                            ],
                            [
                              'numCards' => 3,
                              'buckets' => 1
                            ],
                            [
                              'numCards' => 3,
                              'buckets' => 58
                            ],
                            [
                              'numCards' => 4,
                              'buckets' => 1
                            ],
                            [
                              'numCards' => 4,
                              'buckets' => 57
                            ],
                            [
                              'numCards' => 22,
                              'buckets' => 1
                            ],
                            [
                              'numCards' => 22,
                              'buckets' => 39
                            ],
                            [
                              'numCards' => 23,
                              'buckets' => 1
                            ],
                            [
                              'numCards' => 23,
                              'buckets' => 38
                            ],
                            [
                              'numCards' => 24,
                              'buckets' => 1
                            ],
                            [
                              'numCards' => 24,
                              'buckets' => 37
                            ],
                            [
                              'numCards' => 25,
                              'buckets' => 1
                            ],
                            [
                              'numCards' => 25,
                              'buckets' => 36
                            ]
                          ]
                        ]
                      ],
                      'as' => 'entry',
                      'in' => [
                        'group' => [
                          'deckSize' => '$deckSize',
                          'numCards' => '$$entry.numCards',
                          'bestOf' => '$bestOf',
                          'shuffling' => '$shuffling',
                          'mulliganType' => '$mulliganType',
                          'independent' => [
                            '$ne' => [
                              '$$entry.buckets',
                              1
                            ]
                          ],
                          'week' => '$week',
                          'type' => 'cardPositions'
                        ],
                        'data' => [
                          '$map' => [
                            'input' => [
                              '$range' => [
                                0,
                                7
                              ]
                            ],
                            'as' => 'mulligans',
                            'in' => [
                              '$map' => [
                                'input' => [
                                  '$range' => [
                                    0,
                                    [
                                      '$subtract' => [
                                        [
                                          '$add' => [
                                            '$deckSize',
                                            1
                                          ]
                                        ],
                                        [
                                          '$max' => [
                                            '$$entry.numCards',
                                            1
                                          ]
                                        ]
                                      ]
                                    ]
                                  ]
                                ],
                                'as' => 'position',
                                'in' => [
                                  '$switch' => [
                                    'branches' => [
                                      [
                                        'case' => [
                                          '$and' => [
                                            [
                                              '$ne' => [
                                                '$$entry.buckets',
                                                1
                                              ]
                                            ],
                                            [
                                              '$ne' => [
                                                [
                                                  '$mod' => [
                                                    '$$dateSeconds',
                                                    '$$entry.buckets'
                                                  ]
                                                ],
                                                '$$position'
                                              ]
                                            ]
                                          ]
                                        ],
                                        'then' => [
                                          '$map' => [
                                            'input' => [
                                              '$range' => [
                                                0,
                                                [
                                                  '$add' => [
                                                    [
                                                      '$min' => [
                                                        '$$entry.numCards',
                                                        [
                                                          '$cond' => [
                                                            'if' => [
                                                              '$eq' => [
                                                                '$mulliganType',
                                                                'vancouver'
                                                              ]
                                                            ],
                                                            'then' => [
                                                              '$subtract' => [
                                                                7,
                                                                '$$mulligans'
                                                              ]
                                                            ],
                                                            'else' => 7
                                                          ]
                                                        ]
                                                      ]
                                                    ],
                                                    1
                                                  ]
                                                ]
                                              ]
                                            ],
                                            'as' => 'numDrawn',
                                            'in' => 0
                                          ]
                                        ]
                                      ],
                                      [
                                        'case' => [
                                          '$eq' => [
                                            '$$entry.numCards',
                                            0
                                          ]
                                        ],
                                        'then' => [
                                          '$cond' => [
                                            'if' => [
                                              '$lte' => [
                                                [
                                                  '$size' => [
                                                    '$ifNull' => [
                                                      '$handsDrawn',
                                                      []
                                                    ]
                                                  ]
                                                ],
                                                '$$mulligans'
                                              ]
                                            ],
                                            'then' => [
                                              0,
                                              0
                                            ],
                                            'else' => [
                                              '$let' => [
                                                'vars' => [
                                                  'numDrawn' => [
                                                    '$size' => [
                                                      '$ifNull' => [
                                                        [
                                                          '$filter' => [
                                                            'input' => [
                                                              '$arrayElemAt' => [
                                                                '$handsDrawn',
                                                                '$$mulligans'
                                                              ]
                                                            ],
                                                            'as' => 'card',
                                                            'cond' => [
                                                              '$eq' => [
                                                                '$$card',
                                                                [
                                                                  '$arrayElemAt' => [
                                                                    '$$deckArray',
                                                                    '$$position'
                                                                  ]
                                                                ]
                                                              ]
                                                            ]
                                                          ]
                                                        ],
                                                        []
                                                      ]
                                                    ]
                                                  ]
                                                ],
                                                'in' => [
                                                  [
                                                    '$subtract' => [
                                                      1,
                                                      [
                                                        '$multiply' => [
                                                          '$$numDrawn',
                                                          [
                                                            '$arrayElemAt' => [
                                                              '$$cardEstimationWeights',
                                                              '$$position'
                                                            ]
                                                          ]
                                                        ]
                                                      ]
                                                    ]
                                                  ],
                                                  [
                                                    '$multiply' => [
                                                      '$$numDrawn',
                                                      [
                                                        '$arrayElemAt' => [
                                                          '$$cardEstimationWeights',
                                                          '$$position'
                                                        ]
                                                      ]
                                                    ]
                                                  ]
                                                ]
                                              ]
                                            ]
                                          ]
                                        ]
                                      ]
                                    ],
                                    'default' => [
                                      '$map' => [
                                        'input' => [
                                          '$range' => [
                                            0,
                                            [
                                              '$add' => [
                                                [
                                                  '$min' => [
                                                    '$$entry.numCards',
                                                    [
                                                      '$cond' => [
                                                        'if' => [
                                                          '$eq' => [
                                                            '$mulliganType',
                                                            'vancouver'
                                                          ]
                                                        ],
                                                        'then' => [
                                                          '$subtract' => [
                                                            7,
                                                            '$$mulligans'
                                                          ]
                                                        ],
                                                        'else' => 7
                                                      ]
                                                    ]
                                                  ]
                                                ],
                                                1
                                              ]
                                            ]
                                          ]
                                        ],
                                        'as' => 'numDrawn',
                                        'in' => [
                                          '$switch' => [
                                            'branches' => [
                                              [
                                                'case' => [
                                                  '$lte' => [
                                                    [
                                                      '$size' => [
                                                        '$ifNull' => [
                                                          '$handsDrawn',
                                                          []
                                                        ]
                                                      ]
                                                    ],
                                                    '$$mulligans'
                                                  ]
                                                ],
                                                'then' => 0
                                              ],
                                              [
                                                'case' => [
                                                  '$and' => [
                                                    [
                                                      '$ne' => [
                                                        [
                                                          '$arrayElemAt' => [
                                                            '$$deckArray',
                                                            '$$position'
                                                          ]
                                                        ],
                                                        [
                                                          '$arrayElemAt' => [
                                                            '$$deckArray',
                                                            [
                                                              '$subtract' => [
                                                                '$$position',
                                                                1
                                                              ]
                                                            ]
                                                          ]
                                                        ]
                                                      ]
                                                    ],
                                                    [
                                                      '$ne' => [
                                                        [
                                                          '$arrayElemAt' => [
                                                            '$$deckArray',
                                                            [
                                                              '$add' => [
                                                                '$$position',
                                                                '$$entry.numCards',
                                                                -1
                                                              ]
                                                            ]
                                                          ]
                                                        ],
                                                        [
                                                          '$arrayElemAt' => [
                                                            '$$deckArray',
                                                            [
                                                              '$add' => [
                                                                '$$position',
                                                                '$$entry.numCards'
                                                              ]
                                                            ]
                                                          ]
                                                        ]
                                                      ]
                                                    ],
                                                    [
                                                      '$eq' => [
                                                        '$$numDrawn',
                                                        [
                                                          '$size' => [
                                                            '$ifNull' => [
                                                              [
                                                                '$filter' => [
                                                                  'input' => [
                                                                    '$arrayElemAt' => [
                                                                      '$handsDrawn',
                                                                      '$$mulligans'
                                                                    ]
                                                                  ],
                                                                  'as' => 'card',
                                                                  'cond' => [
                                                                    '$in' => [
                                                                      '$$card',
                                                                      [
                                                                        '$slice' => [
                                                                          '$$deckArray',
                                                                          '$$position',
                                                                          '$$entry.numCards'
                                                                        ]
                                                                      ]
                                                                    ]
                                                                  ]
                                                                ]
                                                              ],
                                                              []
                                                            ]
                                                          ]
                                                        ]
                                                      ]
                                                    ]
                                                  ]
                                                ],
                                                'then' => 1
                                              ]
                                            ],
                                            'default' => 0
                                          ]
                                        ]
                                      ]
                                    ]
                                  ]
                                ]
                              ]
                            ]
                          ]
                        ]
                      ]
                    ]
                  ]
                ]
              ]
            ]
          ],
          [
            '$cond' => [
              'if' => [
                '$not' => '$decklistOk'
              ],
              'then' => [],
              'else' => [
                '$map' => [
                  'input' => [
                    '$filter' => [
                      'input' => [
                        '$objectToArray' => '$multiCardPositions'
                      ],
                      'as' => 'positionSets',
                      'cond' => [
                        '$ne' => [
                          '$$positionSets.v',
                          (object)[]
                        ]
                      ]
                    ]
                  ],
                  'as' => 'positionSets',
                  'in' => [
                    'group' => [
                      'deckSize' => '$deckSize',
                      'numCards' => [
                        '$toInt' => '$$positionSets.k'
                      ],
                      'bestOf' => '$bestOf',
                      'shuffling' => '$shuffling',
                      'mulliganType' => '$mulliganType',
                      'week' => '$week',
                      'type' => 'cardCopies'
                    ],
                    'data' => [
                      '$map' => [
                        'input' => [
                          '$range' => [
                            0,
                            7
                          ]
                        ],
                        'as' => 'mulligans',
                        'in' => [
                          '$cond' => [
                            'if' => [
                              '$lte' => [
                                [
                                  '$size' => [
                                    '$ifNull' => [
                                      '$handsDrawn',
                                      []
                                    ]
                                  ]
                                ],
                                '$$mulligans'
                              ]
                            ],
                            'then' => [],
                            'else' => [
                              '$map' => [
                                'input' => [
                                  '$objectToArray' => '$$positionSets.v'
                                ],
                                'as' => 'card',
                                'in' => [
                                  '$let' => [
                                    'vars' => [
                                      'cardId' => [
                                        '$toInt' => '$$card.k'
                                      ]
                                    ],
                                    'in' => [
                                      '$size' => [
                                        '$ifNull' => [
                                          [
                                            '$filter' => [
                                              'input' => [
                                                '$arrayElemAt' => [
                                                  '$handsDrawn',
                                                  '$$mulligans'
                                                ]
                                              ],
                                              'as' => 'cardDrawn',
                                              'cond' => [
                                                '$eq' => [
                                                  '$$cardDrawn',
                                                  '$$cardId'
                                                ]
                                              ]
                                            ]
                                          ],
                                          []
                                        ]
                                      ]
                                    ]
                                  ]
                                ]
                              ]
                            ]
                          ]
                        ]
                      ]
                    ]
                  ]
                ]
              ]
            ]
          ]
        ]
      ]
    ]
  ],
  [
    '$unwind' => [
      'path' => '$stats'
    ]
  ],
  [
    '$group' => [
      '_id' => '$stats.group',
      'date' => [
        '$max' => '$date'
      ],
      'data' => [
        '$push' => '$stats.data'
      ],
      'numGames' => [
        '$sum' => 1
      ],
      'numMatches' => [
        '$sum' => [
          '$toInt' => [
            '$eq' => [
              '$gameIndex',
              0
            ]
          ]
        ]
      ]
    ]
  ],
  [
    '$addFields' => [
      'data' => [
        '$switch' => [
          'branches' => [
            [
              'case' => [
                '$eq' => [
                  '$_id.type',
                  'handLands'
                ]
              ],
              'then' => [
                '$map' => [
                  'input' => [
                    '$range' => [
                      0,
                      7
                    ]
                  ],
                  'as' => 'mulligans',
                  'in' => [
                    '$map' => [
                      'input' => [
                        '$range' => [
                          0,
                          [
                            '$cond' => [
                              'if' => [
                                '$eq' => [
                                  '$_id.mulliganType',
                                  'vancouver'
                                ]
                              ],
                              'then' => [
                                '$subtract' => [
                                  8,
                                  '$$mulligans'
                                ]
                              ],
                              'else' => 8
                            ]
                          ]
                        ]
                      ],
                      'as' => 'count',
                      'in' => [
                        '$size' => [
                          '$ifNull' => [
                            [
                              '$filter' => [
                                'input' => '$data',
                                'as' => 'hands',
                                'cond' => [
                                  '$eq' => [
                                    [
                                      '$arrayElemAt' => [
                                        '$$hands',
                                        '$$mulligans'
                                      ]
                                    ],
                                    '$$count'
                                  ]
                                ]
                              ]
                            ],
                            []
                          ]
                        ]
                      ]
                    ]
                  ]
                ]
              ]
            ],
            [
              'case' => [
                '$eq' => [
                  '$_id.type',
                  'libraryLands'
                ]
              ],
              'then' => [
                '$map' => [
                  'input' => [
                    '$range' => [
                      0,
                      7
                    ]
                  ],
                  'as' => 'mulligans',
                  'in' => [
                    '$map' => [
                      'input' => [
                        '$range' => [
                          0,
                          [
                            '$cond' => [
                              'if' => [
                                '$eq' => [
                                  '_id.$mulliganType',
                                  'vancouver'
                                ]
                              ],
                              'then' => [
                                '$subtract' => [
                                  8,
                                  '$$mulligans'
                                ]
                              ],
                              'else' => 8
                            ]
                          ]
                        ]
                      ],
                      'as' => 'landsInHand',
                      'in' => [
                        '$map' => [
                          'input' => [
                            '$range' => [
                              0,
                              10
                            ]
                          ],
                          'as' => 'position',
                          'in' => [
                            '$map' => [
                              'input' => [
                                '$range' => [
                                  0,
                                  [
                                    '$min' => [
                                      [
                                        '$add' => [
                                          '$$position',
                                          2
                                        ]
                                      ],
                                      [
                                        '$add' => [
                                          [
                                            '$subtract' => [
                                              '$_id.landsInDeck',
                                              '$$landsInHand'
                                            ]
                                          ],
                                          1
                                        ]
                                      ]
                                    ]
                                  ]
                                ]
                              ],
                              'as' => 'count',
                              'in' => [
                                '$let' => [
                                  'vars' => [
                                    'filtered' => [
                                      '$filter' => [
                                        'input' => '$data',
                                        'as' => 'entry',
                                        'cond' => [
                                          '$and' => [
                                            [
                                              '$eq' => [
                                                '$$mulligans',
                                                '$$entry.mulligans'
                                              ]
                                            ],
                                            [
                                              '$eq' => [
                                                '$$landsInHand',
                                                '$$entry.landsDrawn'
                                              ]
                                            ]
                                          ]
                                        ]
                                      ]
                                    ]
                                  ],
                                  'in' => [
                                    [
                                      '$size' => [
                                        '$ifNull' => [
                                          [
                                            '$filter' => [
                                              'input' => '$$filtered',
                                              'as' => 'entry',
                                              'cond' => [
                                                '$eq' => [
                                                  [
                                                    '$arrayElemAt' => [
                                                      '$$entry.libraryLands',
                                                      '$$position'
                                                    ]
                                                  ],
                                                  '$$count'
                                                ]
                                              ]
                                            ]
                                          ],
                                          []
                                        ]
                                      ]
                                    ],
                                    [
                                      '$size' => [
                                        '$ifNull' => [
                                          [
                                            '$filter' => [
                                              'input' => '$$filtered',
                                              'as' => 'entry',
                                              'cond' => [
                                                '$and' => [
                                                  [
                                                    '$eq' => [
                                                      [
                                                        '$arrayElemAt' => [
                                                          '$$entry.libraryLands',
                                                          -1
                                                        ]
                                                      ],
                                                      '$$count'
                                                    ]
                                                  ],
                                                  [
                                                    '$eq' => [
                                                      [
                                                        '$size' => [
                                                          '$ifNull' => [
                                                            '$$entry.libraryLands',
                                                            []
                                                          ]
                                                        ]
                                                      ],
                                                      '$$position'
                                                    ]
                                                  ]
                                                ]
                                              ]
                                            ]
                                          ],
                                          []
                                        ]
                                      ]
                                    ]
                                  ]
                                ]
                              ]
                            ]
                          ]
                        ]
                      ]
                    ]
                  ]
                ]
              ]
            ],
            [
              'case' => [
                '$eq' => [
                  '$_id.type',
                  'cardPositions'
                ]
              ],
              'then' => [
                '$reduce' => [
                  'input' => [
                    '$slice' => [
                      '$data',
                      1,
                      [
                        '$size' => [
                          '$ifNull' => [
                            '$data',
                            []
                          ]
                        ]
                      ]
                    ]
                  ],
                  'initialValue' => [
                    '$arrayElemAt' => [
                      '$data',
                      0
                    ]
                  ],
                  'in' => [
                    '$map' => [
                      'input' => [
                        '$zip' => [
                          'inputs' => [
                            '$$value',
                            '$$this'
                          ]
                        ]
                      ],
                      'as' => 'mulliganStats',
                      'in' => [
                        '$map' => [
                          'input' => [
                            '$zip' => [
                              'inputs' => [
                                [
                                  '$arrayElemAt' => [
                                    '$$mulliganStats',
                                    0
                                  ]
                                ],
                                [
                                  '$arrayElemAt' => [
                                    '$$mulliganStats',
                                    1
                                  ]
                                ]
                              ]
                            ]
                          ],
                          'as' => 'positionStats',
                          'in' => [
                            '$map' => [
                              'input' => [
                                '$zip' => [
                                  'inputs' => [
                                    [
                                      '$arrayElemAt' => [
                                        '$$positionStats',
                                        0
                                      ]
                                    ],
                                    [
                                      '$arrayElemAt' => [
                                        '$$positionStats',
                                        1
                                      ]
                                    ]
                                  ]
                                ]
                              ],
                              'as' => 'countStats',
                              'in' => [
                                '$sum' => '$$countStats'
                              ]
                            ]
                          ]
                        ]
                      ]
                    ]
                  ]
                ]
              ]
            ],
            [
              'case' => [
                '$eq' => [
                  '$_id.type',
                  'cardCopies'
                ]
              ],
              'then' => [
                '$map' => [
                  'input' => [
                    '$range' => [
                      0,
                      7
                    ]
                  ],
                  'as' => 'mulligans',
                  'in' => [
                    '$map' => [
                      'input' => [
                        '$range' => [
                          0,
                          [
                            '$min' => [
                              [
                                '$add' => [
                                  '$_id.numCards',
                                  1
                                ]
                              ],
                              [
                                '$cond' => [
                                  'if' => [
                                    '$eq' => [
                                      '_id.$mulliganType',
                                      'vancouver'
                                    ]
                                  ],
                                  'then' => [
                                    '$subtract' => [
                                      8,
                                      '$$mulligans'
                                    ]
                                  ],
                                  'else' => 8
                                ]
                              ]
                            ]
                          ]
                        ]
                      ],
                      'as' => 'count',
                      'in' => [
                        '$sum' => [
                          '$map' => [
                            'input' => '$data',
                            'as' => 'entry',
                            'in' => [
                              '$size' => [
                                '$ifNull' => [
                                  [
                                    '$filter' => [
                                      'input' => [
                                        '$arrayElemAt' => [
                                          '$$entry',
                                          '$$mulligans'
                                        ]
                                      ],
                                      'as' => 'drawn',
                                      'cond' => [
                                        '$eq' => [
                                          '$$drawn',
                                          '$$count'
                                        ]
                                      ]
                                    ]
                                  ],
                                  []
                                ]
                              ]
                            ]
                          ]
                        ]
                      ]
                    ]
                  ]
                ]
              ]
            ]
          ]
        ]
      ]
    ]
  ],
  [
    '$lookup' => [
      'from' => 'shuffler_stats',
      'localField' => '_id',
      'foreignField' => '_id',
      'as' => 'existing_stats'
    ]
  ],
  [
    '$project' => [
      'date' => 1,
      'data' => [
        '$cond' => [
          'if' => [
            '$eq' => [
              [
                '$size' => [
                  '$ifNull' => [
                    '$existing_stats',
                    []
                  ]
                ]
              ],
              0
            ]
          ],
          'then' => '$data',
          'else' => [
            '$map' => [
              'input' => [
                '$zip' => [
                  'inputs' => [
                    '$data',
                    [
                      '$arrayElemAt' => [
                        '$existing_stats.data',
                        0
                      ]
                    ]
                  ]
                ]
              ],
              'as' => 'mulliganStats',
              'in' => [
                '$map' => [
                  'input' => [
                    '$zip' => [
                      'inputs' => [
                        [
                          '$arrayElemAt' => [
                            '$$mulliganStats',
                            0
                          ]
                        ],
                        [
                          '$arrayElemAt' => [
                            '$$mulliganStats',
                            1
                          ]
                        ]
                      ]
                    ]
                  ],
                  'as' => 'stats2',
                  'in' => [
                    '$cond' => [
                      'if' => [
                        '$in' => [
                          '$_id.type',
                          [
                            'handLands',
                            'cardCopies'
                          ]
                        ]
                      ],
                      'then' => [
                        '$sum' => '$$stats2'
                      ],
                      'else' => [
                        '$map' => [
                          'input' => [
                            '$zip' => [
                              'inputs' => [
                                [
                                  '$arrayElemAt' => [
                                    '$$stats2',
                                    0
                                  ]
                                ],
                                [
                                  '$arrayElemAt' => [
                                    '$$stats2',
                                    1
                                  ]
                                ]
                              ]
                            ]
                          ],
                          'as' => 'stats3',
                          'in' => [
                            '$cond' => [
                              'if' => [
                                '$eq' => [
                                  '$_id.type',
                                  'cardPositions'
                                ]
                              ],
                              'then' => [
                                '$sum' => '$$stats3'
                              ],
                              'else' => [
                                '$map' => [
                                  'input' => [
                                    '$zip' => [
                                      'inputs' => [
                                        [
                                          '$arrayElemAt' => [
                                            '$$stats3',
                                            0
                                          ]
                                        ],
                                        [
                                          '$arrayElemAt' => [
                                            '$$stats3',
                                            1
                                          ]
                                        ]
                                      ]
                                    ]
                                  ],
                                  'as' => 'stats4',
                                  'in' => [
                                    '$map' => [
                                      'input' => [
                                        '$zip' => [
                                          'inputs' => [
                                            [
                                              '$arrayElemAt' => [
                                                '$$stats4',
                                                0
                                              ]
                                            ],
                                            [
                                              '$arrayElemAt' => [
                                                '$$stats4',
                                                1
                                              ]
                                            ]
                                          ]
                                        ]
                                      ],
                                      'as' => 'stats5',
                                      'in' => [
                                        '$sum' => '$$stats5'
                                      ]
                                    ]
                                  ]
                                ]
                              ]
                            ]
                          ]
                        ]
                      ]
                    ]
                  ]
                ]
              ]
            ]
          ]
        ]
      ],
      'numGames' => [
        '$cond' => [
          'if' => [
            '$eq' => [
              [
                '$size' => [
                  '$ifNull' => [
                    '$existing_stats',
                    []
                  ]
                ]
              ],
              0
            ]
          ],
          'then' => '$numGames',
          'else' => [
            '$add' => [
              '$numGames',
              [
                '$arrayElemAt' => [
                  '$existing_stats.numGames',
                  0
                ]
              ]
            ]
          ]
        ]
      ],
      'numMatches' => [
        '$cond' => [
          'if' => [
            '$eq' => [
              [
                '$size' => [
                  '$ifNull' => [
                    '$existing_stats',
                    []
                  ]
                ]
              ],
              0
            ]
          ],
          'then' => '$numMatches',
          'else' => [
            '$add' => [
              '$numMatches',
              [
                '$arrayElemAt' => [
                  '$existing_stats.numMatches',
                  0
                ]
              ]
            ]
          ]
        ]
      ]
    ]
  ]
];

$statusPipeline = [
  [
    '$match' => [
      '_id.type' => 'cardPositions',
      '_id.numCards' => 0
    ]
  ], [
    '$group' => [
      '_id' => NULL,
      'numGames' => [
        '$sum' => '$numGames'
      ],
      'numMatches' => [
        '$sum' => '$numMatches'
      ]
    ]
  ]
];

$gamesBefore = 0;
$matchesBefore = 0;
$cursor = $mongo_shuffler->aggregate($statusPipeline, ['session' => $session]);
foreach ($cursor as $document) {
  $gamesBefore = $document['numGames'];
  $matchesBefore = $document['numMatches'];
}

$updatesBatch = [];
$ready = 0;
$newEndStr = null;
$cursor = $mongo_matches->aggregate($shuffler_pipeline, ['allowDiskUse' => TRUE, 'session' => $session]);
foreach ($cursor as $document) {
  if ($newEndStr === null || strcmp($newEndStr, $document['date']) < 0) {
    $newEndStr = $document['date'];
  }
  $updatesBatch[] = ['replaceOne' => [['_id' => $document['_id']], $document, ['upsert' => TRUE]]];
  $ready++;
  if ($ready === 100) {
    $mongo_shuffler->bulkWrite($updatesBatch, ['ordered' => FALSE, 'session' => $session]);
    $updatesBatch = [];
    $ready = 0;
  }
}
if ($ready !== 0) {
  $mongo_shuffler->bulkWrite($updatesBatch, ['ordered' => FALSE, 'session' => $session]);
}

$endStr = $newEndStr !== null ? $newEndStr : $endStr;
// If we deleted anything, or used a manual end time, lastProcessed's value may be invalidated.
if (count($deleteConditions) > 0 || array_key_exists('aggregateThroughWeek', $_GET)) {
  $mongo_shuffler->deleteOne(['_id' => 'lastProcessed'], ['session' => $session]);
} else {
  $lastProcessed = [
    '_id' => 'lastProcessed',
    'date' => $endStr
  ];
  $mongo_shuffler->replaceOne(['_id' => 'lastProcessed'], $lastProcessed, ['upsert' => TRUE, 'session' => $session]);
}

$gamesAfter = $gamesBefore;
$matchesAfter = $matchesBefore;
$cursor = $mongo_shuffler->aggregate($statusPipeline, ['session' => $session]);
foreach ($cursor as $document) {
  $gamesAfter = $document['numGames'];
  $matchesAfter = $document['numMatches'];
}

$newGames = $gamesAfter - $gamesBefore;
$newMatches = $matchesAfter - $matchesBefore;
$unfilteredMatches = $mongo_matches->countDocuments(
  ['$and' => [['date' => ['$gt' => $date_recorded]], ['date' => ['$lte' => $endStr]]]],
  ['session' => $session]);

header('Content-Type: text/plain');
echo "Delete conditions: " . count($deleteConditions) . "
Aggregate conditions: " . count($aggregateConditions) . "
Aggregated from $date_recorded to $endStr
Unfiltered new matches: $unfilteredMatches
New games: $newGames
New matches: $newMatches
Total games: $gamesAfter
Total matches: $matchesAfter";