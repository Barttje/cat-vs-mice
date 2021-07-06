import 'package:cat_vs_mice/app/pages/board/model/checker.dart';
import 'package:cat_vs_mice/app/pages/board/model/coordinate.dart';
import 'package:cat_vs_mice/app/pages/board/model/player_type.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:collection/collection.dart';

class CheckerNotifier extends StateNotifier<List<Checker>> {
  CheckerNotifier(List<Checker> state) : super(state);

  void initialize() {
    state = [
      Checker(1, PlayerType.MICE, new Coordinate(0, 0)),
      Checker(2, PlayerType.MICE, new Coordinate(2, 0)),
      Checker(3, PlayerType.MICE, new Coordinate(4, 0)),
      Checker(4, PlayerType.MICE, new Coordinate(6, 0)),
      Checker(5, PlayerType.CAT, new Coordinate(3, 7))
    ];
  }

  void startDrag(Checker selectedChecker) {
    state = [
      for (final checker in state)
        if (checker == selectedChecker)
          checker.copyWith(isDragging: true)
        else
          checker,
    ];
  }

  void cancelDrag(Checker selectedChecker) {
    state = [
      for (final checker in state)
        if (checker == selectedChecker)
          checker.copyWith(isDragging: false)
        else
          checker,
    ];
  }

  void finishDrag(Checker selectedChecker, Coordinate coordinate) {
    Checker? checkerOnDestination =
        state.firstWhereOrNull((checker) => checker.coordinate == coordinate);
    Coordinate origin = selectedChecker.coordinate;
    state = [
      for (final checker in state)
        if (checker == selectedChecker)
          checker.copyWith(isDragging: false, coordinate: coordinate)
        else if (checker == checkerOnDestination)
          checker.copyWith(coordinate: origin)
        else
          checker
    ];
  }
}
