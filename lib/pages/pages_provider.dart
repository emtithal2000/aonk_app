import 'package:aonk_app/pages/gift.dart';
import 'package:aonk_app/pages/page1.dart';
import 'package:aonk_app/pages/page2.dart';
import 'package:aonk_app/pages/page3.dart';
import 'package:aonk_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PagesProvider extends ChangeNotifier {
  var name = TextEditingController();
  var phone = TextEditingController();

  List<String> selected = [];
  List<Widget> pages = [
    const Page1(), //0
    const Gift(), //1
    const Page2(), //2
    const Page3(), //3
  ];

  var formKey = GlobalKey<FormState>();

  int currentPage = 0;
  String? image;

  void reset() {
    currentPage = 0;
    selected.clear();
    name.clear();
    phone.clear();
    image = null;
    notifyListeners();
  }

  void nextPage(bool isPersonal) {
    if (currentPage < pages.length - 1) {
      if (!isPersonal) {
        currentPage++;
      } else {
        currentPage = 2;
      }
    }

    notifyListeners();
  }

  Future<void> selectImage(bool isCamera) async {
    await ImagePicker()
        .pickImage(source: isCamera ? ImageSource.camera : ImageSource.gallery)
        .then((value) {
      if (value != null) {
        image = value.path;
      }
    }).whenComplete(() {});

    notifyListeners();
  }

  void addSelected(String donation) {
    selected.add(donation);

    notifyListeners();
  }

  void removeSelected(String donation) {
    selected.remove(donation);

    notifyListeners();
  }
}

Widget customButton(
    BuildContext context, PagesProvider provider, Function() onPressed) {
  return SizedBox(
    width: double.infinity,
    child: FloatingActionButton(
      onPressed: onPressed,
      child: Text(
        'التالي',
        style: TextStyle(
          fontSize: width(17),
          fontWeight: FontWeight.bold,
          fontFamily: 'Marhey',
        ),
      ),
    ),
  );
}
