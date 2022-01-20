import 'package:cat_vs_mice/app/pages/common/providers/sound_controller.dart';
import 'package:cat_vs_mice/app/pages/common/widgets/sound_widget.dart';
import 'package:cat_vs_mice/app/services/routing_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DefaultPage extends HookWidget {
  final Widget child;

  const DefaultPage(this.child);

  @override
  Widget build(BuildContext context) {
    final routing = useProvider(routingService);
    return Scaffold(
      appBar: AppBar(
        title: Text("Cat vs Mice"),
        actions: [SoundWidget(),
        IconButton(
          icon: Icon(Icons.info),
          onPressed: () => routing.toRules(),
        )],
      ),
      body: Container(child: child),
    );
  }
}
