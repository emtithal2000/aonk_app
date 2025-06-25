import 'dart:io';

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
  const CustomerInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PagesProvider>(
      builder: (_, provider, __) {
        return Form(
          key: provider.loginKey,
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
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: TextField(
                                enabled: false,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                  isDense: true,
                                  hintText: provider.getLocalizedCountryName(
                                    Platform.localeName.split('_')[1],
                                    context,
                                  ),
                                  hintStyle: TextStyle(
                                    color: const Color(0xff84beb0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Card(
                              elevation: 3,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: size * 0.04,
                                ),
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                  ),
                                  child: PopupMenuButton<Cities>(
                                    offset: Offset(0, size * 0.1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    itemBuilder: (context) => provider
                                        .getCitiesForCountry()
                                        .map((Cities item) {
                                      return PopupMenuItem<Cities>(
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
                                    onSelected: (Cities value) {
                                      provider.setCity(value);
                                      provider.updateUserData('city',
                                          provider.getLocalizedCityName(value));
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: size * 0.035,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            provider.selectedCity != null
                                                ? provider.getLocalizedCityName(
                                                    provider.selectedCity!)
                                                : AppLocalizations.of(context)!
                                                    .city,
                                            style: TextStyle(
                                              color: const Color(0xff84beb0),
                                              fontSize: size * 0.04,
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
                                : userData['name'],
                            IconsaxPlusBroken.user,
                            true,
                          ),
                          onChanged: (value) {
                            provider.updateUserData('name', value);
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
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            hintText: AppLocalizations.of(context)!.phoneNumber,
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
                          onChanged: (value) {
                            provider.updateUserData('phone', value);
                          },
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
                          decoration: inputDecoration(
                            context,
                            userData['email'] == ''
                                ? AppLocalizations.of(context)!.email
                                : userData['email'],
                            IconsaxPlusBroken.sms,
                            false,
                          ),
                          onChanged: (value) {
                            provider.updateUserData('email', value);
                          },
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
                          decoration: inputDecoration(
                            context,
                            userData['street'] == ''
                                ? AppLocalizations.of(context)!.streetNumber
                                : userData['street'],
                            IconsaxPlusBroken.location,
                            false,
                          ),
                          onChanged: (value) {
                            provider.updateUserData('street', value);
                          },
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
                          decoration: inputDecoration(
                            context,
                            userData['building'] == ''
                                ? AppLocalizations.of(context)!.buildingNumber
                                : userData['building'],
                            IconsaxPlusBroken.building_4,
                            false,
                          ),
                          onChanged: (value) {
                            provider.updateUserData('building', value);
                          },
                        ),
                      ),
                      Gap(height(10)),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: FloatingActionButton(
                          heroTag: null,
                          onPressed: () async {
                            if (provider.selectedCountry == null ||
                                provider.selectedCity == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${AppLocalizations.of(context)!.pleaseEnter} ${AppLocalizations.of(context)!.country} ${AppLocalizations.of(context)!.city}',
                                    textAlign: TextAlign.center,
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }
                            if (provider.loginKey.currentState!.validate()) {
                              await provider.saveUserData();
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      AppLocalizations.of(context)!
                                          .editSuccessfully,
                                      textAlign: TextAlign.center,
                                    ),
                                    backgroundColor: const Color(0xff81bdaf),
                                  ),
                                );
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
