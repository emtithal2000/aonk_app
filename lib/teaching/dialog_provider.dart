import 'package:flutter/material.dart';

class DialogProvider extends ChangeNotifier {
  int currentIndex = 0;
  String button = 'Next';

  void nextPage() {
    if (currentIndex < title.length - 1) {
      currentIndex++;
      if (currentIndex == 2) {
        button = 'تأكيد';
      }
      notifyListeners();
    }
  }

  List<String> title = [
    'إختر نوع التبرع', //0
    'إختر طريقة التبرع', //1
    'إختر نوع الوسيلة', //2
  ];

  List<Widget> pages = [
    //TODO: call them here
  ];
}
