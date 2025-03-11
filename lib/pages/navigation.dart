import 'package:aonk_app/location.dart';
import 'package:aonk_app/pages/customer_info.dart';
import 'package:aonk_app/pages/home.dart';
import 'package:aonk_app/providers/pages_provider.dart';
import 'package:aonk_app/size_config.dart';
import 'package:aonk_app/sub_pages/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Navigation extends StatelessWidget {
  const Navigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PagesProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          drawer: buildDrawer(context),
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
            // shape: const RoundedRectangleBorder(
            //   borderRadius: BorderRadius.vertical(
            //     bottom: Radius.circular(50),
            //   ),
            // ),
            shadowColor: Colors.grey.withOpacity(0.4),
            elevation: 8,
            title: Text(
              AppLocalizations.of(context)!.appbarTitle,
              style: TextStyle(
                fontSize: height(23),
                fontFamily: 'Marhey',
                color: Colors.white,
              ),
            ),
          ),
          // appBar: PreferredSize(
          //   preferredSize: Size.fromHeight(width(80)),
          //   child: Container(
          //     decoration: BoxDecoration(
          //       color: const Color(0xff81bdaf),
          //       borderRadius: const BorderRadius.vertical(
          //         bottom: Radius.circular(50),
          //       ),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.withOpacity(0.4),
          //     blurRadius: 5,
          //     spreadRadius: 5,
          //   ),
          // ],
          //     ),
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Gap(height(60)),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Row(
          //               children: [
          //                 Gap(width(10)),
          //                 IconButton(
          //                   onPressed: () {},
          //                   icon: const Icon(Icons.menu),
          //                 ),
          //               ],
          //             ),
          //             const Spacer(),
          //             Text(
          //               title[provider.pageIndex],
          //               style: TextStyle(
          //                 fontSize: height(20),
          //                 fontFamily: 'Marhey',
          //                 color: Colors.white,
          //               ),
          //             ),
          //             const Spacer(),
          //           ],
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
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
                height: height(70),
                shape: const CircularNotchedRectangle(),
                color: const Color(0xff81bdaf),
                notchMargin: width(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                          const number = '+96880006000';
                          await launchUrlString("tel://$number");
                        },
                        child: const Icon(
                          IconsaxPlusBroken.call,
                          color: Colors.white,
                        )),
                  ],
                ),
              ),
            ),
          ),
          resizeToAvoidBottomInset: false,
        );
      },
    );
  }
}
