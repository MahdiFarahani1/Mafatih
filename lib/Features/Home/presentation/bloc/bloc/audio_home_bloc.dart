import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';

part 'audio_home_event.dart';
part 'audio_home_state.dart';

class AudioHomeBloc extends Bloc<AudioHomeEvent, AudioHomeState> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;

  AudioHomeBloc() : super(AudioHomeState()) {
    on<PlayAudio>((event, emit) async {
      await _audioPlayer.setReleaseMode(ReleaseMode.loop);
      await _audioPlayer.play(AssetSource('sounds/homeSound.mp3'),
          volume: 0.25);
      isPlaying = true;
    });

    on<DisposAudio>((event, emit) async {
      if (isPlaying) {
        await _audioPlayer.stop();
      }

      isPlaying = false;
    });
  }
}
