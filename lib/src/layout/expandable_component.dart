import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

@Component(
  changeDetection: ChangeDetectionStrategy.OnPush,
  selector: 'expandable',
  styleUrls: ['expandable_component.css'],
  templateUrl: 'expandable_component.html',
  directives: const [coreDirectives, formDirectives],
)
class ExpandableComponent {
  bool expanded;

  ExpandableComponent(Element _element)
      : expanded = _element.hasAttribute('expanded');
}
