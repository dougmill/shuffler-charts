// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parameters.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializers _$_paramSerializers = (new Serializers().toBuilder()
      ..add(Parameters.serializer)
      ..addBuilderFactory(
          const FullType(Parameter, const [const FullType(String)]),
          () => new ParameterBuilder<String>())
      ..addBuilderFactory(
          const FullType(Parameter, const [const FullType(String)]),
          () => new ParameterBuilder<String>())
      ..addBuilderFactory(
          const FullType(Parameter, const [const FullType(String)]),
          () => new ParameterBuilder<String>())
      ..addBuilderFactory(
          const FullType(Parameter, const [const FullType(DisplayOption)]),
          () => new ParameterBuilder<DisplayOption>())
      ..addBuilderFactory(
          const FullType(Parameter, const [const FullType(int)]),
          () => new ParameterBuilder<int>())
      ..addBuilderFactory(
          const FullType(Parameter, const [const FullType(int)]),
          () => new ParameterBuilder<int>())
      ..addBuilderFactory(
          const FullType(Parameter, const [const FullType(int)]),
          () => new ParameterBuilder<int>())
      ..addBuilderFactory(
          const FullType(Parameter, const [const FullType(int)]),
          () => new ParameterBuilder<int>())
      ..addBuilderFactory(
          const FullType(Parameter, const [const FullType(String)]),
          () => new ParameterBuilder<String>())
      ..addBuilderFactory(
          const FullType(Parameter, const [const FullType(int)]),
          () => new ParameterBuilder<int>())
      ..addBuilderFactory(
          const FullType(Parameter, const [const FullType(int)]),
          () => new ParameterBuilder<int>())
      ..addBuilderFactory(
          const FullType(Parameter, const [const FullType(int)]),
          () => new ParameterBuilder<int>())
      ..addBuilderFactory(
          const FullType(Parameter, const [const FullType(int)]),
          () => new ParameterBuilder<int>())
      ..addBuilderFactory(
          const FullType(Parameter, const [const FullType(int)]),
          () => new ParameterBuilder<int>())
      ..addBuilderFactory(
          const FullType(Parameter, const [const FullType(int)]),
          () => new ParameterBuilder<int>()))
    .build();
Serializer<Parameters> _$parametersSerializer = new _$ParametersSerializer();

class _$ParametersSerializer implements StructuredSerializer<Parameters> {
  @override
  final Iterable<Type> types = const [Parameters, _$Parameters];
  @override
  final String wireName = 'Parameters';

  @override
  Iterable serialize(Serializers serializers, Parameters object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'type',
      serializers.serialize(object.type,
          specifiedType:
              const FullType(Parameter, const [const FullType(String)])),
      'xAxis',
      serializers.serialize(object.xAxis,
          specifiedType:
              const FullType(Parameter, const [const FullType(String)])),
      'breakdownBy',
      serializers.serialize(object.breakdownBy,
          specifiedType:
              const FullType(Parameter, const [const FullType(String)])),
      'options',
      serializers.serialize(object.options,
          specifiedType:
              const FullType(Parameter, const [const FullType(DisplayOption)])),
      'deckSize',
      serializers.serialize(object.deckSize,
          specifiedType:
              const FullType(Parameter, const [const FullType(int)])),
      'landsInDeck',
      serializers.serialize(object.landsInDeck,
          specifiedType:
              const FullType(Parameter, const [const FullType(int)])),
      'numCards',
      serializers.serialize(object.numCards,
          specifiedType:
              const FullType(Parameter, const [const FullType(int)])),
      'bestOf',
      serializers.serialize(object.bestOf,
          specifiedType:
              const FullType(Parameter, const [const FullType(int)])),
      'shuffling',
      serializers.serialize(object.shuffling,
          specifiedType:
              const FullType(Parameter, const [const FullType(String)])),
      'mulligans',
      serializers.serialize(object.mulligans,
          specifiedType:
              const FullType(Parameter, const [const FullType(int)])),
      'numDrawn',
      serializers.serialize(object.numDrawn,
          specifiedType:
              const FullType(Parameter, const [const FullType(int)])),
      'landsInHand',
      serializers.serialize(object.landsInHand,
          specifiedType:
              const FullType(Parameter, const [const FullType(int)])),
      'libraryPosition',
      serializers.serialize(object.libraryPosition,
          specifiedType:
              const FullType(Parameter, const [const FullType(int)])),
      'decklistPosition',
      serializers.serialize(object.decklistPosition,
          specifiedType:
              const FullType(Parameter, const [const FullType(int)])),
      'weeks',
      serializers.serialize(object.weeks,
          specifiedType:
              const FullType(Parameter, const [const FullType(int)])),
    ];

