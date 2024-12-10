import 'package:aonk_app/navigation_bar.dart';
import 'package:aonk_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

// Create a menu item model
const _menuItems = [
  {'icon': Icons.info, 'title': 'عن عونك'},
  {'icon': Icons.person, 'title': 'الملف الشخصي'},
  {'icon': Icons.notifications, 'title': 'الاشعارات'},
  {'icon': Icons.handshake_rounded, 'title': 'برنامج الولاء'},
  {'icon': Icons.shopping_bag, 'title': 'حالة الطلب'},
  {'icon': Icons.settings, 'title': 'الاعدادات'},
  {'icon': Icons.logout, 'title': 'تسجيل الخروج'},
];

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
          ..._menuItems.asMap().entries.map(
                (entry) => _buildMenuItem(context, entry.value, entry.key),
              ),
        ],
      ),
    ),
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
      if (index == _menuItems.length - 1) {
        // Last item (Logout)
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
