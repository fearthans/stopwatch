import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'dart:async';

part 'stopwatch_state.dart';

class StopwatchCubit extends Cubit<StopwatchState> {
  StopwatchCubit() : super(StopwatchInitial());

  Timer? _timer;
  Duration _elapsedTime = Duration.zero;

  void start() {
    emit(StopwatchRunning(_elapsedTime));
    _timer = Timer.periodic(const Duration(milliseconds: 1), (timer) {
      _elapsedTime += const Duration(milliseconds: 1);
      emit(StopwatchRunning(_elapsedTime));
    });
  }

  void pause() {
    _timer?.cancel();
    emit(StopwatchPaused(_elapsedTime));
  }

  void resume() {
    start();
  }

  void reset() {
    _timer?.cancel();
    _elapsedTime = Duration.zero;
    emit(StopwatchInitial());
  }

  void stop() {
    _timer?.cancel();
    _elapsedTime = Duration.zero;
    emit(StopwatchInitial());
  }

  void laps(List<dynamic> lapsList) {
    emit(StopwatchLapsUpdated(lapsList, _elapsedTime));
  }
}
