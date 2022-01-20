import 'package:cat_vs_mice/app/services/preference_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final soundController = StateNotifierProvider<SoundController, bool?>((ref) => SoundController(ref.watch(preferenceService)));

class SoundController extends StateNotifier<bool?> {
  PreferenceService _preferenceService;

  SoundController(this._preferenceService) : super(null) {
    Future.delayed(Duration(milliseconds: 50), () {
      state = _preferenceService.isSoundEnabled();
    });
  }

  void toggle() {
    state = !state!;
    _preferenceService.updateSoundEnabled(state!);
  }
}
