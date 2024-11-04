// lib/live_activity_service.dart

import 'dart:io';
import 'package:flutter/services.dart';

class LiveActivityService {
  static const MethodChannel _channel = MethodChannel('live_activity');

  static Future<void> startLiveActivity(int duration, String theme) async {
    if (Platform.isIOS) {
      try {
        await _channel.invokeMethod('startLiveActivity', {
          'duration': duration,
          'theme': theme,
        });
      } catch (e) {
        print('Error starting Live Activity: $e');
      }
    }
  }

  static Future<void> updateLiveActivity(int remainingTime) async {
    if (Platform.isIOS) {
      try {
        await _channel.invokeMethod('updateLiveActivity', {
          'remainingTime': remainingTime,
        });
      } catch (e) {
        print('Error updating Live Activity: $e');
      }
    }
  }

  static Future<void> endLiveActivity() async {
    if (Platform.isIOS) {
      try {
        await _channel.invokeMethod('endLiveActivity');
      } catch (e) {
        print('Error ending Live Activity: $e');
      }
    }
  }
}
