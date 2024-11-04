import 'package:final_timebrew_app/core/enums/audio_enum.dart';

class AudioData {
  final String audioAssetPath; // Path to the audio file
  final String displayName;

  AudioData({required this.audioAssetPath, required this.displayName});
}

final Map<AudioType, AudioData> audioThemeData = {
  AudioType.Basic: AudioData(
    audioAssetPath: 'sounds/gentle_piano_alarm.wav',
    displayName: 'Basic',
  ),
  AudioType.Forest: AudioData(
    audioAssetPath: 'sounds/birds_in_forest.wav',
    displayName: 'Forest',
  ),
  AudioType.Nature: AudioData(
    audioAssetPath: 'sounds/birds_in_forest.wav',
    displayName: 'Nature',
  ),
  AudioType.City: AudioData(
    audioAssetPath: 'sounds/street_noise.wav',
    displayName: 'City Ambience',
  ),
  AudioType.Ocean: AudioData(
    audioAssetPath: 'sounds/ocean.wav',
    displayName: 'Ocean Waves',
  ),
  // Add more audio themes as needed
};
