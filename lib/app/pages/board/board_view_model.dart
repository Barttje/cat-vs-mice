import 'package:cat_vs_mice/app/pages/board/model/ai_settings.dart';
import 'package:cat_vs_mice/app/pages/board/model/checker.dart';
import 'package:cat_vs_mice/app/pages/board/model/coordinate.dart';
import 'package:cat_vs_mice/app/pages/board/model/game_logic.dart';
import 'package:cat_vs_mice/app/pages/board/model/player_type.dart';
import 'package:cat_vs_mice/app/pages/board/providers/checkers_notifier.dart';
import 'package:cat_vs_mice/app/pages/board/providers/player_notifier.dart';
import 'package:cat_vs_mice/app/routing/routing_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _currentPlayer = StateNotifierProvider<PlayerNotifier, PlayerType>(
    (ref) => PlayerNotifier(PlayerType.MICE));
final _checkers = StateNotifierProvider<CheckerNotifier, List<Checker>>(
    (ref) => CheckerNotifier([]));

final currentPlayer = Provider((ref) => ref.watch(_currentPlayer));
final checkers = Provider((ref) => ref.watch(_checkers));
final boardGameViewModel = Provider<BoardViewModel>(
  (ref) => BoardViewModel(ref.watch(_checkers.notifier),
      ref.watch(_currentPlayer.notifier), ref.watch(routingService)),
);

class BoardViewModel {
  RoutingService _routingService;
  CheckerNotifier _checkersStateNotifier;
  PlayerNotifier _playerNotifier;

  BoardViewModel(
      this._checkersStateNotifier, this._playerNotifier, this._routingService);

  void initialize(AISettings? aiSettings) {
    _checkersStateNotifier.initialize();
    _playerNotifier.initialize();
  }

  void startDrag(Checker selectedChecker) {
    _checkersStateNotifier.startDrag(selectedChecker);
  }

  void cancelDrag(Checker selectedChecker) {
    _checkersStateNotifier.cancelDrag(selectedChecker);
  }

  void finishDrag(Checker selectedChecker, Coordinate coordinate) {
    if (coordinate != selectedChecker.coordinate) {
      _playerNotifier.updatePlayer();
      _checkersStateNotifier.finishDrag(selectedChecker, coordinate);
      final winner = GameLogic.playerWon(_checkersStateNotifier.getCheckers());
      if (winner != null) {
        _checkersStateNotifier.initialize();
        _playerNotifier.initialize();
        _routingService.openPlayerDialog(winner);
      }
    }
  }

  bool canMoveTo(Checker selectedChecker, Coordinate coordinate) {
    if (selectedChecker.type != _playerNotifier.getPlayer()) {
      return false;
    }
    return GameLogic.possibleMoves(
            selectedChecker, _checkersStateNotifier.getCheckers())
        .any((c) => c == coordinate);
  }
}
