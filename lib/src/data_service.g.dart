// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_service.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const LoadingStage _$fetching = const LoadingStage._('fetching');
const LoadingStage _$parsing = const LoadingStage._('parsing');
const LoadingStage _$processing = const LoadingStage._('processing');
const LoadingStage _$aggregating = const LoadingStage._('aggregating');
const LoadingStage _$loaded = const LoadingStage._('loaded');

LoadingStage _$loadingValueOf(String name) {
  switch (name) {
    case 'fetching':
      return _$fetching;
    case 'parsing':
      return _$parsing;
    case 'processing':
      return _$processing;
    case 'aggregating':
      return _$aggregating;
    case 'loaded':
      return _$loaded;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<LoadingStage> _$loadingValues =
    new BuiltSet<LoadingStage>(const <LoadingStage>[
  _$fetching,
  _$parsing,
  _$processing,
  _$aggregating,
  _$loaded,
]);

class _$LoadingState extends LoadingState {
  @override
  final LoadingStage stage;
  @override
  final double progress;
  @override
  final BuiltList<DataEntry<BuiltList>> data;
  @override
  final BuiltMap<DisplayOption, BuiltMap<Object, BuiltMap<Object, num>>>
      lineStats;
  @override
  final BuiltMap<DisplayOption, BuiltMap<Object, Point<num>>> scatterStats;

  factory _$LoadingState([void Function(LoadingStateBuilder) updates]) =>
      (new LoadingStateBuilder()..update(updates)).build();

  _$LoadingState._(
      {this.stage, this.progress, this.data, this.lineStats, this.scatterStats})
      : super._() {
    if (stage == null) {
      throw new BuiltValueNullFieldError('LoadingState', 'stage');
    }
  }

  @override
  LoadingState rebuild(void Function(LoadingStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LoadingStateBuilder toBuilder() => new LoadingStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LoadingState &&
        stage == other.stage &&
        progress == other.progress &&
        data == other.data &&
        lineStats == other.lineStats &&
        scatterStats == other.scatterStats;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, stage.hashCode), progress.hashCode), data.hashCode),
            lineStats.hashCode),
        scatterStats.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('LoadingState')
          ..add('stage', stage)
          ..add('progress', progress)
          ..add('data', data)
          ..add('lineStats', lineStats)
          ..add('scatterStats', scatterStats))
        .toString();
  }
}

class LoadingStateBuilder
    implements Builder<LoadingState, LoadingStateBuilder> {
  _$LoadingState _$v;

  LoadingStage _stage;
  LoadingStage get stage => _$this._stage;
  set stage(LoadingStage stage) => _$this._stage = stage;

  double _progress;
  double get progress => _$this._progress;
  set progress(double progress) => _$this._progress = progress;

  ListBuilder<DataEntry<BuiltList>> _data;
  ListBuilder<DataEntry<BuiltList>> get data =>
      _$this._data ??= new ListBuilder<DataEntry<BuiltList>>();
  set data(ListBuilder<DataEntry<BuiltList>> data) => _$this._data = data;

  MapBuilder<DisplayOption, BuiltMap<Object, BuiltMap<Object, num>>> _lineStats;
  MapBuilder<DisplayOption,
      BuiltMap<Object, BuiltMap<Object, num>>> get lineStats => _$this
          ._lineStats ??=
      new MapBuilder<DisplayOption, BuiltMap<Object, BuiltMap<Object, num>>>();
  set lineStats(
          MapBuilder<DisplayOption, BuiltMap<Object, BuiltMap<Object, num>>>
              lineStats) =>
      _$this._lineStats = lineStats;

  MapBuilder<DisplayOption, BuiltMap<Object, Point<num>>> _scatterStats;
  MapBuilder<DisplayOption, BuiltMap<Object, Point<num>>> get scatterStats =>
      _$this._scatterStats ??=
          new MapBuilder<DisplayOption, BuiltMap<Object, Point<num>>>();
  set scatterStats(
          MapBuilder<DisplayOption, BuiltMap<Object, Point<num>>>
              scatterStats) =>
      _$this._scatterStats = scatterStats;

  LoadingStateBuilder();

  LoadingStateBuilder get _$this {
    if (_$v != null) {
      _stage = _$v.stage;
      _progress = _$v.progress;
      _data = _$v.data?.toBuilder();
      _lineStats = _$v.lineStats?.toBuilder();
      _scatterStats = _$v.scatterStats?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LoadingState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$LoadingState;
  }

  @override
  void update(void Function(LoadingStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$LoadingState build() {
    _$LoadingState _$result;
    try {
      _$result = _$v ??
          new _$LoadingState._(
              stage: stage,
              progress: progress,
              data: _data?.build(),
              lineStats: _lineStats?.build(),
              scatterStats: _scatterStats?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        _data?.build();
        _$failedField = 'lineStats';
        _lineStats?.build();
        _$failedField = 'scatterStats';
        _scatterStats?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'LoadingState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
