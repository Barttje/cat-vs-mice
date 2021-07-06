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
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Cat vs Mice"),
        ),
        body: MainMenuPage(),
      ),
    );
  }
}
