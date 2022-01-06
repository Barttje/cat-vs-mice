import 'package:cat_vs_mice/app/pages/board/model/ai_settings.dart';
import 'package:cat_vs_mice/app/pages/board/model/difficulty.dart';
import 'package:cat_vs_mice/app/pages/board/model/player_type.dart';
import 'package:cat_vs_mice/app/pages/menu/game/model/game_menu_settings.dart';
import 'package:cat_vs_mice/app/pages/menu/game/model/player.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsNotifier extends StateNotifier<GameMenuSettings> {
  SettingsNotifier(GameMenuSettings state) : super(state);

  void updateMice(Player player) {
    if (state.error) {
      if (player == Player.HUMAN) {
        state = state.copyWith(mice: player, error: false);
      }
    }
    state = state.copyWith(mice: player);
  }

  void updateCat(Player player) {
    if (state.error) {
      if (player == Player.HUMAN) {
        state = state.copyWith(cat: player, error: false);
      }
    }
    state = state.copyWith(cat: player);
  }

  void updateDifficulty(Difficulty difficulty) {
    state = state.copyWith(difficulty: difficulty);
  }

  void setError() {
    state = state.copyWith(error: true);
  }

  GameMenuSettings settings() {
    return state.copyWith();
  }

  AISettings? getAISettings() {
    if (state.mice == Player.HUMAN && state.cat == Player.HUMAN) {
      return null;
    }
    if (state.mice == Player.COMPUTER) {
      return AISettings(PlayerType.MICE, state.difficulty);
    }
    return AISettings(PlayerType.CAT, state.difficulty);
  }
}
