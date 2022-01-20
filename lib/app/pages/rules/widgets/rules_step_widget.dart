import 'package:flutter/material.dart';

class RulesStepWidget extends StatelessWidget {
  final String text;
  final String image;

  const RulesStepWidget({Key? key, required this.text, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text),
          SizedBox(height: 4,),
          Container(
            child: Image(image: AssetImage('assets/images/${image}.png')),
          ),
        ],
      ),
    );
  }
}
