import 'package:cat_vs_mice/app/pages/menu/game/game_menu_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toggle_switch/toggle_switch.dart';

class DifficultyWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = useProvider(gameMenuViewModel);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Container(),
        ),
        Container(
          width: 120,
          child: Text(
            "Difficulty",
            style: TextStyle(fontSize: 18),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        ToggleSwitch(
          fontSize: 15,
          minWidth: 80,
          activeBgColor: [Colors.green],
          activeFgColor: Colors.white,
          inactiveBgColor: Colors.grey[350],
          inactiveFgColor: Colors.white,
          totalSwitches: 3,
          initialLabelIndex: 1,
          labels: ["Easy", "Normal", "Hard"],
          onToggle: (index) {
            viewModel.updateDifficulty(index);
          },
          animate: true,
          curve: Curves.fastOutSlowIn,
        ),
        Expanded(
          flex: 1,
          child: Container(),
        ),
      ],
    );
  }
}
