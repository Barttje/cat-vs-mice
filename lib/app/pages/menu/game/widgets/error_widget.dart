import 'package:cat_vs_mice/app/pages/menu/game/game_menu_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toggle_switch/toggle_switch.dart';

class GameMenuErrorWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final menu = useProvider(settings);
    if (menu.error) {
      return Container(
        height: 40,
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(
            "No player selected",
            style: TextStyle(fontSize: 18, color: Colors.red),
          ),
        ),
      );
    }
    return Container(
      height: 40,
    );
  }
}
