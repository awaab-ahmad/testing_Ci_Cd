import 'dart:math';

import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/foundation.dart';

class LogicCheckingWork extends StatefulWidget {
  const new({super.key});

  @override
  State<LogicCheckingWork> createState() => _LogicCheckingWorkState();
}

class _LogicCheckingWorkState extends State<LogicCheckingWork> {
  late Random value;
  late int valueToGuess;
  late TextEditingController valueField;

  @override
  void initState() {
    super.initState();
    value = Random();
    valueToGuess = value.nextInt(10);
    valueField = TextEditingController();
    if (kDebugMode) print(value);
  }

  @override
  void dispose() {
    super.dispose();
    valueField.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: .start,
          children: [
            const SizedBox(height: 10),
            Text('Hello, Guess the Number in your mind'),
            Text('Enter a number between 0 to 10 to guess'),
            const SizedBox(height: 20),
            TextField(
              controller: valueField,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly                
              ],
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Enter value 0 - 10'),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  checkValue();                
                },
                child: Text('Evaluate'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void checkValue() {
    if (valueField.text.trim().isEmpty) return;
    final receivedValue = double.tryParse(valueField.text.trim());    
    final userValue = receivedValue?.toInt();    
    if(userValue == null) {
      if(kDebugMode) print('Value\'s format is not right');
      return;
    }
    if(kDebugMode) print(userValue);
    if (userValue == valueToGuess) {
      if (kDebugMode) print('Value matched');
      return;
    } else if (userValue != valueToGuess) {
      if (kDebugMode) print('Not right value, please re-enter another');
      return;
    }
  }
}
