import 'package:cat_vs_mice/app/pages/board/model/difficulty.dart';
import 'package:cat_vs_mice/app/pages/menu/game/model/player.dart';

class GameMenuSettings {
  final Player mice;
  final Player cat;
  final Difficulty difficulty;
  final bool error;

  GameMenuSettings(this.mice, this.cat, this.difficulty, this.error);

  GameMenuSettings copyWith(
      {Player? mice, Player? cat, Difficulty? difficulty, bool? error}) {
    return GameMenuSettings(mice ?? this.mice, cat ?? this.cat,
        difficulty ?? this.difficulty, error ?? this.error);
  }
}
