import 'package:cat_vs_mice/app/pages/board/board_page.dart';
import 'package:cat_vs_mice/app/pages/board/board_view_model.dart';
import 'package:cat_vs_mice/app/routing/routing_service.dart';
import 'package:get/route_manager.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final mainMenuViewModel = Provider<MainMenuViewModel>(
    (ref) => MainMenuViewModel(ref.watch(routingService)));

class MainMenuViewModel {
  RoutingService _routingService;
  MainMenuViewModel(this._routingService);

  void toBoardGame() {
    _routingService.toBoardGame();
  }
}
