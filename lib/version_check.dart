import 'dart:developer' as developer;
import 'dart:io';

import 'package:aonk_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:new_version_plus/new_version_plus.dart';

/// Returns `true` when the user may continue (app is up to date).
/// Returns `false` when an update is required and the update dialog was shown.
Future<bool> ensureLatestVersion(BuildContext context) async {
  try {
    final newVersionPlus = NewVersionPlus();
    final status = await newVersionPlus.getVersionStatus();

    developer.log(
      'Version check — local: ${status?.localVersion}, '
      'store: ${status?.storeVersion}, canUpdate: ${status?.canUpdate}',
    );

    if (status?.canUpdate != true) {
      return true;
    }

    if (!context.mounted) {
      return false;
    }

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Directionality(
        textDirection: TextDirection.ltr,
        child: AlertDialog(
          title: Text(
            'Update Available!',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'A new version of the app is available. Please update to the latest version.',
              ),
              Gap(height(10)),
              Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              Gap(height(10)),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/svg/${Platform.isAndroid ? 'google-play' : 'app-store'}.svg',
                    width: width(35),
                  ),
                  Gap(width(5)),
                  Text(
                    Platform.isAndroid ? 'Google Play' : 'App Store',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontSize: width(13),
                    ),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      newVersionPlus.launchAppStore(
                        status!.appStoreLink,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Platform.isAndroid
                          ? const Color(0xff038a5d)
                          : const Color(0xff229df7),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text('Update'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );

    return false;
  } catch (e) {
    developer.log('Error checking for updates: $e');
    return true;
  }
}
