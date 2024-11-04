// // lib/domain/entities/timer_setting.dart
// import 'package:equatable/equatable.dart';

// class TimerSetting extends Equatable {
//   final Duration duration;

//   const TimerSetting({required this.duration});

//   @override
//   List<Object> get props => [duration];
// }
// lib/domain/entities/timer_setting.dart

// lib/domain/entities/timer_setting.dart

import 'package:hive/hive.dart';

part 'timer_setting.g.dart';

@HiveType(typeId: 0)
class TimerSetting {
  @HiveField(0)
  final int durationInSeconds;

  TimerSetting({required this.durationInSeconds});

  // Getter to convert durationInSeconds back to Duration
  Duration get duration => Duration(seconds: durationInSeconds);
}
