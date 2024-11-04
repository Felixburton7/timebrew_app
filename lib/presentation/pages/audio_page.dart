import 'package:final_timebrew_app/core/enums/audio_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/audio_theme_data.dart';
import '../blocs/bloc/audio_bloc.dart';

class AudioPage extends StatelessWidget {
  AudioPage({Key? key}) : super(key: key);

  // Optional: Helper method for display names
  String getAudioDisplayName(AudioType audioType) {
    return audioThemeData[audioType]?.displayName ?? audioType.toString();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioBloc, AudioState>(
      builder: (context, audioState) {
        final audioBloc = BlocProvider.of<AudioBloc>(context);

        return Scaffold(
          appBar: AppBar(
            title: const Text('Select Audio Theme'),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          ),
          body: ListView.builder(
            itemCount: AudioType.values.length,
            itemBuilder: (context, index) {
              AudioType audioType = AudioType.values[index];
              bool isSelected = audioType == audioState.audioType;

              return ListTile(
                title: Text(getAudioDisplayName(audioType)),
                trailing: isSelected ? Icon(Icons.check) : null,
                onTap: () {
                  audioBloc.add(AudioChangedEvent(audioType: audioType));
                  // Optionally, you can provide feedback
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('${getAudioDisplayName(audioType)} Selected'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
