import 'dart:math';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

part 'parameters.g.dart';

class StatsType extends EnumClass {
  static Serializer<StatsType> get serializer => _$statsTypeSerializer;

  static const StatsType handLands = _$handLands;
  static const StatsType libraryLands = _$libraryLands;
  static const StatsType cardPositions = _$cardPositions;
  static const StatsType cardCopies = _$cardCopies;

  const StatsType._(String name) : super(name);

  static BuiltSet<StatsType> get values => _$statsTypeValues;
  static StatsType valueOf(String name) => _$statsTypeValueOf(name);
}

// The string names of these values are not used for anything, so EnumClass is
// not needed.
enum DisplayOption { actual, expected, bugged, count, sampleSize }

class Shuffling extends EnumClass {
  static Serializer<Shuffling> get serializer => _$shufflingSerializer;

  static const Shuffling normal = _$normal;
  static const Shuffling smoothed = _$smoothed;

  const Shuffling._(String name) : super(name);

  static BuiltSet<Shuffling> get values => _$shufflingValues;
  static Shuffling valueOf(String name) => _$shufflingValueOf(name);
}

abstract class FetchParameters
    implements Built<FetchParameters, FetchParametersBuilder> {
  StatsType get type;
  @nullable
  int get deckSize;
  @nullable
  int get landsInDeck;
  @nullable
  int get numCards;

  String toQueryString() {
    switch (type) {
      case StatsType.handLands:
      case StatsType.cardCopies:
        return 'type=${type.name}';
      case StatsType.libraryLands:
        return 'type=${type.name}&deckSize=$deckSize&landsInDeck=$landsInDeck';
      case StatsType.cardPositions:
        return 'type=${type.name}&deckSize=$deckSize&numCards=$numCards';
      default:
        throw AssertionError();
    }
  }

  factory FetchParameters.from(Parameters params) {
    var builder = FetchParametersBuilder()..type = params.type.value;
    switch (params.type.value) {
      case StatsType.handLands:
      case StatsType.cardCopies:
        return builder.build();
      case StatsType.libraryLands:
        return (builder
              ..deckSize = params.deckSize.value
              ..landsInDeck = params.landsInDeck.value)
            .build();
      case StatsType.cardPositions:
        return (builder
              ..deckSize = params.deckSize.value
              ..numCards = params.numCards.value)
            .build();
      default:
        throw AssertionError();
    }
  }

  FetchParameters._();
  factory FetchParameters([void Function(FetchParametersBuilder) updates]) =
      _$FetchParameters;
}

@SerializersFor([Parameters])
Serializers _paramSerializers = (_$_paramSerializers.toBuilder()
      ..add(_NonSerializer())
      ..addPlugin(_ShallowPlugin()))
    .build();

@BuiltValue(generateBuilderOnSetField: true, nestedBuilders: false)
abstract class Parameters implements Built<Parameters, ParametersBuilder> {
  static Serializer<Parameters> get serializer => _$parametersSerializer;

  Parameter<StatsType> get type;
  Parameter<String> get xAxis;
  Parameter<String> get breakdownBy;
  Parameter<DisplayOption> get options;
  Parameter<int> get deckSize;
  Parameter<int> get landsInDeck;
  Parameter<int> get numCards;
  Parameter<int> get bestOf;
  Parameter<Shuffling> get shuffling;
  Parameter<int> get mulligans;
  Parameter<int> get numDrawn;
  Parameter<int> get landsInHand;
  Parameter<int> get libraryPosition;
  Parameter<int> get decklistPosition;
  Parameter<int> get weeks;

  @memoized
  @BuiltValueField(compare: false, serialize: false)
  BuiltMap<String, Parameter<dynamic>> get asMap =>
      BuiltMap(_paramSerializers.serializeWith(serializer, this));

  Parameters._();
  factory Parameters([void Function(ParametersBuilder) updates]) = _$Parameters;
}

enum ParameterType { selection, toggles }

@BuiltValue(generateBuilderOnSetField: true)
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

/// 'Serializer' that does nothing. Used to enable shallow conversion of
/// Parameters to a BuiltMap.
class _NonSerializer implements PrimitiveSerializer<Parameter<dynamic>> {
  @override
  final Iterable<Type> types = BuiltList<Type>([Parameter]);
  @override
  final String wireName = null;

  @override
  Object serialize(Serializers serializers, Parameter<dynamic> object,
      {FullType specifiedType = FullType.unspecified}) {
    return object;
  }

  @override
  Parameter deserialize(Serializers serializers, Object serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return serialized;
  }
}

class _ShallowPlugin extends StandardJsonPlugin {
  @override
  Object afterSerialize(Object object, FullType specifiedType) {
    return object is Parameter
        ? object
        : super.afterSerialize(object, specifiedType);
  }
}

