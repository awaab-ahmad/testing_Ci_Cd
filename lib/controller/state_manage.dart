import 'package:flutter/material.dart';

class StateManage extends ChangeNotifier {
  String name = 'Awaab Ahmad';
  int age = 10;


  void changeValue(String nm, int ag) {
    age = ag;
    name = nm;
    notifyListeners();
  }
}
