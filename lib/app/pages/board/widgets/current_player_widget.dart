import 'package:cat_vs_mice/app/pages/board/board_view_model.dart';
import 'package:cat_vs_mice/app/pages/board/model/player_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CurrentPlayerWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final player = useProvider(currentPlayer);
    return Container(
      color: Colors.brown[100]!,
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Current Player",
            style: TextStyle(fontSize: 16),
          ),
          Icon(
            Icons.circle,
            color: player == PlayerType.MICE ? Colors.black : Colors.white,
            size: 35,
          ),
        ],
      ),
    );
  }
}
