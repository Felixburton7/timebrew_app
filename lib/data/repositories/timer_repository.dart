// // lib/data/repositories/timer_repository.dart
// import 'package:final_timebrew_app/data/datasources/timer_database.dart';
// import 'package:final_timebrew_app/domain/entities/timer_setting.dart';

// class TimerRepository {
//   final TimerDatabase _db = TimerDatabase.instance;

//   Future<void> saveTimerSetting(TimerSetting setting) async {
//     final database = await _db.database;
//     await database.insert(
//       'timer_settings',
//       {'duration': setting.duration.inSeconds},
//     );
//   }

//   // You can implement methods to retrieve saved settings if needed
// }
// lib/data/repositories/timer_repository.dart

import 'package:final_timebrew_app/data/datasources/timer_database.dart';
import 'package:final_timebrew_app/domain/entities/timer_setting.dart';

class TimerRepository {
  Future<void> saveTimerSetting(TimerSetting setting) async {
    final box = TimerDatabase.box;
    // You can use a unique key or auto-increment
    await box.put('timer_setting', setting);
  }

  Future<TimerSetting?> getTimerSetting() async {
    final box = TimerDatabase.box;
    return box.get('timer_setting');
  }

  // Additional methods as needed
}
