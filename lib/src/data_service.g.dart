// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_service.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MapData<K, V extends Data<dynamic>> extends MapData<K, V> {
  @override
  final String parameter;
  @override
  final BuiltMap<K, V> data;

  factory _$MapData([void Function(MapDataBuilder<K, V>) updates]) =>
      (new MapDataBuilder<K, V>()..update(updates)).build();

  _$MapData._({this.parameter, this.data}) : super._() {
    if (parameter == null) {
      throw new BuiltValueNullFieldError('MapData', 'parameter');
    }
    if (data == null) {
      throw new BuiltValueNullFieldError('MapData', 'data');
    }
    if (K == dynamic) {
      throw new BuiltValueMissingGenericsError('MapData', 'K');
    }
    if (V == dynamic) {
      throw new BuiltValueMissingGenericsError('MapData', 'V');
    }
  }

  @override
  MapData<K, V> rebuild(void Function(MapDataBuilder<K, V>) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MapDataBuilder<K, V> toBuilder() => new MapDataBuilder<K, V>()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MapData &&
        parameter == other.parameter &&
        data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, parameter.hashCode), data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('MapData')
          ..add('parameter', parameter)
          ..add('data', data))
        .toString();
  }
}

class MapDataBuilder<K, V extends Data<dynamic>>
    implements Builder<MapData<K, V>, MapDataBuilder<K, V>> {
  _$MapData<K, V> _$v;

  String _parameter;
  String get parameter => _$this._parameter;
  set parameter(String parameter) => _$this._parameter = parameter;

  MapBuilder<K, V> _data;
  MapBuilder<K, V> get data => _$this._data ??= new MapBuilder<K, V>();
  set data(MapBuilder<K, V> data) => _$this._data = data;

  MapDataBuilder();

  MapDataBuilder<K, V> get _$this {
    if (_$v != null) {
      _parameter = _$v.parameter;
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MapData<K, V> other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$MapData<K, V>;
  }

  @override
  void update(void Function(MapDataBuilder<K, V>) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$MapData<K, V> build() {
    _$MapData<K, V> _$result;
    try {
      _$result = _$v ??
          new _$MapData<K, V>._(parameter: parameter, data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'MapData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$ListData<T extends Data<dynamic>> extends ListData<T> {
  @override
  final String parameter;
  @override
  final BuiltList<T> data;

  factory _$ListData([void Function(ListDataBuilder<T>) updates]) =>
      (new ListDataBuilder<T>()..update(updates)).build();

  _$ListData._({this.parameter, this.data}) : super._() {
    if (parameter == null) {
      throw new BuiltValueNullFieldError('ListData', 'parameter');
    }
    if (data == null) {
      throw new BuiltValueNullFieldError('ListData', 'data');
    }
    if (T == dynamic) {
      throw new BuiltValueMissingGenericsError('ListData', 'T');
    }
  }

  @override
  ListData<T> rebuild(void Function(ListDataBuilder<T>) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ListDataBuilder<T> toBuilder() => new ListDataBuilder<T>()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ListData &&
        parameter == other.parameter &&
        data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, parameter.hashCode), data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ListData')
          ..add('parameter', parameter)
          ..add('data', data))
        .toString();
  }
}

class ListDataBuilder<T extends Data<dynamic>>
    implements Builder<ListData<T>, ListDataBuilder<T>> {
  _$ListData<T> _$v;

  String _parameter;
  String get parameter => _$this._parameter;
  set parameter(String parameter) => _$this._parameter = parameter;

  ListBuilder<T> _data;
  ListBuilder<T> get data => _$this._data ??= new ListBuilder<T>();
  set data(ListBuilder<T> data) => _$this._data = data;

  ListDataBuilder();

  ListDataBuilder<T> get _$this {
    if (_$v != null) {
      _parameter = _$v.parameter;
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ListData<T> other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ListData<T>;
  }

  @override
  void update(void Function(ListDataBuilder<T>) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ListData<T> build() {
    _$ListData<T> _$result;
    try {
      _$result =
          _$v ?? new _$ListData<T>._(parameter: parameter, data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ListData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$CountsData extends CountsData {
  @override
  final String parameter;
  @override
  final BuiltList<int> data;

  factory _$CountsData([void Function(CountsDataBuilder) updates]) =>
      (new CountsDataBuilder()..update(updates)).build();

  _$CountsData._({this.parameter, this.data}) : super._() {
    if (parameter == null) {
      throw new BuiltValueNullFieldError('CountsData', 'parameter');
    }
    if (data == null) {
      throw new BuiltValueNullFieldError('CountsData', 'data');
    }
  }

  @override
  CountsData rebuild(void Function(CountsDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CountsDataBuilder toBuilder() => new CountsDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CountsData &&
        parameter == other.parameter &&
        data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, parameter.hashCode), data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CountsData')
          ..add('parameter', parameter)
          ..add('data', data))
        .toString();
  }
}

class CountsDataBuilder implements Builder<CountsData, CountsDataBuilder> {
  _$CountsData _$v;

  String _parameter;
  String get parameter => _$this._parameter;
  set parameter(String parameter) => _$this._parameter = parameter;

  ListBuilder<int> _data;
  ListBuilder<int> get data => _$this._data ??= new ListBuilder<int>();
  set data(ListBuilder<int> data) => _$this._data = data;

  CountsDataBuilder();

  CountsDataBuilder get _$this {
    if (_$v != null) {
      _parameter = _$v.parameter;
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CountsData other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$CountsData;
  }

  @override
  void update(void Function(CountsDataBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$CountsData build() {
    _$CountsData _$result;
    try {
      _$result =
          _$v ?? new _$CountsData._(parameter: parameter, data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'CountsData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
