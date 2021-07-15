import 'package:cat_vs_mice/app/pages/board/model/checker.dart';
import 'package:cat_vs_mice/app/pages/board/model/coordinate.dart';
import 'package:cat_vs_mice/app/pages/board/model/player_type.dart';

class GameLogic {
  static PlayerType? playerWon(List<Checker> checkers) {
    if (checkers.any((Checker element) =>
        element.type == PlayerType.CAT && element.coordinate.y == 0)) {
      return PlayerType.CAT;
    }
    if (possibleMoves(
            checkers.firstWhere(
                (Checker element) => element.type == PlayerType.CAT),
            checkers)
        .isEmpty) {
      return PlayerType.MICE;
    }
    return null;
  }

  static List<Coordinate> possibleMoves(
      Checker checker, List<Checker> checkers) {
    final List<Coordinate> coordinates = [];
    coordinates
        .add(Coordinate(checker.coordinate.x + 1, checker.coordinate.y + 1));
    coordinates
        .add(Coordinate(checker.coordinate.x - 1, checker.coordinate.y + 1));
    if (checker.type == PlayerType.CAT) {
      coordinates
          .add(Coordinate(checker.coordinate.x + 1, checker.coordinate.y - 1));
      coordinates
          .add(Coordinate(checker.coordinate.x - 1, checker.coordinate.y - 1));
    }
    return coordinates
        .where((Coordinate element) => element.x >= 0 && element.x <= 8)
        .where((Coordinate element) => element.y >= 0 && element.y <= 8)
        .where((Coordinate element) =>
            !checkers.any((Checker check) => element == check.coordinate))
        .toList();
  }
}
