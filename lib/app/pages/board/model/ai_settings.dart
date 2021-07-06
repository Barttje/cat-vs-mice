import 'package:cat_vs_mice/app/pages/board/model/difficulty.dart';
import 'package:cat_vs_mice/app/pages/board/model/player_type.dart';

class AISettings {
  final PlayerType player;
  final Difficulty difficulty;

  AISettings(this.player, this.difficulty);
}
