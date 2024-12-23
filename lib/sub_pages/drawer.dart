import 'package:aonk_app/pages/about_us.dart';
import 'package:aonk_app/pages/notification.dart';
import 'package:aonk_app/pages/splash.dart';
import 'package:aonk_app/size_config.dart';
import 'package:flutter/material.dart';

const _primaryColor = Color(0xff84beb0);

// Create a reusable text style
final _menuTextStyle = TextStyle(
  fontFamily: 'Marhey',
  fontSize: height(16),
);

Drawer buildDrawer(BuildContext context) {
  return Drawer(
    child: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          opacity: 0.2,
          image: AssetImage('assets/images/aonk-png.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
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
                  backgroundColor: Colors.white,
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
          drawerItems(context, Icons.shopping_bag, 'حالة الطلب', null),
          drawerItems(context, Icons.settings, 'الاعدادات', null),
          drawerItems(
              context, Icons.logout, 'تسجيل الخروج', const SplashScreen()),
        ],
      ),
    ),
  );
}

ListTile drawerItems(
    BuildContext context, IconData icon, String title, dynamic page) {
  return ListTile(
    leading: Icon(icon, color: const Color(0xff81bdaf)),
    title: Text(title,
        style: const TextStyle(
          fontFamily: 'Marhey',
          color: Colors.black87,
        )),
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
