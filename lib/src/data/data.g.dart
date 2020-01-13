// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializers _$dataSerializers = (new Serializers().toBuilder()
      ..add(CardsByCountEntry.serializer)
      ..add(CardsByPositionEntry.serializer)
      ..add(Group.serializer)
      ..add(LandsInHandEntry.serializer)
      ..add(LandsInLibraryEntry.serializer)
      ..add(MulliganType.serializer)
      ..add(Shuffling.serializer)
      ..add(StatsType.serializer)
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(BuiltList, const [
              const FullType(BuiltList, const [
                const FullType(BuiltList, const [const FullType(num)])
              ])
            ])
          ]),
          () => new ListBuilder<BuiltList<BuiltList<BuiltList<num>>>>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(BuiltList, const [
              const FullType(BuiltList, const [const FullType(num)])
            ])
          ]),
          () => new ListBuilder<BuiltList<BuiltList<num>>>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(BuiltList, const [const FullType(num)])
          ]),
          () => new ListBuilder<BuiltList<num>>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [
            const FullType(BuiltList, const [const FullType(num)])
          ]),
          () => new ListBuilder<BuiltList<num>>()))
    .build();
Serializer<Group> _$groupSerializer = new _$GroupSerializer();
Serializer<LandsInHandEntry> _$landsInHandEntrySerializer =
    new _$LandsInHandEntrySerializer();
Serializer<LandsInLibraryEntry> _$landsInLibraryEntrySerializer =
    new _$LandsInLibraryEntrySerializer();
Serializer<CardsByPositionEntry> _$cardsByPositionEntrySerializer =
    new _$CardsByPositionEntrySerializer();
Serializer<CardsByCountEntry> _$cardsByCountEntrySerializer =
    new _$CardsByCountEntrySerializer();

class _$GroupSerializer implements StructuredSerializer<Group> {
  @override
  final Iterable<Type> types = const [Group, _$Group];
  @override
  final String wireName = 'Group';

  @override
  Iterable<Object> serialize(Serializers serializers, Group object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'deckSize',
      serializers.serialize(object.deckSize,
          specifiedType: const FullType(int)),
      'numCards',
      serializers.serialize(object.numCards,
          specifiedType: const FullType(int)),
      'bestOf',
      serializers.serialize(object.bestOf, specifiedType: const FullType(int)),
      'shuffling',
      serializers.serialize(object.shuffling,
          specifiedType: const FullType(Shuffling)),
      'mulliganType',
      serializers.serialize(object.mulliganType,
          specifiedType: const FullType(MulliganType)),
      'week',
      serializers.serialize(object.week, specifiedType: const FullType(int)),
      'type',
      serializers.serialize(object.type,
          specifiedType: const FullType(StatsType)),
    ];

    return result;
  }

  @override
  Group deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GroupBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'deckSize':
          result.deckSize = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'numCards':
          result.numCards = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'bestOf':
          result.bestOf = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'shuffling':
          result.shuffling = serializers.deserialize(value,
              specifiedType: const FullType(Shuffling)) as Shuffling;
          break;
        case 'mulliganType':
          result.mulliganType = serializers.deserialize(value,
              specifiedType: const FullType(MulliganType)) as MulliganType;
          break;
        case 'week':
          result.week = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'type':
          result.type = serializers.deserialize(value,
              specifiedType: const FullType(StatsType)) as StatsType;
          break;
      }
    }

    return result.build();
  }
}

class _$LandsInHandEntrySerializer
    implements StructuredSerializer<LandsInHandEntry> {
  @override
  final Iterable<Type> types = const [LandsInHandEntry, _$LandsInHandEntry];
  @override
  final String wireName = 'LandsInHandEntry';

  @override
  Iterable<Object> serialize(Serializers serializers, LandsInHandEntry object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'group',
      serializers.serialize(object.group, specifiedType: const FullType(Group)),
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(BuiltList, const [
            const FullType(BuiltList, const [const FullType(num)])
          ])),
    ];

    return result;
  }

  @override
  LandsInHandEntry deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new LandsInHandEntryBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'group':
          result.group.replace(serializers.deserialize(value,
              specifiedType: const FullType(Group)) as Group);
          break;
        case 'data':
          result.data.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(BuiltList, const [const FullType(num)])
              ])) as BuiltList<dynamic>);
          break;
      }
    }

    return result.build();
  }
}

