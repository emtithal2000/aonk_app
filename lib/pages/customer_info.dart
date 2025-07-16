import 'package:aonk_app/l10n/app_localizations.dart';
import 'package:aonk_app/pages/first_time.dart';
import 'package:aonk_app/providers/pages_provider.dart';
import 'package:aonk_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:provider/provider.dart';
import 'package:aonk_app/models/countries_model.dart';

class CustomerInfo extends StatelessWidget {
  CustomerInfo({super.key});
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<PagesProvider>(
      builder: (_, provider, __) {
        return Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width(30),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double size = constraints.maxWidth;
                  final userData = GetStorage().read('userData');

                  return Column(
                    spacing: height(10),
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Gap(height(70)),
                      Row(
                        children: [
                          Expanded(
                            child: Card(
                              elevation: 3,
                              color: Colors.white,
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                ),
                                child: PopupMenuButton<Countries>(
                                  offset: Offset(0, size * 0.15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  itemBuilder: (context) =>
                                      provider.countries.map((Countries item) {
                                    return PopupMenuItem<Countries>(
                                      value: item,
                                      child: Text(
                                        provider.localizedName(
                                            context, item.country!),
                                        style: TextStyle(
                                          fontSize: size * 0.035,
                                          color: const Color(0xff52b8a0),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onSelected: (Countries value) {
                                    provider.setCountry(value);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: size * 0.04,
                                      horizontal: size * 0.035,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: size * 0.25,
                                          child: Text(
                                            _getCountryDisplayText(
                                                context, provider, userData),
                                            style: TextStyle(
                                              fontSize: size * 0.035,
                                              color: const Color(0xff52b8a0),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xff52b8a0)
                                                .withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            color: Color(0xff52b8a0),
                                            size: size * 0.05,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Card(
                              elevation: 3,
                              color: Colors.white,
                              clipBehavior: Clip.hardEdge,
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                ),
                                child: PopupMenuButton<City>(
                                  offset: Offset(0, size * 0.1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  itemBuilder: (context) => provider
                                      .getCitiesForCountry()
                                      .map((City item) {
                                    return PopupMenuItem<City>(
                                      value: item,
                                      child: Text(
                                        provider.getLocalizedCityName(item),
                                        style: TextStyle(
                                          fontSize: size * 0.035,
                                          color: const Color(0xff52b8a0),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onSelected: (City value) {
                                    provider.setCity(value);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: size * 0.04,
                                      horizontal: size * 0.035,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: size * 0.25,
                                          child: Text(
                                            _getCityDisplayText(
                                                context, provider, userData),
                                            style: TextStyle(
                                              fontSize: size * 0.035,
                                              color: const Color(0xff52b8a0),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xff52b8a0)
                                                .withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            color: Color(0xff52b8a0),
                                            size: size * 0.05,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextFormField(
                          controller: provider.controllers[0],
                          keyboardType: TextInputType.name,
                          decoration: inputDecoration(
                            context,
                            userData['name'] == ''
                                ? AppLocalizations.of(context)!.name
                                : '${userData['name']}',
                            IconsaxPlusBroken.user,
                            true,
                          ),
                          onChanged: (value) {
                            provider.updateUserEdit('name', value);
                          },
                        ),
                      ),
                      Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextFormField(
                          controller: provider.controllers[1],
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(8),
                          ],
                          validator: (value) {
                            if (value!.isNotEmpty) {
                              if (value.length < 8) {
                                return '${AppLocalizations.of(context)!.phoneNumber} must be at least 8 digits';
                              }
                            }

                            return null;
                          },
                          onChanged: (value) {
                            provider.updateUserEdit('phone', value);
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            hintText: userData['phone'] == ''
                                ? AppLocalizations.of(context)!.phoneNumber
                                : '${userData['phone']}',
                            hintStyle: TextStyle(
                              color: const Color(0xff84beb0),
                              fontSize: height(16),
                            ),
                            prefixIcon: Icon(
                              IconsaxPlusBroken.call,
                              color: const Color(0xff52b8a0),
                            ),
                            prefixText: provider.selectedCountry != null ||
                                    provider.controllers[1].text.isNotEmpty
                                ? '${provider.getPhoneCodeForCountry(provider.selectedCountry)} '
                                : '',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            prefixStyle: TextStyle(
                              color: const Color(0xff52b8a0),
                              fontSize: height(16),
                            ),
                            suffixIcon: Icon(
                              Icons.star,
                              color: Colors.red,
                              size: height(10),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            isDense: true,
                            counterText: '',
                          ),
                        ),
                      ),
                      Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: provider.controllers[2],
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value != null && value.isNotEmpty) {
                              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                  .hasMatch(value)) {
                                return '${AppLocalizations.of(context)!.pleaseEnter} ${AppLocalizations.of(context)!.validEmail}';
                              }
                            }
                            return null;
                          },
                          onChanged: (value) {
                            provider.updateUserEdit('email', value);
                          },
                          decoration: inputDecoration(
                            context,
                            userData['email'] == ''
                                ? AppLocalizations.of(context)!.email
                                : '${userData['email']}',
                            IconsaxPlusBroken.sms,
                            false,
                          ),
                        ),
                      ),
                      Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextFormField(
                          controller: provider.controllers[3],
                          autovalidateMode: AutovalidateMode.onUnfocus,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            provider.updateUserEdit('street', value);
                          },
                          decoration: inputDecoration(
                            context,
                            userData['street'] == ''
                                ? AppLocalizations.of(context)!.streetNumber
                                : '${userData['street']}',
                            IconsaxPlusBroken.location,
                            false,
                          ),
                        ),
                      ),
                      Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextFormField(
                          controller: provider.controllers[4],
                          autovalidateMode: AutovalidateMode.onUnfocus,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            provider.updateUserEdit('building', value);
                          },
                          decoration: inputDecoration(
                            context,
                            userData['building'] == ''
                                ? AppLocalizations.of(context)!.buildingNumber
                                : '${userData['building']}',
                            IconsaxPlusBroken.building_4,
                            false,
                          ),
                        ),
                      ),
                      Gap(height(10)),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: FloatingActionButton(
                          heroTag: null,
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              if (context.mounted) {
                                if (provider.updateUserData()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        AppLocalizations.of(context)!
                                            .editSuccessfully,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      backgroundColor: const Color(0xff81bdaf),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        AppLocalizations.of(context)!
                                            .editFailed,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      backgroundColor: Colors.red,
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                }
                              }
                            }
                          },
                          backgroundColor: const Color(0xff81bdaf),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.save,
                            style: TextStyle(
                              fontSize: height(18),
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  String _getCountryDisplayText(BuildContext context, PagesProvider provider,
      Map<String, dynamic>? userData) {
    // First option: Check if there's saved data from storage and use it based on app language
    if (userData != null && userData['country_data'] != null) {
      final savedCountry = userData['country_data'];
      final isArabic = Localizations.localeOf(context).languageCode == 'ar';

      final countryName =
          isArabic ? savedCountry['name_ar'] : savedCountry['name_en'];

      if (countryName != null && countryName.toString().isNotEmpty) {
        return countryName.toString();
      }
    }

    // Second option: If selectedCountry is not null, show it based on current language
    if (provider.selectedCountry?.country != null) {
      final isArabic = Localizations.localeOf(context).languageCode == 'ar';
      final countryName = isArabic
          ? provider.selectedCountry!.country!.countryAr
          : provider.selectedCountry!.country!.countryEn;

      // If the localized name is available, return it
      if (countryName != null && countryName.isNotEmpty) {
        return countryName;
      }
    }

    // Third option: Default value from localization
    return AppLocalizations.of(context)!.country;
  }

  String _getCityDisplayText(BuildContext context, PagesProvider provider,
      Map<String, dynamic>? userData) {
    // First option: If selectedCity is not null, show it based on current language (active selection takes precedence)
    if (provider.selectedCity != null) {
      return provider.getLocalizedCityName(provider.selectedCity!);
    }

    // Second option: Check if there's saved data from storage and use it based on app language
    if (userData != null && userData['city_data'] != null) {
      final savedCity = userData['city_data'];
      final isArabic = Localizations.localeOf(context).languageCode == 'ar';
      final cityName = isArabic
          ? savedCity['cityAr'] ?? savedCity['city_ar']
          : savedCity['cityEn'] ?? savedCity['city_en'];

      if (cityName != null && cityName.toString().isNotEmpty) {
        return cityName.toString();
      }
    }

    // Third option: Default value from localization
    return AppLocalizations.of(context)!.city;
  }

  Widget buildInput(
      String hintText, IconData icon, TextEditingController controller,
      {int? maxLength,
      TextInputType? keyboardType,
      String? counterText,
      String? Function(String?)? validator,
      required BuildContext context}) {
    return Card(
      child: TextFormField(
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator ??
            (value) {
              if (value!.isEmpty) {
                return '${AppLocalizations.of(context)!.pleaseEnter} $hintText';
              }
              return null;
            },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15),
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: hintText,
          isDense: true,
          hintStyle: TextStyle(
            color: const Color(0xff84beb0),
            fontSize: height(16),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15),
          ),
          prefixIcon: Icon(
            icon,
            color: const Color(0xff52b8a0),
          ),
          counterText: counterText,
        ),
        onChanged: (value) {},
        maxLength: maxLength,
        keyboardType: keyboardType,
      ),
    );
  }
}
