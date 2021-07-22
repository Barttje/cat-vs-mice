import 'dart:math';

import 'package:cat_vs_mice/app/pages/board/model/ai_settings.dart';
import 'package:cat_vs_mice/app/pages/board/model/checker.dart';
import 'package:cat_vs_mice/app/pages/board/model/coordinate.dart';
import 'package:cat_vs_mice/app/pages/board/model/game_logic.dart';
import 'package:cat_vs_mice/app/pages/board/model/player_type.dart';
import 'package:cat_vs_mice/app/pages/board/service/move.dart';
import 'package:cat_vs_mice/app/pages/board/service/node.dart';
import 'package:cat_vs_mice/app/pages/board/service/result.dart';

class AIService {
  final AISettings? settings;

  AIService(this.settings);

  Coordinate nextMove(List<Checker> state) {
    GameLogic.playerWon(state);
    return Coordinate(0, 1);
  }

  Result minimax(Node node, int depth, bool maximizingPlayer) {
    final winner = GameLogic.playerWon(node.checkers);
    if (depth == 0 || winner != null) {
      return computeScore(winner);
    }
    if (maximizingPlayer) {
      int value = -1000;
      Iterable<Move> moves = computeCatMoves(node);
      Move? bestmove;
      for (var move in moves) {
        var result =
            minimax(node.copy(move), depth - 1, !maximizingPlayer).value;
        if (result > value) {
          value = result;
          bestmove = move;
        }
      }
      return Result(bestmove, value);
    } else {
      int value = 1000;
      List<Move> moves = computeMiceMoves(node);
      Move? bestmove;
      for (var move in moves) {
        var result =
            minimax(node.copy(move), depth - 1, !maximizingPlayer).value;
        if (result < value) {
          value = result;
          bestmove = move;
        }
      }
      return Result(bestmove, value);
    }
  }

  List<Move> computeMiceMoves(Node node) {
    final mices =
        node.checkers.where((element) => element.type == PlayerType.MICE);
    final List<Move> moves = [];
    for (var mice in mices) {
      moves.addAll(GameLogic.possibleMoves(mice, node.checkers)
          .map((e) => Move(mice, e)));
    }
    return moves;
  }

  Iterable<Move> computeCatMoves(Node node) {
    final cat =
        node.checkers.firstWhere((element) => element.type == PlayerType.CAT);
    final moves =
        GameLogic.possibleMoves(cat, node.checkers).map((e) => Move(cat, e));
    return moves;
  }

  Result computeScore(PlayerType? winner) {
    if (winner == PlayerType.CAT) {
      return Result(null, 10);
    }
    if (winner == PlayerType.MICE) {
      return Result(null, -10);
    }
    return Result(null, 0);
  }

  Result alphaBeta(
      Node node, int depth, int alpha, int beta, bool maximizingPlayer) {
    final winner = GameLogic.playerWon(node.checkers);
    if (depth == 0 || winner != null) {
      return computeScore(winner);
    }
    if (maximizingPlayer) {
      int value = -1000;
      Iterable<Move> moves = computeCatMoves(node);
      Move? bestmove;
      for (var move in moves) {
        var result = alphaBeta(
                node.copy(move), depth - 1, alpha, beta, !maximizingPlayer)
            .value;
        if (result > value) {
          value = result;
          bestmove = move;
        }
        if (value > beta) {
          return Result(bestmove, value);
        }
        alpha = max(value, alpha);
      }
      return Result(bestmove, value);
    } else {
      int value = 1000;
      List<Move> moves = computeMiceMoves(node);
      Move? bestmove;
      for (var move in moves) {
        var result = alphaBeta(
                node.copy(move), depth - 1, alpha, beta, !maximizingPlayer)
            .value;
        if (result < value) {
          value = result;
          bestmove = move;
        }
        if (value < alpha) {
          return Result(bestmove, value);
        }
        beta = min(value, beta);
      }
      return Result(bestmove, value);
    }
  }
}
