import 'package:cat_vs_mice/app/pages/board/board_page.dart';
import 'package:cat_vs_mice/app/pages/board/board_view_model.dart';
import 'package:cat_vs_mice/app/pages/menu/main/main_menu_view_model.dart';
import 'package:cat_vs_mice/app/routing/routing_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/route_manager.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MainMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MenuItem("Play"),
          MenuItem("Settings"),
          MenuItem("About"),
        ],
      ),
    );
  }
}

class MenuItem extends HookWidget {
  final String name;

  const MenuItem(this.name, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = useProvider(mainMenuViewModel);
    return ElevatedButton(
        onPressed: () {
          viewModel.toBoardGame();
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            name,
            style: TextStyle(fontSize: 18),
          ),
        ));
  }
}
