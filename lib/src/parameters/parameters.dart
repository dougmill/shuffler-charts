import 'dart:math';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'parameters.g.dart';

@JsonSerializable(createFactory: false)
class StatsType extends EnumClass {
  static Serializer<StatsType> get serializer => _$statsTypeSerializer;

  static const StatsType handLands = _$handLands;
  static const StatsType libraryLands = _$libraryLands;
  static const StatsType cardPositions = _$cardPositions;
  static const StatsType cardPositionsIndependent = _$cardPositionsIndependent;
  static const StatsType cardCopies = _$cardCopies;

  bool get isByPosition =>
      this == cardPositions || this == cardPositionsIndependent;

  const StatsType._(String name) : super(name);

  static BuiltSet<StatsType> get values => _$statsTypeValues;
  static StatsType valueOf(String name) => _$statsTypeValueOf(name);
}

@JsonSerializable(createFactory: false)
class YAxis extends EnumClass {
  static Serializer<YAxis> get serializer => _$yAxisSerializer;

  static const YAxis percentage = _$percentage;
  static const YAxis count = _$count;
  static const YAxis average = _$average;

  const YAxis._(String name) : super(name);

  static BuiltSet<YAxis> get values => _$yAxisValues;
  static YAxis valueOf(String name) => _$yAxisValueOf(name);
}

@JsonSerializable(createFactory: false)
class DisplayOption extends EnumClass {
  static const DisplayOption actual = _$actual;
  static const DisplayOption expected = _$expected;
  static const DisplayOption bugged = _$bugged;
  static const DisplayOption sampleSize = _$sampleSize;

  const DisplayOption._(String name) : super(name);

  static BuiltSet<DisplayOption> get values => _$displayOptionValues;
  static DisplayOption valueOf(String name) => _$displayOptionValueOf(name);

  static const _labels = {
    actual: 'Actual value',
    expected: 'Expected value',
    bugged: 'Effect of bug',
    sampleSize: 'Sample size'
  };

  String get label => _labels[this];
}

@JsonSerializable(createFactory: false)
class Shuffling extends EnumClass {
  static Serializer<Shuffling> get serializer => _$shufflingSerializer;

  static const Shuffling normal = _$normal;
  static const Shuffling hand = _$hand;
  static const Shuffling smoothed = _$smoothed;

  const Shuffling._(String name) : super(name);

  static BuiltSet<Shuffling> get values => _$shufflingValues;
  static Shuffling valueOf(String name) => _$shufflingValueOf(name);
}

@JsonSerializable(createFactory: false)
class MulliganType extends EnumClass {
  static Serializer<MulliganType> get serializer => _$mulliganTypeSerializer;

  static const MulliganType vancouver = _$vancouver;
  static const MulliganType london = _$london;

  const MulliganType._(String name) : super(name);

  static BuiltSet<MulliganType> get values => _$mulliganTypeValues;
  static MulliganType valueOf(String name) => _$mulliganTypeValueOf(name);
}

abstract class FetchParameters
    implements Built<FetchParameters, FetchParametersBuilder> {
  StatsType get type;
  @nullable
  int get deckSize;
  @nullable
  int get numCards;
  @nullable
  bool get independent;

  String toQueryString() {
    switch (type) {
      case StatsType.handLands:
      case StatsType.cardCopies:
        return 'type=${type.name}';
      case StatsType.libraryLands:
        return 'type=${type.name}&deckSize=$deckSize&landsInDeck=$numCards';
      case StatsType.cardPositions:
        return 'type=${type.name}&deckSize=$deckSize&numCards=$numCards&independent=$independent';
      default:
        throw AssertionError();
    }
  }

  factory FetchParameters.from(Parameters params) {
    return FetchParameters((b) {
      switch (params.type.value) {
        case StatsType.handLands:
        case StatsType.cardCopies:
          b.type = params.type.value;
          break;
        case StatsType.libraryLands:
          b
            ..type = params.type.value
            ..deckSize = params.deckSize.value
            ..numCards = params.numCards.value;
          break;
        case StatsType.cardPositions:
        case StatsType.cardPositionsIndependent:
          b
            ..type = StatsType.cardPositions
            ..deckSize = params.deckSize.value
            ..numCards = params.numCards.value
            ..independent =
                params.type.value == StatsType.cardPositionsIndependent;
          break;
        default:
          throw AssertionError();
      }
    });
  }

  FetchParameters._();
  factory FetchParameters([void Function(FetchParametersBuilder) updates]) =
      _$FetchParameters;
}

