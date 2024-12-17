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
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background2.png'),
              opacity: 0.2,
              fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(30.0),
              height: height(680),
              width: width(330),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xff84beb0).withOpacity(0.1),
                    blurRadius: 10,
                  ),
                ],
                color: const Color(0xff84beb0).withOpacity(0.3),
                border: Border.all(
                  color: const Color(0xff84beb0).withOpacity(0.1),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xff84beb0).withOpacity(0.5),
                    const Color(0xff84beb0).withOpacity(0.2),
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    height: height(120),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xff84beb0).withOpacity(0.6),
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
                          TextSpan(
                            text:
                                'تطبيق ذكي للتخلص من كل ما هو قديم وفائض عن الحاجة',
                            style: TextStyle(
                              fontSize: height(15),
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
                                'بما في ذلك: ملابس - أحذية - بطانيات-أواني اثاث-كهربائيات - أوراق-كتب وإرسالها الى الجهة المختصة حسب الدولة والجهة المستهدفة ...',
                            style: TextStyle(
                              fontSize: height(13),
                              color: Colors.black,
                            ),
                          ),
                          const TextSpan(text: '\n'),
                          TextSpan(
                            text:
                                'تقوم ببيعها الى الجهة المختصصة في مجالها ومن ثم إنفاق ريعيها لدعم الأسر المحتاجة ودعم تعليم أبناهم والبرامج الخيرية الأخرى. حيث يمكنكم من خلال هذا التطبيق تحديد موقعكم وإختيار الوقت المناسب لزيارتكم و تسليم كل ما ترغبون في التبرع به. حيث هدفنا هو " تخفيف عبء النقل عنكم .  ',
                            style: TextStyle(
                              fontSize: height(13),
                              color: Colors.black,
                            ),
                          ),
                          const TextSpan(text: '\n\n'),
                          TextSpan(
                            text:
                                'ذا ندعوكم لاستخدام هذا التطبيق كي تصنعو فارقا مهما في العمل الخيري . "والدال" على الخير كفاعله. ',
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
          ],
        ),
      ),
    );
  }
}