    return result;
  }

  @override
  Parameters deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ParametersBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'type':
          result.type = serializers.deserialize(value,
                  specifiedType:
                      const FullType(Parameter, const [const FullType(String)]))
              as Parameter<String>;
          break;
        case 'xAxis':
          result.xAxis = serializers.deserialize(value,
                  specifiedType:
                      const FullType(Parameter, const [const FullType(String)]))
              as Parameter<String>;
          break;
        case 'breakdownBy':
          result.breakdownBy = serializers.deserialize(value,
                  specifiedType:
                      const FullType(Parameter, const [const FullType(String)]))
              as Parameter<String>;
          break;
        case 'options':
          result.options = serializers.deserialize(value,
                  specifiedType: const FullType(
                      Parameter, const [const FullType(DisplayOption)]))
              as Parameter<DisplayOption>;
          break;
        case 'deckSize':
          result.deckSize = serializers.deserialize(value,
                  specifiedType:
                      const FullType(Parameter, const [const FullType(int)]))
              as Parameter<int>;
          break;
        case 'landsInDeck':
          result.landsInDeck = serializers.deserialize(value,
                  specifiedType:
                      const FullType(Parameter, const [const FullType(int)]))
              as Parameter<int>;
          break;
        case 'numCards':
          result.numCards = serializers.deserialize(value,
                  specifiedType:
                      const FullType(Parameter, const [const FullType(int)]))
              as Parameter<int>;
          break;
        case 'bestOf':
          result.bestOf = serializers.deserialize(value,
                  specifiedType:
                      const FullType(Parameter, const [const FullType(int)]))
              as Parameter<int>;
          break;
        case 'shuffling':
          result.shuffling = serializers.deserialize(value,
                  specifiedType:
                      const FullType(Parameter, const [const FullType(String)]))
              as Parameter<String>;
          break;
        case 'mulligans':
          result.mulligans = serializers.deserialize(value,
                  specifiedType:
                      const FullType(Parameter, const [const FullType(int)]))
              as Parameter<int>;
          break;
        case 'numDrawn':
          result.numDrawn = serializers.deserialize(value,
                  specifiedType:
                      const FullType(Parameter, const [const FullType(int)]))
              as Parameter<int>;
          break;
        case 'landsInHand':
          result.landsInHand = serializers.deserialize(value,
                  specifiedType:
                      const FullType(Parameter, const [const FullType(int)]))
              as Parameter<int>;
          break;
        case 'libraryPosition':
          result.libraryPosition = serializers.deserialize(value,
                  specifiedType:
                      const FullType(Parameter, const [const FullType(int)]))
              as Parameter<int>;
          break;
        case 'decklistPosition':
          result.decklistPosition = serializers.deserialize(value,
                  specifiedType:
                      const FullType(Parameter, const [const FullType(int)]))
              as Parameter<int>;
          break;
        case 'weeks':
          result.weeks = serializers.deserialize(value,
                  specifiedType:
                      const FullType(Parameter, const [const FullType(int)]))
              as Parameter<int>;
          break;
      }
    }

    return result.build();
  }
}

class _$Parameters extends Parameters {
  @override
  final Parameter<String> type;
  @override
  final Parameter<String> xAxis;
  @override
  final Parameter<String> breakdownBy;
  @override
  final Parameter<DisplayOption> options;
  @override
  final Parameter<int> deckSize;
  @override
  final Parameter<int> landsInDeck;
  @override
  final Parameter<int> numCards;
  @override
  final Parameter<int> bestOf;
  @override
  final Parameter<String> shuffling;
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
  BuiltMap<String, Parameter<dynamic>> __asMap;

