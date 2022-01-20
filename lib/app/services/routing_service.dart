import 'package:cat_vs_mice/app/pages/about/about_page.dart';
import 'package:cat_vs_mice/app/pages/board/board_page.dart';
import 'package:cat_vs_mice/app/pages/board/board_page_input.dart';
import 'package:cat_vs_mice/app/pages/board/model/ai_settings.dart';
import 'package:cat_vs_mice/app/pages/board/model/player_type.dart';
import 'package:cat_vs_mice/app/pages/menu/game/game_menu_page.dart';
import 'package:cat_vs_mice/app/pages/rules/rules_page.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final routingService = Provider<RoutingService>((ref) => RoutingService());

class RoutingService {
  void toBoardGame(AISettings? aiSettings) {
    Get.to(() => BoardPage(BoardPageInput(aiSettings)));
  }

  void toAbout() {
    Get.to(() => AboutPage());
  }

  void toGameMenu() {
    Get.to(() => GameMenuPage());
  }

  void toRules() {
    Get.to(() => RulesPage());
  }

  void openRulesDialog(AISettings? aiSettings) async {
    final confirmed = await Get.defaultDialog(
        middleText: "You can always click the info icon to read the rules.",
        textConfirm: "Yes",
        textCancel: "No",
        onConfirm: () {
          Get.back(result: true);
        },
        onCancel: () {
          Get.back(result: false);
        },
        title: "Do you want to go through the rules before you start?");
    if (confirmed == true) {
      toRules();
    } else {
      toBoardGame(aiSettings);
    }
  }

  void back() {
    Get.back();
  }

  void openPlayerDialog(PlayerType playerType) {
    String winner = playerType == PlayerType.MICE ? "Mice" : "Cat";
    Get.defaultDialog(
      title: "$winner won the game",
      textCancel: "Back to menu",
      onCancel: () {
        Get.offAll(() => GameMenuPage());
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
