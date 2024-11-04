// lib/domain/use_cases/start_timer.dart
import 'package:final_timebrew_app/domain/entities/timer_setting.dart';
import 'package:final_timebrew_app/data/repositories/timer_repository.dart';

class StartTimer {
  final TimerRepository repository;

  StartTimer(this.repository);

  Future<void> call(TimerSetting setting) async {
    // Save the timer setting to the repository
    await repository.saveTimerSetting(setting);

    // Additional logic can be added here if needed
  }
}

// I want to deploy this to the app store. 