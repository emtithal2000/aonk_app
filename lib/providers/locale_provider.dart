import 'package:aonk_app/providers/pages_provider.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class LocaleProvider extends ChangeNotifier {
  final _storage = GetStorage();
  final _key = 'locale';

  Locale get locale {
    String? savedLocale = _storage.read(_key);
    return savedLocale != null ? Locale(savedLocale) : const Locale('ar');
  }

  void setLocale(Locale locale, BuildContext context) {
    _storage.write(_key, locale.languageCode);
    Provider.of<PagesProvider>(context, listen: false).selectedCity = null;
    notifyListeners();
  }
}
