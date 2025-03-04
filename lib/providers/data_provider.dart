import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier {
  String text = '';

  void updateText(String newText) {
    text = newText;
    notifyListeners();
  }
}
