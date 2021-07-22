import 'package:cat_vs_mice/app/pages/board/model/move_command.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:collection/collection.dart';

class CommandNotifier extends StateNotifier<List<MoveCommand>> {
  CommandNotifier(List<MoveCommand> state) : super(state);

  void initialize() {
    state = [];
  }

  MoveCommand? pop() {
    if (state.isEmpty) {
      return null;
    }
    final command = state.last;
    state = state.whereNot((element) => element == command).toList();
    return command;
  }

  void push(MoveCommand command) {
    state = [...state, command];
  }
}
