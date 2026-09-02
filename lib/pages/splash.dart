import 'package:aonk_app/location.dart';
import 'package:aonk_app/pages/first_time.dart';
import 'package:aonk_app/pages/navigation.dart';
import 'package:aonk_app/providers/driver_provider.dart';
import 'package:aonk_app/providers/pages_provider.dart';
import 'package:aonk_app/size_config.dart';
import 'package:aonk_app/theme/color_pallate.dart';
import 'package:aonk_app/version_check.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:aonk_app/pages/driver_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _scaleAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _initializeFirstCheck();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildContainer(
        context,
        ScaleTransition(
          scale: _scaleAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: height(150),
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.cover,
                ),
              ),
              Gap(height(50)),
              Text(
                "\"نحول ما لا تحتاجه الي خير\"",
                style: TextStyle(
                  color: ColorPallate.primary,
                  fontSize: height(30),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _initializeFirstCheck() async {
    Provider.of<PagesProvider>(context, listen: false).getCountries();
    await ensureLatestVersion(context);
    if (!mounted) return;

    Future.delayed(
      const Duration(milliseconds: 100),
      () async {
        if (!mounted) return;

        final driverProvider =
            Provider.of<DriverProvider>(context, listen: false);
        final hasDriverSession = await driverProvider.restoreSession();
        if (!mounted) return;

        if (hasDriverSession) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const DriverPage(),
            ),
          );
          return;
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => GetStorage().read('userData') != null
                ? Navigation()
                : FirstTime(),
          ),
        );
      },
    );
  }
}
