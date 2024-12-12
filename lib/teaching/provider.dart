import 'package:aonk_app/teaching/page1.dart';
import 'package:aonk_app/teaching/page2.dart';
import 'package:aonk_app/teaching/page3.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget buildCard(String path) {
  return Builder(
    builder: (context) {
      return GestureDetector(
        onTap: () {
          Provider.of<PageProvider>(context, listen: false).nextPage();
        },
        child: Container(
          height: 100,
          width: 100,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 7,
                spreadRadius: 0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Image.asset(
            'assets/images/$path.png',
          ),
        ),
      );
    },
  );
}

Widget buildInput(String hint) {
  return Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 15,
    ),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: const [
        BoxShadow(
          color: Colors.grey,
          blurRadius: 5,
          spreadRadius: 0,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: TextField(
      textDirection: TextDirection.rtl,
      decoration: InputDecoration(
        hintText: hint,
        hintTextDirection: TextDirection.rtl,
        border: InputBorder.none,
      ),
    ),
  );
}

class PageProvider extends ChangeNotifier {
  int pageIndex = 0;

  List<Widget> pages = [
    const Page1(),
    const Page2(),
    const Page3(),
  ];

  void nextPage() {
    if (pageIndex < pages.length - 1) {
      pageIndex++;
      notifyListeners();
    }
  }
}
