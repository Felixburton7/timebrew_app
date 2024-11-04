// lib/presentation/blocs/timer_state.dart
// lib/presentation/blocs/timer_state.dart
// lib/presentation/blocs/timer_state.dart

part of 'timer_bloc.dart';

abstract class TimerState extends Equatable {
  const TimerState();

  @override
  List<Object> get props => [];
}

class TimerInitial extends TimerState {}

class TimerRunInProgress extends TimerState {
  final Duration duration;
  final Duration totalDuration;

  const TimerRunInProgress(this.duration, this.totalDuration);

  @override
  List<Object> get props => [duration, totalDuration];
}

class TimerRunPause extends TimerState {
  final Duration duration;
  final Duration totalDuration;

  const TimerRunPause(this.duration, this.totalDuration);

  @override
  List<Object> get props => [duration, totalDuration];
}

class TimerRunComplete extends TimerState {}

// New state to indicate that the dialog should be shown
class TimerShowDialog extends TimerState {}
