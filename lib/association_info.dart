import 'package:aonk_app/drawer.dart';
import 'package:aonk_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AssociationInfo extends StatelessWidget {
  const AssociationInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildDrawer(context),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background2.png'),
            opacity: 0.5,
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Dialog(
              backgroundColor: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.all(15.0),
                height: height(290),
                width: width(330),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xff18af89).withOpacity(0.5),
                      blurRadius: 10,
                    ),
                  ],
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'جمعية دار العطاء',
                              style: TextStyle(
                                fontSize: height(20),
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Marhey',
                              ),
                            ),
                            const TextSpan(
                              text: '\n',
                            ),
                            TextSpan(
                              text:
                                  'جمعية خيرية تطوعية تهدف إلى مساعدة الفئة المعسرة الأقل حظا في المجتمع، والهدف الأساسي للجمعية هو تمكين الناس ومساعدتهم على تغيير أوضاعهم الاجتماعية نحو الأفضل',
                              style: TextStyle(
                                fontSize: height(20),
                                color: Colors.black,
                              ),
                            ),
                          ],
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
                            height: height(35),
                            width: width(35),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            const number = '+96824162601';
                            await launchUrlString("tel://$number");
                          },
                          child: Image.asset(
                            'assets/images/viber.png',
                            height: height(35),
                            width: width(35),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
}
