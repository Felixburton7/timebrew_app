// lib/presentation/blocs/bloc/timer_event.dart

part of 'timer_bloc.dart';

abstract class TimerEvent extends Equatable {
  const TimerEvent();

  @override
  List<Object?> get props => [];
}

class TimerStarted extends TimerEvent {
  final Duration duration;
  final Duration totalDuration;
  final DateTime targetEndTime;
  final String audioAssetPath; // Added this line

  const TimerStarted({
    required this.duration,
    required this.totalDuration,
    required this.targetEndTime,
    required this.audioAssetPath, // Added this line
  });

  @override
  List<Object?> get props =>
      [duration, totalDuration, targetEndTime, audioAssetPath];
}

class TimerTicked extends TimerEvent {
  final Duration duration;

  const TimerTicked({required this.duration});

  @override
  List<Object?> get props => [duration];
}

class TimerPaused extends TimerEvent {
  const TimerPaused();

  @override
  List<Object?> get props => [];
}

class TimerResumed extends TimerEvent {
  const TimerResumed();

  @override
  List<Object?> get props => [];
}

class TimerReset extends TimerEvent {
  const TimerReset();

  @override
  List<Object?> get props => [];
}

///
/// New Event: TimerUpdated
/// This event is used to add or subtract 10 seconds from the current timer.
/// `addSeconds` is true for adding and false for subtracting.
///
class TimerUpdated extends TimerEvent {
  final bool addSeconds;

  const TimerUpdated({required this.addSeconds});

  @override
  List<Object?> get props => [addSeconds];
}
