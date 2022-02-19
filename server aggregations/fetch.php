<?php

//require_once "D:/Games/MTG-Arena-Tool/vendor/autoload.php";
require_once(join(DIRECTORY_SEPARATOR,[__DIR__, '..', '..', 'vendor','autoload.php']));
require_once(join(DIRECTORY_SEPARATOR, [__DIR__, '..', 'get_mongo_client.php']));

header('Access-Control-Allow-Origin: *');
if (array_key_exists( 'REQUEST_METHOD', $_SERVER) && $_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
  header('Access-Control-Allow-Methods: GET, OPTIONS');
  header('Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept');
  header('Access-Control-Max-Age: 86400');
  exit();
}
header('Content-Type: application/json');

function fail($queryType, $name, $validValString) {
  http_response_code(400);
  echo $queryType . ' query requires \'' . $name . '\' parameter. Valid values: ' . $validValString . '.';
  exit();
}

function checkParam($queryType, $name, $validVals) {
  if (!array_key_exists($name, $_GET) || !in_array($_GET[$name], $validVals)) {
    fail($queryType, $name, '"' . join('", "', $validVals) . '"');
  }
}

function checkBoolParam($queryType, $name) {
  if (!array_key_exists($name, $_GET) || !in_array($_GET[$name], ["true", "false"])) {
    fail($queryType, $name, 'true, false');
  }
}

function checkIntParam($queryType, $name, $validVals) {
  if (!array_key_exists($name, $_GET) || !ctype_digit($_GET[$name]) || !in_array((int)$_GET[$name], $validVals)) {
    fail($queryType, $name, join(', ', $validVals));
  }
}

function checkRangeParam($queryType, $name, $range) {
  if (!array_key_exists($name, $_GET) || !ctype_digit($_GET[$name])
      || (int)$_GET[$name] < $range[0] || (int)$_GET[$name] > $range[1]) {
    fail($queryType, $name, $range[0] . ' through ' . $range[1]);
  }
}

checkParam('', 'type', ['handLands', 'libraryLands', 'cardPositions', 'cardCopies']);

switch ($_GET['type']) {
  case 'handLands':
  case 'cardCopies':
    $query = ['_id.type' => $_GET['type']];
    break;
  case 'libraryLands':
    checkIntParam('Lands in library', 'deckSize', [40, 60]);
    $deckSize = (int)$_GET['deckSize'];
    checkRangeParam('Lands in library', 'landsInDeck', $deckSize === 40 ? [14, 20] : [10, 28]);
    $query = ['_id.type' => $_GET['type'], '_id.deckSize' => $deckSize, '_id.landsInDeck' => (int)$_GET['landsInDeck']];
    break;
  case 'cardPositions':
    checkIntParam('Cards by decklist position', 'deckSize', [40, 60]);
    checkIntParam('Cards by decklist position', 'numCards',
      (int)$_GET['deckSize'] === 40 ? [0, 1, 2, 3, 4, 15, 16, 17, 18] : [0, 1, 2, 3, 4, 22, 23, 24, 25]);
    checkBoolParam('Cards by decklist position', 'independent');
    $query = [
      '_id.type' => $_GET['type'],
      '_id.deckSize' => (int)$_GET['deckSize'],
      '_id.numCards' => (int)$_GET['numCards'],
      '_id.independent' => $_GET['independent'] === "true"
    ];
    break;
}

//$mongo_shuffler = (new MongoDB\Client)->tracker->shuffler_stats;
$mongo_shuffler = newMongoClient()->tracker->shuffler_stats;
$pipeline = [
  [
    '$match' => $query
  ], [
    '$project' => [
      '_id' => 0,
      'date' => 1,
      'group' => '$_id',
      'data' => 1,
      'numGames' => 1,
      'numMatches' => 1
    ]
  ]
];

$cursor = $mongo_shuffler->aggregate($pipeline, [ 'allowDiskUse' => TRUE ]);
echo json_encode(iterator_to_array($cursor, false));