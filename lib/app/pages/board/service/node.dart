import 'package:cat_vs_mice/app/pages/board/model/checker.dart';
import 'package:cat_vs_mice/app/pages/board/service/move.dart';

class Node {
  final List<Checker> checkers;

  Node(this.checkers);

  Node copy(Move move) {
    final checkers = [
      for (final checker in this.checkers)
        if (checker == move.checker)
          checker.copyWith(coordinate: move.coordinate)
        else
          checker,
    ];
    return Node(checkers);
  }
}
