import 'package:cat_vs_mice/app/pages/board/widgets/cat_move_widget.dart';
import 'package:cat_vs_mice/app/pages/board/widgets/current_player_widget.dart';
import 'package:cat_vs_mice/app/pages/board/widgets/undo_move_widget.dart';
import 'package:flutter/material.dart';


class OptionsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Expanded(flex: 1, child: Container()),
        // RestartWidget(),
        UndoMoveWidget(),
        AIMoveWidget(),
        CurrentPlayerWidget(),
        // Expanded(flex: 1, child: Container()),
      ],
    );
  }
}
