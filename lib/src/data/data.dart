import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shuffler_charts/src/parameters/parameters.dart';

part 'data.g.dart';

@SerializersFor([
  LandsInHandEntry,
  LandsInLibraryEntry,
  CardsByPositionEntry,
  CardsByCountEntry
])
Serializers dataSerializers =
    (_$dataSerializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();

@JsonSerializable(createFactory: false)
abstract class Group implements Built<Group, GroupBuilder> {
  static Serializer<Group> get serializer => _$groupSerializer;

  int get deckSize;
  int get numCards;
  int get bestOf;
  Shuffling get shuffling;
  MulliganType get mulliganType;
  int get week;
  StatsType get type;

  @JsonKey(ignore: true)
  @memoized
  BuiltMap<String, dynamic> get asMap => BuiltMap(_$GroupToJson(this));

  Group._();
  factory Group([void Function(GroupBuilder) updates]) = _$Group;
}

abstract class DataEntry<D extends BuiltList<dynamic>> {
  Group get group;
  D get data;
  BuiltList<String> get indexNames;
}

abstract class LandsInHandEntry
    implements
        DataEntry<BuiltList<BuiltList<num>>>,
        Built<LandsInHandEntry, LandsInHandEntryBuilder> {
  static Serializer<LandsInHandEntry> get serializer =>
      _$landsInHandEntrySerializer;

  static final BuiltList<String> _indexNames =
      BuiltList.of(const ["mulligans", "numDrawn"]);
  @override
  BuiltList<String> get indexNames => _indexNames;

  LandsInHandEntry._();
  factory LandsInHandEntry([void Function(LandsInHandEntryBuilder) updates]) =
      _$LandsInHandEntry;
}

abstract class LandsInLibraryEntry
    implements
        DataEntry<BuiltList<BuiltList<BuiltList<BuiltList<num>>>>>,
        Built<LandsInLibraryEntry, LandsInLibraryEntryBuilder> {
  static Serializer<LandsInLibraryEntry> get serializer =>
      _$landsInLibraryEntrySerializer;

  static final BuiltList<String> _indexNames = BuiltList.of(
      const ["mulligans", "landsInHand", "libraryPosition", "numDrawn"]);
  @override
  BuiltList<String> get indexNames => _indexNames;

  LandsInLibraryEntry._();
  factory LandsInLibraryEntry(
          [void Function(LandsInLibraryEntryBuilder) updates]) =
      _$LandsInLibraryEntry;
}

abstract class CardsByPositionEntry
    implements
        DataEntry<BuiltList<BuiltList<BuiltList<num>>>>,
        Built<CardsByPositionEntry, CardsByPositionEntryBuilder> {
  static Serializer<CardsByPositionEntry> get serializer =>
      _$cardsByPositionEntrySerializer;

  static final BuiltList<String> _indexNames =
      BuiltList.of(const ["mulligans", "decklistPosition", "numDrawn"]);
  @override
  BuiltList<String> get indexNames => _indexNames;

  CardsByPositionEntry._();
  factory CardsByPositionEntry(
          [void Function(CardsByPositionEntryBuilder) updates]) =
      _$CardsByPositionEntry;
}

abstract class CardsByCountEntry
    implements
        DataEntry<BuiltList<BuiltList<num>>>,
        Built<CardsByCountEntry, CardsByCountEntryBuilder> {
  static Serializer<CardsByCountEntry> get serializer =>
      _$cardsByCountEntrySerializer;

  static final BuiltList<String> _indexNames =
      BuiltList.of(const ["mulligans", "numDrawn"]);
  @override
  BuiltList<String> get indexNames => _indexNames;

  CardsByCountEntry._();
  factory CardsByCountEntry([void Function(CardsByCountEntryBuilder) updates]) =
      _$CardsByCountEntry;
}
