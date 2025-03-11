import 'package:aonk_app/l10n/l10n.dart';
import 'package:aonk_app/location.dart';
import 'package:aonk_app/pages/about_us.dart';
import 'package:aonk_app/pages/notification.dart';
import 'package:aonk_app/providers/locale_provider.dart';
import 'package:aonk_app/size_config.dart';
import 'package:aonk_app/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
                    fontFamily: 'Marhey',
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
                      fontFamily: 'Marhey',
                    ),
                  ),
                  content: Text(
                    AppLocalizations.of(context)!.loyaltyProgramSoon,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Marhey',
                    ),
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
                      fontFamily: 'Marhey',
                    ),
                  ),
                  content: Text(
                    AppLocalizations.of(context)!.orderStatusSoon,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Marhey',
                    ),
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
          // drawerItems(
          //     context, Icons.logout, 'تسجيل الخروج', const SplashScreen()),
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
        fontFamily: 'Marhey',
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
            fontFamily: 'Marhey',
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
                      fontFamily: 'Marhey',
                      color: ThemeColors.getTextColor(context),
                      fontSize: height(16),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                trailing: DropdownButton<Locale>(
                  borderRadius: BorderRadius.circular(10),
                  value: localeProvider.locale,
                  items: L10n.all.map((locale) {
                    return DropdownMenuItem(
                      value: locale,
                      child: Text(
                        locale.languageCode == 'ar'
                            ? AppLocalizations.of(context)!.arabic
                            : AppLocalizations.of(context)!.english,
                        style: TextStyle(
                          fontFamily: 'Marhey',
                          color: ThemeColors.getTextColor(context),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (Locale? newLocale) {
                    if (newLocale != null) {
                      localeProvider.setLocale(newLocale);
                    }
                  },
                ),
              );
            }),
          ],
        ),
      );
    },
  );
}