@BuiltValue(generateBuilderOnSetField: true, nestedBuilders: false)
@JsonSerializable(createFactory: false)
abstract class Parameters implements Built<Parameters, ParametersBuilder> {
  Parameter<StatsType> get type;
  Parameter<Object> get xAxis;
  Parameter<YAxis> get yAxis;
  Parameter<String> get breakdownBy;
  Parameter<DisplayOption> get options;
  Parameter<int> get deckSize;
  Parameter<int> get numCards;
  Parameter<Shuffling> get shuffling;
  Parameter<MulliganType> get mulliganType;
  Parameter<int> get mulligans;
  Parameter<int> get numDrawn;
  Parameter<int> get landsInHand;
  Parameter<int> get libraryPosition;
  Parameter<int> get known;
  Parameter<int> get decklistPosition;
  Parameter<int> get week;

  @JsonKey(ignore: true)
  @memoized
  BuiltMap<String, Parameter<dynamic>> get asMap =>
      BuiltMap(_$ParametersToJson(this));

  @JsonKey(ignore: true)
  @memoized
  bool get isValid => asMap.values.every((p) => p.error == null);

  Parameters._();
  factory Parameters([void Function(ParametersBuilder) updates]) = _$Parameters;

  // I'd really prefer this generated, but it seems I'd have to implement the
  // generation myself.
  factory Parameters.fromMap(Map<String, Parameter<dynamic>> map) =>
      _$Parameters._(
          type: map['type'],
          xAxis: map['xAxis'],
          yAxis: map['yAxis'],
          breakdownBy: map['breakdownBy'],
          options: map['options'],
          deckSize: map['deckSize'],
          numCards: map['numCards'],
          shuffling: map['shuffling'],
          mulliganType: map['mulliganType'],
          mulligans: map['mulligans'],
          numDrawn: map['numDrawn'],
          landsInHand: map['landsInHand'],
          libraryPosition: map['libraryPosition'],
          known: map['known'],
          decklistPosition: map['decklistPosition'],
          week: map['week']);
}

enum ParameterType { selection, toggles }

@BuiltValue(generateBuilderOnSetField: true, nestedBuilders: false)
@JsonSerializable()
abstract class Parameter<T>
    implements Built<Parameter<T>, ParameterBuilder<T>> {
  ParameterType get type;
  String get name;
  @nullable
  T get value;
  BuiltList<Option<BuiltSet<T>>> get multiSelections;
  BuiltList<Option<T>> get options;
  @nullable
  String get error;

  Parameter._();
  factory Parameter([void Function(ParameterBuilder<T>) updates]) =
      _$Parameter<T>;
}

@BuiltValue(generateBuilderOnSetField: true, nestedBuilders: false)
abstract class Option<T> implements Built<Option<T>, OptionBuilder<T>> {
  T get value;
  String get label;
  bool get selected;

  Option._();
  factory Option([void Function(OptionBuilder<T>) updates]) = _$Option<T>;

  factory Option.of(T value, String label, [bool selected = false]) =>
      (OptionBuilder<T>()
            ..value = value
            ..label = label
            ..selected = selected)
          .build();

  static Option<BuiltSet<T>> all<T>(BuiltList<Option<T>> options,
          [String label = 'All']) =>
      (OptionBuilder<BuiltSet<T>>()
            ..value = BuiltSet(options.map((o) => o.value))
            ..label = label
            ..selected = options.every((o) => o.selected))
          .build();
}

const _numDrawnLabels = {
  StatsType.handLands: 'Lands drawn',
  StatsType.libraryLands: 'Lands drawn from library',
  StatsType.cardPositions: 'Relevant cards drawn',
  StatsType.cardPositionsIndependent: 'Relevant cards drawn',
  StatsType.cardCopies: 'Copies drawn'
};

String _hl(int i) => '$i lands in deck';
String _ll(int i) => '$i lands in deck';
String _cp(int i) => '$i relevant cards in deck';
String _cpi(int i) => '$i relevant cards in deck';
String _cc(int i) => '$i copies in deck';

