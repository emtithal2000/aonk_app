import 'package:aonk_app/l10n/app_localizations.dart';
import 'package:aonk_app/pages/first_time.dart';
import 'package:aonk_app/providers/pages_provider.dart';
import 'package:aonk_app/size_config.dart';
import 'package:flutter/material.dart';
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
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double size = constraints.maxWidth;
                  return Column(
                    spacing: height(10),
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Gap(height(70)),
                      Row(
                        children: [
                          Expanded(
                            child: Card(
                              elevation: 2,
                              child: FormField<String>(
                                builder: (state) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: size * 0.025),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: PopupMenuButton<String>(
                                        offset: Offset(0, size * 0.1),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        itemBuilder: (context) => provider
                                            .getLocalizedCountryNames(
                                          context,
                                        )
                                            .map((String item) {
                                          return PopupMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: TextStyle(
                                                fontSize: size * 0.035,
                                                color: const Color(0xff52b8a0),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        onSelected: (value) {
                                          provider.setCountry(value);
                                          state.didChange(value);
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: size * 0.035),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: size * 0.35,
                                                child: Text(
                                                  provider.selectedCountry ??
                                                      AppLocalizations.of(
                                                              context)!
                                                          .country,
                                                  style: TextStyle(
                                                    color:
                                                        const Color(0xff84beb0),
                                                    fontSize: height(16),
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
                                                  Icons
                                                      .keyboard_arrow_down_rounded,
                                                  color: Color(0xff52b8a0),
                                                  size: size * 0.05,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: FormField<String>(
                              builder: (state) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Card(
                                    elevation: 2,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: size * 0.025),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: PopupMenuButton<String>(
                                        offset: Offset(0, size * 0.1),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        itemBuilder: (context) => provider
                                            .getCitiesForCountry(
                                          provider.selectedCountry,
                                          context,
                                        )
                                            .map((String item) {
                                          return PopupMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: TextStyle(
                                                fontSize: size * 0.035,
                                                color: const Color(0xff52b8a0),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        onSelected: (value) {
                                          provider.setCity(value);
                                          state.didChange(value);
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: size * 0.035),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: size * 0.35,
                                                child: Text(
                                                  provider.selectedCity ??
                                                      AppLocalizations.of(
                                                              context)!
                                                          .city,
                                                  style: TextStyle(
                                                    color:
                                                        const Color(0xff84beb0),
                                                    fontSize: height(16),
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
                                                  Icons
                                                      .keyboard_arrow_down_rounded,
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
                                ],
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
                            true,
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
                            true,
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
                            AppLocalizations.of(context)!.email,
                            IconsaxPlusBroken.sms,
                            true,
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
                          decoration: inputDecoration(
                            context,
                            AppLocalizations.of(context)!.streetNumber,
                            IconsaxPlusBroken.location,
                            true,
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
                          decoration: inputDecoration(
                            context,
                            AppLocalizations.of(context)!.buildingNumber,
                            IconsaxPlusBroken.building_4,
                            true,
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
                              Provider.of<PagesProvider>(context, listen: false)
                                  .clearCharities();

                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  content: Text(
                                    AppLocalizations.of(context)!
                                        .editSuccessfully,
                                    textAlign: TextAlign.center,
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text(
                                        AppLocalizations.of(context)!.ok,
                                        style: TextStyle(
                                          color: const Color(0xff81bdaf),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
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
