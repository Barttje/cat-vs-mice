import 'package:cat_vs_mice/app/pages/board/model/checker.dart';
import 'package:cat_vs_mice/app/pages/board/model/coordinate.dart';
import 'package:cat_vs_mice/app/pages/board/model/game_logic.dart';
import 'package:cat_vs_mice/app/pages/board/model/move_command.dart';
import 'package:cat_vs_mice/app/pages/board/model/player_type.dart';
import 'package:cat_vs_mice/app/pages/board/providers/checkers_notifier.dart';
import 'package:cat_vs_mice/app/pages/board/providers/commands_notifier.dart';
import 'package:cat_vs_mice/app/pages/board/providers/player_notifier.dart';
import 'package:cat_vs_mice/app/pages/board/service/move_calculator.dart';
import 'package:cat_vs_mice/app/services/routing_service.dart';
import 'package:cat_vs_mice/app/services/sound_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _currentPlayer = StateNotifierProvider<PlayerNotifier, PlayerType>((ref) => PlayerNotifier(PlayerType.MICE));
final _checkers = StateNotifierProvider<CheckerNotifier, List<Checker>>((ref) => CheckerNotifier([]));

final currentPlayer = Provider((ref) => ref.watch(_currentPlayer));
final checkers = Provider((ref) => ref.watch(_checkers));

final _commands = StateNotifierProvider<CommandNotifier, List<MoveCommand>>((ref) => CommandNotifier([]));

final canPop = Provider((ref) => ref.watch(_commands).isNotEmpty);
final boardGameViewModel = Provider<BoardViewModel>(
  (ref) => BoardViewModel(ref.watch(_checkers.notifier), ref.watch(_currentPlayer.notifier),
      ref.watch(_commands.notifier), ref.watch(routingService), ref.watch(soundService)),
);

class BoardViewModel {
  RoutingService _routingService;
  CheckerNotifier _checkersStateNotifier;
  PlayerNotifier _playerNotifier;
  CommandNotifier _commandNotifier;
  SoundService _soundService;
  MoveCalculator? moveCalculator;
  bool aiWillPlayMove = false;

  BoardViewModel(this._checkersStateNotifier, this._playerNotifier, this._commandNotifier, this._routingService,
      this._soundService);

  void initialize(MoveCalculator? moveCalculator) {
    _checkersStateNotifier.initialize();
    _playerNotifier.initialize();
    _commandNotifier.initialize();
    if (moveCalculator != null) {
      this.moveCalculator = moveCalculator;
      if (moveCalculator.getPlayerType() == PlayerType.CAT) {
        aiWillPlayMove = true;
        Future.delayed(Duration(milliseconds: 750), () {
          aiWillPlayMove = false;
          _executeCommand(moveCalculator.computeMove(_checkersStateNotifier.getCheckers()));
        });
      }
    }
  }

  void startDrag(Checker selectedChecker) {
    _checkersStateNotifier.startDrag(selectedChecker);
  }

  void cancelDrag(Checker selectedChecker) {
    _checkersStateNotifier.cancelDrag(selectedChecker);
  }

  void restart() {
    initialize(null);
  }

  void finishDrag(Checker selectedChecker, Coordinate coordinate) {
    if (coordinate != selectedChecker.coordinate) {
      _executeCommand(MoveCommand(selectedChecker.id, selectedChecker.coordinate, coordinate));
    }
  }

  void _executeCommand(MoveCommand move) {
    _soundService.playMoveSound();
    _playerNotifier.updatePlayer();
    _checkersStateNotifier.move(
        _checkersStateNotifier.getCheckers().firstWhere((element) => element.id == move.checkerId), move.to);
    _commandNotifier.push(move);
    checkWinningConditions();
    moveAIIfNeeded();
  }

  void moveAIIfNeeded() {
    if (moveCalculator != null && moveCalculator!.getPlayerType() == _playerNotifier.getPlayer()) {
      aiWillPlayMove = true;
      Future.delayed(
        Duration(milliseconds: 750),
        () {
          _executeCommand(moveCalculator!.computeMove(_checkersStateNotifier.getCheckers()));
          aiWillPlayMove = false;
        },
      );
    }
  }

  void checkWinningConditions() {
    final winner = GameLogic.playerWon(_checkersStateNotifier.getCheckers());
    if (winner != null) {
      if (moveCalculator?.getPlayerType() == winner) {
        _soundService.playLoseSound();
      } else {
        _soundService.playWinSound();
      }
      initialize(null);
      _routingService.openPlayerDialog(winner);
    }
  }

  void aiMove() {
    if (moveCalculator != null && moveCalculator!.getPlayerType() == _playerNotifier.getPlayer()) {
      _executeCommand(moveCalculator!.computeMove(_checkersStateNotifier.getCheckers()));
    }
  }

  void undo() {
    final moveCommand = _commandNotifier.pop();
    if (moveCommand != null) {
      _playerNotifier.updatePlayer();
      _checkersStateNotifier.move(
          _checkersStateNotifier.getCheckers().firstWhere((element) => element.id == moveCommand.checkerId),
          moveCommand.from);
    }
  }

  bool canMoveTo(Checker selectedChecker, Coordinate coordinate) {
    if (selectedChecker.type != _playerNotifier.getPlayer()) {
      return false;
    }
    return GameLogic.possibleMoves(selectedChecker, _checkersStateNotifier.getCheckers()).any((c) => c == coordinate);
  }
}
