import 'dart:async';
import 'dart:convert';

import 'package:angular/core.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

part 'data_service.g.dart';

/// Service that handles fetching, combining, and caching data from the server.
class DataService implements OnInit {
  // numCards => [mulligans][position][numDrawn] = count of games
  final totalCounts = Map<int, List<List<List<int>>>>();
  final perWeekCounts = List<Map<int, List<List<List<int>>>>>();

  final _status = BehaviorSubject<String>.seeded('Fetching');

  Stream<String> get status => _status.stream;

  final _loaded = BehaviorSubject<bool>.seeded(false);

  ValueObservable<bool> get loaded => _loaded.stream;

  @override
  Future<void> ngOnInit() async {
    String url =
        'https://mtgatool.com/shuffler_test/fetch.php?stats_type=positions';
    try {
      String body = await http.read(url);
      _status.add('Parsing');
      List<dynamic> parsed = json.decode(body);
      _status.add('Processing: 0%');
      parsed.sort((a, b) => a['group']['week'].compareTo(b['group']['week']));
      Map<int, List<List<List<int>>>> week;
      for (int i = 0; i < parsed.length; i++) {
        dynamic entry = parsed[i];
        if (entry.group.week >= perWeekCounts.length) {
          week = Map();
          perWeekCounts.add(week);
        }
        int numCards = entry['group']['numCards'] ?? 0;
        week[numCards] = entry['distribution'];
        List<List<List<int>>> totals =
            totalCounts.putIfAbsent(numCards, () => List());
        if (!totalCounts.containsKey(numCards)) {
          await (_combine(totals, entry['distribution'], i / parsed.length,
              1 / parsed.length));
        }
      }
      _status.add('Processing complete');
      _loaded.add(true);
    } on http.ClientException catch (ex) {
      _status.add('Error fetching data: ${ex.message}');
    } catch (ex) {
      _status.add('Error parsing or processing data: $ex');
    }
  }

  Future<void> _combine(List<dynamic> dest, List<dynamic> toAdd, double base,
      double portion) async {
    double newBase = base;
    double newPortion = portion / dest.length;
    Function combiner = toAdd[0] is List
        ? (i) async => await _combine(dest[i], toAdd[i], newBase, newPortion)
        : (i) async => dest[i] + toAdd[i];
    for (int i = 0; i < dest.length; i++) {
      await combiner(i);
      newBase += newPortion;
      String newStatus = 'Processing: ${(newBase * 100).round()}%';
      if (_status.value != newStatus) {
        _status.add(newStatus);
      }
    }
  }
}

Future<MapData<dynamic, dynamic>> parseEntries(StreamController<double> progressReporter,
    List<dynamic> json,
    BuiltList<String> groupKeys, BuiltList<String> indexNames) async {
//  var result =
  for (int i = 0; i < json.length; i++) {
   // MapDataBuilder<dynamic, dynamic> branch = result;
    Map<String, dynamic> entry = json[i];
    Map<String, dynamic> group = entry['group'];
    for (var key in groupKeys) {
     // branch = branch.data[group[key]] ?? branch.data = MapD
    }
  }
}

Future<Data<dynamic>> parseArrays(StreamController<double> progressReporter,
    List<dynamic> input,
    BuiltList<String> indexNames, int currentLevel) async {
  if (currentLevel == indexNames.length - 1) {
    var retVal = CountsData((b) =>
    b..parameter = indexNames.last
      ..data = ListBuilder(input));
    progressReporter.add(1);
    return retVal;
  } else {
    var builder = ListDataBuilder<Data<dynamic>>()..parameter = indexNames[currentLevel];
    for (int i = 0; i < input.length; i++) {
      var subProgress = StreamController<double>();
      Future<Data<dynamic>> subVal = parseArrays(subProgress, input[i], indexNames, currentLevel + 1);
      await for (double sub in subProgress.stream) {
        progressReporter.add((i + sub) / input.length);
      }
      builder.data.add(await subVal);
    }
    return builder.build();
  }
}

/*
Problems:
1. Must know generic type (can't be dynamic) at object creation.
2. Automatic conversion between built and builder in nested fields does not
carry through generic fields, and in particular doesn't work for the contents of
BuiltList and BuiltMap.
3. I can't work around problem 2 by generating non-generic list/map classes with
built_value, or even by using BuiltList/Map with hard coded types.
 */

abstract class Data<T> {
  String get parameter;

  T get data;
}

abstract class MapData<K, V extends Data<dynamic>>
    implements Data<BuiltMap<K, V>>, Built<MapData<K, V>, MapDataBuilder<K, V>> {
  MapData._();

  factory MapData([void Function(MapDataBuilder<K, V>) updates]) =
      _$MapData<K, V>;
}

abstract class ListData<T extends Data<dynamic>>
    implements Data<BuiltList<T>>, Built<ListData<T>, ListDataBuilder<T>> {
  ListData._();

  factory ListData([void Function(ListDataBuilder<T>) updates]) = _$ListData<T>;
}

abstract class CountsData
    implements Data<BuiltList<int>>, Built<CountsData, CountsDataBuilder> {
  CountsData._();

  factory CountsData([void Function(CountsDataBuilder) updates]) = _$CountsData;
}
