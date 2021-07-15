import 'package:cat_vs_mice/app/pages/board/board_page_input.dart';
import 'package:cat_vs_mice/app/pages/board/board_view_model.dart';
import 'package:cat_vs_mice/app/pages/board/model/coordinate.dart';
import 'package:cat_vs_mice/app/pages/board/model/square.dart';
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
      Column(
        children: [
          GridView.count(
            shrinkWrap: true,
            physics: new NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(4),
            crossAxisCount: 8,
            children: squares.map((square) => SquareWidget(square)).toList(),
          ),
          CurrentPlayerWidget()
        ],
      ),
    );
  }

  void init(BuildContext context) {
    useEffect(() {
      Future.delayed(Duration.zero, () {
        context.read(boardGameViewModel).initialize(input.aiSettings);
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
