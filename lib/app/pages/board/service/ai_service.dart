import 'package:cat_vs_mice/app/pages/board/model/ai_settings.dart';
import 'package:cat_vs_mice/app/pages/board/model/checker.dart';
import 'package:cat_vs_mice/app/pages/board/model/coordinate.dart';

class AIService {
  final AISettings settings;

  AIService(this.settings);

  Coordinate nextMove(List<Checker> state) {
    return Coordinate(0, 1);
  }
}
