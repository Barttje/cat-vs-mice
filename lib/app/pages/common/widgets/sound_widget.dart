import 'package:cat_vs_mice/app/pages/common/providers/sound_controller.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SoundWidget extends HookWidget {
  const SoundWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final enabled = useProvider(soundController);
    final controller = useProvider(soundController.notifier);
    return IconButton(
      onPressed: () => controller.toggle(),
      icon: Icon(enabled == true ? Icons.music_note_sharp : Icons.music_off),
    );
  }
}
