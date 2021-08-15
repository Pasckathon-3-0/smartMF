import 'package:flutter/material.dart';

class StartProvider extends ChangeNotifier {
  bool isOn = false;

  changestatus() {
    isOn = !isOn;
    notifyListeners();
  }
}
