import 'package:cat_vs_mice/app/pages/common/page.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultPage(Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                  maxLines: 12,
                  style: TextStyle(fontSize: 16),
                  overflow: TextOverflow.clip,
                ),
              ),
            ),
          ),
        ],
      ),
    ));
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
