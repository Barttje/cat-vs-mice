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
      padding: EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.brown[200]!,
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Current Player",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              width: 6,
            ),
            Icon(
              Icons.circle,
              color: player == PlayerType.MICE ? Colors.black : Colors.white,
              size: 35,
            ),
          ],
        ),
      ),
    );
  }
}