class _$LandsInLibraryEntrySerializer
    implements StructuredSerializer<LandsInLibraryEntry> {
  @override
  final Iterable<Type> types = const [
    LandsInLibraryEntry,
    _$LandsInLibraryEntry
  ];
  @override
  final String wireName = 'LandsInLibraryEntry';

  @override
  Iterable<Object> serialize(
      Serializers serializers, LandsInLibraryEntry object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'group',
      serializers.serialize(object.group, specifiedType: const FullType(Group)),
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(BuiltList, const [
            const FullType(BuiltList, const [
              const FullType(BuiltList, const [
                const FullType(BuiltList, const [const FullType(num)])
              ])
            ])
          ])),
    ];

    return result;
  }

  @override
  LandsInLibraryEntry deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new LandsInLibraryEntryBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'group':
          result.group.replace(serializers.deserialize(value,
              specifiedType: const FullType(Group)) as Group);
          break;
        case 'data':
          result.data.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(BuiltList, const [
                  const FullType(BuiltList, const [
                    const FullType(BuiltList, const [const FullType(num)])
                  ])
                ])
              ])) as BuiltList<dynamic>);
          break;
      }
    }

    return result.build();
  }
}

class _$CardsByPositionEntrySerializer
    implements StructuredSerializer<CardsByPositionEntry> {
  @override
  final Iterable<Type> types = const [
    CardsByPositionEntry,
    _$CardsByPositionEntry
  ];
  @override
  final String wireName = 'CardsByPositionEntry';

  @override
  Iterable<Object> serialize(
      Serializers serializers, CardsByPositionEntry object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'group',
      serializers.serialize(object.group, specifiedType: const FullType(Group)),
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(BuiltList, const [
            const FullType(BuiltList, const [
              const FullType(BuiltList, const [const FullType(num)])
            ])
          ])),
    ];

    return result;
  }

  @override
  CardsByPositionEntry deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CardsByPositionEntryBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'group':
          result.group.replace(serializers.deserialize(value,
              specifiedType: const FullType(Group)) as Group);
          break;
        case 'data':
          result.data.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(BuiltList, const [
                  const FullType(BuiltList, const [const FullType(num)])
                ])
              ])) as BuiltList<dynamic>);
          break;
      }
    }

    return result.build();
  }
}

class _$CardsByCountEntrySerializer
    implements StructuredSerializer<CardsByCountEntry> {
  @override
  final Iterable<Type> types = const [CardsByCountEntry, _$CardsByCountEntry];
  @override
  final String wireName = 'CardsByCountEntry';

  @override
  Iterable<Object> serialize(Serializers serializers, CardsByCountEntry object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'group',
      serializers.serialize(object.group, specifiedType: const FullType(Group)),
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(BuiltList, const [
            const FullType(BuiltList, const [const FullType(num)])
          ])),
    ];

    return result;
  }

  @override
  CardsByCountEntry deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CardsByCountEntryBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'group':
          result.group.replace(serializers.deserialize(value,
              specifiedType: const FullType(Group)) as Group);
          break;
        case 'data':
          result.data.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(BuiltList, const [const FullType(num)])
              ])) as BuiltList<dynamic>);
          break;
      }
    }

    return result.build();
  }
}

class _$Group extends Group {
  @override
  final int deckSize;
  @override
  final int numCards;
  @override
  final int bestOf;
  @override
  final Shuffling shuffling;
  @override
  final MulliganType mulliganType;
  @override
  final int week;
  @override
  final StatsType type;
  BuiltMap<String, Object> __asMap;

  factory _$Group([void Function(GroupBuilder) updates]) =>
      (new GroupBuilder()..update(updates)).build();

