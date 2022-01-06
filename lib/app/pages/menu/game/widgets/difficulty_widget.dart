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
            child: Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
              child: Row(
                children: [
                  Text(
                    "Difficulty",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            )),
        SizedBox(
          width: 10,
        ),
        ToggleSwitch(
          fontSize: 15,
          activeBgColor: [Colors.green],
          activeFgColor: Colors.white,
          inactiveBgColor: Colors.grey[350],
          inactiveFgColor: Colors.white,
          totalSwitches: 2,
          initialLabelIndex: 0,
          labels: [ "Normal", "Hard"],
          onToggle: (index) {
            viewModel.updateDifficulty(index);
          },
          animate: true,
          curve: Curves.fastOutSlowIn,
        ),
        Expanded(
          flex: 2,
          child: Container(),
        ),
      ],
    );
  }
}
