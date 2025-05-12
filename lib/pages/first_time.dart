import 'package:aonk_app/builders.dart';
import 'package:aonk_app/l10n/app_localizations.dart';
import 'package:aonk_app/pages/login.dart';
import 'package:aonk_app/pages/navigation.dart';
import 'package:aonk_app/providers/locale_provider.dart';
import 'package:aonk_app/providers/pages_provider.dart';
import 'package:aonk_app/size_config.dart';
import 'package:aonk_app/static_values.dart';
import 'package:aonk_app/value.dart' as staticvalues;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:provider/provider.dart';

InputDecoration inputDecoration(
    BuildContext context, String hintText, IconData icon) {
  return InputDecoration(
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
    errorStyle: TextStyle(
      height: 0,
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
  );
}

class FirstTime extends StatefulWidget {
  const FirstTime({super.key});

  @override
  State<FirstTime> createState() => _FirstTimeState();
}

class _FirstTimeState extends State<FirstTime> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/aonk-background.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.8),
              BlendMode.srcOver,
            ),
          ),
        ),
        child: SafeArea(
          child: Consumer<PagesProvider>(
            builder: (_, provider, __) {
              return Form(
                key: provider.loginKey,
                child: LayoutBuilder(builder: (context, constraints) {
                  final size = constraints.maxWidth;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Login(),
                                ),
                              );
                            },
                            borderRadius: BorderRadius.circular(10),
                            child: Card(
                              elevation: 2,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Icon(
                                  IconsaxPlusBroken.car,
                                  color: const Color(0xff52b8a0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.only(
                            left: width(30),
                            right: width(30),
                            bottom: MediaQuery.of(context).viewInsets.bottom +
                                height(20),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Gap(height(40)),
                              Text(
                                AppLocalizations.of(context)!.welcomeToAonk,
                                style: TextStyle(
                                  fontSize: height(22),
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xff52b8a0),
                                ),
                              ),
                              Text(
                                AppLocalizations.of(context)!.enterYourData,
                                style: TextStyle(
                                  fontSize: height(19),
                                  color: const Color(0xff52b8a0),
                                ),
                              ),
                              Gap(height(50)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  buildSelectionMobile(
                                    size,
                                    provider.getLocalizedCountryNames(
                                      context,
                                    ),
                                    provider.selectedCountry != null
                                        ? countryNames[
                                                provider.selectedCountry]![
                                            Localizations.localeOf(
                                            context,
                                          ).languageCode]!
                                        : AppLocalizations.of(context)!.country,
                                    onSelected: (value) {
                                      provider.setCountry(
                                        countryNames.keys.firstWhere(
                                          (key) =>
                                              countryNames[key]![
                                                  Localizations.localeOf(
                                                context,
                                              ).languageCode] ==
                                              value,
                                        ),
                                      );
                                    },
                                    isExpanded: true,
                                  ),
                                  buildSelectionMobile(
                                    size,
                                    provider.getCitiesForCountry(
                                      provider.selectedCountry,
                                      context,
                                    ),
                                    provider.selectedCity ??
                                        AppLocalizations.of(context)!.city,
                                    onSelected: (value) {
                                      provider.setCity(value);
                                    },
                                    isExpanded: true,
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
                                  autovalidateMode: AutovalidateMode.onUnfocus,
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
                                clipBehavior: Clip.hardEdge,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: TextFormField(
                                  controller: provider.controllers[1],
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(8),
                                  ],
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                    hintText: AppLocalizations.of(context)!
                                        .phoneNumber,
                                    hintStyle: TextStyle(
                                      color: const Color(0xff84beb0),
                                      fontSize: height(16),
                                    ),
                                    prefixIcon: Icon(
                                      IconsaxPlusBroken.call,
                                      color: const Color(0xff52b8a0),
                                    ),
                                    prefixText: provider.selectedCountry !=
                                                null ||
                                            provider
                                                .controllers[1].text.isNotEmpty
                                        ? '${getPhoneCodeForCountry(provider.selectedCountry)} '
                                        : '',
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    prefixStyle: TextStyle(
                                      color: const Color(0xff52b8a0),
                                      fontSize: height(16),
                                    ),
                                    fillColor: Colors.white,
                                    filled: true,
                                    isDense: true,
                                    counterText: '',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '${AppLocalizations.of(context)!.pleaseEnter} ${AppLocalizations.of(context)!.phoneNumber}';
                                    }
                                    if (value.length < 8) {
                                      return '${AppLocalizations.of(context)!.phoneNumber} must be at least 8 digits';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {},
                                ),
                              ),
                              Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: provider.controllers[2],
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value != null && value.isNotEmpty) {
                                      if (!RegExp(
                                              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
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
                                  autovalidateMode: AutovalidateMode.onUnfocus,
                                  controller: provider.controllers[3],
                                  keyboardType: TextInputType.number,
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
                                  decoration: inputDecoration(
                                    context,
                                    AppLocalizations.of(context)!
                                        .buildingNumber,
                                    IconsaxPlusBroken.building_4,
                                  ),
                                  onChanged: (value) {},
                                ),
                              ),
                              Gap(height(25)),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: FloatingActionButton(
                                  heroTag: null,
                                  onPressed: () async {
                                    if (provider.loginKey.currentState!
                                        .validate()) {
                                      await GetStorage().write(
                                        'userData',
                                        {
                                          'name': provider.controllers[0].text,
                                          'phone': provider.controllers[1].text
                                                  .isNotEmpty
                                              ? '${getPhoneCodeForCountry(provider.selectedCountry)}${provider.controllers[1].text}'
                                              : '',
                                          'email': provider.controllers[2].text,
                                          'street':
                                              provider.controllers[3].text,
                                          'building':
                                              provider.controllers[4].text,
                                          'city': provider.selectedCity,
                                          'country': provider.selectedCountry,
                                          'location': provider.locationData,
                                          'created_by':
                                              provider.controllers[0].text,
                                        },
                                      );

                                      if (context.mounted) {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const Navigation(),
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
                                    ),
                                  ),
                                ),
                              ),
                              Gap(height(50)),
                              Card(
                                elevation: 2,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    final localeProvider =
                                        context.read<LocaleProvider>();
                                    if (localeProvider.locale.languageCode ==
                                        'ar') {
                                      localeProvider.setLocale(
                                          const Locale('en'), context);
                                    } else {
                                      localeProvider.setLocale(
                                          const Locale('ar'), context);
                                    }
                                  },
                                  borderRadius: BorderRadius.circular(10),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: width(16),
                                      vertical: height(8),
                                    ),
                                    child: Text(
                                      context
                                                  .watch<LocaleProvider>()
                                                  .locale
                                                  .languageCode ==
                                              'ar'
                                          ? 'English'
                                          : 'Arabic',
                                      style: TextStyle(
                                        color: const Color(0xff52b8a0),
                                        fontSize: height(14),
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
                  );
                }),
              );
            },
          ),
        ),
      ),
    );
  }

  String? getPhoneCodeForCountry(String? country) {
    if (country == null) return '';
    return staticvalues.countryPhoneCodes[country] ?? '';
  }

  @override
  void initState() {
    super.initState();
    context.read<PagesProvider>().getLocation();
  }
}
