import 'package:cat_vs_mice/app/pages/about/about_page.dart';
import 'package:cat_vs_mice/app/pages/board/board_page.dart';
import 'package:cat_vs_mice/app/pages/board/board_view_model.dart';
import 'package:cat_vs_mice/app/pages/menu/game/game_menu_page.dart';
import 'package:cat_vs_mice/app/pages/settings/settings_page.dart';
import 'package:get/route_manager.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final routingService =
    Provider<RoutingService>((ref) => RoutingService(ref.read));

class RoutingService {
  Reader _read;
  RoutingService(this._read);

  void toBoardGame() {
    _read(boardGameViewModel).initialize(null);
    Get.to(() => BoardPage());
  }

  void toSettings() {
    Get.to(() => SettingsPage());
  }

  void toAbout() {
    Get.to(() => AboutPage());
  }

  void toGameMenu() {
    Get.to(() => GameMenuPage());
  }
}
