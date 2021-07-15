import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app/pages/menu/main/main_menu_page.dart';

void main() => runApp(ProviderScope(child: DragAndDropExample()));

class DragAndDropExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
//        accentColor: Colors.cyan[600],
//        elevatedButtonTheme: ElevatedButtonThemeData(
//          style: ButtonStyle(
//            backgroundColor: MaterialStateProperty.all<Color>(
//              Colors.green,
//            ), //button color
//            foregroundColor: MaterialStateProperty.all<Color>(
//              Colors.black,
//            ), //text (and icon)
//          ),
//        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainMenuPage(),
    );
  }
}
