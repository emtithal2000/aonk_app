import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class ThemeProvider extends ChangeNotifier {
  final _storage = GetStorage();
  final _key = 'isDarkMode';

  bool get isDarkMode => _storage.read(_key) ?? false;

  ThemeMode get themeMode => isDarkMode ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _storage.write(_key, !isDarkMode);
    notifyListeners();
  }
} 