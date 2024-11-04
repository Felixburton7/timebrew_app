// // lib/presentation/blocs/timer_bloc.dart

// import 'dart:async';
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:final_timebrew_app/domain/usecases/start_timer.dart';
// import 'package:final_timebrew_app/domain/entities/timer_setting.dart';
// import 'package:flutter_screen_wake/flutter_screen_wake.dart'; // Import the package
// import 'package:audioplayers/audioplayers.dart';

// part 'timer_event.dart';
// part 'timer_state.dart';

// class TimerBloc extends Bloc<TimerEvent, TimerState> {
//   final StartTimer startTimerUseCase;
//   final AudioPlayer _audioPlayer = AudioPlayer(); // Add this line

//   TimerBloc({required this.startTimerUseCase}) : super(TimerInitial()) {
//     on<TimerStarted>(_onTimerStarted);
//     on<TimerTicked>(_onTimerTicked);
//     on<TimerPaused>(_onTimerPaused);
//     on<TimerResumed>(_onTimerResumed);
//     on<TimerReset>(_onTimerReset);
//     on<TimerUpdated>(_onTimerUpdated);
//   }

//   Timer? _timer;
//   DateTime? _targetEndTime;
//   Duration _remainingDuration = Duration.zero;

//   void _onTimerStarted(TimerStarted event, Emitter<TimerState> emit) async {
//     await startTimerUseCase(
//       TimerSetting(durationInSeconds: event.duration.inSeconds),
//     );

//     _targetEndTime = event.targetEndTime;
//     _remainingDuration = event.duration;
//     _startTimer();

//     // Enable keeping the screen on
//     FlutterScreenWake.keepOn(true);

//     emit(TimerRunInProgress(_remainingDuration, event.totalDuration));
//   }

//   void _startTimer() {
//     _timer?.cancel();
//     _timer = Timer.periodic(Duration(seconds: 1), (_) {
//       final now = DateTime.now();
//       _remainingDuration = _targetEndTime!.difference(now);
//       if (_remainingDuration <= Duration.zero) {
//         _timer?.cancel();
//         add(TimerTicked(duration: Duration.zero));
//       } else {
//         add(TimerTicked(duration: _remainingDuration));
//       }
//     });
//   }

//   void _onTimerTicked(TimerTicked event, Emitter<TimerState> emit) {
//     if (event.duration > Duration.zero) {
//       if (state is TimerRunInProgress) {
//         emit(TimerRunInProgress(
//             event.duration, (state as TimerRunInProgress).totalDuration));
//       } else if (state is TimerRunPause) {
//         emit(TimerRunInProgress(
//             event.duration, (state as TimerRunPause).totalDuration));
//       }
//     } else {
//       // Timer completed
//       FlutterScreenWake.keepOn(false);
//       emit(TimerRunComplete());
//       emit(TimerShowDialog());

//       // Play the alarm sound
//       _playAlarmSound();
//     }
//   }

//   void _onTimerPaused(TimerPaused event, Emitter<TimerState> emit) {
//     if (state is TimerRunInProgress) {
//       _timer?.cancel();
//       // Calculate remaining duration at the moment of pause
//       final now = DateTime.now();
//       _remainingDuration = _targetEndTime!.difference(now);

//       // Disable keeping the screen on when the timer is paused
//       FlutterScreenWake.keepOn(false);

//       emit(TimerRunPause(
//           _remainingDuration, (state as TimerRunInProgress).totalDuration));
//     }
//   }

//   void _onTimerResumed(TimerResumed event, Emitter<TimerState> emit) {
//     if (state is TimerRunPause) {
//       // Set a new target end time based on remaining duration
//       _targetEndTime = DateTime.now().add(_remainingDuration);
//       _startTimer();

//       // Enable keeping the screen on when the timer resumes
//       FlutterScreenWake.keepOn(true);

//       emit(TimerRunInProgress(
//           _remainingDuration, (state as TimerRunPause).totalDuration));
//     }
//   }

