import 'package:aonk_app/l10n/app_localizations.dart';
import 'package:aonk_app/pages/driver_page.dart';
import 'package:aonk_app/providers/driver_provider.dart';
import 'package:aonk_app/providers/locale_provider.dart';
import 'package:aonk_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Consumer<DriverProvider>(
        builder: (_, provider, __) {
          return Container(
            height: double.infinity,
            width: double.infinity,
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
            child: Form(
              key: provider.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                spacing: height(10),
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: width(30),
                        right: width(30),
                        bottom: MediaQuery.of(context).viewInsets.bottom +
                            height(20),
                      ),
                      child: Column(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.welcomeToAonk,
                            style: TextStyle(
                              fontSize: height(22),
                              fontFamily: 'Marhey',
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff52b8a0),
                            ),
                          ),
                          Text(
                            AppLocalizations.of(context)!.login,
                            style: TextStyle(
                              fontSize: height(19),
                              fontFamily: 'Marhey',
                              color: const Color(0xff52b8a0),
                            ),
                          ),
                          Gap(height(50)),
                          Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: TextFormField(
                              controller: provider.username,
                              autovalidateMode: AutovalidateMode.onUnfocus,
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return '${AppLocalizations.of(context)!.pleaseEnter} ${AppLocalizations.of(context)!.username}';
                                }
                                return null;
                              },
                              decoration: inputDecoration(
                                context,
                                AppLocalizations.of(context)!.username,
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
                              autovalidateMode: AutovalidateMode.onUnfocus,
                              controller: provider.password,
                              keyboardType: TextInputType.number,
                              obscureText: true,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return '${AppLocalizations.of(context)!.pleaseEnter} ${AppLocalizations.of(context)!.password}';
                                }
                                return null;
                              },
                              decoration: inputDecoration(
                                context,
                                AppLocalizations.of(context)!.password,
                                IconsaxPlusBroken.lock,
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
                                if (provider.formKey.currentState!.validate()) {
                                  provider.login().then(
                                    (value) {
                                      if (context.mounted) {
                                        if (value) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DriverPage(),
                                              ));
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      'Invalid Username/Password!')));
                                        }
                                      }
                                    },
                                  );
                                }
                              },
                              backgroundColor: const Color(0xff81bdaf),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                AppLocalizations.of(context)!.loginButton,
                                style: TextStyle(
                                  fontSize: height(18),
                                  color: Colors.white,
                                  fontFamily: 'Marhey',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 2,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      onTap: () {
                        final localeProvider = context.read<LocaleProvider>();
                        if (localeProvider.locale.languageCode == 'ar') {
                          localeProvider.setLocale(const Locale('en'));
                        } else {
                          localeProvider.setLocale(const Locale('ar'));
                        }
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: width(16),
                          vertical: height(8),
                        ),
                        child: Text(
                          context.watch<LocaleProvider>().locale.languageCode ==
                                  'ar'
                              ? 'Enlish'
                              : 'Arabic',
                          style: TextStyle(
                            fontFamily: 'Marhey',
                            fontSize: height(14),
                            color: const Color(0xff52b8a0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
