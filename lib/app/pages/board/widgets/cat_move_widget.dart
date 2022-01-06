import 'package:cat_vs_mice/app/pages/board/board_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AIMoveWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final undoAllowed = useProvider(canPop);
    final viewModel = useProvider(boardGameViewModel);
    return ElevatedButton(
      onPressed: performUndo(undoAllowed, viewModel),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Icon(
              Icons.undo,
              size: 20,
            ),
            Text("Cat Move"),
          ],
        ),
      ),
    );
  }

  VoidCallback? performUndo(bool undoAllowed, BoardViewModel viewModel) {
    if (undoAllowed) {
      return () => {viewModel.aiMove()};
    }
    return null;
  }
}
