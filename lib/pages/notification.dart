import 'package:aonk_app/location.dart';
import 'package:aonk_app/providers/locale_provider.dart';
import 'package:aonk_app/size_config.dart';
import 'package:aonk_app/theme/color_pallate.dart';
import 'package:flutter/material.dart';
import 'package:aonk_app/l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: buildContainer(
        context,
        Column(
          children: [
            Gap(
              height(
                Theme.of(context).platform == TargetPlatform.iOS ? 50 : 15,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    context.watch<LocaleProvider>().locale.languageCode == 'ar'
                        ? IconsaxPlusBroken.arrow_left_2
                        : IconsaxPlusBroken.arrow_right_3,
                    color: ColorPallate.primary,
                    size: height(35),
                  ),
                  color: ColorPallate.primary,
                  iconSize: height(35),
                ),
              ],
            ),
            Spacer(),
            Lottie.asset(
              'assets/images/Animation - 1739950326716.json',
              height: height(300),
              repeat: false,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: AppLocalizations.of(context)!.notifications,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  const TextSpan(
                    text: '\n',
                  ),
                  TextSpan(
                    text:
                        AppLocalizations.of(context)!.notificationsDescription,
                    style: TextStyle(
                      fontSize: height(24),
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
