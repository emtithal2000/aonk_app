import 'package:aonk_app/l10n/app_localizations.dart';
import 'package:aonk_app/location.dart';
import 'package:aonk_app/providers/locale_provider.dart';
import 'package:aonk_app/providers/pages_provider.dart';
import 'package:aonk_app/size_config.dart';
import 'package:aonk_app/value.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    final language = Provider.of<LocaleProvider>(context).locale.languageCode;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: buildContainer(
        context,
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Gap(height(15)),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                language == 'ar'
                    ? IconsaxPlusBroken.arrow_left_2
                    : IconsaxPlusBroken.arrow_right_3,
                color: const Color(0xff84beb0),
                size: height(35),
              ),
            ),
            Gap(height(10)),
            Consumer<PagesProvider>(
              builder: (_, provider, __) {
                final data = provider.detailedCountry;
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: width(20),
                    vertical: height(10),
                  ),
                  alignment: Alignment.center,
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: width(10),
                        vertical: height(20),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: width(35),
                        vertical: height(20),
                      ),
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
                                  color:
                                      const Color(0xff84beb0).withOpacity(0.8),
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
                                  text:
                                      AppLocalizations.of(context)!.whatIsAonk,
                                  style: TextStyle(
                                    fontSize: width(23),
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const TextSpan(text: '\n \n'),
                                TextSpan(
                                  text: AppLocalizations.of(context)!
                                      .aonkDescription,
                                  style: TextStyle(
                                    fontSize: height(18),
                                    color: const Color(0xff2b6c59)
                                        .withOpacity(0.75),
                                  ),
                                ),
                                const TextSpan(text: '\n \n'),
                                TextSpan(
                                  text: language == 'ar'
                                      ? data?.detailsAr ?? ''
                                      : data?.detailsEn ?? '',
                                  style: TextStyle(
                                    fontSize: height(15),
                                    color: Colors.black,
                                  ),
                                ),
                                const TextSpan(text: '\n\n'),
                                TextSpan(
                                  text: AppLocalizations.of(context)!
                                      .aonkDescription5,
                                  style: TextStyle(
                                    fontSize: height(15),
                                    color: const Color(0xff2b6c59)
                                        .withOpacity(0.5),
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
                                separatorBuilder: (context, index) =>
                                    Gap(width(10)),
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
                                        launchUrlString(index == 0
                                            ? (data?.whatsappLink ?? '')
                                            : index == 1
                                                ? (data?.instaLink ?? '')
                                                : (data?.xLink ?? ''));
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
