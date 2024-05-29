part of 'audio_home_bloc.dart';

sealed class AudioHomeEvent {}

final class PlayAudio extends AudioHomeEvent {}

final class DisposAudio extends AudioHomeEvent {}
