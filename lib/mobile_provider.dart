import 'package:flutter/material.dart';

class MobileProvider extends ChangeNotifier {
  final TextEditingController mobileController = TextEditingController();
  final List<TextEditingController> personalInfoControllers = [];

  String? selectedCity;
  String? selectedCountry;

  int _selectedIndex = 0;
  final List<int> selectedItems = [];

  int _selectedAssociationIndex = 0;
  int get selectedAssociationIndex => _selectedAssociationIndex;

  int get selectedIndex => _selectedIndex;

  void setCity(String city) {
    selectedCity = city;
    notifyListeners();
  }

  void setCountry(String country) {
    selectedCountry = country;
    notifyListeners();
  }

  void setPersonalInfo(int index, String value) {
    personalInfoControllers[index].text = value;
    notifyListeners();
  }

  void setSelectedAssociationIndex(int index) {
    _selectedAssociationIndex = index;
    notifyListeners();
  }

  void setSelectedIndex(int index) {
    _selectedIndex = index;
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
