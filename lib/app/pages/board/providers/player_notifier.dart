import 'package:cat_vs_mice/app/pages/board/model/checker.dart';
import 'package:cat_vs_mice/app/pages/board/model/coordinate.dart';
import 'package:cat_vs_mice/app/pages/board/model/player_type.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:collection/collection.dart';

class PlayerNotifier extends StateNotifier<PlayerType> {
  PlayerNotifier(PlayerType state) : super(state);

  void initialize() {
    state = PlayerType.MICE;
  }

  void updatePlayer() {
    state = state == PlayerType.MICE ? PlayerType.CAT : PlayerType.MICE;
  }

  PlayerType getPlayer() {
    return state;
  }
}