  _$Group._(
      {this.deckSize,
      this.numCards,
      this.bestOf,
      this.shuffling,
      this.mulliganType,
      this.week,
      this.type})
      : super._() {
    if (deckSize == null) {
      throw new BuiltValueNullFieldError('Group', 'deckSize');
    }
    if (numCards == null) {
      throw new BuiltValueNullFieldError('Group', 'numCards');
    }
    if (bestOf == null) {
      throw new BuiltValueNullFieldError('Group', 'bestOf');
    }
    if (shuffling == null) {
      throw new BuiltValueNullFieldError('Group', 'shuffling');
    }
    if (mulliganType == null) {
      throw new BuiltValueNullFieldError('Group', 'mulliganType');
    }
    if (week == null) {
      throw new BuiltValueNullFieldError('Group', 'week');
    }
    if (type == null) {
      throw new BuiltValueNullFieldError('Group', 'type');
    }
  }

  @override
  BuiltMap<String, Object> get asMap => __asMap ??= super.asMap;

  @override
  Group rebuild(void Function(GroupBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GroupBuilder toBuilder() => new GroupBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Group &&
        deckSize == other.deckSize &&
        numCards == other.numCards &&
        bestOf == other.bestOf &&
        shuffling == other.shuffling &&
        mulliganType == other.mulliganType &&
        week == other.week &&
        type == other.type;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, deckSize.hashCode), numCards.hashCode),
                        bestOf.hashCode),
                    shuffling.hashCode),
                mulliganType.hashCode),
            week.hashCode),
        type.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Group')
          ..add('deckSize', deckSize)
          ..add('numCards', numCards)
          ..add('bestOf', bestOf)
          ..add('shuffling', shuffling)
          ..add('mulliganType', mulliganType)
          ..add('week', week)
          ..add('type', type))
        .toString();
  }
}

class GroupBuilder implements Builder<Group, GroupBuilder> {
  _$Group _$v;

  int _deckSize;
  int get deckSize => _$this._deckSize;
  set deckSize(int deckSize) => _$this._deckSize = deckSize;

  int _numCards;
  int get numCards => _$this._numCards;
  set numCards(int numCards) => _$this._numCards = numCards;

  int _bestOf;
  int get bestOf => _$this._bestOf;
  set bestOf(int bestOf) => _$this._bestOf = bestOf;

  Shuffling _shuffling;
  Shuffling get shuffling => _$this._shuffling;
  set shuffling(Shuffling shuffling) => _$this._shuffling = shuffling;

  MulliganType _mulliganType;
  MulliganType get mulliganType => _$this._mulliganType;
  set mulliganType(MulliganType mulliganType) =>
      _$this._mulliganType = mulliganType;

  int _week;
  int get week => _$this._week;
  set week(int week) => _$this._week = week;

  StatsType _type;
  StatsType get type => _$this._type;
  set type(StatsType type) => _$this._type = type;

  GroupBuilder();

