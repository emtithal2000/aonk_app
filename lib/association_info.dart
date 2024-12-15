import 'package:aonk_app/pages/pages_provider.dart';
import 'package:aonk_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AssociationInfo extends StatelessWidget {
  const AssociationInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PagesProvider>(builder: (_, provider, __) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              'جمعية خيرية تطوعية تهدف إلى مساعدة الفئة المعسرة الأقل حظا في المجتمع، والهدف الأساسي للجمعية هو تمكين الناس ومساعدتهم على تغيير أوضاعهم الاجتماعية نحو الأفضل.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: width(19),
                color: Colors.black,
              ),
            ),
          ),
          Gap(height(20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () async {
                  const url = 'https://daralatta.org/ar/';
                  await launchUrl(Uri.parse(url));
                },
                child: Image.asset(
                  'assets/images/globe.png',
                  width: width(33),
                  color: const Color(0xff81bdaf),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  const number = '+96824162601';
                  await launchUrlString("tel://$number");
                },
                child: Image.asset(
                  'assets/images/viber.png',
                  width: width(30),
                  color: const Color(0xff81bdaf),
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}

  // Future<void> _callNumber() async {
  //   const number = '+96824162601';
  //   try {
  //     bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  //     if (res == false) {
  //       final Uri phoneUri = Uri(scheme: 'tel', path: number);
  //       if (await canLaunchUrl(phoneUri)) {
  //         await launchUrl(phoneUri);
  //       }
  //     }
  //   } catch (e) {
  //     debugPrint('Error making phone call: $e');
  //   }
  // }

