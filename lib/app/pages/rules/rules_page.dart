import 'package:cat_vs_mice/app/pages/common/page.dart';
import 'package:cat_vs_mice/app/pages/rules/widgets/rules_step_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RulesPage extends StatefulWidget {
  const RulesPage({Key? key}) : super(key: key);

  @override
  _RulesPageState createState() => _RulesPageState();
}

class _RulesPageState extends State<RulesPage> {
  int _currentStep = 0;

  _stepState(int step) {
    if (_currentStep > step) {
      return StepState.complete;
    } else {
      return StepState.disabled;
    }
  }

  _steps() => [
        Step(
          title: const Text('Moves of the cat'),
          content: RulesStepWidget(
            image: "moves_cat",
            text: "The cat can move diagonally in each direction",
          ),
          state: _stepState(0),
          isActive: _currentStep == 0,
        ),
        Step(
          title: const Text('Goal of the cat'),
          content: RulesStepWidget(
            image: "win_cat",
            text: "The goal of the cat is to reach the other side",
          ),
          state: _stepState(1),
          isActive: _currentStep == 1,
        ),
        Step(
          title: const Text('Moves of the mice'),
          content: RulesStepWidget(
            image: "moves_mice",
            text: "The mice can also move diagonally, but only forward",
          ),
          state: _stepState(2),
          isActive: _currentStep == 2,
        ),
        Step(
          title: const Text('Goal of the mice'),
          content: RulesStepWidget(
            image: "win_mice",
            text: "The mice win when the cat cannot move",
          ),
          state: _stepState(3),
          isActive: _currentStep == 3,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return DefaultPage(
      Stepper(
        type: StepperType.vertical,
        controlsBuilder: (BuildContext context, ControlsDetails controls) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              children: <Widget>[
                if (_currentStep != 3)
                  ElevatedButton(
                    onPressed: controls.onStepContinue,
                    child: const Text('Next'),
                  ),
                if (_currentStep == 3)
                  ElevatedButton(
                    onPressed: controls.onStepContinue,
                    child: const Text('Got it'),
                  ),
                if (_currentStep != 0)
                  TextButton(
                    onPressed: controls.onStepCancel,
                    child: const Text(
                      'Back',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
              ],
            ),
          );
        },
        onStepTapped: (step) => setState(() => _currentStep = step),
        onStepContinue: () {
          setState(() {
            if (_currentStep < _steps().length - 1) {
              _currentStep += 1;
            } else {
              Get.back();
            }
          });
        },
        onStepCancel: () {
          setState(() {
            if (_currentStep > 0) {
              _currentStep -= 1;
            } else {
              _currentStep = 0;
            }
          });
        },
        currentStep: _currentStep,
        steps: _steps(),
      ),
    );
  }
}