List<Option<String>> _getAxisOptions(StatsType type) {
  const numDrawnLabels = {
    StatsType.handLands: 'Lands drawn',
    StatsType.libraryLands: 'Lands in library',
    StatsType.cardPositions: 'Relevant cards drawn',
    StatsType.cardCopies: 'Copies drawn'
  };
  return [
    Option.of('deckSize', 'Cards in deck'),
    if (type == StatsType.handLands) Option.of('landsInDeck', 'Lands in deck'),
    Option.of('bestOf', 'Best of'),
    Option.of('shuffling', 'Shuffling'),
    Option.of('mulligans', 'Mulligans'),
    Option.of('numDrawn', numDrawnLabels[type]),
    if (type == StatsType.libraryLands)
      Option.of('landsInHand', 'Lands in opening hand'),
    if (type == StatsType.libraryLands)
      Option.of('libraryPosition', 'Card position in library'),
    if (type == StatsType.cardPositions)
      Option.of('decklistPosition', 'Card position in decklist'),
    Option.of('week', 'Week')
  ];
}

List<Option<int>> _range(int min, int max, [int labelFunc(int i)]) {
  labelFunc = labelFunc ?? (i) => i;
  return [
    for (int i = min; i <= max; i++) Option.of(i, labelFunc(i).toString())
  ];
}

