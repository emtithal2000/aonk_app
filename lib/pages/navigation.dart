import 'package:aonk_app/pages/customer_info.dart';
import 'package:aonk_app/sub_pages/drawer.dart';
import 'package:aonk_app/pages/home.dart';
import 'package:aonk_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  late PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(Icons.menu, color: Colors.white),
          );
        }),
      ),
      drawer: buildDrawer(context),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: const [
          Home(),
          CustomerInfo(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff81bdaf),
        shape: const CircleBorder(),
        onPressed: () {
          _pageController.jumpToPage(0);
        },
        child: Icon(
          IconsaxPlusBroken.home_1,
          size: height(25),
          color: Colors.white,
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
                  IconsaxPlusBroken.user,
                  color: Colors.white,
                ),
              ),
              GestureDetector(
                  onTap: () async {
                    const number = '+96880006000';
                    await launchUrlString("tel://$number");
                  },
                  child: const Icon(
                    IconsaxPlusBroken.call,
                    color: Colors.white,
                  )
                  // Image.asset(
                  //   'assets/images/viber.png',
                  //   height: height(22),
                  //   width: width(22),
                  //   color: Colors.white,
                  // ),
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
