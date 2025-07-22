import 'dart:developer';
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
import 'package:aonk_app/theme/color_pallate.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:gap/gap.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

Widget customButton(Function() onPressed, String title) {
  return Column(
    children: [
      Gap(height(15)),
      SizedBox(
        width: double.infinity,
        height: height(40),
        child: FloatingActionButton(
          onPressed: onPressed,
          backgroundColor: ColorPallate.primary,
          child: Text(
            title,
            style: TextStyle(
              fontSize: width(15),
              color: Colors.white,
            ),
          ),
        ),
      ),
    ],
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
    Gift(), //1
    const DonationDetails(), //2
    const DonationImages(), //3
  ];
  var controllers = List.generate(7, (index) => TextEditingController());
  var pageController = PageController();

  int currentPage = 0;
  int pageIndex = 0;

  XFile? image;
  City? selectedCity;
  Countries? selectedCountry;
  int? selectedCharityId;
  String? selectedDonationType;
  String? selectedGiftName;
  String? selectedGiftPhone;
  String? locationData;
  bool isGift = false;

  var userEdit = {};

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
    final countryMap =
        GetStorage().read('userData')['country_data'] as Map<String, dynamic>;
    final countryData = Country.fromJson(countryMap);
    final cityMap =
        GetStorage().read('userData')['city_data'] as Map<String, dynamic>;
    final cityData = City.fromJson(cityMap);

    try {
      final response = await Dio().get(
        'https://api.aonk.app/charities_mobile?country_id=${countryData.countryId}&city_id=${cityData.cityId}',
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
      await Dio()
          .get(
        'https://api.aonk.app/countries',
      )
          .then((value) {
        var data = value.data['countries'] as List;
        countries = data
            .map((e) => Countries.fromJson(e as Map<String, dynamic>))
            .toList();

        // After fetching countries, automatically set country based on user location
        _getUserLocation();
      });
    } on DioException catch (e) {
      log(e.toString());
    }
    notifyListeners();
  }

  /// Automatically gets user's GPS location and saves it
  Future<void> _getUserLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        log('Location services are disabled');
        return;
      }

      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          log('Location permissions are denied');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        log('Location permissions are permanently denied');
        return;
      }

      // Get current position with timeout
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );

      // Save location data
      locationData = '${position.latitude},${position.longitude}';
      final country =
          await getCountryFromLocation(position.latitude, position.longitude);

      if (country != null) {
        selectedCountry = country;
      }
      notifyListeners();
    } catch (e) {
      log('Error in _getUserLocation: $e');
    }
  }

  /// Gets country from coordinates and returns country model based on app language
  Future<Countries?> getCountryFromLocation(
      double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isNotEmpty) {
        String? countryName = placemarks.first.country;

        if (countryName != null) {
          // Search for the country in our countries list
          return countries.firstWhere(
            (country) =>
                country.country?.countryEn?.toLowerCase() ==
                    countryName.toLowerCase() ||
                country.country?.countryAr?.toLowerCase() ==
                    countryName.toLowerCase(),
            orElse: () => Countries(),
          );
        }
      }
      return null;
    } catch (e) {
      log('Error getting country from location: $e');
      return null;
    }
  }

  List<City> getCitiesForCountry() {
    if (selectedCountry == null || selectedCountry!.cities == null) return [];
    return selectedCountry!.cities!;
  }

  Future<void> getDetailedCountry() async {
    final countryID = GetStorage().read('userData')['country_data']['id'];

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
    final countryID = GetStorage().read('userData')['country_data']['id'];

    try {
      await Dio()
          .get('https://api.aonk.app/donation_types?country_id=$countryID')
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

  String getLocalizedCityName(City city) {
    return LocaleProvider().locale.languageCode == 'ar'
        ? city.cityAr!
        : city.cityEn!;
  }

  String localizedName(BuildContext context, Object object) {
    if (object is Charity) {
      return LocaleProvider().locale.languageCode == 'ar'
          ? object.nameAr ?? ''
          : object.nameEn ?? '';
    }
    if (object is Country) {
      return LocaleProvider().locale.languageCode == 'ar'
          ? object.countryAr ?? ''
          : object.countryEn ?? '';
    }
    return '';
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
        ? selectedCountry?.country?.countryAr
        : selectedCountry?.country?.countryEn;
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
      final countryID = GetStorage().read('userData')['country_data']['id'];
      final cityID = GetStorage().read('userData')['city_data']['city_id'];

      final formDataMap = {
        "charity_id": selectedCharityId,
        "types": selected,
        "country_id": countryID,
        "city_id": cityID,
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

  void resetControllers() {
    for (var controller in controllers) {
      controller.clear();
    }
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

  void setCity(City city) {
    selectedCity = city;
    updateUserMap('city_data', city.toJson());
    notifyListeners();
  }

  void setCountry(Countries country) {
    selectedCountry = country;
    selectedCity = null;
    updateUserMap('country_data', country.country?.toJson() ?? {});
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

  void updateUserMap(String key, Map<String, dynamic> map) {
    userEdit[key] = map;
    notifyListeners();
  }

  void updateUserEdit(String key, String value) {
    userEdit[key] = value;
    notifyListeners();
  }

  bool updateUserData() {
    try {
      final userData = GetStorage().read('userData') ?? {};

      userEdit.forEach((key, value) {
        userData[key] = value;
      });
      GetStorage().write('userData', userData);
      notifyListeners();
      return true;
    } catch (e) {
      log('updateUserData: Exception caught = $e');
      return false;
    }
  }

  /// Saves complete user data to storage
  Future<void> saveUserData() async {
    final userData = {
      'name': controllers[0].text,
      'phone': controllers[1].text,
      'email': controllers[2].text,
      'street': controllers[3].text,
      'building': controllers[4].text,
      'city_data': selectedCity?.toJson(),
      'country_data': selectedCountry?.country?.toJson(),
      'location': locationData,
      'created_by': controllers[0].text,
    };

    await GetStorage().write('userData', userData);

    resetControllers();
    notifyListeners();
  }
}