BuiltList<Option<int>> _builtRange(int min, int max, [int labelFunc(int i)]) {
  return BuiltList<Option<int>>(_range(min, max, labelFunc));
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

void initialize(ParametersBuilder b, int maxWeek) {
  b.type = Parameter((p) => p
    ..type = ParameterType.selection
    ..name = 'Chart type'
    ..value = StatsType.cardPositions
    ..options = ListBuilder([
      Option.of(StatsType.handLands, 'Lands in opening hand'),
      Option.of(StatsType.libraryLands, 'Lands in library'),
      Option.of(StatsType.cardPositions, 'Cards by position in decklist'),
      Option.of(StatsType.cardCopies, 'Cards by number of copies')
    ]));

  b.xAxis = Parameter((p) => p
    ..type = ParameterType.selection
    ..name = 'X axis'
    ..value = 'decklistPosition');

  b.breakdownBy = Parameter((p) => p
    ..type = ParameterType.selection
    ..name = 'Breakdown by'
    ..value = 'none');

  b.options = Parameter((p) => p
    ..type = ParameterType.toggles
    ..name = 'Display options'
    ..options = ListBuilder([
      Option.of(DisplayOption.actual, 'Show actual values', true),
      Option.of(DisplayOption.expected, 'Show expected values', true),
      Option.of(DisplayOption.bugged, 'Show prediction for bug', true),
      Option.of(DisplayOption.count, 'Show values by count', false),
      Option.of(DisplayOption.sampleSize, 'Show sample sizes', false)
    ]));

  b.deckSize = Parameter((p) => p
    ..type = ParameterType.selection
    ..name = 'Cards in deck'
    ..options = ListBuilder([Option.of(40, '40'), Option.of(60, '60')])
    ..value = 60);

  b.landsInDeck = Parameter((p) => p
    ..type = ParameterType.selection
    ..name = 'Lands in deck');

  b.numCards = Parameter((p) => p
    ..type = ParameterType.selection
    ..name = 'Number of relevant cards'
    ..value = 0);

  b.bestOf = Parameter((p) => p
    ..type = ParameterType.toggles
    ..name = 'Best of'
    ..options = ListBuilder([Option.of(1, '1', false), Option.of(3, '3', true)])
    ..multiSelections = ListBuilder([Option.all(p.options.build())]));

  b.shuffling = Parameter((p) => p
    ..type = ParameterType.toggles
    ..name = 'Shuffling'
    ..options = ListBuilder([
      Option.of(Shuffling.normal, 'Normal', true),
      Option.of(Shuffling.smoothed, 'Smoothed', false)
    ])
    ..multiSelections = ListBuilder([Option.all(p.options.build())]));

  b.mulligans = Parameter((p) => p
    ..type = ParameterType.toggles
    ..name = 'Mulligans'
    ..options = ListBuilder(_range(0, 6))
    ..multiSelections = ListBuilder([Option.all(p.options.build())]));

  b.numDrawn = Parameter((p) => p
    ..type = ParameterType.toggles
    ..name = 'Amount drawn'
    ..value = 1);

  b.landsInHand = Parameter((p) => p
    ..type = ParameterType.toggles
    ..name = 'Lands in opening hand');

  b.libraryPosition = Parameter((p) => p
    ..type = ParameterType.toggles
    ..name = 'Cards from library');

  b.decklistPosition = Parameter((p) => p
    ..type = ParameterType.toggles
    ..name = 'Position in decklist'
    ..value = 0);

  b.weeks = Parameter((p) => p
    ..type = ParameterType.toggles
    ..name = 'Weeks'
    ..options = ListBuilder([
      for (int week = 0; week <= maxWeek; week++)
        Option.of(week, _weekLabel(week), true)
    ])
    ..multiSelections = ListBuilder([
      Option.all(p.options.build()),
      Option.all(p.options.build().sublist(0, 2), 'Before smooth shuffling'),
      Option.all(p.options.build().sublist(2), 'After smooth shuffling'),
      Option.all(p.options.build().sublist(0, 16), 'Before War of the Spark'),
      Option.all(p.options.build().sublist(16), 'After War of the Spark')
    ]));

  validate(Parameters(), b);
}

void validate(Parameters old, ParametersBuilder updated) {
  void Function() onSet = updated.onSet;
  updated.onSet = () {};

  StatsType type = updated.type.value;
  if (old.type.value != type) {
    if (type == StatsType.cardPositions) {
      if (!updated.options.options
          .any((o) => o.value == DisplayOption.bugged)) {
        updated.options = updated.options.rebuild((p) => p.options.insert(2,
            Option.of(DisplayOption.bugged, 'Show prediction for bug', true)));
      }
    } else {
      updated.options = updated.options.rebuild(
          (p) => p.options.removeWhere((o) => o.value == DisplayOption.bugged));
    }

    updated.xAxis = updated.xAxis.rebuild((b) => b.options =
        ListBuilder([...updated.options.options, ..._getAxisOptions(type)]));
    updated.breakdownBy = updated.breakdownBy.rebuild((p) => p.options =
        ListBuilder([Option.of('none', 'None'), ..._getAxisOptions(type)]));
  }

  void Function(ParameterBuilder<T>) errorSetter<T>(String error) {
    return (p) {
      if (p.error != error) {
        p.error = error;
      }
    };
  }

  const String unsetError = 'Select a value.';
  String error;
  bool isValueInOptions<T>(Parameter<T> p) =>
      p.options.any((o) => o.value == p.value);
  if (!isValueInOptions(updated.xAxis)) {
    error = unsetError;
  } else if (updated.xAxis.value == updated.breakdownBy.value) {
    error = 'Cannot break down by X axis factor.';
  } else {
    error = null;
  }
  updated.xAxis = updated.xAxis.rebuild(errorSetter(error));

  if (!isValueInOptions(updated.breakdownBy)) {
    error = unsetError;
  } else if (updated.xAxis.value == updated.breakdownBy.value) {
    error = 'Cannot break down by X axis factor.';
  } else {
    error = null;
  }
  updated.breakdownBy = updated.breakdownBy.rebuild(errorSetter(error));

  error = updated.options.options
          .any((o) => o.selected && o.value != DisplayOption.count)
      ? null
      : unsetError;
  updated.options = updated.options.rebuild(errorSetter(error));

  void Function(ParameterBuilder<T>) optionsSetter<T>(
      BuiltList<Option<T>> options) {
    return (p) {
      if (p.options.build() != options) {
        var oldSelections =
            BuiltMap<T, bool>({for (var o in options) o.value: o.selected});
        p
          ..options = (options.toBuilder()
            ..map((o) => o.rebuild(
                (ob) => ob.selected = oldSelections[o.value] ?? o.selected)))
          ..multiSelections = ListBuilder(
              [if (p.type == ParameterType.toggles) Option.all(options)]);
      }
    };
  }

  void Function(ParameterBuilder<T>) multiSelectionsUpdater<T>(
      Parameter<T> before) {
    return (after) {
      if (after.multiSelections.build() != before.multiSelections) {
        for (int i = 0; i < after.multiSelections.length; i++) {
          if (after.multiSelections[i].selected !=
              before.multiSelections[i].selected) {
            BuiltSet<T> vals = after.multiSelections[i].value;
            bool selected = after.multiSelections[i].selected;
            after.options.map((o) => vals.contains(o.value)
                ? o.rebuild((b) => b.selected = selected)
                : o);
            break;
          }
        }
      }
      if (after.options.build() != before.options &&
          after.multiSelections.isNotEmpty) {
        BuiltSet<T> selectedVals =
            BuiltSet([for (var o in after.options.build()) o.value]);
        after.multiSelections.map((m) =>
            Option.of(m.value, m.label, m.value.every(selectedVals.contains)));
      }
    };
  }

  bool isAnyValueSelected<T>(ParameterBuilder<T> p) =>
      p.options.build().any((o) => o.selected);

  void Function(ParameterBuilder<T>) defaultErrorSetter<T>() {
    return (p) {
      bool condition = p.type == ParameterType.toggles
          ? isAnyValueSelected(p)
          : isValueInOptions(p.build());
      errorSetter(condition ? null : unsetError);
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
      multiSelectionsUpdater(before)(p);
      defaultErrorSetter()(p);
    };
  }

  BuiltList<Option<int>> newOptions;
  if (old.type.value != type || updated.deckSize.value != old.deckSize.value) {
    if (const [StatsType.handLands, StatsType.libraryLands].contains(type)) {
      newOptions = BuiltList([
        if (updated.deckSize.value != 40) ..._range(10, 13),
        ..._range(14, 20),
        if (updated.deckSize.value != 40) ..._range(21, 28)
      ]);
    } else {
      newOptions = BuiltList();
    }
    var paramType = type == StatsType.handLands
        ? ParameterType.toggles
        : ParameterType.selection;
    updated.landsInDeck = updated.landsInDeck
        .rebuild(paramUpdater(old.landsInDeck, newOptions, paramType));
  }

  if (old.type.value != type) {
    if (type == StatsType.cardPositions) {
      newOptions = BuiltList([
        Option.of(0, 'Estimate for every card'),
        ..._range(1, 4),
        if (updated.deckSize.value != 60) ..._range(15, 18),
        if (updated.deckSize.value != 40) ..._range(22, 25)
      ]);
    } else if (type == StatsType.cardCopies) {
      newOptions = _builtRange(2, 4);
    } else {
      newOptions = BuiltList();
    }
    var paramType = type == StatsType.cardCopies
        ? ParameterType.toggles
        : ParameterType.selection;
    updated.numCards = updated.numCards
        .rebuild(paramUpdater(old.numCards, newOptions, paramType));
  }

  error = !updated.bestOf.options[0].selected &&
          updated.bestOf.options[1].selected &&
          !updated.shuffling.options[0].selected &&
          updated.shuffling.options[1].selected
      ? 'Bo3 cannot have smoothed shuffling'
      : null;
  updated.bestOf = updated.bestOf.rebuild((p) {
    multiSelectionsUpdater(old.bestOf)(p);
    if (error == null) {
      defaultErrorSetter()(p);
    } else {
      errorSetter(error)(p);
    }
  });
  updated.shuffling = updated.shuffling.rebuild((p) {
    multiSelectionsUpdater(old.shuffling)(p);
    if (error == null) {
      defaultErrorSetter()(p);
    } else {
      errorSetter(error)(p);
    }
  });

  updated.mulligans = updated.mulligans.rebuild(defaultErrorSetter());

  int maxPossibleDrawn = [
    if (type == StatsType.libraryLands)
      if (updated.breakdownBy.value == 'libraryPosition')
        10
      else
        (updated.libraryPosition.options.lastWhere((o) => o.selected).value ??
                9) +
            1
    else
      if (updated.breakdownBy.value == 'mulligans')
        7
      else
        7 - (updated.mulligans.options.lastWhere((o) => o.selected).value ?? 0),
    if (type == StatsType.libraryLands &&
        updated.breakdownBy.value == 'landsInHand')
      (updated.landsInDeck.value ?? 25) -
          (updated.landsInHand.options.firstWhere((o) => o.selected).value ??
              0),
    if (type == StatsType.cardPositions &&
        updated.breakdownBy.value != 'numCards')
      max(updated.numCards.options.lastWhere((o) => o.selected).value ?? 25, 1),
    if (type == StatsType.cardCopies)
      if (updated.breakdownBy.value == 'numCards')
        4
      else
        updated.numCards.options.lastWhere((o) => o.selected).value ?? 4
  ].reduce(min);
  updated.numDrawn = updated.numDrawn
      .rebuild(paramUpdater(old.numDrawn, _builtRange(0, maxPossibleDrawn)));

  if (type == StatsType.libraryLands) {
    newOptions = _builtRange(0, 7);
  } else {
    newOptions = BuiltList();
  }
  updated.landsInHand =
      updated.landsInHand.rebuild(paramUpdater(old.landsInHand, newOptions));

  if (type == StatsType.libraryLands) {
    newOptions = _builtRange(0, 9, (i) => i + 1);
  } else {
    newOptions = BuiltList();
  }
  updated.libraryPosition = updated.libraryPosition
      .rebuild(paramUpdater(old.libraryPosition, newOptions));

  if (type == StatsType.cardPositions) {
    int minBlockSize = updated.breakdownBy.value == 'numCards'
        ? 1
        : max(updated.numCards.options.firstWhere((o) => o.selected).value ?? 1,
            1);
    newOptions =
        _builtRange(0, updated.deckSize.value - minBlockSize + 1, (i) => i + 1);
  } else {
    newOptions = BuiltList();
  }
  updated.decklistPosition = updated.decklistPosition
      .rebuild(paramUpdater(old.decklistPosition, newOptions));

  updated.weeks = updated.weeks.rebuild(defaultErrorSetter());

  updated.onSet = onSet;
}
