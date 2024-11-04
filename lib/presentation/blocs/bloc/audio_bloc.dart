// lib/presentation/blocs/bloc/audio_bloc.dart

import 'package:final_timebrew_app/core/audio_theme_data.dart';
import 'package:final_timebrew_app/core/enums/audio_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'audio_event.dart';
part 'audio_state.dart';

// lib/presentation/blocs/bloc/audio_bloc.dar
class AudioBloc extends Bloc<AudioEvent, AudioState> {
  AudioBloc()
      : super(AudioState(
          audioType: AudioType.Nature,
          audioData: audioThemeData[AudioType.Nature]!,
        )) {
    on<AudioChangedEvent>((event, emit) {
      // Emit new state with the selected audio theme
      emit(AudioState(
        audioType: event.audioType,
        audioData: audioThemeData[event.audioType]!,
      ));
    });
  }
}
