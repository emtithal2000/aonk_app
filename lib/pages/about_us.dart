import 'package:aonk_app/location.dart';
import 'package:aonk_app/size_config.dart';
import 'package:aonk_app/value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
            icon: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: const Icon(IconsaxPlusBroken.arrow_right_3),
            ),
            color: const Color(0xff84beb0),
            iconSize: height(35),
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
                height: height(600),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          const TextSpan(text: '\n'),
                          TextSpan(
                            text: AppLocalizations.of(context)!.whatIsAonk,
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
                            text: AppLocalizations.of(context)!.aonkDescription,
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
                                AppLocalizations.of(context)!.aonkDescription3,
                            style: TextStyle(
                              fontSize: height(15),
                              color: Colors.black,
                            ),
                          ),
                          const TextSpan(text: '\n'),
                          TextSpan(
                            text:
                                AppLocalizations.of(context)!.aonkDescription4,
                            style: TextStyle(
                              fontSize: height(13),
                              color: Colors.black,
                            ),
                          ),
                          const TextSpan(text: '\n\n'),
                          TextSpan(
                            text:
                                AppLocalizations.of(context)!.aonkDescription5,
                            style: TextStyle(
                              fontSize: height(15),
                              color: const Color(0xff84beb0),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(height(20)),
                    Center(
                      child: SizedBox(
                        height: height(50),
                        width: width(170),
                        child: ListView.separated(
                          itemCount: 3,
                          separatorBuilder: (context, index) => Gap(width(10)),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.all(8),
                              height: height(30),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xff84beb0)
                                        .withOpacity(0.8),
                                    blurRadius: 5,
                                    spreadRadius: 1,
                                  ),
                                ],
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  launchUrlString(contactLinks[index]);
                                },
                                child: Image.asset(
                                  contactImage[index],
                                ),
                              ),
                            );
                          },
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
