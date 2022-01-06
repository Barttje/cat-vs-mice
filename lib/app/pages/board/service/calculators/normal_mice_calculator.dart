import 'package:cat_vs_mice/app/pages/board/model/checker.dart';
import 'package:cat_vs_mice/app/pages/board/model/game_logic.dart';
import 'package:cat_vs_mice/app/pages/board/model/move_command.dart';
import 'package:cat_vs_mice/app/pages/board/model/player_type.dart';
import 'package:cat_vs_mice/app/pages/board/service/calculators/mice_logic.dart';
import 'package:cat_vs_mice/app/pages/board/service/move_calculator.dart';

class NormalMiceCalculator extends MoveCalculator {
  @override
  MoveCommand computeMove(List<Checker> checkers) {
    final mices = checkers.where((element) => element.type == PlayerType.MICE).toList();
    final cat = checkers.firstWhere((element) => element.type == PlayerType.CAT);
    // try to do safe move ( close rank without creating new gap)
    var result = MiceLogic.sharedBasicRules(checkers);
    if (result != null) {
      return result;
    }

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