  factory _$Parameters([void Function(ParametersBuilder) updates]) =>
      (new ParametersBuilder()..update(updates)).build();

  _$Parameters._(
      {this.type,
      this.xAxis,
      this.breakdownBy,
      this.options,
      this.deckSize,
      this.landsInDeck,
      this.numCards,
      this.bestOf,
      this.shuffling,
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
    if (landsInDeck == null) {
      throw new BuiltValueNullFieldError('Parameters', 'landsInDeck');
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
  BuiltMap<String, Parameter<dynamic>> get asMap => __asMap ??= super.asMap;

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
        landsInDeck == other.landsInDeck &&
        numCards == other.numCards &&
        bestOf == other.bestOf &&
        shuffling == other.shuffling &&
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
                                            landsInDeck.hashCode),
                                        numCards.hashCode),
                                    bestOf.hashCode),
                                shuffling.hashCode),
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
          ..add('landsInDeck', landsInDeck)
          ..add('numCards', numCards)
          ..add('bestOf', bestOf)
          ..add('shuffling', shuffling)
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

  Parameter<String> _type;
  Parameter<String> get type => _$this._type;
  set type(Parameter<String> type) {
    _$this._type = type;
    onSet();
  }

  Parameter<String> _xAxis;
  Parameter<String> get xAxis => _$this._xAxis;
  set xAxis(Parameter<String> xAxis) {
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

  Parameter<int> _landsInDeck;
  Parameter<int> get landsInDeck => _$this._landsInDeck;
  set landsInDeck(Parameter<int> landsInDeck) {
    _$this._landsInDeck = landsInDeck;
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

  Parameter<String> _shuffling;
  Parameter<String> get shuffling => _$this._shuffling;
  set shuffling(Parameter<String> shuffling) {
    _$this._shuffling = shuffling;
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
      _landsInDeck = _$v.landsInDeck;
      _numCards = _$v.numCards;
      _bestOf = _$v.bestOf;
      _shuffling = _$v.shuffling;
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
            landsInDeck: landsInDeck,
            numCards: numCards,
            bestOf: bestOf,
            shuffling: shuffling,
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
    if (value == null) {
      throw new BuiltValueNullFieldError('Parameter', 'value');
    }
    if (multiSelections == null) {
      throw new BuiltValueNullFieldError('Parameter', 'multiSelections');
    }
    if (options == null) {
      throw new BuiltValueNullFieldError('Parameter', 'options');
    }
    if (error == null) {
      throw new BuiltValueNullFieldError('Parameter', 'error');
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

  ListBuilder<Option<BuiltSet<T>>> _multiSelections;
  ListBuilder<Option<BuiltSet<T>>> get multiSelections =>
      _$this._multiSelections ??= new ListBuilder<Option<BuiltSet<T>>>();
  set multiSelections(ListBuilder<Option<BuiltSet<T>>> multiSelections) {
    _$this._multiSelections = multiSelections;
    onSet();
  }

  ListBuilder<Option<T>> _options;
  ListBuilder<Option<T>> get options =>
      _$this._options ??= new ListBuilder<Option<T>>();
  set options(ListBuilder<Option<T>> options) {
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
      _multiSelections = _$v.multiSelections?.toBuilder();
      _options = _$v.options?.toBuilder();
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
    _$Parameter<T> _$result;
    try {
      _$result = _$v ??
          new _$Parameter<T>._(
              type: type,
              name: name,
              value: value,
              multiSelections: multiSelections.build(),
              options: options.build(),
              error: error);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'multiSelections';
        multiSelections.build();
        _$failedField = 'options';
        options.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Parameter', _$failedField, e.toString());
      }
      rethrow;
    }
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
    return other is Option && value == other.value && label == other.label;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, value.hashCode), label.hashCode));
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

  T _value;
  T get value => _$this._value;
  set value(T value) => _$this._value = value;

  String _label;
  String get label => _$this._label;
  set label(String label) => _$this._label = label;

  bool _selected;
  bool get selected => _$this._selected;
  set selected(bool selected) => _$this._selected = selected;

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