const _numCardsLabelFuncs = {
  StatsType.handLands: _hl,
  StatsType.libraryLands: _ll,
  StatsType.cardPositions: _cp,
  StatsType.cardPositionsIndependent: _cpi,
  StatsType.cardCopies: _cc
};

List<Option<String>> _getInputSelectOptions(StatsType type, YAxis yAxis) {
  return [
    if ((const [StatsType.handLands, StatsType.cardCopies]).contains(type))
      Option.of('deckSize', 'Cards in deck'),
    if (type == StatsType.handLands) Option.of('numCards', 'Lands in deck'),
    if (type == StatsType.cardCopies) Option.of('numCards', 'Relevant cards'),
    Option.of('shuffling', 'Shuffling'),
    Option.of('mulliganType', 'Mulligan type'),
    Option.of('mulligans', 'Mulligans'),
    if (yAxis != YAxis.average) Option.of('numDrawn', _numDrawnLabels[type]),
    if (type == StatsType.libraryLands)
      Option.of('landsInHand', 'Lands in opening hand'),
    if (type == StatsType.libraryLands)
      Option.of('libraryPosition', 'Card position in library'),
    if (type.isByPosition)
      Option.of('decklistPosition', 'Card position in decklist'),
    Option.of('week', 'Week')
  ];
}

List<Option<int>> _range(int min, int max,
    {Object Function(int i) labelFunc,
    List<int> selected = const [],
    bool allSelected = false}) {
  labelFunc = labelFunc ?? (i) => i;
  return [
    for (int i = min; i <= max; i++)
      Option.of(i, labelFunc(i).toString(), allSelected || selected.contains(i))
  ];
}

BuiltList<Option<int>> _builtRange(int min, int max,
    {Object Function(int i) labelFunc,
    List<int> selected = const [],
    bool allSelected = false}) {
  return BuiltList<Option<int>>(_range(min, max,
      labelFunc: labelFunc, selected: selected, allSelected: allSelected));
}

final DateTime _endOfWeek0 = DateTime.utc(2019, 2, 7, 15);
const List<String> _months = [
  '',
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec'
];

String _weekLabel(int i) {
  if (i == 0) {
    return 'Jan 28 - Feb 6';
  }
  DateTime startOfWeek = _endOfWeek0.add(Duration(days: 7 * (i - 1)));
  DateTime endOfWeek = startOfWeek.add(Duration(days: 6));
  return '${_months[startOfWeek.month]} ${startOfWeek.day}'
      ' - ${_months[endOfWeek.month]} ${endOfWeek.day}';
}

String _s(int i) {
  return i == 1 ? '' : 's';
}

typedef dummySetter<T> = void Function(ParameterBuilder<T> p);

