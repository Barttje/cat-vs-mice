import 'package:cat_vs_mice/app/pages/board/board_view_model.dart';
import 'package:cat_vs_mice/app/pages/board/model/checker.dart';
import 'package:cat_vs_mice/app/pages/board/model/player_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CheckerWidget extends HookWidget {
  final Checker checker;

  int allowMove(PlayerType playerType) {
    if (playerType == checker.type) {
      return 1;
    }
    return 0;
  }

  getColor() {
    if (PlayerType.CAT == checker.type) {
      return Colors.white;
    }
    return Colors.black;
  }

  const CheckerWidget(this.checker);

  @override
  Widget build(BuildContext context) {
    final current = useProvider(currentPlayer);

    return Draggable(
      data: checker,
      maxSimultaneousDrags: allowMove(current),
      onDragStarted: () {
        context.read(boardGameViewModel).startDrag(checker);
      },
      onDraggableCanceled: (a, b) {
        context.read(boardGameViewModel).cancelDrag(checker);
      },
      feedback: Container(
        child: Icon(
          Icons.circle,
          color: getColor(),
          size: 35,
        ),
      ),
      child: Container(
        child: Icon(
          Icons.circle,
          color: getColor(),
          size: 35,
        ),
      ),
    );
  }
}
