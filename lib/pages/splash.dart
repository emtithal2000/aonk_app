import 'dart:io';

import 'package:aonk_app/location.dart';
import 'package:aonk_app/pages/first_time.dart';
import 'package:aonk_app/pages/navigation.dart';
import 'package:aonk_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get_storage/get_storage.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'dart:developer' as developer;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildContainer(
        context,
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: height(150),
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.cover,
                color: const Color(0xff52b8a0),
              ),
            ),
            Gap(height(50)),
            Text(
              "\"نحول ما لا تحتاجه الي خير\"",
              style: TextStyle(
                color: const Color(0xff52b8a0),
                fontSize: height(30),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _checkVersion(context);
  }

  Future<void> _checkVersion(BuildContext context) async {
    try {
      final newVersionPlus = NewVersionPlus();
      final status = await newVersionPlus.getVersionStatus();

      if (status?.canUpdate == true) {
        if (context.mounted) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
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
          );
        }
      } else {
        _initializeFiirstCheck();
      }
    } catch (e) {
      developer.log('Error checking for updates: $e');
    }
  }

  Future<void> _initializeFiirstCheck() async {
    if (mounted) {
      Future.delayed(
        const Duration(seconds: 3),
        () {
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => GetStorage().read('userData') != null
                    ? const Navigation()
                    : const FirstTime(),
              ),
            );
          }
        },
      );
    }
  }
}
