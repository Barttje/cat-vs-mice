import 'package:cat_vs_mice/app/pages/board/model/player_type.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PlayerNotifier extends StateNotifier<PlayerType> {
  PlayerNotifier(PlayerType state) : super(state);

  void initialize() {
    state = PlayerType.CAT;
  }

  void updatePlayer() {
    state = state == PlayerType.MICE ? PlayerType.CAT : PlayerType.MICE;
  }

  PlayerType getPlayer() {
    return state;
  }
}
