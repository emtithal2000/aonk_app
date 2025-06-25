import 'dart:developer';
import 'dart:io';

import 'package:aonk_app/models/charities_model.dart';
import 'package:aonk_app/models/countries_model.dart';
import 'package:aonk_app/models/country_details_model.dart';
import 'package:aonk_app/models/types_mode.dart';
import 'package:aonk_app/providers/locale_provider.dart';
import 'package:aonk_app/size_config.dart';
import 'package:aonk_app/static_values.dart';
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
  List<int> selected = [];
  List<CharitiesModel> charities = [];
  List<Countries> countries = [];
  List<DonationTypes> donationTypes = [];
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
  Cities? selectedCity;
  Countries? selectedCountry;
  int? selectedCharityId;
  String? selectedDonationType;
  String? selectedGiftName;
  String? selectedGiftPhone;
  String? locationData;
  bool isGift = false;

  void addSelected(int id) {
    selected.add(id);
    notifyListeners();
  }

  void removeSelected(int id) {
    selected.remove(id);
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
    final countryID = GetStorage().read('userData')['country_id'];
    final cityID = GetStorage().read('userData')['city_id'];

    try {
      final response = await Dio().get(
        'https://api.aonk.app/charities_mobile?country_id=$countryID&city_id=$cityID',
      );
      if (response.statusCode == 200) {
        final List<dynamic> charitiesJson = response.data['charities_mobile'];
        charities =
            charitiesJson.map((json) => CharitiesModel.fromJson(json)).toList();
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

        // After fetching countries, automatically set country based on device locale
        _setCountryFromDeviceLocale();
      });
    } on DioException catch (e) {
      log(e.response?.data.toString() ?? 'Error');
    }
    notifyListeners();
  }

  /// Automatically sets the country based on device locale
  void _setCountryFromDeviceLocale() {
    if (countries.isEmpty) return;

    final deviceLocale = Platform.localeName.split('_')[1];
    // Find country by code
    Countries? foundCountry;
    for (var country in countries) {
      final countryCode = _getCountryCode(country);
      if (countryCode == deviceLocale) {
        foundCountry = country;
        break;
      }
    }

    // If not found by code, try to find by name
    if (foundCountry == null) {
      final deviceCountryName = _getCountryNameFromCode(deviceLocale);
      if (deviceCountryName != null) {
        for (var country in countries) {
          final countryNameEn = country.country?.countryEn;
          final countryNameAr = country.country?.countryAr;

          if (countryNameEn == deviceCountryName ||
              countryNameAr == deviceCountryName) {
            foundCountry = country;
            break;
          }
        }
      }
    }

    if (foundCountry != null) {
      selectedCountry = foundCountry;
    } else {
      log('Could not find country for device locale: $deviceLocale');
    }
  }

  /// Gets the country code from a Countries object
  String _getCountryCode(Countries country) {
    final countryNameEn = country.country?.countryEn;
    final countryNameAr = country.country?.countryAr;

    // Map country names to codes
    if (countryNameEn == 'Oman' || countryNameAr == 'سلطنة عُمان') {
      return 'OM';
    } else if (countryNameEn == 'Qatar' || countryNameAr == 'قطر') {
      return 'QR';
    }

    return '';
  }

  /// Gets the country name from country code
  String? _getCountryNameFromCode(String code) {
    switch (code) {
      case 'OM':
        return 'Oman';
      case 'QR':
        return 'Qatar';
      default:
        return null;
    }
  }

  List<Cities> getCitiesForCountry() {
    if (selectedCountry == null || selectedCountry!.cities == null) return [];
    return selectedCountry!.cities!;
  }

  Future<void> getDetailedCountry() async {
    final countryID = GetStorage().read('userData')['country_id'];

    try {
      final response = await Dio().get(
        'https://api.aonk.app/country_details?country_id=$countryID',
      );

      if (response.statusCode == 200) {
        var charitiesJson = response.data['country_details'][0];
        detailedCountry = DetailedCountry.fromJson(charitiesJson);
      }
    } on DioException catch (e) {
      log(e.response?.data.toString() ?? 'No response data');
    }
  }

  Future<void> getDonationTypes() async {
    try {
      await Dio()
          .get('https://api.aonk.app/donation_types?country_id=1')
          .then((value) {
        var data = value.data['donation_types'] as List;
        donationTypes = data
            .map((e) => DonationTypes.fromJson(e as Map<String, dynamic>))
            .toList();
      });
    } on DioException catch (e) {
      log(e.response?.data.toString() ?? 'Error');
    }
    notifyListeners();
  }

  String? getPhoneCodeForCountry(Countries? country) {
    if (country == null) return '';

    final countryNameEn = country.country?.countryEn;
    final countryNameAr = country.country?.countryAr;

    // Use the existing countryPhoneCodes getter for better performance
    // First try with English name
    if (countryNameEn != null && countryPhoneCodes.containsKey(countryNameEn)) {
      return countryPhoneCodes[countryNameEn];
    }

    // Then try with Arabic name
    if (countryNameAr != null && countryPhoneCodes.containsKey(countryNameAr)) {
      return countryPhoneCodes[countryNameAr];
    }

    return '';
  }

  String getLocalizedCityName(Cities city) {
    return LocaleProvider().locale.languageCode == 'ar'
        ? city.cityAr!
        : city.cityEn!;
  }

  String getLocalizedCountryName(String countryCode, BuildContext context) {
    final localeCode = Localizations.localeOf(context).languageCode;

    final countryNameMap = countryCodeToNames[countryCode];
    if (countryNameMap == null) {
      return countryCode;
    }

    final countryName = countryNameMap[localeCode] ?? countryNameMap['en']!;

    return countryName;
  }

  /// Gets the localized name of the selected country
  String? getLocalizedSelectedCountryName(BuildContext context) {
    if (selectedCountry == null) return null;

    final localeCode = Localizations.localeOf(context).languageCode;
    return localeCode == 'ar'
        ? selectedCountry!.country!.countryAr
        : selectedCountry!.country!.countryEn;
  }

  String getLocalizedType(DonationTypes type) {
    return LocaleProvider().locale.languageCode == 'ar'
        ? type.nameAr!
        : type.nameEn!;
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

  Future<bool> postDonation() async {
    try {
      final storage = GetStorage().read('userData');
      final formDataMap = {
        "charity_id": selectedCharityId,
        "types": selected,
        "country_id": storage['country_id'],
        "city_id": storage['city_id'],
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
        "platform": "mobile",
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
      return true;
    } on DioException catch (e) {
      log(e.response?.data.toString() ?? 'No response data');
      return false;
    }
  }

  void reset() {
    currentPage = 0;
    selected.clear();
    // name.clear();
    // phone.clear();
    image = null;
    selectedCharityId = null;
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

  void setCharity(int charityId) {
    selectedCharityId = charityId;
    notifyListeners();
  }

  void setCity(Cities city) {
    selectedCity = city;
    notifyListeners();
  }

  void setCountry(Countries country) {
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

  void updateUserData(String key, String value) {
    final userData = GetStorage().read('userData') ?? {};
    userData[key] = value;
    GetStorage().write('userData', userData);
    notifyListeners();
  }

  /// Saves complete user data to storage
  Future<void> saveUserData() async {
    final userData = {
      'name': controllers[0].text,
      'phone': controllers[1].text.isNotEmpty ? controllers[1].text : '',
      'email': controllers[2].text,
      'street': controllers[3].text,
      'building': controllers[4].text,
      'city_id': selectedCity?.cityId,
      'city_name':
          selectedCity != null ? getLocalizedCityName(selectedCity!) : null,
      'country_id': selectedCountry?.country?.countryId,
      'country_name': selectedCountry?.country?.countryEn,
      'location': locationData,
      'created_by': controllers[0].text,
    };

    await GetStorage().write('userData', userData);
    notifyListeners();
  }
}
