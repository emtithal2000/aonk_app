import 'package:aonk_app/l10n/app_localizations.dart';
import 'package:aonk_app/location.dart';
import 'package:aonk_app/pages/customer_info.dart';
import 'package:aonk_app/pages/home.dart';
import 'package:aonk_app/providers/pages_provider.dart';
import 'package:aonk_app/size_config.dart';
import 'package:aonk_app/sub_pages/drawer.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:provider/provider.dart';

class Navigation extends StatelessWidget {
  const Navigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PagesProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          drawer: buildDrawer(context),
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: const Color(0xff81bdaf),
            centerTitle: true,
            leading: Builder(builder: (context) {
              return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(IconsaxPlusLinear.menu),
                color: Colors.white,
                iconSize: width(23),
              );
            }),
            shadowColor: Colors.grey.withOpacity(0.4),
            elevation: 8,
            title: Text(
              AppLocalizations.of(context)!.appbarTitle,
              style: TextStyle(
                fontSize: height(23),
                color: Colors.white,
              ),
            ),
          ),
          body: buildContainer(
            context,
            PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: provider.pageController,
              children: const [
                Home(),
                CustomerInfo(),
              ],
            ),
          ),
          floatingActionButton: Container(
            height: height(60),
            width: width(60),
            margin: EdgeInsets.zero,
            child: FloatingActionButton(
              backgroundColor: const Color(0xff81bdaf),
              shape: const CircleBorder(),
              onPressed: () {
                provider.jumpToPage(0);
              },
              child: Icon(
                IconsaxPlusBroken.home_1,
                size: height(25),
                color: Colors.white,
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: Container(
            color: Colors.transparent,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(35),
              ),
              child: BottomAppBar(
                height: height(50),
                shape: const CircularNotchedRectangle(),
                color: const Color(0xff81bdaf),
                notchMargin: width(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  spacing: width(50),
                  children: [
                    IconButton(
                      onPressed: () {
                        provider.jumpToPage(1);
                      },
                      icon: const Icon(
                        IconsaxPlusBroken.user,
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await provider.callAonk();
                      },
                      child: const Icon(
                        IconsaxPlusBroken.call,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