//   void _onTimerReset(TimerReset event, Emitter<TimerState> emit) {
//     _timer?.cancel();

//     // Stop the alarm sound if it's playing
//     _audioPlayer.stop();

//     // Disable keeping the screen on when the timer is reset
//     FlutterScreenWake.keepOn(false);

//     emit(TimerInitial());
//   }

//   void _onTimerUpdated(TimerUpdated event, Emitter<TimerState> emit) {
//     // Adjust the remaining duration based on added or subtracted seconds
//     if (_targetEndTime != null &&
//         (state is TimerRunInProgress || state is TimerRunPause)) {
//       if (event.addSeconds) {
//         _remainingDuration += Duration(seconds: 10);
//       } else {
//         _remainingDuration -= Duration(seconds: 10);
//         if (_remainingDuration < Duration.zero) {
//           _remainingDuration = Duration.zero;
//         }
//       }
//       // Update the target end time
//       if (state is TimerRunInProgress) {
//         _targetEndTime = DateTime.now().add(_remainingDuration);
//         emit(TimerRunInProgress(
//             _remainingDuration, (state as TimerRunInProgress).totalDuration));
//       } else if (state is TimerRunPause) {
//         // Do not restart the timer if paused
//         emit(TimerRunPause(
//             _remainingDuration, (state as TimerRunPause).totalDuration));
//       }
//     }
//   }

//   @override
//   Future<void> close() {
//     _timer?.cancel();
//     _audioPlayer.dispose(); // Dispose the audio player
//     FlutterScreenWake.keepOn(false);
//     return super.close();
//   }

//   Future<void> _playAlarmSound() async {
//     try {
//       // Ensure the audio player is stopped before playing
//       await _audioPlayer.stop();

//       // Play the local asset
//       await _audioPlayer.play(
//         AssetSource(
//             'sounds/gentle_piano_alarm.wav'), // Update path if necessary
//       );

