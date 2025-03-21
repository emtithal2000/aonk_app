import 'package:aonk_app/location.dart';
import 'package:aonk_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:aonk_app/l10n/app_localizations.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:lottie/lottie.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

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
            icon: const Icon(IconsaxPlusBroken.arrow_right_3),
            color: const Color(0xff84beb0),
            iconSize: height(35),
          ),
        ],
      ),
      body: buildContainer(
        context,
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                        AppLocalizations.of(context)!.notificationsDescription,
                    style: TextStyle(
                      fontSize: height(24),
                      color: Colors.black,
                      fontFamily: 'Marhey',
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
