import 'package:aonk_app/models/charities_model.dart';
import 'package:aonk_app/providers/locale_provider.dart';
import 'package:aonk_app/size_config.dart';
import 'package:aonk_app/theme/color_pallate.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AssociationInfo extends StatelessWidget {
  final CharitiesModel charity;
  const AssociationInfo({super.key, required this.charity});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              context.watch<LocaleProvider>().locale.languageCode == 'ar'
                  ? charity.descriptionAr ?? ''
                  : charity.descriptionEn ?? '',
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
                  var url = charity.website ?? '';
                  await launchUrl(Uri.parse(url));
                },
                child: Image.asset(
                  'assets/images/globe.png',
                  width: width(33),
                  color: ColorPallate.secondary,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  var number = charity.contactPhone;
                  await launchUrlString("tel://$number");
                },
                child: Image.asset(
                  'assets/images/viber.png',
                  width: width(30),
                  color: ColorPallate.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
