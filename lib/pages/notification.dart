import 'package:aonk_app/location.dart';
import 'package:aonk_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:lottie/lottie.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(IconsaxPlusBroken.arrow_left_2),
            color: const Color(0xff84beb0),
            iconSize: height(30),
          ),
          Gap(width(10)),
        ],
      ),
      body: buildContainer(
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/images/notification.json',
              height: height(300),
              repeat: false,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'الاشعارات',
                    style: TextStyle(
                      fontSize: height(25),
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Marhey',
                    ),
                  ),
                  const TextSpan(
                    text: '\n',
                  ),
                  TextSpan(
                    text: 'لا يوجد اشعارات',
                    style: TextStyle(
                      fontSize: height(24),
                      color: Colors.black,
                      fontFamily: 'Marhey',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
