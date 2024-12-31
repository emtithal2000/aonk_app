import 'package:aonk_app/location.dart';
import 'package:aonk_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

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
        ],
      ),
      body: buildContainer(
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Container(
                padding: const EdgeInsets.all(30.0),
                height: height(550),
                width: width(330),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: const Color(0xff84beb0).withOpacity(0.7),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xff84beb0).withOpacity(0.3),
                      const Color(0xff84beb0).withOpacity(0.5),
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      height: height(100),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xff84beb0).withOpacity(0.8),
                            blurRadius: 5,
                            spreadRadius: 1,
                          ),
                        ],
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Image.asset(
                        "assets/images/logo.png",
                      ),
                    ),
                    Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            const TextSpan(text: '\n'),
                            TextSpan(
                              text: 'ما هو عونك؟!!',
                              style: TextStyle(
                                fontSize: width(23),
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Marhey',
                              ),
                            ),
                            const TextSpan(text: '\n'),
                            const TextSpan(text: '\n'),
                            TextSpan(
                              text:
                                  'تطبيق ذكي للتخلص من كل ما هو قديم وفائض عن الحاجة',
                              style: TextStyle(
                                fontSize: height(18),
                                color: const Color(0xff84beb0),
                                fontFamily: 'Marhey',
                              ),
                            ),
                            const TextSpan(
                              text: '\n',
                            ),
                            const TextSpan(text: '\n'),
                            TextSpan(
                              text:
                                  'كـ الملابس👕👚👗👖 ، الاحذية والحقائب 👜👞 ، الستائر و البطانيات و الشراشف 🛏 ، العاب الاطفال🎠🏓🎡 ، الاواني المنزلية 🍽 ، الكتب و الروايات 📚 و الاجهزة الالكترونية📺🔌 ',
                              style: TextStyle(
                                fontSize: height(15),
                                color: Colors.black,
                              ),
                            ),
                            const TextSpan(text: '\n'),
                            TextSpan(
                              text:
                                  '"لـ صالح الجهات الخيرية فالسلطنة  فــ هدفنا هو " تخفيف عبء النقل عنكم "',
                              style: TextStyle(
                                fontSize: height(13),
                                color: Colors.black,
                              ),
                            ),
                            const TextSpan(text: '\n\n'),
                            TextSpan(
                              text:
                                  'و لرفع خلفية معلوماتك عنا اكثر، يمكنك تصفح مواقع التواصل الاجتماعي الخاصة بنا ',
                              style: TextStyle(
                                fontSize: height(15),
                                color: const Color(0xff84beb0),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
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
}
