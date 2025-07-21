import 'package:aonk_app/location.dart';
import 'package:aonk_app/pages/home.dart';
import 'package:aonk_app/size_config.dart';
import 'package:aonk_app/theme/color_pallate.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0, //This
        centerTitle: true,
        title: Text(
          'الاشعارات',
          style: TextStyle(
            color: ColorPallate.primary,
            fontSize: height(25),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context,
                  MaterialPageRoute(builder: (context) => const Home()));
            },
            icon: const Icon(IconsaxPlusBroken.arrow_left_2),
            color: const Color(0xff81bdaf),
            iconSize: height(30),
          ),
        ],
      ),
      body: buildContainer(
        context,
        Column(
          children: [
            Expanded(
              child: SafeArea(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.white,
                      elevation: 5,
                      margin: EdgeInsets.symmetric(
                        vertical: height(8),
                        horizontal: width(20),
                      ),
                      child: ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Color(0xff81bdaf),
                          child: Icon(IconsaxPlusBroken.notification_1,
                              color: Colors.white),
                        ),
                        title: Text(
                          'الاشعار الاول',
                          style: TextStyle(
                            fontSize: height(16),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          'تم اضافة الاشعار الاول',
                          style: TextStyle(
                            fontSize: height(14),
                            color: const Color(0xff81bdaf),
                          ),
                        ),
                        trailing: Text(
                          'منذ ساعتين',
                          style: TextStyle(
                            fontSize: height(12),
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
