import 'package:cat_vs_mice/app/pages/board/model/coordinate.dart';

class MoveCommand {
  final int checkerId;
  final Coordinate from;
  final Coordinate to;

  MoveCommand(this.checkerId, this.from, this.to);
}
