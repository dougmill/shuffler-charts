import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import 'package:rxdart/rxdart.dart';

import 'package:shuffler_charts/src/parameters/options_list_component.dart';
import 'package:shuffler_charts/src/parameters/parameters.dart';
import 'package:shuffler_charts/src/utils.dart';

@Component(
  changeDetection: ChangeDetectionStrategy.OnPush,
  selector: 'shuffle-parameter',
  styleUrls: ['parameter_component.css'],
  templateUrl: 'parameter_component.html',
  directives: const [coreDirectives, formDirectives, OptionsListComponent],
  exports: const[ParameterType],
)
class ParameterComponent {
  ParameterBuilder paramBuilder;
  final _output = BehaviorSubject<Parameter>();

  @Input()
  set param(Parameter param) {
    if (paramBuilder == null) {
      paramBuilder = param.toBuilder();
      paramBuilder.onSet = () => _output.add(paramBuilder.build());
    } else {
      paramBuilder.replace(param);
    }
  }

  @Output()
  Stream<Parameter> get paramChange => _output.stream;

  Object trackByLabel(_, dynamic o) => o is Option ? canonicalize(o.label) : o;
}
