import 'package:aonk_app/location.dart';
import 'package:aonk_app/pages/about_us.dart';
import 'package:aonk_app/pages/notification.dart';
import 'package:aonk_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aonk_app/providers/theme_provider.dart';
import 'package:aonk_app/theme/theme_colors.dart';

// Update the _primaryColor constant to use ThemeColors
const _primaryColor = ThemeColors.primaryColor;

// Create a reusable text style
final _menuTextStyle = TextStyle(
  fontFamily: 'Marhey',
  fontSize: height(16),
);

Drawer buildDrawer(BuildContext context) {
  return Drawer(
    backgroundColor: ThemeColors.getBackgroundColor(context),
    child: buildContainer(
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
                  'عونك',
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
          drawerItems(context, Icons.info, 'عن عونك', const AboutUs()),
          drawerItems(context, Icons.notifications, 'الاشعارات',
              const NotificationScreen()),
          drawerItems(context, Icons.handshake_rounded, 'برنامج الولاء', () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  title: const Text(
                    'برنامج الولاء',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xff52b8a0),
                      fontFamily: 'Marhey',
                    ),
                  ),
                  content: const Text(
                    'قريباً',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Marhey',
                    ),
                  ),
                );
              },
            );
          }),
          drawerItems(context, Icons.shopping_bag, 'حالة الطلب', () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  title: const Text(
                    'حالة الطلب',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xff52b8a0),
                      fontFamily: 'Marhey',
                    ),
                  ),
                  content: const Text(
                    'قريباً',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Marhey',
                    ),
                  ),
                );
              },
            );
          }),
          drawerItems(context, Icons.settings, 'الاعدادات', () => showSettingsDialog(context)),
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
          'الاعدادات',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ThemeColors.accentColor,
            fontFamily: 'Marhey',
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return ListTile(
                  leading: Icon(
                    themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                    color: ThemeColors.iconColor,
                  ),
                  title: Text(
                    themeProvider.isDarkMode ? 'الوضع الداكن' : 'الوضع الفاتح',
                    style: TextStyle(
                      fontFamily: 'Marhey',
                      color: ThemeColors.getTextColor(context),
                    ),
                  ),
                  trailing: Switch(
                    value: themeProvider.isDarkMode,
                    onChanged: (value) {
                      themeProvider.toggleTheme();
                    },
                    activeColor: ThemeColors.accentColor,
                  ),
                );
              },
            ),
          ],
        ),
      );
    },
  );
}
