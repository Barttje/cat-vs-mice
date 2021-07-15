import 'package:cat_vs_mice/app/pages/about/about_page.dart';
import 'package:cat_vs_mice/app/pages/board/board_page.dart';
import 'package:cat_vs_mice/app/pages/board/board_page_input.dart';
import 'package:cat_vs_mice/app/pages/board/model/ai_settings.dart';
import 'package:cat_vs_mice/app/pages/board/model/player_type.dart';
import 'package:cat_vs_mice/app/pages/menu/game/game_menu_page.dart';
import 'package:cat_vs_mice/app/pages/menu/main/main_menu_page.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final routingService = Provider<RoutingService>((ref) => RoutingService());

class RoutingService {
  void toBoardGame(AISettings? aiSettings) {
    Get.off(() => BoardPage(BoardPageInput(aiSettings)));
  }

  void toAbout() {
    Get.to(() => AboutPage());
  }

  void toGameMenu() {
    Get.to(() => GameMenuPage());
  }

  void back() {
    Get.keys.forEach((key, value) {
      print(value);
    });
    Get.back();
  }

  void openPlayerDialog(PlayerType playerType) {
    String winner = playerType == PlayerType.MICE ? "Mice" : "Cat";
    Get.defaultDialog(
      title: "$winner won the game",
      textCancel: "Back to menu",
      onCancel: () {
        Get.offAll(() => MainMenuPage());
      },
      textConfirm: "Play Again",
      confirmTextColor: Colors.white,
      content: Container(),
      onConfirm: () {
        Get.back();
      },
    );
  }
}
