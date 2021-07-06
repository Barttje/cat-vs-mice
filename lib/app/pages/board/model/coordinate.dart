import 'package:quiver/core.dart';

class Coordinate {
  final int x;
  final int y;

  Coordinate(this.x, this.y);

  @override
  bool operator ==(Object o) => o is Coordinate && o.y == y && o.x == x;

  @override
  int get hashCode => hash2(x, y);
}
