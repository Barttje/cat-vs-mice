import 'package:cat_vs_mice/app/pages/board/model/checker.dart';
import 'package:cat_vs_mice/app/pages/board/model/coordinate.dart';
import 'package:cat_vs_mice/app/pages/board/model/game_logic.dart';
import 'package:cat_vs_mice/app/pages/board/model/move_command.dart';
import 'package:cat_vs_mice/app/pages/board/model/player_type.dart';
import 'package:cat_vs_mice/app/pages/board/service/move_calculator.dart';

class HardCatCalculator extends MoveCalculator {
  @override
  MoveCommand computeMove(List<Checker> checkers) {
    final catChecker = checkers.firstWhere((element) => element.type == PlayerType.CAT);
    final possibleMoves = GameLogic.possibleMoves(catChecker, checkers);
    possibleMoves.shuffle();
    final movesForward = possibleMoves.where((element) => element.y < catChecker.coordinate.y).toList();
    if (movesForward.length == 2) {
      //check if any position is blocked by mice
      for (Coordinate move in movesForward) {
        if (!coordinateIsBlockedByMice(move, checkers)) {
          return MoveCommand(catChecker.id, catChecker.coordinate, move);
        }
      }
      return moveToTheMiddle(movesForward.first, movesForward.last, catChecker);
    }
    if (movesForward.isNotEmpty) {
      return MoveCommand(catChecker.id, catChecker.coordinate, movesForward.first);
    }
    if (possibleMoves.length == 2) {
      return moveToTheMiddle(possibleMoves.first, possibleMoves.last, catChecker);
    }
    return MoveCommand(catChecker.id, catChecker.coordinate, possibleMoves.first);
  }

  MoveCommand moveToTheMiddle(Coordinate option1, Coordinate option2, Checker catChecker) {
    if ((option1.x - 3.5).abs() <= (option2.x - 3.5).abs()) {
      return MoveCommand(catChecker.id, catChecker.coordinate, option1);
    }
    return MoveCommand(catChecker.id, catChecker.coordinate, option2);
  }

  bool coordinateIsBlockedByMice(Coordinate coordinate, List<Checker> checkers) {
    return coordinateIsBlocked(Coordinate(coordinate.x - 1, coordinate.y + 1),
            checkers.where((element) => element.type == PlayerType.MICE).toList()) &&
        coordinateIsBlocked(Coordinate(coordinate.x + 1, coordinate.y + 1),
            checkers.where((element) => element.type == PlayerType.MICE).toList());
  }

  bool coordinateIsBlocked(Coordinate coordinate, List<Checker> mices) {
    if (coordinate.x < 0 || coordinate.x > 7) {
      return true;
    }
    return mices.any(
        (element) => element.coordinate == coordinate || GameLogic.possibleMoves(element, mices).contains(element));
  }

  @override
  PlayerType getPlayerType() {
    return PlayerType.CAT;
  }
}
