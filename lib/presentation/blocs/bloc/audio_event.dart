part of 'audio_bloc.dart';

abstract class AudioEvent {}

class AudioChangedEvent extends AudioEvent {
  final AudioType audioType;

  AudioChangedEvent({required this.audioType});
}
