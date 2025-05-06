import 'package:aonk_app/l10n/app_localizations.dart';
import 'package:aonk_app/location.dart';
import 'package:aonk_app/pages/about_us.dart';
import 'package:aonk_app/pages/first_time.dart';
import 'package:aonk_app/pages/notification.dart';
import 'package:aonk_app/providers/locale_provider.dart';
import 'package:aonk_app/providers/pages_provider.dart';
import 'package:aonk_app/size_config.dart';
import 'package:aonk_app/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

// Update the _primaryColor constant to use ThemeColors
const _primaryColor = ThemeColors.primaryColor;

Drawer buildDrawer(BuildContext context) {
  return Drawer(
    backgroundColor: ThemeColors.getBackgroundColor(context),
    child: buildContainer(
      context,
      Column(
        spacing: 5,
        children: [
          Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: _primaryColor,
            ),
            height: height(200),
            child: Column(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: height(45),
                  backgroundColor: ThemeColors.getCardColor(context),
                  child: Padding(
                    padding: EdgeInsets.all(width(15)),
                    child: Image.asset(
                      'assets/images/logo.png',
                    ),
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.aonk,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: height(20),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          drawerItems(context, Icons.info,
              AppLocalizations.of(context)!.aboutAonk, const AboutUs()),
          drawerItems(
              context,
              Icons.notifications,
              AppLocalizations.of(context)!.notification,
              const NotificationScreen()),
          drawerItems(context, Icons.handshake_rounded,
              AppLocalizations.of(context)!.loyaltyProgram, () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  title: Text(
                    AppLocalizations.of(context)!.loyaltyProgram,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xff52b8a0),
                    ),
                  ),
                  content: Text(
                    AppLocalizations.of(context)!.loyaltyProgramSoon,
                    textAlign: TextAlign.center,
                  ),
                );
              },
            );
          }),
          drawerItems(context, Icons.shopping_bag,
              AppLocalizations.of(context)!.orderStatus, () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  title: Text(
                    AppLocalizations.of(context)!.orderStatus,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xff52b8a0),
                    ),
                  ),
                  content: Text(
                    AppLocalizations.of(context)!.orderStatusSoon,
                    textAlign: TextAlign.center,
                  ),
                );
              },
            );
          }),
          drawerItems(
              context,
              Icons.settings,
              AppLocalizations.of(context)!.settings,
              () => showSettingsDialog(context)),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(left: width(10)),
            child: Align(
              alignment: Alignment.topLeft,
              child: FloatingActionButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        title: Text(
                          AppLocalizations.of(context)!.alert,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff52b8a0),
                            fontWeight: FontWeight.bold,
                            fontSize: height(20),
                          ),
                        ),
                        content: Text(
                          AppLocalizations.of(context)!.alert2,
                          textAlign: TextAlign.center,
                        ),
                        actionsAlignment: MainAxisAlignment.spaceEvenly,
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Close dialog
                              GetStorage().erase();
                              Provider.of<PagesProvider>(context, listen: false)
                                  .resetValues();
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const FirstTime()),
                                (route) => false,
                              );
                            },
                            child: Text(
                              AppLocalizations.of(context)!.deleteAccount,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: height(12),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Close dialog
                            },
                            child: Text(
                              AppLocalizations.of(context)!.cancel,
                              style: TextStyle(
                                color: Color(0xff52b8a0),
                                fontSize: height(12),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                heroTag: null,
                tooltip: AppLocalizations.of(context)!.deleteAccount,
                backgroundColor: Color(0xff84beb0),
                child: Icon(
                  Icons.logout,
                  color: Colors.white,
                  size: width(20),
                ),
              ),
            ),
          ),
          Gap(height(10)),
        ],
      ),
    ),
  );
}

ListTile drawerItems(
    BuildContext context, IconData icon, String title, dynamic page) {
  return ListTile(
    leading: Icon(icon, color: ThemeColors.iconColor),
    title: Text(
      title,
      style: TextStyle(
        color: ThemeColors.getTextColor(context),
      ),
    ),
    onTap: () {
      if (page is Widget) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      } else if (page is Function) {
        page();
      }
    },
  );
}

void showSettingsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: ThemeColors.getCardColor(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        title: Text(
          AppLocalizations.of(context)!.settings,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ThemeColors.getDialogTitleColor(context),
            fontSize: height(18),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Consumer<ThemeProvider>(
            //   builder: (context, themeProvider, child) {
            //     return ListTile(
            //       leading: Icon(
            //         themeProvider.isDarkMode
            //             ? Icons.dark_mode
            //             : Icons.light_mode,
            //         color: ThemeColors.iconColor,
            //         size: height(24),
            //       ),
            //       title: Text(
            //         themeProvider.isDarkMode
            //             ? AppLocalizations.of(context)!.darkMode
            //             : AppLocalizations.of(context)!.lightMode,
            //         style: TextStyle(
            //           fontFamily: 'Marhey',
            //           color: ThemeColors.getTextColor(context),
            //           fontSize: height(16),
            //         ),
            //       ),
            //       trailing: Switch(
            //         value: themeProvider.isDarkMode,
            //         onChanged: (value) {
            //           themeProvider.toggleTheme();
            //         },
            //         activeColor: ThemeColors.accentColor,
            //       ),
            //     );
            //   },
            // ),
            Consumer<LocaleProvider>(builder: (context, localeProvider, child) {
              return ListTile(
                leading: Icon(
                  Icons.language,
                  color: ThemeColors.iconColor,
                  size: height(24),
                ),
                title: SizedBox(
                  width: width(100),
                  child: Text(
                    AppLocalizations.of(context)!.language,
                    style: TextStyle(
                      color: ThemeColors.getTextColor(context),
                      fontSize: height(14),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      localeProvider.locale.languageCode == 'ar'
                          ? 'عربي'
                          : 'English',
                      style: TextStyle(
                        color: ThemeColors.getTextColor(context),
                        fontSize: height(12),
                      ),
                    ),
                    Switch(
                      value: localeProvider.locale.languageCode == 'ar',
                      onChanged: (value) {
                        localeProvider.setLocale(
                            value ? const Locale('ar') : const Locale('en'),
                            context);
                      },
                      activeColor: ThemeColors.accentColor,
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      );
    },
  );
}
