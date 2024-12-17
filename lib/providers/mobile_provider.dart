import 'package:flutter/material.dart';

class MobileProvider extends ChangeNotifier {
  String? selectedCity;
  String? selectedCountry;

  List<int> selectedItems = [];

  final formKey = GlobalKey<FormState>();

  void setCity(String city) {
    selectedCity = city;
    notifyListeners();
  }

  void setCountry(String country) {
    selectedCountry = country;
    notifyListeners();
  }

  void toggleSelectedItem(int index) {
    if (selectedItems.contains(index)) {
      selectedItems.remove(index);
    } else {
      selectedItems.add(index);
    }
    notifyListeners();
  }
}
