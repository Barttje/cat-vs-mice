import 'package:flutter/material.dart';

class GameMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MenuItem("One Player"),
          MenuItem("Two Players"),
          MenuItem("Tutorial"),
          MenuItem("About"),
        ],
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String name;

  const MenuItem(this.name, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => {},
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            name,
            style: TextStyle(fontSize: 18),
          ),
        ));
  }
}
