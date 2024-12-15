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
            iconSize: 30,
          ),
          Gap(width(10)),
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            opacity: 0.4,
            image: AssetImage('assets/images/background2.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Lottie.asset(
                'assets/images/notification.json',
                height: height(190),
                repeat: false,
              ),
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
