import 'package:aonk_app/location.dart';
import 'package:aonk_app/pages/first_time.dart';
import 'package:aonk_app/providers/pages_provider.dart';
import 'package:aonk_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:aonk_app/l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:provider/provider.dart';

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
              child: Column(
                spacing: height(10),
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Gap(height(50)),
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          color: Colors.white,
                          child: DropdownButtonFormField<String>(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null) {
                                return '${AppLocalizations.of(context)!.pleaseEnter} ${AppLocalizations.of(context)!.country}';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              isDense: true,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: width(5),
                            ),
                            hint: Text(
                              AppLocalizations.of(context)!.country,
                              style: TextStyle(
                                fontSize: height(16),
                                color: const Color(0xff52b8a0),
                              ),
                            ),
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: Color(0xff52b8a0),
                            ),
                            dropdownColor: Colors.white,
                            elevation: 1,
                            borderRadius: BorderRadius.circular(15),
                            isExpanded: true,
                            items: countryCities.keys.map((String country) {
                              return DropdownMenuItem<String>(
                                value: country,
                                child: Text(
                                  country,
                                  style: TextStyle(
                                    fontSize: height(16),
                                    color: const Color(0xff52b8a0),
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              provider.setCountry(newValue!);
                              provider.resetSelected();
                            },
                            value: provider.selectedCountry,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          color: Colors.white,
                          child: DropdownButtonFormField<String>(
                            isExpanded: true,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null) {
                                return '${AppLocalizations.of(context)!.pleaseEnter} ${AppLocalizations.of(context)!.city}';
                              }
                              return null;
                            },
                            padding: EdgeInsets.symmetric(
                              horizontal: width(5),
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              isDense: true,
                            ),
                            hint: Text(
                              AppLocalizations.of(context)!.city,
                              style: TextStyle(
                                fontSize: height(16),
                                color: const Color(0xff52b8a0),
                              ),
                            ),
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: Color(0xff52b8a0),
                            ),
                            dropdownColor: Colors.white,
                            elevation: 1,
                            borderRadius: BorderRadius.circular(10),
                            items: getCitiesForCountry(provider.selectedCountry)
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    fontSize: height(16),
                                    color: const Color(0xff52b8a0),
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              provider.setCity(newValue!);
                            },
                            value: provider.selectedCity,
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '${AppLocalizations.of(context)!.pleaseEnter} ${AppLocalizations.of(context)!.name}';
                            }
                            return null;
                          },
                          decoration: inputDecoration(
                            context,
                            AppLocalizations.of(context)!.name,
                            IconsaxPlusBroken.user,
                          ),
                          onChanged: (value) {},
                        ),
                      ),
                      Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextFormField(
                          controller: provider.controllers[1],
                          autovalidateMode: AutovalidateMode.onUnfocus,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '${AppLocalizations.of(context)!.pleaseEnter} ${AppLocalizations.of(context)!.phoneNumber}';
                            }
                            return null;
                          },
                          decoration: inputDecoration(
                            context,
                            AppLocalizations.of(context)!.phoneNumber,
                            IconsaxPlusBroken.call,
                          ),
                          onChanged: (value) {},
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
                            if (value!.isEmpty) {
                              return '${AppLocalizations.of(context)!.pleaseEnter} ${AppLocalizations.of(context)!.email}';
                            }
                            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value)) {
                              return '${AppLocalizations.of(context)!.pleaseEnter} ${AppLocalizations.of(context)!.validEmail}';
                            }

                            return null;
                          },
                          decoration: inputDecoration(
                            context,
                            AppLocalizations.of(context)!.email,
                            IconsaxPlusBroken.sms,
                          ),
                          onChanged: (value) {},
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '${AppLocalizations.of(context)!.pleaseEnter} ${AppLocalizations.of(context)!.streetNumber}';
                            }
                            return null;
                          },
                          decoration: inputDecoration(
                            context,
                              AppLocalizations.of(context)!.streetNumber,
                            IconsaxPlusBroken.location,
                          ),
                          onChanged: (value) {},
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '${AppLocalizations.of(context)!.pleaseEnter} ${AppLocalizations.of(context)!.buildingNumber}';
                            }
                            return null;
                          },
                          decoration: inputDecoration(
                            context,
                            AppLocalizations.of(context)!.buildingNumber,
                            IconsaxPlusBroken.building_4,
                          ),
                          onChanged: (value) {},
                        ),
                      ),
                  Gap(height(10)),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: FloatingActionButton(
                      heroTag: null,
                      onPressed: () {
                        if (provider.loginKey.currentState!.validate()) {
                          GetStorage().write('userData', {
                            'name': provider.controllers[0].text,
                            'phone': provider.controllers[1].text,
                            'email': provider.controllers[2].text,
                            'street': provider.controllers[3].text,
                            'building': provider.controllers[4].text,
                            'city': provider.selectedCity,
                            'country': provider.selectedCountry,
                          });
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
