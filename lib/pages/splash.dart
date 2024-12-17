import 'package:aonk_app/pages/navigation.dart';
import 'package:aonk_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            opacity: 0.3,
            image: AssetImage('assets/images/background2.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
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
                fontFamily: 'Marhey',
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
    Future.delayed(
      const Duration(seconds: 3),
      () {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Navigation(),
            ),
          );
        }
      },
    );
  }
}
