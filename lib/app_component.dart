import 'package:angular/angular.dart';
import 'package:rxdart/rxdart.dart';

import 'package:shuffler_charts/src/data_service.dart';
import 'package:shuffler_charts/src/display/chart_component.dart';
import 'package:shuffler_charts/src/display/loading_component.dart';
import 'package:shuffler_charts/src/display/table_component.dart';
import 'package:shuffler_charts/src/parameters/parameters.dart';
import 'package:shuffler_charts/src/parameters/parameters_component.dart';

// AngularDart info: https://webdev.dartlang.org/angular
// Components info: https://webdev.dartlang.org/components

@Component(
    selector: 'shuffler-statistics',
    styleUrls: ['app_component.css'],
    templateUrl: 'app_component.html',
    providers: [ClassProvider(DataService)],
    directives: [
      coreDirectives,
      ParametersComponent,
      ChartComponent,
      TableComponent,
      LoadingComponent,
    ],
    pipes: [AsyncPipe],
    exports: [LoadingStage])
class AppComponent {
  Parameters _params;
  Parameters get params => _params;
  set params(Parameters p) {
    p = p.rebuild((builder) => validate(_params, builder));
    _params = p;
    state = p.isValid
        ? _dataService.loadStats(p)
        : BehaviorSubject.seeded(
            LoadingState((b) => b.stage = LoadingStage.invalid));
  }

  final DataService _dataService;
  ValueStream<LoadingState> state;

  AppComponent(this._dataService) {
    _params = Parameters(initialize);
    state = _dataService.loadStats(_params);
  }
}
