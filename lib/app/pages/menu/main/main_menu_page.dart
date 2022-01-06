import 'package:cat_vs_mice/app/pages/common/page.dart';
import 'package:cat_vs_mice/app/pages/menu/main/main_menu_view_model.dart';
import 'package:cat_vs_mice/app/pages/menu/main/model/menu_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MainMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultPage(Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MenuItem("Play", MenuOption.GAME),
          SizedBox(
            height: 32,
          ),
          MenuItem("About", MenuOption.ABOUT),
        ],
      ),
    ));
  }
}

class MenuItem extends HookWidget {
  final String name;
  final MenuOption option;

  const MenuItem(this.name, this.option);

  @override
  Widget build(BuildContext context) {
    final viewModel = useProvider(mainMenuViewModel);
    return ElevatedButton(
        onPressed: () {
          viewModel.toPage(option);
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            name,
            style: TextStyle(fontSize: 24),
          ),
        ));
  }
}
