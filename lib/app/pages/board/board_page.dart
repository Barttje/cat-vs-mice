import 'package:cat_vs_mice/app/pages/board/board_page_input.dart';
import 'package:cat_vs_mice/app/pages/board/board_view_model.dart';
import 'package:cat_vs_mice/app/pages/board/model/ai_settings.dart';
import 'package:cat_vs_mice/app/pages/board/model/coordinate.dart';
import 'package:cat_vs_mice/app/pages/board/model/difficulty.dart';
import 'package:cat_vs_mice/app/pages/board/model/player_type.dart';
import 'package:cat_vs_mice/app/pages/board/model/square.dart';
import 'package:cat_vs_mice/app/pages/board/service/calculators/hard_mice_calculator.dart';
import 'package:cat_vs_mice/app/pages/board/service/calculators/normal_cat_calculator.dart';
import 'package:cat_vs_mice/app/pages/board/service/calculators/normal_mice_calculator.dart';
import 'package:cat_vs_mice/app/pages/board/service/move_calculator.dart';
import 'package:cat_vs_mice/app/pages/board/widgets/current_player_widget.dart';
import 'package:cat_vs_mice/app/pages/board/widgets/square_widget.dart';
import 'package:cat_vs_mice/app/pages/common/page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BoardPage extends HookWidget {
  final BoardPageInput input;
  final List<Square> squares = SquareInitializer.squares();

  BoardPage(this.input);

  @override
  Widget build(BuildContext context) {
    init(context);
    return DefaultPage(
      Container(
        color: Colors.brown[50]!,
        child: Column(
          children: [
            CurrentPlayerWidget(),
            GridView.count(
              shrinkWrap: true,
              padding: EdgeInsets.all(12),
              physics: new NeverScrollableScrollPhysics(),
              crossAxisCount: 8,
              children: squares.map((square) => SquareWidget(square)).toList(),
            ),
          ],
        ),
      ),
    );
  }

  void init(BuildContext context) {
    useEffect(() {
      Future.delayed(Duration.zero, () {
        context.read(boardGameViewModel).initialize(_moveCalculator(input.aiSettings));
      });
    }, []);
  }
}

class SquareInitializer {
  static List<Square> squares() {
    List<Square> squares = [];
    for (var y = 0; y < 8; y++) {
      for (var x = 0; x < 8; x++) {
        squares.add(Square(Coordinate(x, y)));
      }
    }
    return squares;
  }
}

MoveCalculator? _moveCalculator(AISettings? aiSettings) {
  if (aiSettings == null) {
    return null;
  }
  print(aiSettings.difficulty);
  if (aiSettings.player == PlayerType.CAT) {
    if (aiSettings.difficulty == Difficulty.NORMAL) {
      return NormalCatCalculator();
    }
    return HardMiceCalculator();
  }
  if (aiSettings.difficulty == Difficulty.NORMAL) {
    return NormalMiceCalculator();
  }
  print('hoi');
  return HardMiceCalculator();
}
