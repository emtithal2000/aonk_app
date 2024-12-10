import 'package:aonk_app/size_config.dart';
import 'package:aonk_app/value.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

class DonationImage extends StatelessWidget {
  const DonationImage({super.key});

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
                            text: 'قم بارفاق الصورة',
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
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: _buildDonationItem(
                                  "assets/images/camera2.png", donationPhoto[0],
                                  onTap: () async {
                                final ImagePicker picker = ImagePicker();
                                final XFile? photo = await picker.pickImage(
                                    source: ImageSource.camera);
                                if (photo != null) {
                                  // Handle the captured image
                                }
                              }),
                            ),
                            _buildDonationItem(
                                "assets/images/gallery.png", donationPhoto[1],
                                onTap: () async {
                              final ImagePicker picker = ImagePicker();
                              final XFile? photo = await picker.pickImage(
                                  source: ImageSource.gallery);
                              if (photo != null) {
                                // Handle the selected image
                              }
                            }),
                          ],
                        ),
                      ],
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

  Widget _buildDonationItem(String imagePath, String text,
      {Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: height(100),
            width: width(120),
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
            child: Image.asset(imagePath),
          ),
          Gap(height(15)),
          Text(
            text,
            style: TextStyle(
              fontSize: height(16),
              fontFamily: 'Marhey',
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
