import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';

part 'audio_state.dart';

class AudioCubit extends Cubit<AudioState> {
  AudioCubit()
      : super(AudioState(
            icon: Icons.play_arrow,
            duration: Duration.zero,
            isPlaying: false,
            position: Duration.zero));

  initState(AudioPlayer audioPlayer) {
    audioPlayer.onPlayerStateChanged.listen((stateA) {
      bool play = stateA == PlayerState.playing;
      emit(state.copyWith(isplay: play));
    });

    audioPlayer.onDurationChanged.listen((newDur) {
      emit(state.copyWith(dur: newDur));
    });
    audioPlayer.onPositionChanged.listen((newPos) {
      emit(state.copyWith(pos: newPos));
    });
  }

  dispose() {
    emit(AudioState(
        icon: Icons.play_arrow,
        duration: Duration.zero,
        isPlaying: false,
        position: Duration.zero));
  }

  Future<void> changeIcon(AudioPlayer audioPlayer, String url, int id) async {
    if (!state.isPlaying) {
      emit(state.copyWith(icon: Icons.pause));

      //  final directory = await getApplicationDocumentsDirectory();
      final filePath = box.read("audio$id");

      await audioPlayer.play(DeviceFileSource(filePath));
    } else {
      emit(state.copyWith(icon: Icons.play_arrow));
      await audioPlayer.pause();
    }
  }

  Future<void> networkAudio(AudioPlayer audioPlayer, String url, int id) async {
    if (!state.isPlaying) {
      emit(state.copyWith(icon: Icons.pause));

      //  final directory = await getApplicationDocumentsDirectory();
      //  final filePath = box.read("audio$id");

      await audioPlayer.play(UrlSource(url));
    } else {
      emit(state.copyWith(icon: Icons.play_arrow));
      await audioPlayer.pause();
    }
  }
}
