import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import 'package:shuffler_charts/src/data/predictions.dart';
import 'package:shuffler_charts/src/parameters/parameters.dart';

import 'data/data.dart';

part 'data_service.g.dart';

/// Service that handles fetching, combining, and caching data from the server.
class DataService {
  final _dataCache = Map<FetchParameters, ValueStream<LoadingState>>();
  final _statsCache = Map<Parameters, ValueStream<LoadingState>>();

  ValueStream<LoadingState> loadStats(Parameters params) {
    return _statsCache[params] ??= _fromStream(_loadStats(params));
  }

  ValueStream<T> _fromStream<T>(Stream<T> stream) {
    var obs = BehaviorSubject<T>();
    return obs..addStream(stream).then((_) => obs.close());
  }

  Stream<LoadingState> _loadStats(Parameters params) async* {
    var fetchParams = FetchParameters.from(params);
    var dataStream =
        _dataCache[fetchParams] ??= _fromStream(_fetchData(fetchParams));
    yield* dataStream;
    yield* _aggregate(dataStream.value.data, params);
  }

  Stream<LoadingState> _fetchData(FetchParameters params) async* {
    String url = '/shuffler_stats.json';
    Future<String> request = http.read(url);
    yield LoadingState((b) => b.stage = LoadingStage.fetching);
    await _runEventLoop();
    String rawData = await request;

    yield LoadingState((b) => b.stage = LoadingStage.parsing);
    await _runEventLoop(true);
    const entryTypes = {
      StatsType.handLands: FullType(LandsInHandEntry),
      StatsType.libraryLands: FullType(LandsInLibraryEntry),
      StatsType.cardPositions: FullType(CardsByPositionEntry),
      StatsType.cardCopies: FullType(CardsByCountEntry)
    };
    List<Object> json = jsonDecode(rawData);

    var dataBuilder = ListBuilder<DataEntry>();
    for (int i = 0; i < json.length; i++) {
      yield LoadingState((b) => b
        ..stage = LoadingStage.processing
        ..progress = i / json.length);
      await _runEventLoop();
      dataBuilder.add(dataSerializers.deserialize(json[i],
          specifiedType: entryTypes[params.type]));
    }
    yield LoadingState((b) => b
      ..stage = LoadingStage.processing
      ..progress = 1
      ..data = dataBuilder);
    await _runEventLoop();
  }

