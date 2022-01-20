import 'dart:ui';

import 'package:cat_vs_mice/app/pages/board/board_view_model.dart';
import 'package:cat_vs_mice/app/pages/board/model/checker.dart';
import 'package:cat_vs_mice/app/pages/board/model/player_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CheckerWidget extends HookWidget {
  final Checker checker;

  int allowMove(PlayerType playerType, bool aiWillPlayMove) {
    if(aiWillPlayMove) {
      return 0;
    }
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
    final viewModel = context.read(boardGameViewModel);
    return Draggable(
      data: checker,
      maxSimultaneousDrags: allowMove(current, viewModel.aiWillPlayMove),
      onDragStarted: () {
        viewModel.startDrag(checker);
      },
      onDraggableCanceled: (a, b) {
        viewModel.cancelDrag(checker);
      },
      feedback: checkerWidget(),
      child: checkerWidget(),
    );
  }

  Container checkerWidget() {
    return Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: getColor(),
          borderRadius: BorderRadius.all(Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: SizedBox(
          width: 35,
          height: 35,
        ));
  }
}