  GroupBuilder get _$this {
    if (_$v != null) {
      _deckSize = _$v.deckSize;
      _numCards = _$v.numCards;
      _bestOf = _$v.bestOf;
      _shuffling = _$v.shuffling;
      _mulliganType = _$v.mulliganType;
      _week = _$v.week;
      _type = _$v.type;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Group other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Group;
  }

  @override
  void update(void Function(GroupBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Group build() {
    final _$result = _$v ??
        new _$Group._(
            deckSize: deckSize,
            numCards: numCards,
            bestOf: bestOf,
            shuffling: shuffling,
            mulliganType: mulliganType,
            week: week,
            type: type);
    replace(_$result);
    return _$result;
  }
}

class _$LandsInHandEntry extends LandsInHandEntry {
  @override
  final Group group;
  @override
  final BuiltList<BuiltList<num>> data;

  factory _$LandsInHandEntry(
          [void Function(LandsInHandEntryBuilder) updates]) =>
      (new LandsInHandEntryBuilder()..update(updates)).build();

  _$LandsInHandEntry._({this.group, this.data}) : super._() {
    if (group == null) {
      throw new BuiltValueNullFieldError('LandsInHandEntry', 'group');
    }
    if (data == null) {
      throw new BuiltValueNullFieldError('LandsInHandEntry', 'data');
    }
  }

  @override
  LandsInHandEntry rebuild(void Function(LandsInHandEntryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LandsInHandEntryBuilder toBuilder() =>
      new LandsInHandEntryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LandsInHandEntry &&
        group == other.group &&
        data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, group.hashCode), data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('LandsInHandEntry')
          ..add('group', group)
          ..add('data', data))
        .toString();
  }
}

class LandsInHandEntryBuilder
    implements Builder<LandsInHandEntry, LandsInHandEntryBuilder> {
  _$LandsInHandEntry _$v;

  GroupBuilder _group;
  GroupBuilder get group => _$this._group ??= new GroupBuilder();
  set group(GroupBuilder group) => _$this._group = group;

  ListBuilder<BuiltList<num>> _data;
  ListBuilder<BuiltList<num>> get data =>
      _$this._data ??= new ListBuilder<BuiltList<num>>();
  set data(ListBuilder<BuiltList<num>> data) => _$this._data = data;

  LandsInHandEntryBuilder();

  LandsInHandEntryBuilder get _$this {
    if (_$v != null) {
      _group = _$v.group?.toBuilder();
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LandsInHandEntry other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$LandsInHandEntry;
  }

  @override
  void update(void Function(LandsInHandEntryBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$LandsInHandEntry build() {
    _$LandsInHandEntry _$result;
    try {
      _$result = _$v ??
          new _$LandsInHandEntry._(group: group.build(), data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'group';
        group.build();
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'LandsInHandEntry', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$LandsInLibraryEntry extends LandsInLibraryEntry {
  @override
  final Group group;
  @override
  final BuiltList<BuiltList<BuiltList<BuiltList<num>>>> data;

  factory _$LandsInLibraryEntry(
          [void Function(LandsInLibraryEntryBuilder) updates]) =>
      (new LandsInLibraryEntryBuilder()..update(updates)).build();

  _$LandsInLibraryEntry._({this.group, this.data}) : super._() {
    if (group == null) {
      throw new BuiltValueNullFieldError('LandsInLibraryEntry', 'group');
    }
    if (data == null) {
      throw new BuiltValueNullFieldError('LandsInLibraryEntry', 'data');
    }
  }

  @override
  LandsInLibraryEntry rebuild(
          void Function(LandsInLibraryEntryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LandsInLibraryEntryBuilder toBuilder() =>
      new LandsInLibraryEntryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LandsInLibraryEntry &&
        group == other.group &&
        data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, group.hashCode), data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('LandsInLibraryEntry')
          ..add('group', group)
          ..add('data', data))
        .toString();
  }
}

class LandsInLibraryEntryBuilder
    implements Builder<LandsInLibraryEntry, LandsInLibraryEntryBuilder> {
  _$LandsInLibraryEntry _$v;

  GroupBuilder _group;
  GroupBuilder get group => _$this._group ??= new GroupBuilder();
  set group(GroupBuilder group) => _$this._group = group;

  ListBuilder<BuiltList<BuiltList<BuiltList<num>>>> _data;
  ListBuilder<BuiltList<BuiltList<BuiltList<num>>>> get data =>
      _$this._data ??= new ListBuilder<BuiltList<BuiltList<BuiltList<num>>>>();
  set data(ListBuilder<BuiltList<BuiltList<BuiltList<num>>>> data) =>
      _$this._data = data;

  LandsInLibraryEntryBuilder();

  LandsInLibraryEntryBuilder get _$this {
    if (_$v != null) {
      _group = _$v.group?.toBuilder();
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LandsInLibraryEntry other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$LandsInLibraryEntry;
  }

  @override
  void update(void Function(LandsInLibraryEntryBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$LandsInLibraryEntry build() {
    _$LandsInLibraryEntry _$result;
    try {
      _$result = _$v ??
          new _$LandsInLibraryEntry._(group: group.build(), data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'group';
        group.build();
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'LandsInLibraryEntry', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$CardsByPositionEntry extends CardsByPositionEntry {
  @override
  final Group group;
  @override
  final BuiltList<BuiltList<BuiltList<num>>> data;

  factory _$CardsByPositionEntry(
          [void Function(CardsByPositionEntryBuilder) updates]) =>
      (new CardsByPositionEntryBuilder()..update(updates)).build();

  _$CardsByPositionEntry._({this.group, this.data}) : super._() {
    if (group == null) {
      throw new BuiltValueNullFieldError('CardsByPositionEntry', 'group');
    }
    if (data == null) {
      throw new BuiltValueNullFieldError('CardsByPositionEntry', 'data');
    }
  }

  @override
  CardsByPositionEntry rebuild(
          void Function(CardsByPositionEntryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CardsByPositionEntryBuilder toBuilder() =>
      new CardsByPositionEntryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CardsByPositionEntry &&
        group == other.group &&
        data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, group.hashCode), data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CardsByPositionEntry')
          ..add('group', group)
          ..add('data', data))
        .toString();
  }
}

class CardsByPositionEntryBuilder
    implements Builder<CardsByPositionEntry, CardsByPositionEntryBuilder> {
  _$CardsByPositionEntry _$v;

  GroupBuilder _group;
  GroupBuilder get group => _$this._group ??= new GroupBuilder();
  set group(GroupBuilder group) => _$this._group = group;

  ListBuilder<BuiltList<BuiltList<num>>> _data;
  ListBuilder<BuiltList<BuiltList<num>>> get data =>
      _$this._data ??= new ListBuilder<BuiltList<BuiltList<num>>>();
  set data(ListBuilder<BuiltList<BuiltList<num>>> data) => _$this._data = data;

  CardsByPositionEntryBuilder();

  CardsByPositionEntryBuilder get _$this {
    if (_$v != null) {
      _group = _$v.group?.toBuilder();
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CardsByPositionEntry other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$CardsByPositionEntry;
  }

  @override
  void update(void Function(CardsByPositionEntryBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$CardsByPositionEntry build() {
    _$CardsByPositionEntry _$result;
    try {
      _$result = _$v ??
          new _$CardsByPositionEntry._(
              group: group.build(), data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'group';
        group.build();
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'CardsByPositionEntry', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$CardsByCountEntry extends CardsByCountEntry {
  @override
  final Group group;
  @override
  final BuiltList<BuiltList<num>> data;

  factory _$CardsByCountEntry(
          [void Function(CardsByCountEntryBuilder) updates]) =>
      (new CardsByCountEntryBuilder()..update(updates)).build();

  _$CardsByCountEntry._({this.group, this.data}) : super._() {
    if (group == null) {
      throw new BuiltValueNullFieldError('CardsByCountEntry', 'group');
    }
    if (data == null) {
      throw new BuiltValueNullFieldError('CardsByCountEntry', 'data');
    }
  }

  @override
  CardsByCountEntry rebuild(void Function(CardsByCountEntryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CardsByCountEntryBuilder toBuilder() =>
      new CardsByCountEntryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CardsByCountEntry &&
        group == other.group &&
        data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, group.hashCode), data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CardsByCountEntry')
          ..add('group', group)
          ..add('data', data))
        .toString();
  }
}

class CardsByCountEntryBuilder
    implements Builder<CardsByCountEntry, CardsByCountEntryBuilder> {
  _$CardsByCountEntry _$v;

  GroupBuilder _group;
  GroupBuilder get group => _$this._group ??= new GroupBuilder();
  set group(GroupBuilder group) => _$this._group = group;

  ListBuilder<BuiltList<num>> _data;
  ListBuilder<BuiltList<num>> get data =>
      _$this._data ??= new ListBuilder<BuiltList<num>>();
  set data(ListBuilder<BuiltList<num>> data) => _$this._data = data;

  CardsByCountEntryBuilder();

  CardsByCountEntryBuilder get _$this {
    if (_$v != null) {
      _group = _$v.group?.toBuilder();
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CardsByCountEntry other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$CardsByCountEntry;
  }

  @override
  void update(void Function(CardsByCountEntryBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$CardsByCountEntry build() {
    _$CardsByCountEntry _$result;
    try {
      _$result = _$v ??
          new _$CardsByCountEntry._(group: group.build(), data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'group';
        group.build();
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'CardsByCountEntry', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$GroupToJson(Group instance) => <String, dynamic>{
      'deckSize': instance.deckSize,
      'numCards': instance.numCards,
      'bestOf': instance.bestOf,
      'shuffling': instance.shuffling,
      'mulliganType': instance.mulliganType,
      'week': instance.week,
      'type': instance.type,
    };
