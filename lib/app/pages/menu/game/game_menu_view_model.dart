import 'package:cat_vs_mice/app/pages/board/model/difficulty.dart';
import 'package:cat_vs_mice/app/pages/board/model/player_type.dart';
import 'package:cat_vs_mice/app/pages/menu/game/model/player.dart';
import 'package:cat_vs_mice/app/pages/menu/game/providers/settings_notifier.dart';
import 'package:cat_vs_mice/app/services/preference_service.dart';
import 'package:cat_vs_mice/app/services/routing_service.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'model/game_menu_settings.dart';

final _settings = StateNotifierProvider<SettingsNotifier, GameMenuSettings>(
    (ref) => SettingsNotifier(GameMenuSettings(Player.HUMAN, Player.COMPUTER, Difficulty.NORMAL, false)));

final settings = Provider((ref) => ref.watch(_settings));

final gameMenuViewModel = Provider<GameMenuViewModel>(
  (ref) => GameMenuViewModel(
    ref.watch(routingService),
    ref.watch(preferenceService),
    ref.watch(_settings.notifier),
  ),
);

class GameMenuViewModel {
  RoutingService _routingService;
  PreferenceService _preferenceService;
  SettingsNotifier _settingsNotifier;

  GameMenuViewModel(this._routingService, this._preferenceService, this._settingsNotifier);

  void initialize() {
    _settingsNotifier.updateMice(Player.HUMAN);
    _settingsNotifier.updateCat(Player.COMPUTER);
    _settingsNotifier.updateDifficulty(Difficulty.NORMAL);
  }

  void updatePlayer(PlayerType type, int index) {
    switch (type) {
      case PlayerType.MICE:
        switch (index) {
          case 0:
            _settingsNotifier.updateMice(Player.HUMAN);
            break;
          case 1:
            _settingsNotifier.updateMice(Player.COMPUTER);
            break;
        }
        break;
      case PlayerType.CAT:
        switch (index) {
          case 0:
            _settingsNotifier.updateCat(Player.HUMAN);
            break;
          case 1:
            _settingsNotifier.updateCat(Player.COMPUTER);
            break;
        }
        break;
    }
  }

  void updateDifficulty(int index) {
    switch (index) {
      case 0:
        _settingsNotifier.updateDifficulty(Difficulty.NORMAL);
        break;
      case 1:
        _settingsNotifier.updateDifficulty(Difficulty.HARD);
        break;
    }
  }

  void play() async {
    if (_settingsNotifier.settings().cat == Player.COMPUTER && _settingsNotifier.settings().mice == Player.COMPUTER) {
      _settingsNotifier.setError();
    }
    if (!_preferenceService.isRulesQuestionAsked()) {
      _preferenceService.updateRulesQuestionAsked();
      _routingService.openRulesDialog(_settingsNotifier.getAISettings());
    } else {
      _routingService.toBoardGame(_settingsNotifier.getAISettings());
    }
  }
}
