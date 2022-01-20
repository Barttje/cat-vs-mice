import 'package:cat_vs_mice/app/pages/menu/game/game_menu_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/route_manager.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(ProviderScope(child: DragAndDropExample()));
}

class DragAndDropExample extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              Colors.green,
            ), //button color
            foregroundColor: MaterialStateProperty.all<Color>(
              Colors.black,
            ), //text (and icon)
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: GameMenuPage(),
    );
  }
}
