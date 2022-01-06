import 'package:cat_vs_mice/app/pages/board/model/checker.dart';
import 'package:cat_vs_mice/app/pages/board/model/game_logic.dart';
import 'package:cat_vs_mice/app/pages/board/model/move_command.dart';
import 'package:cat_vs_mice/app/pages/board/model/player_type.dart';
import 'package:collection/src/iterable_extensions.dart';

class MiceLogic {
  static MoveCommand? sharedBasicRules(List<Checker> checkers) {
    final mices = checkers.where((element) => element.type == PlayerType.MICE).toList();
    var result = _canMoveWithoutGapLeftSide(checkers, mices);
    if (result != null) {
      return result;
    }
    result = _canMoveWithoutGapRightSide(checkers, mices);
    if (result != null) {
      return result;
    }
    // try to do safe move ( close rank without creating new gap)
    final mice = mices.firstWhereOrNull((element) => _canCloseRank(element, mices));
    if (mice != null && GameLogic.possibleMoves(mice, checkers).isNotEmpty) {
      return MoveCommand(mice.id, mice.coordinate, GameLogic.possibleMoves(mice, checkers).first);
    }
  }

  static bool _canCloseRank(Checker checker, List<Checker> mices) {
    if (checker.coordinate.y % 2 == 0) {
      return mices.any((element) =>
          (element.coordinate.y - 1) == checker.coordinate.y && (element.coordinate.x + 1) == checker.coordinate.x);
    }
    return mices.any((element) =>
        (element.coordinate.y - 1) == checker.coordinate.y && (element.coordinate.x - 1) == checker.coordinate.x);
  }

  static MoveCommand? _canMoveWithoutGapLeftSide(List<Checker> checkers, List<Checker> mices) {
    final leftMice = mices.firstWhereOrNull((element) => element.coordinate.x == 0);
    final leftMice2 = mices.firstWhereOrNull((element) => element.coordinate.x == 2);
    if (leftMice != null &&
        leftMice2 != null &&
        leftMice.coordinate.y == leftMice2.coordinate.y &&
        GameLogic.possibleMoves(leftMice, checkers).isNotEmpty) {
      return MoveCommand(leftMice.id, leftMice.coordinate, GameLogic.possibleMoves(leftMice, checkers).first);
    }
    return null;
  }

  static MoveCommand? _canMoveWithoutGapRightSide(List<Checker> checkers, List<Checker> mices) {
    final rightMice = mices.firstWhereOrNull((element) => element.coordinate.x == 7);
    final rightMice2 = mices.firstWhereOrNull((element) => element.coordinate.x == 5);
    if (rightMice != null &&
        rightMice2 != null &&
        rightMice.coordinate.y == rightMice2.coordinate.y &&
        GameLogic.possibleMoves(rightMice, checkers).isNotEmpty) {
      return MoveCommand(rightMice.id, rightMice.coordinate, GameLogic.possibleMoves(rightMice, checkers).first);
    }
    return null;
  }
}
