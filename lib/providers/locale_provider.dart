import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class LocaleProvider extends ChangeNotifier {
  final _storage = GetStorage();
  final _key = 'locale';

  Locale get locale {
    String? savedLocale = _storage.read(_key);
    return savedLocale != null ? Locale(savedLocale) : const Locale('ar');
  }

  void setLocale(Locale locale) {
    _storage.write(_key, locale.languageCode);
    notifyListeners();
  }
}
