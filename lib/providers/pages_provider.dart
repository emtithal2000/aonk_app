import 'dart:developer';

import 'package:aonk_app/models/customer_model.dart';
import 'package:aonk_app/size_config.dart';
import 'package:aonk_app/sub_pages/donation_details.dart';
import 'package:aonk_app/sub_pages/donation_images.dart';
import 'package:aonk_app/sub_pages/donation_type.dart';
import 'package:aonk_app/sub_pages/gift.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

Widget customButton(
    BuildContext context, PagesProvider provider, Function() onPressed) {
  return SizedBox(
    width: double.infinity,
    child: FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: const Color(0xFF81bdaf),
      child: Text(
        'التالي',
        style: TextStyle(
          fontSize: width(15),
          fontWeight: FontWeight.bold,
          fontFamily: 'Marhey',
        ),
      ),
    ),
  );
}

class PagesProvider extends ChangeNotifier {
  List<String> selected = [];
  List<Widget> pages = [
    const DonationType(), //0
    const Gift(), //1
    const DonationDetails(), //2
    const DonationImages(), //3
  ];
  var controllers = List.generate(7, (index) => TextEditingController());
  var pageController = PageController();
  var formKey = GlobalKey<FormState>();
  final loginKey = GlobalKey<FormState>();

  int currentPage = 0;
  int pageIndex = 0;

  XFile? image;
  String? selectedCity;
  String? selectedCountry;
  String? selectedCharity;
  String? selectedDonationType;
  String? selectedGiftName;
  String? selectedGiftPhone;
  bool isGift = false;

  List<CustomerModel> customerModel = [];

  void addSelected(String donation) {
    selected.add(donation);

    notifyListeners();
  }

  void jumpToPage(int page) {
    pageIndex = page;
    pageController.jumpToPage(page);
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

  Future<void> postDonation() async {
    try {
      final imageBytes = await image!.readAsBytes();

      final formData = FormData.fromMap({
        "charity_name": selectedCharity,
        "donation_type": selectedDonationType,
        "gift": isGift,
        "gift_name": controllers[5].text,
        "gift_phone": controllers[6].text,
        "donation_list": selected,
        "donation_image": MultipartFile.fromBytes(imageBytes,
            filename: 'image_${image?.path.split('/').last}.jpg'),
        "date": DateFormat('dd-MM-yyyy').format(DateTime.now()),
        "country": selectedCountry,
        "city": selectedCity,
        "name": controllers[0].text,
        "phone": controllers[1].text,
        "email": controllers[2].text,
        "street": controllers[3].text,
        "building": controllers[4].text
      });

      log(formData.fields.toString());

      // await Dio().post(
      //   'https://fb32a2d4-9e60-45f3-af24-4c51c4aa3df6-00-2iorkf0oozeaq.janeway.replit.dev/customer_donations',
      //   data: formData,
      //   options: Options(
      //     headers: {
      //       'Content-Type': 'multipart/form-data',
      //     },
      //   ),
      // );
    } catch (e) {
      log(e.toString());
    }
  }

  void removeSelected(String donation) {
    selected.remove(donation);

    notifyListeners();
  }

  void reset() {
    currentPage = 0;
    selected.clear();
    // name.clear();
    // phone.clear();
    image = null;
    notifyListeners();
  }

  Future<void> selectImage(bool isCamera) async {
    await ImagePicker()
        .pickImage(source: isCamera ? ImageSource.camera : ImageSource.gallery)
        .then((value) {
      if (value != null) {
        image = value;
      }
    }).whenComplete(() {});

    notifyListeners();
  }

  void setCharity(String charity) {
    selectedCharity = charity;
    notifyListeners();
  }

  void setCity(String city) {
    selectedCity = city;
    notifyListeners();
  }

  void setCountry(String country) {
    selectedCountry = country;
    notifyListeners();
  }

  void setDonationType(String donationType) {
    selectedDonationType = donationType;
    notifyListeners();
  }

  void setGift() {
    isGift = !isGift;
    notifyListeners();
  }
}
