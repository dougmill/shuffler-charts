import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rxdart/rxdart.dart';

import 'package:shuffler_charts/src/parameters/parameters.dart';
import 'package:shuffler_charts/src/utils.dart';

@Component(
  changeDetection: ChangeDetectionStrategy.OnPush,
  selector: 'shuffle-options-list',
  styleUrls: ['options_list_component.css'],
  templateUrl: 'options_list_component.html',
  directives: const [
    coreDirectives,
    formDirectives,
  ],
)
class OptionsListComponent {
  ListBuilder<Option> _outputBuilder;
  BuiltList<OptionBuilder> optionBuilders;
  final _output = BehaviorSubject<BuiltList<Option>>();

  @Input()
  set options(BuiltList<Option> options) {
    _outputBuilder = options.toBuilder();
    optionBuilders = BuiltList([
      for (int i = 0; i < options.length; i++) _initOptionBuilder(options[i], i)
    ]);
  }

  OptionBuilder<T> _initOptionBuilder<T>(Option<T> option, int i) {
    var builder = option.toBuilder();
    builder.onSet = () {
      _outputBuilder[i] = builder.build();
      _output.add(_outputBuilder.build());
    };
    return builder;
  }

  @Output()
  Stream<BuiltList<Option>> get optionsChange => _output.stream;

  Object trackByLabel(_, dynamic o) =>
      o is OptionBuilder ? canonicalize(o.label) : o;
}
