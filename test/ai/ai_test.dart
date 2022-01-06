// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:cat_vs_mice/app/pages/board/model/ai_settings.dart';
import 'package:cat_vs_mice/app/pages/board/model/checker.dart';
import 'package:cat_vs_mice/app/pages/board/model/coordinate.dart';
import 'package:cat_vs_mice/app/pages/board/model/difficulty.dart';
import 'package:cat_vs_mice/app/pages/board/model/player_type.dart';
import 'package:cat_vs_mice/app/pages/board/service/ai_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Counter value should be incremented', () {
    final aiService = AIService(AISettings(PlayerType.CAT, Difficulty.NORMAL));

    final checkers = [
      Checker(1, PlayerType.MICE, new Coordinate(0, 6)),
      Checker(2, PlayerType.MICE, new Coordinate(2, 6)),
      Checker(3, PlayerType.MICE, new Coordinate(4, 6)),
      Checker(4, PlayerType.MICE, new Coordinate(6, 6)),
      Checker(5, PlayerType.CAT, new Coordinate(5, 2))
    ];

    final result = aiService.computeMoveForEasyCat(checkers);
    print(result.value);
    print(result.move?.coordinate.x);
    print(result.move?.coordinate.y);
    print(result.move?.checker.type);
  });
}
