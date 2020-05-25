import 'dart:html';

import 'package:angular/angular.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shuffler_charts/src/chartjs/chartjs.dart';
import 'package:shuffler_charts/src/data_service.dart';

import 'package:shuffler_charts/src/parameters/parameters.dart';

@Component(
  changeDetection: ChangeDetectionStrategy.OnPush,
  selector: 'shuffle-chart',
  styleUrls: ['chart_component.css'],
  templateUrl: 'chart_component.html',
  directives: [coreDirectives],
)
class ChartComponent implements OnInit {
  Parameters _params;
  @Input()
  set parameters(Parameters value) {
    _params = value;
    chart = null;
    state = _dataService.loadStats(_params);
    state.listen((_) => {}, onDone: () {
      // In case a new value was set before loading finished.
      if (_params == value) {
        _updateChart();
      }
    });
  }

  final DataService _dataService;
  final ChangeDetectorRef _ref;
  ValueStream<LoadingState> state;
  Chart chart;
  @ViewChild('chartElement', read: HtmlElement)
  CanvasElement chartElement;

  ChartComponent(this._dataService, this._ref);

  @override
  void ngOnInit() {
    if (chart == null) {
      _updateChart();
    }
  }

  void _updateChart() {
    if ((state.value?.lineStats?.values?.isEmpty ?? true) &&
        (state.value?.scatterStats?.values?.isEmpty ?? true)) {
      chart = null;
      return;
    }
    List<Object> breakdownValues;
    var yAxis = _params.yAxis.value;
    String capitalize(String str) {
      return str[0].toUpperCase() + str.substring(1);
    }

    var paramsMap = _params.asMap;
    var breakdownLabel = paramsMap[_params.breakdownBy.value]?.name;
    var xLabel =
        paramsMap[_params.xAxis.value]?.name ?? _params.xAxis.value.toString();

    if (state.value.lineStats != null) {
      var stats = state.value.lineStats;
      breakdownValues = stats.values.first.keys.toList();
      var xValues = stats.values.first.values.first.keys.toList();
      String lineColor(DisplayOption option, Object breakdown) {
        int red = option == DisplayOption.bugged ? 255 : 0;
        int green = option == DisplayOption.expected ? 255 : 0;
        int blue = breakdownValues.length == 1
            ? 0
            : 255 *
                breakdownValues.indexOf(breakdown) ~/
                (breakdownValues.length - 1);
        return 'rgba($red, $green, $blue, 0.8)';
      }

      chart = Chart(
          chartElement,
          ChartConfiguration(
              type: 'line',
              data: LinearChartData(labels: [
                for (var x in xValues) x.toString()
              ], datasets: [
                for (var option in stats.keys)
                  if (option != DisplayOption.sampleSize ||
                      yAxis == YAxis.count)
                    for (var breakdown in breakdownValues)
                      ChartDataSets(
                          data: [
                            for (var x in xValues) stats[option][breakdown][x]
                          ],
                          label: breakdown == ''
                              ? option.label
                              : '$breakdown, ${option.label}',
                          fill: false,
                          borderColor: lineColor(option, breakdown),
                          pointBackgroundColor: lineColor(option, breakdown),
                          pointBorderColor: lineColor(option, breakdown))
              ]),
              options: ChartOptions(
                  title: ChartTitleOptions(
                      display: true,
                      text: yAxis == YAxis.average
                          ? [
                              'Average ' + _params.numDrawn.name.toLowerCase(),
                              'vs ' + xLabel.toLowerCase(),
                              'In games matching selected parameters',
                              if (breakdownLabel != null)
                                'Broken down by ' + breakdownLabel.toLowerCase()
                            ]
                          : [
                              capitalize(yAxis.name) +
                                  ' of games with selected ' +
                                  _params.numDrawn.name.toLowerCase(),
                              if (xLabel != null) 'vs ' + xLabel.toLowerCase(),
                              'Out of those matching selected parameters',
                              if (breakdownLabel != null)
                                'Broken down by ' + breakdownLabel.toLowerCase()
                            ]),
                  scales: ChartScales(xAxes: [
                    ChartXAxe(
                        type: 'category',
                        scaleLabel: ScaleTitleOptions(
                            display: true, labelString: xLabel))
                  ], yAxes: [
                    ChartYAxe(
                        type: 'linear',
                        ticks: TickOptions(beginAtZero: true, min: 0),
                        scaleLabel: ScaleTitleOptions(
                            display: true,
                            labelString: yAxis == YAxis.average
                                ? 'Average ' + _params.numDrawn.name
                                : yAxis == YAxis.count
                                    ? 'Number of games'
                                    : 'Fraction of games'))
                  ]),
                  elements:
                      ChartElementsOptions(line: ChartLineOptions(tension: 0)),
                  animation: ChartAnimationOptions(duration: 0),
                  hover: ChartHoverOptions(animationDuration: 0),
                  responsiveAnimationDuration: 0)));
    } else {
      var stats = state.value.scatterStats;
      breakdownValues = stats.values.first.keys.toList();
      String pointColor(DisplayOption option) {
        int red = option == DisplayOption.bugged ? 255 : 0;
        int green = option == DisplayOption.expected ? 255 : 0;
        return 'rgba($red, $green, 0, 0.8)';
      }

      String yTitle = stats.keys
          .where((o) =>
              o != _params.xAxis.value &&
              (yAxis == YAxis.count || o != DisplayOption.sampleSize))
          .map((o) => o.label)
          .join(' and ');

      chart = Chart(
          chartElement,
          ChartConfiguration(
              type: 'scatter',
              data: LinearChartData(datasets: [
                for (var option in stats.keys)
                  if ((option != DisplayOption.sampleSize ||
                          yAxis == YAxis.count) &&
                      option != _params.xAxis.value)
                    ChartDataSets(
                        data: [
                          for (var breakdown in breakdownValues)
                            ChartPoint(
                                x: stats[option][breakdown].x,
                                y: stats[option][breakdown].y)
                        ],
                        label: option.label,
                        pointBackgroundColor: pointColor(option),
                        pointBorderColor: pointColor(option))
              ]),
              options: ChartOptions(
                  title: ChartTitleOptions(
                      display: true,
                      text: yAxis == YAxis.average
                          ? [
                              'Average ' + _params.numDrawn.name.toLowerCase(),
                              'vs ' + xLabel.toLowerCase(),
                              'In games matching selected parameters',
                              if (breakdownLabel != null)
                                'Broken down by ' + breakdownLabel.toLowerCase()
                            ]
                          : [
                              capitalize(yAxis.name) +
                                  ' of games with selected ' +
                                  _params.numDrawn.name.toLowerCase(),
                              yTitle + ' vs ' + xLabel.toLowerCase(),
                              'Out of those matching selected parameters',
                              if (breakdownLabel != null)
                                'Broken down by ' + breakdownLabel.toLowerCase()
                            ]),
                  scales: ChartScales(xAxes: [
                    ChartXAxe(
                        type: 'linear',
                        ticks: TickOptions(beginAtZero: true, min: 0),
                        scaleLabel: ScaleTitleOptions(
                            display: true, labelString: xLabel))
                  ], yAxes: [
                    ChartYAxe(
                        type: 'linear',
                        ticks: TickOptions(beginAtZero: true, min: 0))
                  ]),
                  elements:
                      ChartElementsOptions(line: ChartLineOptions(tension: 0)),
                  animation: ChartAnimationOptions(duration: 0),
                  hover: ChartHoverOptions(animationDuration: 0),
                  responsiveAnimationDuration: 0)));
    }
    _ref.markForCheck();
  }
}
