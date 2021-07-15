import 'package:cat_vs_mice/app/pages/board/model/player_type.dart';
import 'package:cat_vs_mice/app/pages/menu/game/game_menu_view_model.dart';
import 'package:cat_vs_mice/app/pages/menu/game/widgets/difficulty_widget.dart';
import 'package:cat_vs_mice/app/pages/menu/game/widgets/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SettingsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          MenuItem("Mice", 0),
          SizedBox(
            height: 10,
          ),
          MenuItem("Cat", 1),
          SizedBox(
            height: 10,
          ),
          DifficultyWidget(),
          GameMenuErrorWidget(),
        ],
      ),
    );
  }
}

class MenuItem extends HookWidget {
  final String name;
  final int initial;

  const MenuItem(this.name, this.initial, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = useProvider(gameMenuViewModel);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 25,
        ),
        Container(
            width: 120,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
              child: Row(
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            )),
        SizedBox(
          width: 10,
        ),
        ToggleSwitch(
          iconSize: 45,
          activeBgColor: [Colors.green],
          activeFgColor: Colors.white,
          inactiveBgColor: Colors.grey[350],
          inactiveFgColor: Colors.white,
          totalSwitches: 2,
          initialLabelIndex: initial,
          icons: [Icons.account_box, Icons.laptop_chromebook],
          onToggle: (index) {
            viewModel.updatePlayer(
                name == 'Cat' ? PlayerType.CAT : PlayerType.MICE, index);
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
