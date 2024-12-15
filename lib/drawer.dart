import 'package:aonk_app/about_us.dart';
import 'package:aonk_app/login.dart';
import 'package:aonk_app/navigation_bar.dart';
import 'package:aonk_app/notification_page.dart';
import 'package:aonk_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

// Create a reusable text style
const _menuTextStyle = TextStyle(
  fontFamily: 'Marhey',
  fontSize: 16,
);

const _primaryColor = Color(0xff84beb0);

Drawer buildDrawer(BuildContext context) {
  return Drawer(
    child: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          opacity: 0.3,
          image: AssetImage('assets/images/background2.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildDrawerHeader(),
          drawerItems(context, Icons.info, 'عن عونك', const AboutUs()),
          drawerItems(
              context, Icons.person, 'الملف الشخصي', const LoginScreen()),
          drawerItems(context, Icons.notifications, 'الاشعارات',
              const NotificationPage()),
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
          drawerItems(context, Icons.logout, 'تسجيل الخروج', null),
        ],
      ),
    ),
  );
}

ListTile drawerItems(
    BuildContext context, IconData icon, String title, dynamic page) {
  return ListTile(
    leading: Icon(icon, color: _primaryColor),
    title: Text(title, style: _menuTextStyle),
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

Widget _buildDrawerHeader() {
  return DrawerHeader(
    decoration: const BoxDecoration(color: _primaryColor),
    child: Column(
      children: [
        CircleAvatar(
          radius: 45,
          backgroundColor: Colors.white,
          child: Image.asset(
            'assets/images/logo.png',
            height: 60,
            color: _primaryColor,
          ),
        ),
        Gap(height(10)),
        const Text(
          'عونك',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontFamily: 'Marhey',
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

ListTile _buildMenuItem(
    BuildContext context, Map<String, dynamic> item, int index) {
  return ListTile(
    leading: Icon(item['icon'] as IconData, color: _primaryColor),
    title: Text(item['title'] as String, style: _menuTextStyle),
    onTap: () {
      if (index == 6) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NavigationBarPage()),
        );
      } else {
        Navigator.pop(context);
      }
    },
  );
}
