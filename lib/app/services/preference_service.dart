import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final preferenceService = Provider<PreferenceService>((ref) => PreferenceService());

class PreferenceService {
  SharedPreferences? _sharedPreferences;

  PreferenceService() {
    SharedPreferences.getInstance().then((value) {
      _sharedPreferences = value;
    });
  }

  updateSoundEnabled(bool soundEnabled) {
    _sharedPreferences!.setBool("SOUND_ENABLED", soundEnabled);
  }

  bool isSoundEnabled() {
    return _sharedPreferences?.getBool("SOUND_ENABLED") ?? false;
  }

  updateRulesQuestionAsked() {
    _sharedPreferences!.setBool("RULES_QUESTION_ASKED", true);
  }

  bool isRulesQuestionAsked() {
    return _sharedPreferences?.getBool("RULES_QUESTION_ASKED") ?? false;
  }
}
