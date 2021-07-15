import 'package:cat_vs_mice/app/pages/board/model/player_type.dart';
import 'package:cat_vs_mice/app/pages/common/page.dart';
import 'package:cat_vs_mice/app/pages/menu/game/game_menu_view_model.dart';
import 'package:cat_vs_mice/app/pages/menu/game/widgets/difficulty_widget.dart';
import 'package:cat_vs_mice/app/pages/menu/game/widgets/error_widget.dart';
import 'package:cat_vs_mice/app/pages/menu/game/widgets/game_menu_buttons_widget.dart';
import 'package:cat_vs_mice/app/pages/menu/game/widgets/settings_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GameMenuPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    useEffect(() {
      Future.delayed(Duration.zero, () {
        context.read(gameMenuViewModel).initialize();
      });
    }, []);
    return DefaultPage(
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SettingsWidget(),
            GameMenuButtonsWidget(),
          ],
        ),
      ),
    );
  }
}