  Stream<LoadingState> _aggregate(
      BuiltList<DataEntry> data, Parameters params) async* {
    var paramValuesMap = params.asMap.map((k, v) {
      if (v.type == ParameterType.selection) {
        return MapEntry(k, BuiltSet<Object>.of([v.value]));
      } else {
        return MapEntry(
            k,
            BuiltSet<Object>.of(
                v.options.where((o) => o.selected).map((o) => o.value)));
      }
    });

    var options = BuiltSet<DisplayOption>.of({
      for (var option in params.options.options)
        if (option.selected) option.value,
      if (params.xAxis.value is DisplayOption) params.xAxis.value
    });
    var statsBuilder = <DisplayOption, Map<Object, Map<Object, num>>>{
      for (var option in {...options, DisplayOption.sampleSize})
        option: {
          for (var breakdownKey in params.breakdownBy.value == 'none'
              ? ['']
              : paramValuesMap[params.breakdownBy.value])
            breakdownKey: {
              for (var xKey in paramValuesMap[params.xAxis.value]) xKey: 0
            }
        }
    };

    entry:
    for (int i = 0; i < data.length; i++) {
      yield LoadingState((b) => b
        ..stage = LoadingStage.aggregating
        ..progress = i / data.length);
      await _runEventLoop();

      var entry = data[i];
      var group = entry.group;
      Object breakdownKey = '';
      Object xKey = '';
      var inputsForExpected = HypergeometricInputsBuilder()
        ..population = group.deckSize
        ..hits = max(group.numCards, 1);
      var inputsForBugged = BuggedInputsBuilder()
        ..population = group.deckSize
        ..hits = max(group.numCards, 1);

      void maybeSetKey(String name, Object value) {
        if (name == params.breakdownBy.value) {
          breakdownKey = value;
        } else if (name == params.xAxis.value) {
          xKey = value;
        }
        switch (name) {
          case 'mulligans':
            int handSize =
                group.mulliganType == MulliganType.london ? 7 : 7 - value;
            if (group.type != StatsType.libraryLands) {
              inputsForExpected.sample = handSize;
            } else {
              inputsForExpected.population = group.deckSize - handSize;
            }
            inputsForBugged.mulligans = value;
            inputsForBugged.sample = handSize;
            break;
          case 'decklistPosition':
            inputsForBugged.position = value;
            break;
          case 'landsInHand':
            inputsForExpected.hits = group.numCards - value;
            break;
          case 'libraryPosition':
            inputsForExpected.sample = 1 + value;
            break;
        }
      }

      void addToStat(DisplayOption option, num n) {
        var breakdownBuilder =
            statsBuilder[option] ??= Map<Object, Map<Object, num>>();
        var xBuilder = breakdownBuilder[breakdownKey] ??= Map<Object, num>();
        xBuilder[xKey] ??= 0;
        xBuilder[xKey] += n;
      }

      for (var field in group.asMap.entries) {
        if (paramValuesMap.containsKey(field.key) &&
            !paramValuesMap[field.key].contains(field.value)) {
          continue entry;
        }
        maybeSetKey(field.key, field.value);
      }

      void processLists(BuiltList<Object> list, int currentDepth) {
        String indexName = entry.indexNames[currentDepth];
        if (list is BuiltList<num>) {
          var sampleSize = list.reduce((a, b) => a + b);
          var expectedDistribution = options.contains(DisplayOption.expected)
              ? hypergeometric(inputsForExpected.build())
              : const <double>[];
          var buggedDistribution = options.contains(DisplayOption.bugged)
              ? bugged(inputsForBugged.build())
              : const <double>[];
          if (params.breakdownBy.value != 'numDrawn') {
            addToStat(DisplayOption.sampleSize, sampleSize);
          }
          for (int i = 0; i < list.length; i++) {
            maybeSetKey(indexName, i);
            if (params.yAxis.value != YAxis.average &&
                !paramValuesMap[indexName].contains(i)) {
              continue;
            }
            if (params.breakdownBy.value == 'numDrawn') {
              addToStat(DisplayOption.sampleSize, sampleSize);
            }
            int multiplier = params.yAxis.value == YAxis.average ? i : 1;
            if (options.contains(DisplayOption.actual)) {
              addToStat(DisplayOption.actual, list[i] * multiplier);
            }
            if (options.contains(DisplayOption.expected)) {
              addToStat(DisplayOption.expected,
                  expectedDistribution[i] * sampleSize * multiplier);
            }
            if (options.contains(DisplayOption.bugged)) {
              addToStat(DisplayOption.bugged,
                  buggedDistribution[i] * sampleSize * multiplier);
            }
          }
        } else {
          for (int selected in paramValuesMap[indexName]) {
            maybeSetKey(indexName, selected);
            var childList = params.type.value == StatsType.libraryLands &&
                    indexName == 'libraryPosition'
                ? BuiltList<num>([
                    for (BuiltList<num> inner in list[selected])
                      inner[params.known.value]
                  ])
                : list[selected];
            processLists(childList, currentDepth + 1);
          }
        }
      }

      processLists(entry.data, 0);
    }

    yield LoadingState((b) => b
      ..stage = LoadingStage.aggregating
      ..progress = 1);
    await _runEventLoop();

    if (params.yAxis.value != YAxis.count) {
      var sampleSizes = statsBuilder[DisplayOption.sampleSize];
      statsBuilder.remove(DisplayOption.sampleSize);
      statsBuilder.forEach((displayOption, breakdownBuilder) =>
          breakdownBuilder.forEach((breakdown, xBuilder) => xBuilder
              .updateAll((x, count) => count / sampleSizes[breakdown][x])));
      statsBuilder[DisplayOption.sampleSize] = sampleSizes;
    }

    if (params.xAxis.value is DisplayOption) {
      var xVals = statsBuilder[params.xAxis.value];
      var scatterStatsBuilder =
          MapBuilder<DisplayOption, BuiltMap<Object, Point<num>>>();
      statsBuilder.forEach((displayOption, breakdownMap) {
        var breakdownBuilder = MapBuilder<Object, Point<num>>();
        breakdownMap.forEach((breakdown, yMap) => breakdownBuilder[breakdown] =
            Point(xVals[breakdown][''], yMap['']));
        scatterStatsBuilder[displayOption] = breakdownBuilder.build();
      });

      yield LoadingState((b) => b
        ..stage = LoadingStage.loaded
        ..scatterStats = scatterStatsBuilder);
      await _runEventLoop();
    } else {
      var lineStatsBuilder =
          MapBuilder<DisplayOption, BuiltMap<Object, BuiltMap<Object, num>>>();
      statsBuilder.forEach((displayOption, breakdownMap) {
        if (options.contains(displayOption)) {
          var breakdownBuilder = MapBuilder<Object, BuiltMap<Object, num>>();
          breakdownMap.forEach((breakdown, xMap) =>
              breakdownBuilder[breakdown] = BuiltMap<Object, num>.of(xMap));
          lineStatsBuilder[displayOption] = breakdownBuilder.build();
        }
      });

      yield LoadingState((b) => b
        ..stage = LoadingStage.loaded
        ..lineStats = lineStatsBuilder);
      await _runEventLoop();
    }
  }
}

Stopwatch _delayRegulator;

Future<void> _runEventLoop([bool forceWait = false]) {
  _delayRegulator ??= Stopwatch()..start();
  if (_delayRegulator.elapsedMilliseconds < 50 && !forceWait) {
    return Future.value();
  }
  _delayRegulator.reset();
  return Future.delayed(Duration(milliseconds: 0));
}

class LoadingStage extends EnumClass {
  static const LoadingStage invalid = _$invalid;
  static const LoadingStage fetching = _$fetching;
  static const LoadingStage parsing = _$parsing;
  static const LoadingStage processing = _$processing;
  static const LoadingStage aggregating = _$aggregating;
  static const LoadingStage loaded = _$loaded;

  String get label => '${name[0].toUpperCase()}${name.substring(1)}';

  const LoadingStage._(String name) : super(name);

  static BuiltSet<LoadingStage> get values => _$loadingValues;
  static LoadingStage valueOf(String name) => _$loadingValueOf(name);
}

abstract class LoadingState
    implements Built<LoadingState, LoadingStateBuilder> {
  LoadingStage get stage;
  @nullable
  double get progress;
  @nullable
  BuiltList<DataEntry> get data;
  @nullable
  BuiltMap<DisplayOption, BuiltMap<Object, BuiltMap<Object, num>>>
      get lineStats;
  @nullable
  BuiltMap<DisplayOption, BuiltMap<Object, Point<num>>> get scatterStats;

  LoadingState._();
  factory LoadingState([void Function(LoadingStateBuilder) updates]) =
      _$LoadingState;
}
