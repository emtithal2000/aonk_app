import 'package:flutter/material.dart';

class DialogPageProvider extends ChangeNotifier {
  int _currentIndex = 0;
  int _selectedIndex = 0;
  String button = 'التالي';

  int get currentIndex => _currentIndex;
  int get selectedIndex => _selectedIndex;

  set selectedIndex(int value) {
    _selectedIndex = value;
    notifyListeners();
  }

  void nextPage() {
    _currentIndex++;
    notifyListeners();
  }

  void reset() {
    _currentIndex = 0;
    notifyListeners();
  }
}
