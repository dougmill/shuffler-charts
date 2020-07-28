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
  final NgZone _zone;
  ValueStream<LoadingState> state;
  Chart chart;
  @ViewChild('chartElement', read: HtmlElement)
  CanvasElement chartElement;

  List<String> title = const [];
  LinearChartData data = LinearChartData(labels: [], datasets: []);
  ChartTooltipModel tooltip;

  ChartComponent(this._dataService, this._ref, this._zone);

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
      title = const [];
      data = LinearChartData(labels: [], datasets: []);
      tooltip = null;
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

    title = yAxis == YAxis.average
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
          ];

    if (state.value.lineStats != null) {
      var stats = state.value.lineStats;
      breakdownValues = stats.values.first.keys.toList();
      var xValueOptions = paramsMap[_params.xAxis.value].options;
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

      data = LinearChartData(
        labels: [for (var x in xValueOptions) if (x.selected) x.label],
        datasets: [
          for (var breakdown in breakdownValues)
            for (var option in stats.keys)
              if (option != DisplayOption.sampleSize || yAxis == YAxis.count)
                ChartDataSets(
                    data: [
                      for (var x in xValueOptions)
                        if (x.selected) stats[option][breakdown][x.value]
                    ],
                    label: breakdown == ''
                        ? option.label
                        : '$breakdown, ${option.label}',
                    fill: false,
                    borderColor: lineColor(option, breakdown),
                    pointBackgroundColor: lineColor(option, breakdown),
                    pointBorderColor: lineColor(option, breakdown))
        ]);

      chart = Chart(
          chartElement,
          ChartConfiguration(
              type: 'line',
              data: data,
              options: ChartOptions(
                  legend: ChartLegendOptions(display: false),
                  tooltips: ChartTooltipOptions(
                      enabled: false,
                      custom: (ChartTooltipModel model) {
                        tooltip = model;
                        // x as given is left edge of built-in tooltip.
                        // I need the center instead for positioning custom
                        // tooltip, and I don't want the edge-of-chart built-in
                        // behavior.
                        if (tooltip.xAlign == 'center') {
                          tooltip.x += tooltip.width / 2;
                        } else if (tooltip.xAlign == 'right') {
                          tooltip.x += tooltip.width;
                        }
                        tooltip.xAlign = 'center';
                        _ref.markForCheck();
                        // need to force change detection to actually run
                        _zone.run(() {});
                      },
                      mode: 'index',
                      intersect: false,
                      callbacks: ChartTooltipCallback(label: ([item, data]) {
                        var value = item.yLabel is num
                            ? item.yLabel as num
                            : num.parse(item.yLabel);
                        switch (yAxis) {
                          case YAxis.count:
                            return value.round().toString();
                          case YAxis.percentage:
                            return (value * 100).toStringAsFixed(2) + '%';
                          case YAxis.average:
                            return value.toStringAsFixed(2);
                          default:
                            throw AssertionError('Unknown YAxis value $yAxis');
                        }
                      })),
                  scales: ChartScales(xAxes: [
                    ChartXAxe(
                        type: 'category',
                        ticks: TickOptions(fontColor: 'black'),
                        scaleLabel: ScaleTitleOptions(
                            display: true,
                            labelString: xLabel,
                            fontColor: 'black'))
                  ], yAxes: [
                    ChartYAxe(
                        type: 'linear',
                        ticks: TickOptions(
                            beginAtZero: true, min: 0, fontColor: 'black'),
                        scaleLabel: ScaleTitleOptions(
                            display: true,
                            labelString: yAxis == YAxis.average
                                ? 'Average ' + _params.numDrawn.name
                                : yAxis == YAxis.count
                                    ? 'Number of games'
                                    : 'Fraction of games',
                            fontColor: 'black'))
                  ]),
                  elements:
                      ChartElementsOptions(line: ChartLineOptions(tension: 0)),
                  animation: ChartAnimationOptions(duration: 0),
                  hover:
                      ChartHoverOptions(animationDuration: 0, intersect: false),
                  responsiveAnimationDuration: 0,
                  maintainAspectRatio: false)));
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
