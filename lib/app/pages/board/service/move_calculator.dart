import 'package:cat_vs_mice/app/pages/board/model/checker.dart';
import 'package:cat_vs_mice/app/pages/board/model/move_command.dart';
import 'package:cat_vs_mice/app/pages/board/model/player_type.dart';

abstract class MoveCalculator {
  MoveCommand computeMove(List<Checker> checkers);
  PlayerType getPlayerType();
}