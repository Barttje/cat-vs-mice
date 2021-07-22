import 'package:cat_vs_mice/app/pages/board/board_view_model.dart';
import 'package:cat_vs_mice/app/pages/board/model/player_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RestartWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = useProvider(boardGameViewModel);
    return ElevatedButton(
      onPressed: () {
        viewModel.restart();
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Icon(
              Icons.replay,
              size: 20,
            ),
            Text("Restart"),
          ],
        ),
      ),
    );
  }
}
