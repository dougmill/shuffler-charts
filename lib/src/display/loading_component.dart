import 'dart:async';

import 'package:angular/angular.dart';
import 'package:rxdart/rxdart.dart';

import 'package:shuffler_charts/src/data_service.dart';

@Component(
  changeDetection: ChangeDetectionStrategy.OnPush,
  selector: 'shuffle-loading',
  styleUrls: ['loading_component.css'],
  templateUrl: 'loading_component.html',
  directives: [coreDirectives],
  pipes: [LoadingPipe],
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
  StreamSubscription<LoadingState> _inputSubscription;
  ValueStream<LoadingState> _inputStream;
  StreamSubscription<String> _timerSubscription;
  final ChangeDetectorRef _ref;

  LoadingPipe(this._ref);

  @override
  void ngOnDestroy() {
    if (_timerSubscription != null) {
      _dispose();
    }
  }

  dynamic transform(dynamic /* ValueStream<LoadingState> */ inputStream) {
    if (_inputStream == null) {
      if (inputStream != null) {
        _subscribe(inputStream);
      }
    } else if (!identical(inputStream, _inputStream)) {
      _dispose();
      return transform(inputStream);
    }
    return _value;
  }

  void _subscribe(ValueStream<LoadingState> inputStream) {
    _inputStream = inputStream;
    _inputSubscription = inputStream.listen((state) {
      if (identical(_inputStream, inputStream)) {
        _maybeUpdateValue(state);
      }
    });
    _timerSubscription = Stream.periodic(Duration(seconds: 1),
            (i) => const ['.\u00A0\u00A0', '..\u00A0', '...'][i % 3])
        .listen((dots) {
      _dots = dots;
      _updateValue();
    });
  }

  void _dispose() {
    _timerSubscription.cancel();
    _timerSubscription = null;
    _inputSubscription.cancel();
    _inputSubscription = null;
    _state = null;
    _inputStream = null;
  }

  void _maybeUpdateValue(LoadingState state) {
    if (!identical(state, _state)) {
      var oldState = _state;
      _state = state;
      if (oldState == null ||
          _state == null ||
          !identical(oldState.stage, _state.stage) ||
          _percent(oldState.progress) != _percent(_state.progress)) {
        _updateValue();
      }
    }
  }

  void _updateValue() {
    var stage = (_state?.stage ?? LoadingStage.fetching).label;
    if (_state?.progress == null) {
      _value = '$stage$_dots';
    } else {
      _value = '$stage ${_percent(_state.progress)}%$_dots';
    }
    _ref.markForCheck();
  }

  int _percent(double num) {
    return num == null ? null : (num * 100).toInt();
  }
}
