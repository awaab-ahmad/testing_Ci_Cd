import 'package:flutter/material.dart';

class StateManage extends ChangeNotifier {
  String name = 'Awaab Ahmad';
  int age = 10;

  void changeValue(String nm, int ag) {
    age = ag;
    name = nm;
    notifyListeners();
  }

  Future<void> changeAsyncName(String nm) async {
    await Future.delayed(Duration(seconds: 1), () {
      name = nm;
    });
    notifyListeners();
  }
}
