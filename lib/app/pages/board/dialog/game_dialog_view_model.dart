import 'package:cat_vs_mice/app/pages/board/model/ai_settings.dart';
import 'package:cat_vs_mice/app/pages/board/model/checker.dart';
import 'package:cat_vs_mice/app/pages/board/model/coordinate.dart';
import 'package:cat_vs_mice/app/pages/board/model/game_logic.dart';
import 'package:cat_vs_mice/app/pages/board/model/player_type.dart';
import 'package:cat_vs_mice/app/pages/board/providers/checkers_notifier.dart';
import 'package:cat_vs_mice/app/pages/board/providers/player_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/route_manager.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _currentPlayer = StateNotifierProvider<PlayerNotifier, PlayerType>(
    (ref) => PlayerNotifier(PlayerType.MICE));
final _checkers = StateNotifierProvider<CheckerNotifier, List<Checker>>(
    (ref) => CheckerNotifier([]));

final currentPlayer = Provider((ref) => ref.watch(_currentPlayer));
final checkers = Provider((ref) => ref.watch(_checkers));
final boardGameViewModel = Provider<BoardViewModel>(
  (ref) => BoardViewModel(ref.watch(_checkers.notifier),
      ref.watch(_currentPlayer.notifier), ref.read),
);

class BoardViewModel {
  Reader _read;
  CheckerNotifier checkersStateNotifier;
  PlayerNotifier playerNotifier;

  BoardViewModel(this.checkersStateNotifier, this.playerNotifier, this._read);

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
    if (coordinate != selectedChecker.coordinate) {
      playerNotifier.updatePlayer();
      checkersStateNotifier.finishDrag(selectedChecker, coordinate);
      if (GameLogic.playerWon(_read(checkers)) != null) {
        Get.defaultDialog(
          title: "Won",
          textCancel: "Back to menu",
          onCancel: () {
            Get.back();
            Get.back();
          },
          textConfirm: "Play Again",
          confirmTextColor: Colors.white,
          content: Container(),
          onConfirm: () {
            initialize(null);
            Get.back();
          },
        );
      }
    }
  }

  bool canMoveTo(Checker selectedChecker, Coordinate coordinate) {
    if (selectedChecker.type != _read(currentPlayer)) {
      return false;
    }
    return GameLogic.possibleMoves(selectedChecker, _read(checkers))
        .any((c) => c == coordinate);
  }
}
