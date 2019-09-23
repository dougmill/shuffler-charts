import 'dart:math';

import 'package:angular/angular.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:rxdart/rxdart.dart';

import 'package:shuffler_charts/src/data_service.dart';
import 'package:shuffler_charts/src/parameters/parameters.dart';

part 'table_component.g.dart';

@Component(
  changeDetection: ChangeDetectionStrategy.OnPush,
  selector: 'shuffle-table',
  styleUrls: ['table_component.css'],
  templateUrl: 'table_component.html',
  directives: const [coreDirectives],
  exports: const [LoadingStage],
)
class TableComponent {
  Parameters _params;
  @Input()
  set parameters(Parameters value) {
    _params = value;
    _table = null;
    state = _dataService.loadStats(_params);
    state.doOnDone(() {
      // In case a new value was set before loading finished.
      if (_params != value) {
        return;
      }
      if (_params.breakdownBy.value == 'none') {
        _table = Table.forNoBreakdown(_params, state.value.lineStats);
      } else if (state.value.lineStats != null) {
        _table = Table.forLinesChart(_params, state.value.lineStats);
      } else {
        _table = Table.forScatterPlot(_params, state.value.scatterStats);
      }
    });
  }

  final DataService _dataService;
  ValueObservable<LoadingState> state;
  Table _table;

  TableComponent(this._dataService);

  String get columnHeader => _table.columnHeader;
  String get rowHeader => _table.rowHeader;
  BuiltList<String> get columnLabels => _table.columnLabels;
  BuiltList<String> get rowLabels => _table.rowLabels;
  BuiltMap<String, BuiltMap<String, num>> get values => _table.values;
}

@BuiltValue(nestedBuilders: false)
abstract class Table implements Built<Table, TableBuilder> {
  @nullable
  String get columnHeader;
  String get rowHeader;
  BuiltList<String> get columnLabels;
  BuiltList<String> get rowLabels;
  BuiltMap<String, BuiltMap<String, num>> get values;

  Table._();
  factory Table([void Function(TableBuilder) updates]) = _$Table;

  factory Table.forNoBreakdown(
          Parameters params,
          BuiltMap<DisplayOption, BuiltMap<Object, BuiltMap<Object, num>>>
              data) =>
      /*
      With no breakdown param:
        The indices of `data` are, in order, the display options, a placeholder
          value ('') for the breakdown, and the x values.
        Columns are the display options (actual/expected/bugged/sample).
        Column labels have no overall header.
        Rows are x values.
       */
      Table((builder) => builder
        ..rowHeader = params.xAxis.value.toString()
        ..columnLabels =
            BuiltList.of([for (var option in data.keys) option.label])
        ..rowLabels = BuiltList.of(
            [for (var value in data.values.first[''].keys) value.toString()])
        ..values = BuiltMap.of({
          for (var row in builder.rowLabels)
            row: BuiltMap.of({
              for (var column in builder.columnLabels)
                column: data[column][''][row]
            })
        }));

  factory Table.forLinesChart(
          Parameters params,
          BuiltMap<DisplayOption, BuiltMap<Object, BuiltMap<Object, num>>>
              data) =>
      /*
      Lines chart with breakdown:
      The indices of `data` are, in order, the display options, the breakdown
        values, and the x values.
      Columns are breakdown values, plus sample size if breakdown is numDrawn
      Rows are x and display option combinations, minus sample size if that's a
        column.
     */
      Table((builder) {
        bool sampleSizeIsColumn = params.breakdownBy.value == 'numDrawn' &&
            data.containsKey(DisplayOption.sampleSize);
        builder
          ..columnHeader = params.breakdownBy.value
          ..rowHeader = params.xAxis.value.toString()
          ..columnLabels = BuiltList.of([
            for (var breakdown in data.values.first.keys) breakdown.toString(),
            if (sampleSizeIsColumn) DisplayOption.sampleSize.label
          ])
          ..rowLabels = BuiltList.of([
            for (var value in data.values.first.values.first.keys) ...[
              for (var option in data.keys)
                if (!sampleSizeIsColumn || option != DisplayOption.sampleSize)
                  '$value ${option.label}'
            ]
          ])
          ..values = BuiltMap.of({
            for (var value in data.values.first.values.first.keys) ...{
              for (var option in data.keys)
                if (!sampleSizeIsColumn || option != DisplayOption.sampleSize)
                  '$value ${option.label}': BuiltMap.of({
                    for (var breakdown in data.values.first.keys)
                      breakdown.toString(): data[option][breakdown][value],
                    if (sampleSizeIsColumn)
                      DisplayOption.sampleSize.label:
                          data[DisplayOption.sampleSize].values.first[value]
                  })
            }
          });
      });

  factory Table.forScatterPlot(Parameters params,
          BuiltMap<DisplayOption, BuiltMap<Object, Point<num>>> data) =>
      /*
      Scatter plot:
      The indices of `data` are, in order, the display options and the breakdown
        values.
      The chosen x axis of the chart is one of the display options (actual,
        expected, or bugged values, or sample size).
      Columns are display options, including the one selected for x.
      Rows are breakdown values.
     */
      Table((builder) => builder
        ..rowHeader = params.breakdownBy.value.toString()
        ..columnLabels =
            BuiltList.of([for (var option in data.keys) option.label])
        ..rowLabels = BuiltList.of(
            [for (var value in data.values.first.keys) value.toString()])
        ..values = BuiltMap.of({
          for (var row in builder.rowLabels)
            row: BuiltMap.of({
              for (var column in builder.columnLabels)
                column: data[column][row].y
            })
        }));
}