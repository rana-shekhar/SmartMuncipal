import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier {
  String text = '';

  void updateText(String newText) {
    text = newText;
    notifyListeners();
  }

  List<String> items = [
    'ward 1',
    'ward 2',
    'ward 3', 
    'ward 4',
    'ward 5',   
    'ward 6',
    'ward 7',
  ];
void updateItems(List<String> newItems) {
    items = newItems;
    notifyListeners();
  }
}
