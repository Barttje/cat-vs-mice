import 'package:cat_vs_mice/app/pages/menu/main/model/menu_options.dart';
import 'package:cat_vs_mice/app/routing/routing_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final mainMenuViewModel = Provider<MainMenuViewModel>(
  (ref) => MainMenuViewModel(
    ref.watch(routingService),
  ),
);

class MainMenuViewModel {
  RoutingService _routingService;

  MainMenuViewModel(this._routingService);

  void toPage(MenuOption option) {
    switch (option) {
      case MenuOption.GAME:
        _routingService.toGameMenu();
        break;
      case MenuOption.ABOUT:
        _routingService.toAbout();
        break;
    }
  }
}
