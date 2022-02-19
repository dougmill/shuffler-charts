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

$session = $client->startSession();

// Want to process matches a) newer than any processed before, and b) old enough that any reasonable variation in clock
// time on the player's computer will not make a match be missed.

$mainFilter = [
  '$and' => [
    [
      'date' => [
        '$gt' => "2020-09-01T00:00:00.000Z" // placeholder
      ]
    ],
    [
      'date' => [
        '$lte' => "2020-09-02T00:00:00.000Z" // placeholder
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
    '$limit' => 100
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
];

$cursor = $mongo_matches->aggregate($shuffler_pipeline, [ 'allowDiskUse' => TRUE ]);
echo json_encode(iterator_to_array($cursor, false));