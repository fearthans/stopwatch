part of 'stopwatch_cubit.dart';

@immutable
abstract class StopwatchState {}

class StopwatchInitial extends StopwatchState {}

class StopwatchRunning extends StopwatchState {
  final Duration elapsedTime;
  StopwatchRunning(this.elapsedTime);
}

class StopwatchPaused extends StopwatchState {
  final Duration elapsedTime;
  StopwatchPaused(this.elapsedTime);
}

class StopwatchLapsUpdated extends StopwatchState {
  final List<dynamic> lapsList;
  final Duration elapsedTime;
  StopwatchLapsUpdated(this.lapsList, this.elapsedTime);
}
