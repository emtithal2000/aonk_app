import 'package:aonk_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background2.png'),
            opacity: 0.4,
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Gap(height(40)),
              Text(
                'الاشعارات',
                style: TextStyle(
                  fontSize: height(25),
                  color: const Color(0xff84beb0),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Marhey',
                ),
              ),
              Gap(height(30)),
              buildInput('عنوان الاشعار', IconsaxPlusBroken.notification_1),
              Gap(height(15)),
              buildInput('عنوان الاشعار', IconsaxPlusBroken.notification),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInput(String hintText, IconData icon) {
    return Container(
      height: height(200),
      width: width(320),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.7),
            blurRadius: 10,
          ),
        ],
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          children: [
            Row(
              children: [
                Icon(icon, size: height(25), color: const Color(0xff84beb0)),
                Gap(width(10)),
                Column(
                  children: [
                    Text(
                      hintText,
                      style: TextStyle(
                        fontSize: height(18),
                        color: const Color(0xff84beb0),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Marhey',
                      ),
                    ),
                    const Text(
                      '15-5-2024',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  alignment: Alignment.center,
                  height: height(30),
                  width: width(50),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xff84beb0).withOpacity(0.3),
                  ),
                  child: const Text(
                    '08:00',
                  ),
                ),
              ],
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(20),
              height: height(100),
              width: width(320),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                color: const Color(0xff84beb0).withOpacity(0.3),
              ),
              child: const Text(
                'ggggggggggggggggggggggggggggggggg',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
