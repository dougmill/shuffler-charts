import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

part 'data.g.dart';

@SerializersFor([
  LandsInHandEntry,
  LandsInLibraryEntry,
  CardsByPositionEntry,
  CardsByCountEntry
])
Serializers dataSerializers =
    (_$dataSerializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();

abstract class LandsGroup implements Built<LandsGroup, LandsGroupBuilder> {
  static Serializer<LandsGroup> get serializer => _$landsGroupSerializer;

  int get deckSize;
  int get landsInDeck;
  int get bestOf;
  String get shuffling;
  int get week;
  String get type;

  LandsGroup._();

  factory LandsGroup([void Function(LandsGroupBuilder) updates]) = _$LandsGroup;
}

abstract class CardsGroup implements Built<CardsGroup, CardsGroupBuilder> {
  static Serializer<CardsGroup> get serializer => _$cardsGroupSerializer;

  int get deckSize;
  int get numCards;
  int get bestOf;
  String get shuffling;
  int get week;
  String get type;

  CardsGroup._();

  factory CardsGroup([void Function(CardsGroupBuilder) updates]) = _$CardsGroup;
}

abstract class DataEntry<G, D extends BuiltList<dynamic>> {
  G get group;
  D get data;
  BuiltList<String> get indexNames;
}

abstract class LandsInHandEntry
    implements
        DataEntry<LandsGroup, BuiltList<BuiltList<int>>>,
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
        DataEntry<LandsGroup, BuiltList<BuiltList<BuiltList<BuiltList<int>>>>>,
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
        DataEntry<CardsGroup, BuiltList<BuiltList<BuiltList<int>>>>,
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
        DataEntry<CardsGroup, BuiltList<BuiltList<int>>>,
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
