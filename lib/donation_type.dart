import 'package:aonk_app/size_config.dart';
import 'package:aonk_app/value.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

// Add these lists at the top of the file, outside the class

class DonationType extends StatelessWidget {
  const DonationType({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background2.png'),
              opacity: 0.5,
              fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              height: height(320),
              width: width(330),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xff18af89).withOpacity(0.5),
                    blurRadius: 10,
                    // spreadRadius: 4,
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
                            text: 'اختر نوع التبرع',
                            style: TextStyle(
                              fontSize: height(18),
                              color: Colors.black,
                              fontFamily: 'Marhey',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Gap(height(30)),
                  SizedBox(
                    height: height(140),
                    width: width(320),
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: height(10),
                        crossAxisSpacing: width(20),
                        childAspectRatio: 0.5,
                      ),
                      itemBuilder: (context, index) => Column(
                        children: [
                          Container(
                            height: height(100),
                            width: width(100),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.4),
                                  blurRadius: 10,
                                ),
                              ],
                              color: Colors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: donationTypeImages[index],
                            ),
                          ),
                          Gap(height(15)),
                          Text(
                            donationType[index],
                            style: TextStyle(
                              fontSize: height(16),
                              fontFamily: 'Marhey',
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      itemCount: donationTypeImages.length,
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
