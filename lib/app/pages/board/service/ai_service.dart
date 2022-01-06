
import 'package:cat_vs_mice/app/pages/board/model/ai_settings.dart';
import 'package:cat_vs_mice/app/pages/board/model/checker.dart';
import 'package:cat_vs_mice/app/pages/board/model/game_logic.dart';
import 'package:cat_vs_mice/app/pages/board/model/player_type.dart';
import 'package:cat_vs_mice/app/pages/board/service/move.dart';
import 'package:cat_vs_mice/app/pages/board/service/result.dart';
import 'package:collection/src/iterable_extensions.dart';

class AIService {
  final AISettings settings;

  AIService(this.settings);

  Result computeMoveForEasyCat(final List<Checker> checkers) {
    final catChecker = checkers.firstWhere((element) => element.type == PlayerType.CAT);
    final possibleMoves = GameLogic.possibleMoves(catChecker, checkers);
    possibleMoves.shuffle();
    final movesForward = possibleMoves.where((element) => element.y < catChecker.coordinate.y).toList();
    if (movesForward.isNotEmpty) {
      return Result(Move(catChecker, movesForward.first), 0);
    }
    return Result(Move(catChecker, possibleMoves.first), 0);
  }

  Result computeMoveForEasyMice(final List<Checker> checkers) {
    final mices = checkers.where((element) => element.type == PlayerType.MICE).toList();
    final cat = checkers.firstWhere((element) => element.type == PlayerType.CAT);
    // try to do safe move ( close rank without creating new gap)
    mices.forEach((element) {
      print('x ${element.coordinate.x}, y ${element.coordinate.y}');
    });

    var result = canMoveWithoutGapLeftSide(checkers, mices);
    if (result != null) {
      return result;
    }
    result = canMoveWithoutGapRightSide(checkers, mices);
    if (result != null) {
      return result;
    }
    // try to do safe move ( close rank without creating new gap)
    final mice = mices.firstWhereOrNull((element) => canCloseRank(element, mices));
    if (mice != null && GameLogic.possibleMoves(mice, checkers).isNotEmpty) {
      return Result(Move(mice, GameLogic.possibleMoves(mice, checkers).first), 0);
    }
    // close another gap

    // move cat most far away
    mices.sort((element, element2) => distance(element, cat) - distance(element2, cat));
    var first = mices.first;
    var last = mices.last;
    print('x ${first.coordinate.x}, y ${first.coordinate.y}');
    print('x ${last.coordinate.x}, y ${last.coordinate.y}');

    final miceChecker = last;
    final possibleMoves = GameLogic.possibleMoves(miceChecker, checkers);
    possibleMoves.shuffle();
    return Result(Move(miceChecker, possibleMoves.first), 0);
  }

  int distance(Checker from, Checker to) =>
      (from.coordinate.x - to.coordinate.x).abs() + (from.coordinate.y - to.coordinate.y).abs();

  bool canCloseRank(Checker checker, List<Checker> mices) {
    print(checker.coordinate.y);
    if (checker.coordinate.y % 2 == 0) {
      return mices.any((element) =>
          (element.coordinate.y - 1) == checker.coordinate.y && (element.coordinate.x + 1) == checker.coordinate.x);
    }
    return mices.any((element) =>
        (element.coordinate.y - 1) == checker.coordinate.y && (element.coordinate.x - 1) == checker.coordinate.x);
  }

  Result? canMoveWithoutGapLeftSide(List<Checker> checkers, List<Checker> mices) {
    final leftMice = mices.firstWhereOrNull((element) => element.coordinate.x == 0);
    final leftMice2 = mices.firstWhereOrNull((element) => element.coordinate.x == 2);
    if (leftMice != null &&
        leftMice2 != null &&
        leftMice.coordinate.y == leftMice2.coordinate.y &&
        GameLogic
            .possibleMoves(leftMice, checkers)
            .isNotEmpty) {
      return Result(Move(leftMice, GameLogic
          .possibleMoves(leftMice, checkers)
          .first), 10);
    }
    return null;
  }

  Result? canMoveWithoutGapRightSide(List<Checker> checkers, List<Checker> mices) {
    final rightMice = mices.firstWhereOrNull((element) => element.coordinate.x == 7);
    final rightMice2 = mices.firstWhereOrNull((element) => element.coordinate.x == 5);
    if (rightMice != null &&
        rightMice2 != null &&
        rightMice.coordinate.y == rightMice2.coordinate.y &&
        GameLogic.possibleMoves(rightMice, checkers).isNotEmpty) {
      return Result(Move(rightMice, GameLogic.possibleMoves(rightMice, checkers).first), 10);
    }
    return null;
  }
}
