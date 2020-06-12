import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import 'package:built_collection/built_collection.dart';
import 'package:rxdart/rxdart.dart';

import 'package:shuffler_charts/src/layout/expandable_component.dart';
import 'package:shuffler_charts/src/parameters/parameter_component.dart';
import 'package:shuffler_charts/src/parameters/parameters.dart';

@Component(
  changeDetection: ChangeDetectionStrategy.OnPush,
  selector: 'shuffle-parameters',
  styleUrls: ['parameters_component.css'],
  templateUrl: 'parameters_component.html',
  directives: const [
    coreDirectives,
    formDirectives,
    ExpandableComponent,
    ParameterComponent
  ],
)
class ParametersComponent {
  BuiltList<String> paramKeys;
  _MapBuilderWrapper<String, Parameter<dynamic>> paramsBuilder;
  final _output = BehaviorSubject<Parameters>();

  @Input()
  set parameters(Parameters params) {
    if (paramsBuilder == null) {
      var map = params.asMap;
      paramKeys = BuiltList.of(map.keys);
      paramsBuilder = _MapBuilderWrapper(map.toBuilder());
      paramsBuilder.onSet = () => _output
          .add(Parameters.fromMap(paramsBuilder.builder.build().asMap()));
    } else {
      paramsBuilder.builder = params.asMap.toBuilder();
    }
  }

  @Output()
  Stream<Parameters> get parametersChange => _output.stream;
}

class _MapBuilderWrapper<K, V> {
  MapBuilder<K, V> builder;

  void Function() onSet = () {};

  _MapBuilderWrapper(this.builder);

  V operator [](Object key) => builder[key];

  void operator []=(K key, V value) {
    builder[key] = value;
    onSet();
  }
}
