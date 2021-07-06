import 'package:cat_vs_mice/app/pages/board/model/ai_settings.dart';
import 'package:cat_vs_mice/app/pages/board/model/checker.dart';
import 'package:cat_vs_mice/app/pages/board/model/coordinate.dart';
import 'package:cat_vs_mice/app/pages/board/model/player_type.dart';
import 'package:cat_vs_mice/app/pages/board/providers/checkers_notifier.dart';
import 'package:cat_vs_mice/app/pages/board/providers/player_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _currentPlayer = StateNotifierProvider<PlayerNotifier, PlayerType>(
    (ref) => PlayerNotifier(PlayerType.MICE));
final _checkers = StateNotifierProvider<CheckerNotifier, List<Checker>>(
    (ref) => CheckerNotifier([]));

final currentPlayer = Provider((ref) => ref.watch(_currentPlayer));
final checkers = Provider((ref) => ref.watch(_checkers));
final boardGameViewModel = Provider<BoardViewModel>((ref) => BoardViewModel(
    ref.watch(_checkers.notifier), ref.watch(_currentPlayer.notifier)));

class BoardViewModel {
  CheckerNotifier checkersStateNotifier;
  PlayerNotifier playerNotifier;

  BoardViewModel(this.checkersStateNotifier, this.playerNotifier);

  void initialize(AISettings? aiSettings) {
    checkersStateNotifier.initialize();
    playerNotifier.initialize();
  }

  void startDrag(Checker selectedChecker) {
    checkersStateNotifier.startDrag(selectedChecker);
  }

  void cancelDrag(Checker selectedChecker) {
    checkersStateNotifier.cancelDrag(selectedChecker);
  }

  void finishDrag(Checker selectedChecker, Coordinate coordinate) {
    checkersStateNotifier.finishDrag(selectedChecker, coordinate);
    playerNotifier.updatePlayer();
  }
}
