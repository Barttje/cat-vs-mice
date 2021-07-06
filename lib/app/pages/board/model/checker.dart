import 'package:cat_vs_mice/app/pages/board/model/coordinate.dart';
import 'package:cat_vs_mice/app/pages/board/model/player_type.dart';

class Checker {
  final int id;
  final PlayerType type;
  final bool isDragging;
  final Coordinate coordinate;

  Checker(this.id, this.type, this.coordinate, {this.isDragging = false});

  Checker copyWith({bool? isDragging, Coordinate? coordinate}) {
    return Checker(this.id, type, coordinate ?? this.coordinate,
        isDragging: isDragging ?? this.isDragging);
  }

  @override
  bool operator ==(Object o) => o is Checker && o.id == id;

  @override
  int get hashCode => id;
}
