import 'package:cat_vs_mice/app/pages/board/board_view_model.dart';
import 'package:cat_vs_mice/app/pages/board/model/player_type.dart';
import 'package:cat_vs_mice/app/pages/board/widgets/current_player_widget.dart';
import 'package:cat_vs_mice/app/pages/board/widgets/restart_widget.dart';
import 'package:cat_vs_mice/app/pages/board/widgets/undo_move_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OptionsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 1, child: Container()),
        RestartWidget(),
        UndoMoveWidget(),
        CurrentPlayerWidget(),
        Expanded(flex: 1, child: Container()),
      ],
    );
  }
}
