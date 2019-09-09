// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_component.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Table extends Table {
  @override
  final String columnHeader;
  @override
  final String rowHeader;
  @override
  final BuiltList<String> columnLabels;
  @override
  final BuiltList<String> rowLabels;
  @override
  final BuiltMap<String, BuiltMap<String, num>> values;

  factory _$Table([void Function(TableBuilder) updates]) =>
      (new TableBuilder()..update(updates)).build();

  _$Table._(
      {this.columnHeader,
      this.rowHeader,
      this.columnLabels,
      this.rowLabels,
      this.values})
      : super._() {
    if (rowHeader == null) {
      throw new BuiltValueNullFieldError('Table', 'rowHeader');
    }
    if (columnLabels == null) {
      throw new BuiltValueNullFieldError('Table', 'columnLabels');
    }
    if (rowLabels == null) {
      throw new BuiltValueNullFieldError('Table', 'rowLabels');
    }
    if (values == null) {
      throw new BuiltValueNullFieldError('Table', 'values');
    }
  }

  @override
  Table rebuild(void Function(TableBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TableBuilder toBuilder() => new TableBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Table &&
        columnHeader == other.columnHeader &&
        rowHeader == other.rowHeader &&
        columnLabels == other.columnLabels &&
        rowLabels == other.rowLabels &&
        values == other.values;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, columnHeader.hashCode), rowHeader.hashCode),
                columnLabels.hashCode),
            rowLabels.hashCode),
        values.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Table')
          ..add('columnHeader', columnHeader)
          ..add('rowHeader', rowHeader)
          ..add('columnLabels', columnLabels)
          ..add('rowLabels', rowLabels)
          ..add('values', values))
        .toString();
  }
}

class TableBuilder implements Builder<Table, TableBuilder> {
  _$Table _$v;

  String _columnHeader;
  String get columnHeader => _$this._columnHeader;
  set columnHeader(String columnHeader) => _$this._columnHeader = columnHeader;

  String _rowHeader;
  String get rowHeader => _$this._rowHeader;
  set rowHeader(String rowHeader) => _$this._rowHeader = rowHeader;

  BuiltList<String> _columnLabels;
  BuiltList<String> get columnLabels => _$this._columnLabels;
  set columnLabels(BuiltList<String> columnLabels) =>
      _$this._columnLabels = columnLabels;

  BuiltList<String> _rowLabels;
  BuiltList<String> get rowLabels => _$this._rowLabels;
  set rowLabels(BuiltList<String> rowLabels) => _$this._rowLabels = rowLabels;

  BuiltMap<String, BuiltMap<String, num>> _values;
  BuiltMap<String, BuiltMap<String, num>> get values => _$this._values;
  set values(BuiltMap<String, BuiltMap<String, num>> values) =>
      _$this._values = values;

  TableBuilder();

  TableBuilder get _$this {
    if (_$v != null) {
      _columnHeader = _$v.columnHeader;
      _rowHeader = _$v.rowHeader;
      _columnLabels = _$v.columnLabels;
      _rowLabels = _$v.rowLabels;
      _values = _$v.values;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Table other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Table;
  }

  @override
  void update(void Function(TableBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Table build() {
    final _$result = _$v ??
        new _$Table._(
            columnHeader: columnHeader,
            rowHeader: rowHeader,
            columnLabels: columnLabels,
            rowLabels: rowLabels,
            values: values);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
