import 'package:aonk_app/donation.dart';
import 'package:aonk_app/drawer.dart';
import 'package:aonk_app/login.dart';
import 'package:aonk_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

class NavigationBarPage extends StatefulWidget {
  const NavigationBarPage({super.key});

  @override
  State<NavigationBarPage> createState() => _NavigationBarPageState();
}

class _NavigationBarPageState extends State<NavigationBarPage> {
  late PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: buildDrawer(context),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: const [
          DonationPage(),
          LoginScreen(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff81bdaf),
        shape: const CircleBorder(),
        onPressed: () {
          _pageController.jumpToPage(0);
        },
        child: const Icon(
          Icons.home,
          size: 25,
          // color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(35),
        ),
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          color: const Color(0xff81bdaf),
          notchMargin: width(10),
          padding: EdgeInsets.symmetric(horizontal: width(50)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  _pageController.jumpToPage(1);
                },
                icon: const Icon(
                  IconsaxPlusBold.user,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  const number = '+96880006000';
                  await launchUrlString("tel://$number");
                },
                child: Image.asset(
                  'assets/images/viber.png',
                  height: height(22),
                  width: width(22),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }
}
