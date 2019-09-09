import 'dart:async';

import 'package:angular/angular.dart';
import 'package:intl/intl.dart';

import 'package:shuffler_charts/src/data_service.dart';

@Component(
    changeDetection: ChangeDetectionStrategy.OnPush,
    selector: 'shuffle-loading',
    styleUrls: ['loading_component.css'],
    templateUrl: 'loading_component.html',
    directives: const [
      coreDirectives,
    ],
    pipes: const [AsyncPipe, LoadingPipe],
)
class LoadingComponent {
  @Input()
  Stream<LoadingState> state;
}

@Pipe('loadingText', pure: false)
class LoadingPipe implements OnDestroy, PipeTransform {
  String _value;
  String _dots = '...';
  LoadingState _state;
  StreamSubscription<String> _subscription;
  ChangeDetectorRef _ref;
  static final _percentFormat = NumberFormat('##0%');

  LoadingPipe(this._ref) {
    _subscription = Stream.periodic(
            Duration(seconds: 1), (i) => const ['.', '..', '...'][i % 3])
        .listen((dots) {
      _dots = dots;
      _updateValue();
    });
  }

  @override
  void ngOnDestroy() {
    if (_subscription != null) {
      _subscription.cancel();
      _subscription = null;
    }
  }

  dynamic transform(dynamic state) {
    if (!identical(state, _state)) {
      _state = state;
      _updateValue();
    }
    return _value;
  }

  void _updateValue() {
    String stage = _state.stage.label;
    if (_state.progress == null) {
      _value = '$stage$_dots';
    } else {
      _value = '$stage ${_percentFormat.format(_state.progress)}$_dots';
    }
    _ref.markForCheck();
  }
}