void initialize(ParametersBuilder b) {
  b.type = Parameter((p) => p
    ..type = ParameterType.selection
    ..name = 'Chart type'
    ..value = StatsType.cardPositions
    ..options = BuiltList([
      Option.of(StatsType.handLands, 'Lands in opening hand'),
      Option.of(StatsType.libraryLands, 'Lands in library'),
      Option.of(StatsType.cardPositions, 'Cards by position in decklist'),
      Option.of(
          StatsType.cardPositionsIndependent, 'Cards by position, bucketed'),
      Option.of(StatsType.cardCopies, 'Cards by number of copies')
    ])
    ..multiSelections = BuiltList());

  b.xAxis = Parameter((p) => p
    ..type = ParameterType.selection
    ..name = 'X axis'
    ..value = 'decklistPosition'
    ..options = BuiltList()
    ..multiSelections = BuiltList());

  b.yAxis = Parameter((p) => p
    ..type = ParameterType.selection
    ..name = 'Y axis'
    ..value = YAxis.percentage
    ..options = BuiltList([
      Option.of(YAxis.percentage, 'Percentage of games'),
      Option.of(YAxis.count, 'Count of games'),
      Option.of(YAxis.average, 'Average')
    ])
    ..multiSelections = BuiltList());

  b.breakdownBy = Parameter((p) => p
    ..type = ParameterType.selection
    ..name = 'Breakdown by'
    ..value = 'numDrawn'
    ..options = BuiltList()
    ..multiSelections = BuiltList());

  b.options = Parameter((p) => p
    ..type = ParameterType.toggles
    ..name = 'Display options'
    ..options = BuiltList([
      Option.of(DisplayOption.actual, DisplayOption.actual.label, true),
      Option.of(DisplayOption.expected, DisplayOption.expected.label, true),
      Option.of(DisplayOption.sampleSize, DisplayOption.sampleSize.label, true)
    ])
    ..multiSelections = BuiltList());

  b.deckSize = Parameter((p) => p
    ..type = ParameterType.selection
    ..name = 'Cards in deck'
    ..value = 60
    ..options =
        BuiltList([Option.of(40, '40 cards'), Option.of(60, '60 cards')])
    ..multiSelections = BuiltList());

  b.numCards = Parameter((p) => p
    ..type = ParameterType.selection
    ..name = 'Number of relevant cards'
    ..value = 24
    ..options = BuiltList()
    ..multiSelections = BuiltList());

  b.shuffling = Parameter((p) => p
    ..type = ParameterType.toggles
    ..name = 'Shuffling'
    ..options = BuiltList([
      Option.of(Shuffling.normal, 'Normal (Best of 3)', true),
      Option.of(Shuffling.hand, 'Bo1 hand selection', false),
      Option.of(Shuffling.smoothed, 'Play queue smoothing', false)
    ])
    ..multiSelections = BuiltList([Option.all(p.options)]));

  b.mulliganType = Parameter((p) => p
    ..type = ParameterType.toggles
    ..name = 'Mulligan type'
    ..options = BuiltList([
      Option.of(MulliganType.vancouver, 'Vancouver mulligan', true),
      Option.of(MulliganType.london, 'London mulligan', true)
    ])
    ..multiSelections = BuiltList([Option.all(p.options)]));

  b.mulligans = Parameter((p) => p
    ..type = ParameterType.toggles
    ..name = 'Mulligans'
    ..options = BuiltList(
        _range(0, 6, labelFunc: (m) => '$m mulligan${_s(m)}', selected: [0]))
    ..multiSelections = BuiltList([Option.all(p.options)]));

  b.numDrawn = Parameter((p) => p
    ..type = ParameterType.toggles
    ..name = _numDrawnLabels[StatsType.cardPositions]
    ..options = BuiltList(_range(0, 7,
        labelFunc: (d) => '$d relevant cards drawn', allSelected: true))
    ..multiSelections = BuiltList());

  b.landsInHand = Parameter((p) => p
    ..type = ParameterType.toggles
    ..name = 'Lands in opening hand'
    ..options = BuiltList()
    ..multiSelections = BuiltList());

  b.libraryPosition = Parameter((p) => p
    ..type = ParameterType.toggles
    ..name = 'Cards from library'
    ..options = BuiltList()
    ..multiSelections = BuiltList());

  b.known = Parameter((p) => p
    ..type = ParameterType.selection
    ..name = 'Data availability'
    ..value = 0
    ..options = BuiltList()
    ..multiSelections = BuiltList());

  b.decklistPosition = Parameter((p) => p
    ..type = ParameterType.toggles
    ..name = 'Position in decklist'
    ..options = BuiltList()
    ..multiSelections = BuiltList());

  int maxWeek = DateTime.now().difference(_endOfWeek0).inDays ~/ 7 + 1;
  b.week = Parameter((p) => p
    ..type = ParameterType.toggles
    ..name = 'Weeks'
    ..options =
        BuiltList(_range(0, maxWeek, labelFunc: _weekLabel, allSelected: true))
    ..multiSelections = BuiltList([
      Option.all(p.options),
      Option.all(p.options.sublist(0, 2), 'Before smooth shuffling'),
      Option.all(p.options.sublist(2), 'After smooth shuffling'),
      Option.all(p.options.sublist(0, 16), 'Before War of the Spark'),
      Option.all(p.options.sublist(16), 'After War of the Spark'),
      Option.all(p.options.sublist(0, 21), 'Before M20'),
      Option.all(p.options.sublist(22), 'After M20')
    ]));

  void dummyParam<T>(ParameterBuilder<T> p) {
    p
      ..type = ParameterType.toggles
      ..name = 'placeholder'
      ..options = BuiltList()
      ..multiSelections = BuiltList();
  }

  dummySetter<T> dummyWithValue<T>(T value) => (p) {
        dummyParam(p);
        p.value = value;
      };

  var dummy = Parameters((p) => p
    ..type = Parameter(dummyWithValue(StatsType.handLands))
    ..xAxis = Parameter(dummyParam)
    ..yAxis = Parameter(dummyParam)
    ..breakdownBy = Parameter(dummyParam)
    ..options = Parameter(dummyParam)
    ..deckSize = Parameter(dummyParam)
    ..numCards = Parameter(dummyParam)
    ..shuffling = Parameter(dummyParam)
    ..mulliganType = Parameter(dummyParam)
    ..mulligans = Parameter(dummyParam)
    ..numDrawn = Parameter(dummyParam)
    ..landsInHand = Parameter(dummyParam)
    ..libraryPosition = Parameter(dummyParam)
    ..known = Parameter(dummyParam)
    ..decklistPosition = Parameter(dummyParam)
    ..week = Parameter(dummyParam));

  validate(dummy, b);
}

