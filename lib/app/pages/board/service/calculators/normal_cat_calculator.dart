import 'package:cat_vs_mice/app/pages/board/model/checker.dart';
import 'package:cat_vs_mice/app/pages/board/model/game_logic.dart';
import 'package:cat_vs_mice/app/pages/board/model/move_command.dart';
import 'package:cat_vs_mice/app/pages/board/model/player_type.dart';
import 'package:cat_vs_mice/app/pages/board/service/move_calculator.dart';

class NormalCatCalculator extends MoveCalculator {
  @override
  MoveCommand computeMove(List<Checker> checkers) {
    final catChecker = checkers.firstWhere((element) => element.type == PlayerType.CAT);
    final possibleMoves = GameLogic.possibleMoves(catChecker, checkers);
    possibleMoves.shuffle();
    final movesForward = possibleMoves.where((element) => element.y < catChecker.coordinate.y).toList();
    if (movesForward.isNotEmpty) {
      return MoveCommand(catChecker.id, catChecker.coordinate, movesForward.first);
    }
    return MoveCommand(catChecker.id, catChecker.coordinate, possibleMoves.first);
  }

  @override
  PlayerType getPlayerType() {
    return PlayerType.CAT;
  }
}
