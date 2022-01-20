import 'package:audioplayers/audioplayers.dart';
import 'package:cat_vs_mice/app/services/preference_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final soundService = Provider<SoundService>((ref) => SoundService(
    AudioCache(prefix: 'assets/audio/', fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP)),
    ref.watch(preferenceService)));

class SoundService {
  final AudioCache _audioCache;
  final PreferenceService _preferenceService;

  SoundService(this._audioCache, this._preferenceService);

  void playWinSound() {
    if (_preferenceService.isSoundEnabled()) {
      _audioCache.play("win.wav");
    }
  }

  void playLoseSound() {
    if (_preferenceService.isSoundEnabled()) {
      _audioCache.play("loss.wav");
    }
  }

  void playMoveSound() {
    if (_preferenceService.isSoundEnabled()) {
      _audioCache.play("move.mp3");
    }
  }
}
