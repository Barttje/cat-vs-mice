import 'package:flutter/material.dart';

class DefaultPage extends StatelessWidget {
  final Widget child;

  const DefaultPage(this.child);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cat vs Mice"),
      ),
      body: Container(child: child),
    );
  }
}