//       // Optional: Loop the alarm sound until the user interacts
//       // Uncomment the following lines if you want the alarm to loop
//       await _audioPlayer.setReleaseMode(ReleaseMode.loop);
//       await _audioPlayer.resume();
//     } catch (e) {
//       print('Error playing alarm sound: $e');
//     }
//   }
// }
// lib/presentation/blocs/timer_bloc.dart

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_timebrew_app/domain/usecases/start_timer.dart';
import 'package:final_timebrew_app/domain/entities/timer_setting.dart';
import 'package:flutter_screen_wake/flutter_screen_wake.dart'; // Import the package
import 'package:audioplayers/audioplayers.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final StartTimer startTimerUseCase;
  final AudioPlayer _audioPlayer = AudioPlayer(); // Add this line
  String? _audioAssetPath; // Add this line

  TimerBloc({required this.startTimerUseCase}) : super(TimerInitial()) {
    on<TimerStarted>(_onTimerStarted);
    on<TimerTicked>(_onTimerTicked);
    on<TimerPaused>(_onTimerPaused);
    on<TimerResumed>(_onTimerResumed);
    on<TimerReset>(_onTimerReset);
    on<TimerUpdated>(_onTimerUpdated);
  }

  Timer? _timer;
  DateTime? _targetEndTime;
  Duration _remainingDuration = Duration.zero;

  void _onTimerStarted(TimerStarted event, Emitter<TimerState> emit) async {
    await startTimerUseCase(
      TimerSetting(durationInSeconds: event.duration.inSeconds),
    );

    _targetEndTime = event.targetEndTime;
    _remainingDuration = event.duration;
    _audioAssetPath = event.audioAssetPath; // Store the audio asset path
    _startTimer();

    // Enable keeping the screen on
    FlutterScreenWake.keepOn(true);

    emit(TimerRunInProgress(_remainingDuration, event.totalDuration));
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      final now = DateTime.now();
      _remainingDuration = _targetEndTime!.difference(now);
      if (_remainingDuration <= Duration.zero) {
        _timer?.cancel();
        add(TimerTicked(duration: Duration.zero));
      } else {
        add(TimerTicked(duration: _remainingDuration));
      }
    });
  }

  void _onTimerTicked(TimerTicked event, Emitter<TimerState> emit) {
    if (event.duration > Duration.zero) {
      if (state is TimerRunInProgress) {
        emit(TimerRunInProgress(
            event.duration, (state as TimerRunInProgress).totalDuration));
      } else if (state is TimerRunPause) {
        emit(TimerRunInProgress(
            event.duration, (state as TimerRunPause).totalDuration));
      }
    } else {
      // Timer completed
      FlutterScreenWake.keepOn(false);
      emit(TimerRunComplete());
      emit(TimerShowDialog());

      // Play the alarm sound
      _playAlarmSound();
    }
  }

  void _onTimerPaused(TimerPaused event, Emitter<TimerState> emit) {
    if (state is TimerRunInProgress) {
      _timer?.cancel();
      // Calculate remaining duration at the moment of pause
      final now = DateTime.now();
      _remainingDuration = _targetEndTime!.difference(now);

      // Disable keeping the screen on when the timer is paused
      FlutterScreenWake.keepOn(false);

      emit(TimerRunPause(
          _remainingDuration, (state as TimerRunInProgress).totalDuration));
    }
  }

  void _onTimerResumed(TimerResumed event, Emitter<TimerState> emit) {
    if (state is TimerRunPause) {
      // Set a new target end time based on remaining duration
      _targetEndTime = DateTime.now().add(_remainingDuration);
      _startTimer();

      // Enable keeping the screen on when the timer resumes
      FlutterScreenWake.keepOn(true);

      emit(TimerRunInProgress(
          _remainingDuration, (state as TimerRunPause).totalDuration));
    }
  }

  void _onTimerReset(TimerReset event, Emitter<TimerState> emit) {
    _timer?.cancel();

    // Stop the alarm sound if it's playing
    _audioPlayer.stop();

    // Disable keeping the screen on when the timer is reset
    FlutterScreenWake.keepOn(false);

    emit(TimerInitial());
  }

  void _onTimerUpdated(TimerUpdated event, Emitter<TimerState> emit) {
    // Adjust the remaining duration based on added or subtracted seconds
    if (_targetEndTime != null &&
        (state is TimerRunInProgress || state is TimerRunPause)) {
      if (event.addSeconds) {
        _remainingDuration += Duration(seconds: 10);
      } else {
        _remainingDuration -= Duration(seconds: 10);
        if (_remainingDuration < Duration.zero) {
          _remainingDuration = Duration.zero;
        }
      }
      // Update the target end time
      if (state is TimerRunInProgress) {
        _targetEndTime = DateTime.now().add(_remainingDuration);
        emit(TimerRunInProgress(
            _remainingDuration, (state as TimerRunInProgress).totalDuration));
      } else if (state is TimerRunPause) {
        // Do not restart the timer if paused
        emit(TimerRunPause(
            _remainingDuration, (state as TimerRunPause).totalDuration));
      }
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    _audioPlayer.dispose(); // Dispose the audio player
    FlutterScreenWake.keepOn(false);
    return super.close();
  }

  Future<void> _playAlarmSound() async {
    try {
      // Ensure the audio player is stopped before playing
      await _audioPlayer.stop();

      if (_audioAssetPath != null) {
        // Play the selected audio asset
        await _audioPlayer.play(
          AssetSource(_audioAssetPath!), // Use the stored audio asset path
        );
      } else {
        // Fallback to a default sound if _audioAssetPath is null
        await _audioPlayer.play(
          AssetSource('sounds/gentle_piano_alarm.wav'),
        );
      }

      // Loop the alarm sound until the user interacts
      await _audioPlayer.setReleaseMode(ReleaseMode.loop);
    } catch (e) {
      print('Error playing alarm sound: $e');
    }
  }
}
