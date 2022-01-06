import 'package:cat_vs_mice/app/pages/board/model/checker.dart';
import 'package:cat_vs_mice/app/pages/board/model/coordinate.dart';
import 'package:cat_vs_mice/app/pages/board/model/game_logic.dart';
import 'package:cat_vs_mice/app/pages/board/model/move_command.dart';
import 'package:cat_vs_mice/app/pages/board/model/player_type.dart';
import 'package:cat_vs_mice/app/pages/board/service/calculators/mice_logic.dart';
import 'package:cat_vs_mice/app/pages/board/service/move_calculator.dart';
import 'package:collection/src/iterable_extensions.dart';

class HardMiceCalculator extends MoveCalculator {
  @override
  MoveCommand computeMove(List<Checker> checkers) {
    final mices = checkers.where((element) => element.type == PlayerType.MICE).toList();
    final cat = checkers.firstWhere((element) => element.type == PlayerType.CAT);

    // close a gap
    final mice = mices.firstWhereOrNull(
        (element) => element.coordinate.y == (cat.coordinate.y - 2) && element.coordinate.x == (cat.coordinate.x));
    if (mice != null) {
      final moves = GameLogic.possibleMoves(mice, checkers);
      for (var move in moves) {
        if (move.x >= 1) {
          final nextMove = Coordinate(move.x - 1, move.y - 1);
          if (mices.none((p0) =>
              p0.coordinate.x == nextMove.x && p0.coordinate.y == nextMove.y ||
              GameLogic.possibleMoves(p0, checkers).contains(nextMove))) {
            return MoveCommand(mice.id, mice.coordinate, move);
          }
        }
        if (move.x < 7) {
          final nextMove = Coordinate(move.x + 1, move.y - 1);
          if (mices.none((p0) =>
              p0.coordinate.x == nextMove.x && p0.coordinate.y == nextMove.y ||
              GameLogic.possibleMoves(p0, checkers).any((e1) => e1.x == nextMove.x && e1.y == nextMove.y))) {
            return MoveCommand(mice.id, mice.coordinate, move);
          }
        }
      }
    }
    // try to do safe move ( close rank without creating new gap)
    var result = MiceLogic.sharedBasicRules(checkers);
    if (result != null) {
      return result;
    }

    // move cat most far away
    mices.sort((element, element2) => GameLogic.distance(element2, cat) - GameLogic.distance(element, cat));
    for (var mice in mices) {
      final moves = GameLogic.possibleMoves(mice, checkers);
      if (moves.isNotEmpty) {
        // for 'impossible' ai
        // moves.sort((element, element2) => GameLogic.distanceC(element, cat) - GameLogic.distanceC(element2, cat));
        return MoveCommand(mice.id, mice.coordinate, moves.first);
      }
    }
    return MoveCommand(mices.first.id, mices.first.coordinate, GameLogic.possibleMoves(mices.first, checkers).first);
  }

  @override
  PlayerType getPlayerType() {
    return PlayerType.MICE;
  }
}
