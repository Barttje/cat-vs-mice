import 'package:cat_vs_mice/app/pages/board/model/checker.dart';
import 'package:cat_vs_mice/app/pages/board/model/coordinate.dart';
import 'package:cat_vs_mice/app/pages/board/model/player_type.dart';

class Move {
  final Checker checker;
  final Coordinate coordinate;

  Move(this.checker, this.coordinate);
}
