import 'dart:developer';

import 'package:aonk_app/models/charities_model.dart';
import 'package:aonk_app/size_config.dart';
import 'package:aonk_app/sub_pages/donation_details.dart';
import 'package:aonk_app/sub_pages/donation_images.dart';
import 'package:aonk_app/sub_pages/donation_type.dart';
import 'package:aonk_app/sub_pages/gift.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

Widget customButton(BuildContext context, PagesProvider provider,
    Function() onPressed, String title) {
  return SizedBox(
    width: double.infinity,
    height: height(40),
    child: FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: const Color(0xFF81bdaf),
      child: Text(
        title,
        style: TextStyle(
          fontSize: width(15),
          fontFamily: 'Marhey',
        ),
      ),
    ),
  );
}

class PagesProvider extends ChangeNotifier {
  List<String> selected = [];
  List<Charity> charities = [];
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

  String msg = '';

  void addSelected(String donation) {
    selected.add(donation);

    notifyListeners();
  }

  String changer(String country) {
    String result = '';
    switch (country) {
      case 'قطر':
        result = 'Qatar';
        break;
      case 'الكويت':
        result = 'Kuwait';
        break;
      default:
        result = 'Oman';
        break;
    }
    return result;
  }

  void clearCharities() {
    charities.clear();
    notifyListeners();
  }

  Future<void> getCharities() async {
    final country = changer(GetStorage().read('userData')['country']);

    try {
      final response = await Dio().get(
        'https://api.aonk.app/charities_mobile?country=$country',
      );

      if (response.statusCode == 200) {
        final List<dynamic> charitiesJson = response.data['charities_mobile'];
        charities =
            charitiesJson.map((json) => Charity.fromJson(json)).toList();
      }
    } on DioException catch (e) {
      log(e.response?.data.toString() ?? 'No response data');
      msg = e.response?.data;
    }
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
      final storage = GetStorage().read('userData');
      final imageBytes = await image!.readAsBytes();

      final formData = FormData.fromMap({
        "charity_name": selectedCharity,
        "donation_types": selected,
        "donation_image": MultipartFile.fromBytes(imageBytes,
            filename: 'image_${image?.path.split('/').last}.jpg'),
        "country": storage['country'],
        "city": storage['city'],
        "name": storage['name'],
        "phone": storage['phone'],
        "email": storage['email'],
        "street": storage['street'],
        "building": storage['building'],
        "gift": isGift,
        "gift_name": controllers[5].text,
        "gift_phone": controllers[6].text,
      });

      log(formData.toString());
      // Uncomment and update the API endpoint when ready
      // await Dio().post(
      //   'https://api.aonk.app/customer_donations',
      //   data: formData,
      //   options: Options(
      //     headers: {
      //       'Content-Type': 'multipart/form-data',
      //     },
      //   ),
      // );
      log('Donation posted successfully');
    } on DioException catch (e) {
      log(e.response?.data.toString() ?? 'No response data');
      msg = e.response?.data;
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

  void resetSelected() {
    selectedCity = null;
    notifyListeners();
  }

  resetValues() {
    selectedCity = null;
    selectedCountry = null;
    for (int x = 0; x < 5; x++) {
      controllers[x].clear();
    }
    clearCharities();
    notifyListeners();
  }

  Future<void> selectImage(bool isCamera) async {
    await ImagePicker()
        .pickImage(
      source: isCamera ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 50,
    )
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
