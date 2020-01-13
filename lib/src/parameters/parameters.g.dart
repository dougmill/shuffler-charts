// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parameters.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const StatsType _$handLands = const StatsType._('handLands');
const StatsType _$libraryLands = const StatsType._('libraryLands');
const StatsType _$cardPositions = const StatsType._('cardPositions');
const StatsType _$cardCopies = const StatsType._('cardCopies');

StatsType _$statsTypeValueOf(String name) {
  switch (name) {
    case 'handLands':
      return _$handLands;
    case 'libraryLands':
      return _$libraryLands;
    case 'cardPositions':
      return _$cardPositions;
    case 'cardCopies':
      return _$cardCopies;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<StatsType> _$statsTypeValues =
    new BuiltSet<StatsType>(const <StatsType>[
  _$handLands,
  _$libraryLands,
  _$cardPositions,
  _$cardCopies,
]);

const DisplayOption _$actual = const DisplayOption._('actual');
const DisplayOption _$expected = const DisplayOption._('expected');
const DisplayOption _$bugged = const DisplayOption._('bugged');
const DisplayOption _$count = const DisplayOption._('count');
const DisplayOption _$sampleSize = const DisplayOption._('sampleSize');

DisplayOption _$displayOptionValueOf(String name) {
  switch (name) {
    case 'actual':
      return _$actual;
    case 'expected':
      return _$expected;
    case 'bugged':
      return _$bugged;
    case 'count':
      return _$count;
    case 'sampleSize':
      return _$sampleSize;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<DisplayOption> _$displayOptionValues =
    new BuiltSet<DisplayOption>(const <DisplayOption>[
  _$actual,
  _$expected,
  _$bugged,
  _$count,
  _$sampleSize,
]);

const Shuffling _$normal = const Shuffling._('normal');
const Shuffling _$smoothed = const Shuffling._('smoothed');

Shuffling _$shufflingValueOf(String name) {
  switch (name) {
    case 'normal':
      return _$normal;
    case 'smoothed':
      return _$smoothed;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<Shuffling> _$shufflingValues =
    new BuiltSet<Shuffling>(const <Shuffling>[
  _$normal,
  _$smoothed,
]);

const MulliganType _$vancouver = const MulliganType._('vancouver');
const MulliganType _$london = const MulliganType._('london');

MulliganType _$mulliganTypeValueOf(String name) {
  switch (name) {
    case 'vancouver':
      return _$vancouver;
    case 'london':
      return _$london;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<MulliganType> _$mulliganTypeValues =
    new BuiltSet<MulliganType>(const <MulliganType>[
  _$vancouver,
  _$london,
]);

Serializer<StatsType> _$statsTypeSerializer = new _$StatsTypeSerializer();
Serializer<Shuffling> _$shufflingSerializer = new _$ShufflingSerializer();
Serializer<MulliganType> _$mulliganTypeSerializer =
    new _$MulliganTypeSerializer();

class _$StatsTypeSerializer implements PrimitiveSerializer<StatsType> {
  @override
  final Iterable<Type> types = const <Type>[StatsType];
  @override
  final String wireName = 'StatsType';

  @override
  Object serialize(Serializers serializers, StatsType object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  StatsType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      StatsType.valueOf(serialized as String);
}

class _$ShufflingSerializer implements PrimitiveSerializer<Shuffling> {
  @override
  final Iterable<Type> types = const <Type>[Shuffling];
  @override
  final String wireName = 'Shuffling';

  @override
  Object serialize(Serializers serializers, Shuffling object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  Shuffling deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Shuffling.valueOf(serialized as String);
}

class _$MulliganTypeSerializer implements PrimitiveSerializer<MulliganType> {
  @override
  final Iterable<Type> types = const <Type>[MulliganType];
  @override
  final String wireName = 'MulliganType';

  @override
  Object serialize(Serializers serializers, MulliganType object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  MulliganType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      MulliganType.valueOf(serialized as String);
}

class _$FetchParameters extends FetchParameters {
  @override
  final StatsType type;
  @override
  final int deckSize;
  @override
  final int numCards;

  factory _$FetchParameters([void Function(FetchParametersBuilder) updates]) =>
      (new FetchParametersBuilder()..update(updates)).build();

  _$FetchParameters._({this.type, this.deckSize, this.numCards}) : super._() {
    if (type == null) {
      throw new BuiltValueNullFieldError('FetchParameters', 'type');
    }
  }

  @override
  FetchParameters rebuild(void Function(FetchParametersBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FetchParametersBuilder toBuilder() =>
      new FetchParametersBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FetchParameters &&
        type == other.type &&
        deckSize == other.deckSize &&
        numCards == other.numCards;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, type.hashCode), deckSize.hashCode), numCards.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('FetchParameters')
          ..add('type', type)
          ..add('deckSize', deckSize)
          ..add('numCards', numCards))
        .toString();
  }
}

class FetchParametersBuilder
    implements Builder<FetchParameters, FetchParametersBuilder> {
  _$FetchParameters _$v;

  StatsType _type;
  StatsType get type => _$this._type;
  set type(StatsType type) => _$this._type = type;

  int _deckSize;
  int get deckSize => _$this._deckSize;
  set deckSize(int deckSize) => _$this._deckSize = deckSize;

  int _numCards;
  int get numCards => _$this._numCards;
  set numCards(int numCards) => _$this._numCards = numCards;

  FetchParametersBuilder();

  FetchParametersBuilder get _$this {
    if (_$v != null) {
      _type = _$v.type;
      _deckSize = _$v.deckSize;
      _numCards = _$v.numCards;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FetchParameters other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$FetchParameters;
  }

  @override
  void update(void Function(FetchParametersBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$FetchParameters build() {
    final _$result = _$v ??
        new _$FetchParameters._(
            type: type, deckSize: deckSize, numCards: numCards);
    replace(_$result);
    return _$result;
  }
}

class _$Parameters extends Parameters {
  @override
  final Parameter<StatsType> type;
  @override
  final Parameter<Object> xAxis;
  @override
  final Parameter<String> breakdownBy;
  @override
  final Parameter<DisplayOption> options;
  @override
  final Parameter<int> deckSize;
  @override
  final Parameter<int> numCards;
  @override
  final Parameter<int> bestOf;
  @override
  final Parameter<Shuffling> shuffling;
  @override
  final Parameter<MulliganType> mulliganType;
  @override
  final Parameter<int> mulligans;
  @override
  final Parameter<int> numDrawn;
  @override
  final Parameter<int> landsInHand;
  @override
  final Parameter<int> libraryPosition;
  @override
  final Parameter<int> decklistPosition;
  @override
  final Parameter<int> weeks;
  BuiltMap<String, Parameter> __asMap;
  bool __isValid;

  factory _$Parameters([void Function(ParametersBuilder) updates]) =>
      (new ParametersBuilder()..update(updates)).build();

  _$Parameters._(
      {this.type,
      this.xAxis,
      this.breakdownBy,
      this.options,
      this.deckSize,
      this.numCards,
      this.bestOf,
      this.shuffling,
      this.mulliganType,
      this.mulligans,
      this.numDrawn,
      this.landsInHand,
      this.libraryPosition,
      this.decklistPosition,
      this.weeks})
      : super._() {
    if (type == null) {
      throw new BuiltValueNullFieldError('Parameters', 'type');
    }
    if (xAxis == null) {
      throw new BuiltValueNullFieldError('Parameters', 'xAxis');
    }
    if (breakdownBy == null) {
      throw new BuiltValueNullFieldError('Parameters', 'breakdownBy');
    }
    if (options == null) {
      throw new BuiltValueNullFieldError('Parameters', 'options');
    }
    if (deckSize == null) {
      throw new BuiltValueNullFieldError('Parameters', 'deckSize');
    }
    if (numCards == null) {
      throw new BuiltValueNullFieldError('Parameters', 'numCards');
    }
    if (bestOf == null) {
      throw new BuiltValueNullFieldError('Parameters', 'bestOf');
    }
    if (shuffling == null) {
      throw new BuiltValueNullFieldError('Parameters', 'shuffling');
    }
    if (mulliganType == null) {
      throw new BuiltValueNullFieldError('Parameters', 'mulliganType');
    }
    if (mulligans == null) {
      throw new BuiltValueNullFieldError('Parameters', 'mulligans');
    }
    if (numDrawn == null) {
      throw new BuiltValueNullFieldError('Parameters', 'numDrawn');
    }
    if (landsInHand == null) {
      throw new BuiltValueNullFieldError('Parameters', 'landsInHand');
    }
    if (libraryPosition == null) {
      throw new BuiltValueNullFieldError('Parameters', 'libraryPosition');
    }
    if (decklistPosition == null) {
      throw new BuiltValueNullFieldError('Parameters', 'decklistPosition');
    }
    if (weeks == null) {
      throw new BuiltValueNullFieldError('Parameters', 'weeks');
    }
  }

  @override
  BuiltMap<String, Parameter> get asMap => __asMap ??= super.asMap;

  @override
  bool get isValid => __isValid ??= super.isValid;

  @override
  Parameters rebuild(void Function(ParametersBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ParametersBuilder toBuilder() => new ParametersBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Parameters &&
        type == other.type &&
        xAxis == other.xAxis &&
        breakdownBy == other.breakdownBy &&
        options == other.options &&
        deckSize == other.deckSize &&
        numCards == other.numCards &&
        bestOf == other.bestOf &&
        shuffling == other.shuffling &&
        mulliganType == other.mulliganType &&
        mulligans == other.mulligans &&
        numDrawn == other.numDrawn &&
        landsInHand == other.landsInHand &&
        libraryPosition == other.libraryPosition &&
        decklistPosition == other.decklistPosition &&
        weeks == other.weeks;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc(
                                                $jc(
                                                    $jc(
                                                        $jc(
                                                            $jc(0,
                                                                type.hashCode),
                                                            xAxis.hashCode),
                                                        breakdownBy.hashCode),
                                                    options.hashCode),
                                                deckSize.hashCode),
                                            numCards.hashCode),
                                        bestOf.hashCode),
                                    shuffling.hashCode),
                                mulliganType.hashCode),
                            mulligans.hashCode),
                        numDrawn.hashCode),
                    landsInHand.hashCode),
                libraryPosition.hashCode),
            decklistPosition.hashCode),
        weeks.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Parameters')
          ..add('type', type)
          ..add('xAxis', xAxis)
          ..add('breakdownBy', breakdownBy)
          ..add('options', options)
          ..add('deckSize', deckSize)
          ..add('numCards', numCards)
          ..add('bestOf', bestOf)
          ..add('shuffling', shuffling)
          ..add('mulliganType', mulliganType)
          ..add('mulligans', mulligans)
          ..add('numDrawn', numDrawn)
          ..add('landsInHand', landsInHand)
          ..add('libraryPosition', libraryPosition)
          ..add('decklistPosition', decklistPosition)
          ..add('weeks', weeks))
        .toString();
  }
}

class ParametersBuilder implements Builder<Parameters, ParametersBuilder> {
  _$Parameters _$v;

  void Function() onSet = () {};

  Parameter<StatsType> _type;
  Parameter<StatsType> get type => _$this._type;
  set type(Parameter<StatsType> type) {
    _$this._type = type;
    onSet();
  }

  Parameter<Object> _xAxis;
  Parameter<Object> get xAxis => _$this._xAxis;
  set xAxis(Parameter<Object> xAxis) {
    _$this._xAxis = xAxis;
    onSet();
  }

  Parameter<String> _breakdownBy;
  Parameter<String> get breakdownBy => _$this._breakdownBy;
  set breakdownBy(Parameter<String> breakdownBy) {
    _$this._breakdownBy = breakdownBy;
    onSet();
  }

  Parameter<DisplayOption> _options;
  Parameter<DisplayOption> get options => _$this._options;
  set options(Parameter<DisplayOption> options) {
    _$this._options = options;
    onSet();
  }

  Parameter<int> _deckSize;
  Parameter<int> get deckSize => _$this._deckSize;
  set deckSize(Parameter<int> deckSize) {
    _$this._deckSize = deckSize;
    onSet();
  }

  Parameter<int> _numCards;
  Parameter<int> get numCards => _$this._numCards;
  set numCards(Parameter<int> numCards) {
    _$this._numCards = numCards;
    onSet();
  }

  Parameter<int> _bestOf;
  Parameter<int> get bestOf => _$this._bestOf;
  set bestOf(Parameter<int> bestOf) {
    _$this._bestOf = bestOf;
    onSet();
  }

  Parameter<Shuffling> _shuffling;
  Parameter<Shuffling> get shuffling => _$this._shuffling;
  set shuffling(Parameter<Shuffling> shuffling) {
    _$this._shuffling = shuffling;
    onSet();
  }

  Parameter<MulliganType> _mulliganType;
  Parameter<MulliganType> get mulliganType => _$this._mulliganType;
  set mulliganType(Parameter<MulliganType> mulliganType) {
    _$this._mulliganType = mulliganType;
    onSet();
  }

  Parameter<int> _mulligans;
  Parameter<int> get mulligans => _$this._mulligans;
  set mulligans(Parameter<int> mulligans) {
    _$this._mulligans = mulligans;
    onSet();
  }

  Parameter<int> _numDrawn;
  Parameter<int> get numDrawn => _$this._numDrawn;
  set numDrawn(Parameter<int> numDrawn) {
    _$this._numDrawn = numDrawn;
    onSet();
  }

  Parameter<int> _landsInHand;
  Parameter<int> get landsInHand => _$this._landsInHand;
  set landsInHand(Parameter<int> landsInHand) {
    _$this._landsInHand = landsInHand;
    onSet();
  }

  Parameter<int> _libraryPosition;
  Parameter<int> get libraryPosition => _$this._libraryPosition;
  set libraryPosition(Parameter<int> libraryPosition) {
    _$this._libraryPosition = libraryPosition;
    onSet();
  }

  Parameter<int> _decklistPosition;
  Parameter<int> get decklistPosition => _$this._decklistPosition;
  set decklistPosition(Parameter<int> decklistPosition) {
    _$this._decklistPosition = decklistPosition;
    onSet();
  }

  Parameter<int> _weeks;
  Parameter<int> get weeks => _$this._weeks;
  set weeks(Parameter<int> weeks) {
    _$this._weeks = weeks;
    onSet();
  }

  ParametersBuilder();

  ParametersBuilder get _$this {
    if (_$v != null) {
      _type = _$v.type;
      _xAxis = _$v.xAxis;
      _breakdownBy = _$v.breakdownBy;
      _options = _$v.options;
      _deckSize = _$v.deckSize;
      _numCards = _$v.numCards;
      _bestOf = _$v.bestOf;
      _shuffling = _$v.shuffling;
      _mulliganType = _$v.mulliganType;
      _mulligans = _$v.mulligans;
      _numDrawn = _$v.numDrawn;
      _landsInHand = _$v.landsInHand;
      _libraryPosition = _$v.libraryPosition;
      _decklistPosition = _$v.decklistPosition;
      _weeks = _$v.weeks;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Parameters other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Parameters;
  }

  @override
  void update(void Function(ParametersBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Parameters build() {
    final _$result = _$v ??
        new _$Parameters._(
            type: type,
            xAxis: xAxis,
            breakdownBy: breakdownBy,
            options: options,
            deckSize: deckSize,
            numCards: numCards,
            bestOf: bestOf,
            shuffling: shuffling,
            mulliganType: mulliganType,
            mulligans: mulligans,
            numDrawn: numDrawn,
            landsInHand: landsInHand,
            libraryPosition: libraryPosition,
            decklistPosition: decklistPosition,
            weeks: weeks);
    replace(_$result);
    return _$result;
  }
}

class _$Parameter<T> extends Parameter<T> {
  @override
  final ParameterType type;
  @override
  final String name;
  @override
  final T value;
  @override
  final BuiltList<Option<BuiltSet<T>>> multiSelections;
  @override
  final BuiltList<Option<T>> options;
  @override
  final String error;

  factory _$Parameter([void Function(ParameterBuilder<T>) updates]) =>
      (new ParameterBuilder<T>()..update(updates)).build();

  _$Parameter._(
      {this.type,
      this.name,
      this.value,
      this.multiSelections,
      this.options,
      this.error})
      : super._() {
    if (type == null) {
      throw new BuiltValueNullFieldError('Parameter', 'type');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('Parameter', 'name');
    }
    if (multiSelections == null) {
      throw new BuiltValueNullFieldError('Parameter', 'multiSelections');
    }
    if (options == null) {
      throw new BuiltValueNullFieldError('Parameter', 'options');
    }
    if (T == dynamic) {
      throw new BuiltValueMissingGenericsError('Parameter', 'T');
    }
  }

  @override
  Parameter<T> rebuild(void Function(ParameterBuilder<T>) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ParameterBuilder<T> toBuilder() => new ParameterBuilder<T>()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Parameter &&
        type == other.type &&
        name == other.name &&
        value == other.value &&
        multiSelections == other.multiSelections &&
        options == other.options &&
        error == other.error;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc($jc(0, type.hashCode), name.hashCode), value.hashCode),
                multiSelections.hashCode),
            options.hashCode),
        error.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Parameter')
          ..add('type', type)
          ..add('name', name)
          ..add('value', value)
          ..add('multiSelections', multiSelections)
          ..add('options', options)
          ..add('error', error))
        .toString();
  }
}

class ParameterBuilder<T>
    implements Builder<Parameter<T>, ParameterBuilder<T>> {
  _$Parameter<T> _$v;

  void Function() onSet = () {};

  ParameterType _type;
  ParameterType get type => _$this._type;
  set type(ParameterType type) {
    _$this._type = type;
    onSet();
  }

  String _name;
  String get name => _$this._name;
  set name(String name) {
    _$this._name = name;
    onSet();
  }

  T _value;
  T get value => _$this._value;
  set value(T value) {
    _$this._value = value;
    onSet();
  }

  BuiltList<Option<BuiltSet<T>>> _multiSelections;
  BuiltList<Option<BuiltSet<T>>> get multiSelections => _$this._multiSelections;
  set multiSelections(BuiltList<Option<BuiltSet<T>>> multiSelections) {
    _$this._multiSelections = multiSelections;
    onSet();
  }

  BuiltList<Option<T>> _options;
  BuiltList<Option<T>> get options => _$this._options;
  set options(BuiltList<Option<T>> options) {
    _$this._options = options;
    onSet();
  }

  String _error;
  String get error => _$this._error;
  set error(String error) {
    _$this._error = error;
    onSet();
  }

  ParameterBuilder();

  ParameterBuilder<T> get _$this {
    if (_$v != null) {
      _type = _$v.type;
      _name = _$v.name;
      _value = _$v.value;
      _multiSelections = _$v.multiSelections;
      _options = _$v.options;
      _error = _$v.error;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Parameter<T> other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Parameter<T>;
  }

  @override
  void update(void Function(ParameterBuilder<T>) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Parameter<T> build() {
    final _$result = _$v ??
        new _$Parameter<T>._(
            type: type,
            name: name,
            value: value,
            multiSelections: multiSelections,
            options: options,
            error: error);
    replace(_$result);
    return _$result;
  }
}

class _$Option<T> extends Option<T> {
  @override
  final T value;
  @override
  final String label;
  @override
  final bool selected;

  factory _$Option([void Function(OptionBuilder<T>) updates]) =>
      (new OptionBuilder<T>()..update(updates)).build();

  _$Option._({this.value, this.label, this.selected}) : super._() {
    if (value == null) {
      throw new BuiltValueNullFieldError('Option', 'value');
    }
    if (label == null) {
      throw new BuiltValueNullFieldError('Option', 'label');
    }
    if (selected == null) {
      throw new BuiltValueNullFieldError('Option', 'selected');
    }
    if (T == dynamic) {
      throw new BuiltValueMissingGenericsError('Option', 'T');
    }
  }

  @override
  Option<T> rebuild(void Function(OptionBuilder<T>) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OptionBuilder<T> toBuilder() => new OptionBuilder<T>()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Option &&
        value == other.value &&
        label == other.label &&
        selected == other.selected;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, value.hashCode), label.hashCode), selected.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Option')
          ..add('value', value)
          ..add('label', label)
          ..add('selected', selected))
        .toString();
  }
}

class OptionBuilder<T> implements Builder<Option<T>, OptionBuilder<T>> {
  _$Option<T> _$v;

  void Function() onSet = () {};

  T _value;
  T get value => _$this._value;
  set value(T value) {
    _$this._value = value;
    onSet();
  }

  String _label;
  String get label => _$this._label;
  set label(String label) {
    _$this._label = label;
    onSet();
  }

  bool _selected;
  bool get selected => _$this._selected;
  set selected(bool selected) {
    _$this._selected = selected;
    onSet();
  }

  OptionBuilder();

  OptionBuilder<T> get _$this {
    if (_$v != null) {
      _value = _$v.value;
      _label = _$v.label;
      _selected = _$v.selected;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Option<T> other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Option<T>;
  }

  @override
  void update(void Function(OptionBuilder<T>) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Option<T> build() {
    final _$result = _$v ??
        new _$Option<T>._(value: value, label: label, selected: selected);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$StatsTypeToJson(StatsType instance) => <String, dynamic>{
      'name': instance.name,
    };

Map<String, dynamic> _$DisplayOptionToJson(DisplayOption instance) =>
    <String, dynamic>{
      'name': instance.name,
      'label': instance.label,
    };

Map<String, dynamic> _$ShufflingToJson(Shuffling instance) => <String, dynamic>{
      'name': instance.name,
    };

Map<String, dynamic> _$MulliganTypeToJson(MulliganType instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

Map<String, dynamic> _$ParametersToJson(Parameters instance) =>
    <String, dynamic>{
      'type': instance.type,
      'xAxis': instance.xAxis,
      'breakdownBy': instance.breakdownBy,
      'options': instance.options,
      'deckSize': instance.deckSize,
      'numCards': instance.numCards,
      'bestOf': instance.bestOf,
      'shuffling': instance.shuffling,
      'mulliganType': instance.mulliganType,
      'mulligans': instance.mulligans,
      'numDrawn': instance.numDrawn,
      'landsInHand': instance.landsInHand,
      'libraryPosition': instance.libraryPosition,
      'decklistPosition': instance.decklistPosition,
      'weeks': instance.weeks,
    };

Parameter<T> _$ParameterFromJson<T>(Map<String, dynamic> json) {
  return Parameter<T>();
}

Map<String, dynamic> _$ParameterToJson<T>(Parameter<T> instance) =>
    <String, dynamic>{};
