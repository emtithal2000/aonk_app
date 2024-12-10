import 'package:aonk_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

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
              fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Gap(height(40)),
            Image.asset(
              'assets/images/logo.png',
              height: height(130),
              width: width(130),
              // color: const Color(0xff84beb0),
            ),
            Gap(height(30)),
            Container(
              padding: const EdgeInsets.all(15.0),
              height: height(500),
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
                            text: 'عن المنصة',
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
                            text:
                                'تطبيق ذكي للتخلص من كل ما هو قديم وفائض عن الحاجة',
                            style: TextStyle(
                              fontSize: height(18),
                              color: Colors.black,
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
                              fontSize: height(15),
                              color: Colors.black,
                            ),
                          ),
                          const TextSpan(
                            text: '\n',
                          ),
                          const TextSpan(text: '\n'),
                          TextSpan(
                            text:
                                'تقوم ببيعها الى الجهة المختصصة في مجالها ومن ثم إنفاق ريعيها لدعم الأسر المحتاجة ودعم تعليم أبناهم والبرامج الخيرية الأخرى. حيث يمكنكم من خلال هذا التطبيق تحديد موقعكم وإختيار الوقت المناسب لزيارتكم و تسليم كل ما ترغبون في التبرع به. حيث هدفنا هو " تخفيف عبء النقل عنكم .  ',
                            style: TextStyle(
                              fontSize: height(15),
                              color: Colors.black,
                            ),
                          ),
                          const TextSpan(
                            text: '\n',
                          ),
                          const TextSpan(text: '\n'),
                          TextSpan(
                            text:
                                'ذا ندعوكم لاستخدام هذا التطبيق كي تصنعو فارقا مهما في العمل الخيري . والدال" على الخير كفاعله. ',
                            style: TextStyle(
                              fontSize: height(18),
                              color: Colors.black,
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
