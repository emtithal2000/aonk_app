import 'package:aonk_app/l10n/app_localizations.dart';
import 'package:aonk_app/location.dart';
import 'package:aonk_app/pages/customer_info.dart';
import 'package:aonk_app/pages/first_time.dart';
import 'package:aonk_app/pages/home.dart';
import 'package:aonk_app/providers/locale_provider.dart';
import 'package:aonk_app/providers/pages_provider.dart';
import 'package:aonk_app/size_config.dart';
import 'package:aonk_app/sub_pages/drawer.dart';
import 'package:aonk_app/theme/color_pallate.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
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
            backgroundColor: ColorPallate.primary,
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
            title: Text(
              AppLocalizations.of(context)!.appbarTitle,
              style: TextStyle(
                fontSize: height(23),
                color: Colors.white,
              ),
            ),
            actions: [
              RotatedBox(
                quarterTurns:
                    context.watch<LocaleProvider>().locale.languageCode == 'ar'
                        ? 0
                        : 2,
                child: IconButton(
                  onPressed: () {
                    GetStorage().erase();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FirstTime(),
                      ),
                    );
                  },
                  icon: const Icon(IconsaxPlusLinear.logout),
                  color: Colors.white,
                ),
              ),
            ],
          ),
          body: buildContainer(
            context,
            PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: provider.pageController,
              children: [
                Home(),
                CustomerInfo(),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: ColorPallate.primary,
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
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: Container(
            color: Colors.transparent,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(35),
              ),
              child: BottomAppBar(
                height: width(50),
                shape: const CircularNotchedRectangle(),
                color: ColorPallate.primary,
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
                    InkWell(
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
