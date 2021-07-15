import 'package:cat_vs_mice/app/pages/menu/game/game_menu_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GameMenuButtonsWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = useProvider(gameMenuViewModel);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
            style: TextButton.styleFrom(backgroundColor: Colors.grey),
            onPressed: () {
              viewModel.back();
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Back",
                style: TextStyle(fontSize: 22),
              ),
            )),
        ElevatedButton(
            onPressed: () {
              viewModel.play();
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Play",
                style: TextStyle(fontSize: 22),
              ),
            )),
      ],
    );
  }
}