void validate(Parameters old, ParametersBuilder updated) {
  void Function() onSet = updated.onSet;
  updated.onSet = () {};

  StatsType type = updated.type.value;
  if (old.type.value != type) {
    if (type.isByPosition && !old.type.value.isByPosition) {
      updated.options = updated.options.rebuild((p) => p.options = p.options
          .rebuild((lo) => lo.insert(
              2,
              Option.of(
                  DisplayOption.bugged, DisplayOption.bugged.label, true))));
    } else if (!type.isByPosition && old.type.value.isByPosition) {
      updated.options = updated.options.rebuild(
          (p) => p.options = p.options.rebuild((lo) => lo.removeAt(2)));
    }
  }

  if (old.type.value != type || old.yAxis.value != updated.yAxis.value) {
    updated.xAxis = updated.xAxis.rebuild((b) => b.options = BuiltList([
          ..._getInputSelectOptions(type, updated.yAxis.value),
          Option.of(DisplayOption.actual, DisplayOption.actual.label),
          Option.of(DisplayOption.expected, DisplayOption.expected.label),
          if (type.isByPosition)
            Option.of(DisplayOption.bugged, DisplayOption.bugged.label),
          Option.of(DisplayOption.sampleSize, DisplayOption.sampleSize.label)
        ]));
    updated.breakdownBy = updated.breakdownBy.rebuild((p) => p.options =
            BuiltList([
          Option.of('none', 'None'),
          ..._getInputSelectOptions(type, updated.yAxis.value)
        ]));
  }

  void Function(ParameterBuilder<T>) errorSetter<T>(String error) {
    return (p) {
      // Skip calling the actual setter on no-op calls because the setter forces
      // creating a new copy for the next build even if nothing actually
      // changed.
      if (p.error != error) {
        p.error = error;
      }
    };
  }

  const String unsetError = 'Select a value.';
  String error;
  bool isValueInOptions<T>(Parameter<T> p) =>
      p.options.isEmpty || p.options.any((o) => o.value == p.value);
  String findAxisError<T>(Parameter<T> p) {
    if (!isValueInOptions(p)) {
      return unsetError;
    } else if (updated.xAxis.value == updated.breakdownBy.value) {
      return 'Cannot break down by X axis factor.';
    } else {
      return null;
    }
  }

  updated.xAxis =
      updated.xAxis.rebuild(errorSetter(findAxisError(updated.xAxis)));
  updated.breakdownBy = updated.breakdownBy
      .rebuild(errorSetter(findAxisError(updated.breakdownBy)));

  error = updated.options.options.any((o) => o.selected) ? null : unsetError;
  updated.options = updated.options.rebuild(errorSetter(error));

  void Function(ParameterBuilder<T>) optionsSetter<T>(
      BuiltList<Option<T>> options) {
    return (p) {
      if (options.length == p.options.length &&
          Iterable<int>.generate(options.length).every((i) =>
              options[i].value == p.options[i].value &&
              options[i].label == p.options[i].label)) {
        return;
      }

      var oldSelections =
          BuiltMap<T, bool>({for (var o in p.options) o.value: o.selected});
      p
        ..options = (options.toBuilder()
              ..map((o) => o.rebuild(
                  (ob) => ob.selected = oldSelections[o.value] ?? o.selected)))
            .build()
        ..multiSelections = BuiltList(
            [if (p.type == ParameterType.toggles) Option.all(p.options)]);
    };
  }

  void Function(ParameterBuilder<T>) multiSelectionsUpdater<T>(
      Parameter<T> before) {
    return (after) {
      if (after.multiSelections.length == before.multiSelections.length &&
          after.multiSelections != before.multiSelections) {
        for (int i = 0; i < after.multiSelections.length; i++) {
          if (after.multiSelections[i].selected !=
              before.multiSelections[i].selected) {
            BuiltSet<T> vals = after.multiSelections[i].value;
            bool selected = after.multiSelections[i].selected;
            after.options = BuiltList.of(after.options.map((o) =>
                vals.contains(o.value)
                    ? o.rebuild((b) => b.selected = selected)
                    : o));
            break;
          }
        }
      }
      if (after.options != before.options && after.multiSelections.isNotEmpty) {
        BuiltSet<T> selectedVals =
            BuiltSet([for (var o in after.options) if (o.selected) o.value]);
        after.multiSelections = BuiltList.of(after.multiSelections.map((m) =>
            Option.of(m.value, m.label, m.value.every(selectedVals.contains))));
      }
    };
  }

  bool isAnyValueSelected<T>(ParameterBuilder<T> p) =>
      p.options.isEmpty || p.options.any((o) => o.selected);

  void Function(ParameterBuilder<T>) defaultErrorSetter<T>() {
    return (p) {
      bool condition = p.type == ParameterType.toggles
          ? p.options.isEmpty || isAnyValueSelected(p)
          : isValueInOptions(p.build());
      errorSetter(condition ? null : unsetError)(p);
    };
  }

  void Function(ParameterBuilder<T>) defaultParamUpdater<T>(
      Parameter<T> before) {
    return (p) {
      multiSelectionsUpdater(before)(p);
      defaultErrorSetter()(p);
    };
  }

  void Function(ParameterBuilder<T>) paramUpdater<T>(
      Parameter<T> before, BuiltList<Option<T>> options,
      [ParameterType type]) {
    return (p) {
      if (type != null && p.type != type) {
        p.type = type;
      }
      optionsSetter(options)(p);
      defaultParamUpdater(before)(p);
    };
  }

  BuiltList<Option<int>> newOptions;
  if (old.type.value != type || updated.deckSize.value != old.deckSize.value) {
    newOptions = BuiltList([
      if (const [StatsType.handLands, StatsType.libraryLands]
          .contains(type)) ...[
        if (updated.deckSize.value != 40)
          ..._range(10, 13, labelFunc: _numCardsLabelFuncs[type]),
        ..._range(14, 20, labelFunc: _numCardsLabelFuncs[type]),
        if (updated.deckSize.value != 40)
          ..._range(21, 28, labelFunc: _numCardsLabelFuncs[type])
      ] else if (type.isByPosition) ...[
        // cardPositionsIndependent does not do estimations, so include
        // estimation only for cardPositions
        if (type == StatsType.cardPositions)
          Option.of(0, 'Estimate for every card'),
        ..._range(1, 4, labelFunc: _numCardsLabelFuncs[type]),
        if (updated.deckSize.value == 40)
          ..._range(15, 18, labelFunc: _numCardsLabelFuncs[type]),
        if (updated.deckSize.value == 60)
          ..._range(22, 25, labelFunc: _numCardsLabelFuncs[type])
      ] else if (type == StatsType.cardCopies)
        ..._range(2, 4, labelFunc: _numCardsLabelFuncs[type])
    ]);

    var paramType =
        const [StatsType.handLands, StatsType.cardCopies].contains(type)
            ? ParameterType.toggles
            : ParameterType.selection;
    updated.numCards = updated.numCards
        .rebuild(paramUpdater(old.numCards, newOptions, paramType));
  }

  updated.shuffling =
      updated.shuffling.rebuild(defaultParamUpdater(old.shuffling));

  bool isValueSelected<T>(Parameter<T> p, T value) {
    return p.options.any((o) => o.selected && o.value == value);
  }

  var mulliganTypesForSelectedWeeks = BuiltList.of([
    if (updated.week.options.any((week) => week.selected && week.value < 22))
      MulliganType.vancouver,
    if (updated.week.options
        .any((week) => week.selected && (week.value == 18 || week.value >= 21)))
      MulliganType.london
  ]);
  updated.mulliganType = updated.mulliganType.rebuild((p) {
    multiSelectionsUpdater(old.mulliganType)(p);
    if (!isAnyValueSelected(p)) {
      error = unsetError;
    } else if (mulliganTypesForSelectedWeeks.length == 1 &&
        !isValueSelected(
            updated.mulliganType, mulliganTypesForSelectedWeeks[0])) {
      error = mulliganTypesForSelectedWeeks[0].name +
          ' mulligan not used in selected weeks';
    } else {
      error = null;
    }
    errorSetter(error)(p);
  });

  updated.mulligans =
      updated.mulligans.rebuild(defaultParamUpdater(old.mulligans));

  int firstSelected(Parameter<int> p) {
    return p.options.firstWhere((o) => o.selected, orElse: () => null)?.value;
  }

  int lastSelected(Parameter<int> p) {
    return p.options.lastWhere((o) => o.selected, orElse: () => null)?.value;
  }

  if (updated.yAxis.value == YAxis.average) {
    newOptions = BuiltList();
  } else {
    int maxPossibleDrawn = [
      if (type == StatsType.libraryLands)
        (lastSelected(updated.libraryPosition) ?? 9) + 1
      else if (isValueSelected(updated.mulliganType, MulliganType.london))
        7
      else
        7 - (firstSelected(updated.mulligans) ?? 0),
      if (type == StatsType.libraryLands)
        (updated.numCards.value ?? 25) -
            (firstSelected(updated.landsInHand) ?? 0),
      if (type.isByPosition) max(updated.numCards.value ?? 25, 1),
      if (type == StatsType.cardCopies) lastSelected(updated.numCards) ?? 4
    ].reduce(min);
    newOptions = _builtRange(0, maxPossibleDrawn,
        labelFunc: (d) => '$d ${_numDrawnLabels[type].toLowerCase()}');
  }
  updated.numDrawn = updated.numDrawn.rebuild((builder) {
    paramUpdater(old.numDrawn, newOptions)(builder);
    builder.name = _numDrawnLabels[type];
  });

  if (type == StatsType.libraryLands) {
    newOptions = _builtRange(0, 7, labelFunc: (l) => '$l lands in hand');
  } else {
    newOptions = BuiltList();
  }
  updated.landsInHand =
      updated.landsInHand.rebuild(paramUpdater(old.landsInHand, newOptions));

  if (type == StatsType.libraryLands) {
    newOptions = BuiltList([
      Option.of(0, 'All needed cards revealed'),
      Option.of(1, '1 card unknown')
    ]);
  } else {
    newOptions = BuiltList();
  }
  updated.known = updated.known.rebuild(paramUpdater(old.known, newOptions));

  if (type == StatsType.libraryLands) {
    newOptions = _builtRange(0, 9,
        labelFunc: (i) => 'Top ${i + 1} card${_s(i + 1)} of library');
  } else {
    newOptions = BuiltList();
  }
  updated.libraryPosition = updated.libraryPosition
      .rebuild(paramUpdater(old.libraryPosition, newOptions));

  if (type.isByPosition) {
    int minBlockSize = max(updated.numCards.value ?? 1, 1);
    newOptions = _builtRange(0, updated.deckSize.value - minBlockSize,
        labelFunc: (i) => minBlockSize == 1
            ? 'Card ${i + 1}'
            : 'Cards ${i + 1} to ${i + minBlockSize}',
        allSelected: !old.type.value.isByPosition ||
            old.decklistPosition.multiSelections
                .every((multi) => multi.selected));
  } else {
    newOptions = BuiltList();
  }
  updated.decklistPosition = updated.decklistPosition
      .rebuild(paramUpdater(old.decklistPosition, newOptions));

  updated.week = updated.week.rebuild(defaultParamUpdater(old.week));

  updated.onSet = onSet;
}
