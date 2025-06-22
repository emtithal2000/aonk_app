import 'dart:developer';

import 'package:aonk_app/models/charities_model.dart';
import 'package:aonk_app/models/countries_model.dart';
import 'package:aonk_app/models/country_details_model.dart';
import 'package:aonk_app/providers/locale_provider.dart';
import 'package:aonk_app/size_config.dart';
import 'package:aonk_app/static_values.dart' as staticvalues;
import 'package:aonk_app/sub_pages/donation_details.dart';
import 'package:aonk_app/sub_pages/donation_images.dart';
import 'package:aonk_app/sub_pages/donation_type.dart';
import 'package:aonk_app/sub_pages/gift.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher_string.dart';

Widget customButton(Function() onPressed, String title) {
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
          color: Colors.white,
        ),
      ),
    ),
  );
}

class PagesProvider extends ChangeNotifier {
  List<String> selected = [];
  List<Charity> charities = [];
  List<Countries> countries = [];
  DetailedCountry? detailedCountry;
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
  String? locationData;
  bool isGift = false;

  PagesProvider() {
    getCountries();
  }

  void addSelected(String donation) {
    selected.add(donation);
    notifyListeners();
  }

  Future<void> callAonk() async {
    final number = detailedCountry?.phone;
    await launchUrlString("tel://$number");
  }

  void clearCharities() {
    charities.clear();
    notifyListeners();
  }

  Future<void> getCharities() async {
    final country = GetStorage().read('userData')['country'];
    final userPlace = GetStorage().read('userData')['city'];

    try {
      final response = await Dio().get(
        'https://api.aonk.app/charities_mobile?country=$country&place=$userPlace',
      );

      if (response.statusCode == 200) {
        final List<dynamic> charitiesJson = response.data['charities_mobile'];
        charities =
            charitiesJson.map((json) => Charity.fromJson(json)).toList();
      }
    } on DioException catch (e) {
      log(e.response?.data.toString() ?? 'No response data');
    }
    notifyListeners();
  }

  Future<void> getCountries() async {
    try {
      await Dio().get('https://api.aonk.app/countries').then((value) {
        var data = value.data['countries'] as List;
        countries = data
            .map((e) => Countries.fromJson(e as Map<String, dynamic>))
            .toList();
      });
    } on DioException catch (e) {
      log(e.response?.data.toString() ?? 'Error');
    }
    notifyListeners();
  }

  List<String> getCitiesForCountry(String? country, BuildContext context) {
    switch (country) {
      case 'سلطنة عمان':
        country = 'Oman';
        break;
      case 'قطر':
        country = 'Qatar';
    }
    if (country == null) return [];
    final locale = Localizations.localeOf(context);
    final cities =
        staticvalues.countryCities[country]?[locale.languageCode] ?? [];
    return cities;
  }

  Future<void> getDetailedCountry() async {
    final country = GetStorage().read('userData')['country'];

    try {
      final response = await Dio().get(
        'https://api.aonk.app/country_details?country=$country',
      );

      if (response.statusCode == 200) {
        var charitiesJson = response.data['country_details'][0];
        detailedCountry = DetailedCountry.fromJson(charitiesJson);
      }
    } on DioException catch (e) {
      log(e.response?.data.toString() ?? 'No response data');
    }
  }

  List<String> getLocalizedCountryNames(BuildContext context) {
    final locale = Localizations.localeOf(context);
    return staticvalues.countryNames.keys
        .map((country) =>
            staticvalues.countryNames[country]![locale.languageCode]!)
        .toList();
  }

  String? getPhoneCodeForCountry(String? country) {
    if (country == null) return '';
    if (country == 'سلطنة عمان') return '+968';
    if (country == 'قطر') return '+974';
    return staticvalues.countryPhoneCodes[country] ?? '';
  }

  String getLocalizedCityName(Cities city) {
    return LocaleProvider().locale.languageCode == 'ar'
        ? city.cityAr!
        : city.cityEn!;
  }

  String getLocalizedCountryName(String countryCode, BuildContext context) {
    final locale = Localizations.localeOf(context);
    final isArabic = locale.languageCode == 'ar';

    // Find the country in the countries list
    final country = countries.firstWhere(
      (c) => c.country?.countryEn?.toUpperCase() == countryCode.toUpperCase(),
      orElse: () => Countries(),
    );

    if (country.country != null) {
      return isArabic
          ? (country.country!.countryAr ??
              country.country!.countryEn ??
              countryCode)
          : (country.country!.countryEn ?? countryCode);
    }

    // Fallback for hardcoded cases
    switch (countryCode.toUpperCase()) {
      case 'OM':
        return isArabic ? 'سلطنة عُمان' : 'Oman';
      case 'QR':
        return isArabic ? 'قطر' : 'Qatar';
      default:
        return countryCode;
    }
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
      final formDataMap = {
        "charity_name": selectedCharity,
        "types": selected,
        "country": storage['country'],
        "city": storage['city'],
        "name": storage['name'],
        "phone": storage['phone'],
        "email": storage['email'],
        "street": storage['street'],
        "building": storage['building'],
        "gift": isGift,
        "location": storage['location'],
        "gift_name": controllers[5].text,
        "gift_phone": controllers[6].text,
        "created_by": storage['name'],
        "request_date": DateTime.now(),
      };

      // Only add image if it exists
      if (image != null) {
        final imageBytes = await image!.readAsBytes();
        formDataMap["donation_image"] = MultipartFile.fromBytes(
          imageBytes,
          filename: 'image_${image?.path.split('/').last}.jpg',
        );
      }

      final formData = FormData.fromMap(formDataMap);

      await Dio().post(
        'https://api.aonk.app/customer_donations',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );
      log('Donation posted successfully');
    } on DioException catch (e) {
      log(e.response?.data.toString() ?? 'No response data');
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

  void resetValues() {
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
      imageQuality: 100,
    )
        .then((value) async {
      if (value != null) {
        final result = await FlutterImageCompress.compressAndGetFile(
          value.path,
          '${value.path}_compressed.jpg',
          quality: 60,
          minWidth: 1080,
          minHeight: 1080,
          format: CompressFormat.jpeg,
          keepExif: false,
        );
        if (result != null) {
          image = XFile(result.path);
        }
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
    selectedCity = null;
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

  void updateUserData(String key, String value) {
    final userData = GetStorage().read('userData') ?? {};
    userData[key] = value;
    GetStorage().write('userData', userData);
    notifyListeners();
  }
}
