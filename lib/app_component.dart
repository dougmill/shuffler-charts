import 'package:angular/angular.dart';

import 'package:shuffler_charts/src/data_service.dart';
import 'package:shuffler_charts/src/display/chart_component.dart';
import 'package:shuffler_charts/src/display/table_component.dart';
import 'package:shuffler_charts/src/parameters/parameters.dart';
import 'package:shuffler_charts/src/parameters/parameters_component.dart';

// AngularDart info: https://webdev.dartlang.org/angular
// Components info: https://webdev.dartlang.org/components

@Component(
  selector: 'shuffler-statistics',
  styleUrls: const ['app_component.css'],
  templateUrl: 'app_component.html',
  providers: const [ClassProvider(DataService)],
  directives: [
    ParametersComponent,
    ChartComponent,
    TableComponent,
  ],
)
class AppComponent {
  Parameters lastValidParams;

  Parameters _params;
  Parameters get params => _params;
  set params(Parameters p) {
    p = p.rebuild((builder) => validate(_params, builder));
    if (p.isValid) {
      lastValidParams = p;
    }
  }

  AppComponent() {
    lastValidParams = Parameters(initialize);
    _params = lastValidParams;
  }
}
