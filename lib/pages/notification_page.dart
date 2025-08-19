import 'package:aonk_app/l10n/app_localizations.dart';
import 'package:aonk_app/location.dart';
import 'package:aonk_app/pages/home.dart';
import 'package:aonk_app/providers/pages_provider.dart';
import 'package:aonk_app/size_config.dart';
import 'package:aonk_app/theme/color_pallate.dart';
import 'package:aonk_app/value.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:provider/provider.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0, //This
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.notification,
          style: TextStyle(
            color: ColorPallate.primary,
            fontSize: height(25),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context,
                  MaterialPageRoute(builder: (context) => const Home()));
            },
            icon: const Icon(IconsaxPlusBroken.arrow_left_2),
            color: const Color(0xff81bdaf),
            iconSize: height(30),
          ),
        ],
      ),
      body: buildContainer(
        context,
        Column(
          children: [
            Expanded(
              child: SafeArea(
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.white,
                      elevation: 5,
                      margin: EdgeInsets.symmetric(
                        vertical: height(8),
                        horizontal: width(20),
                      ),
                      child: ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Color(0xff81bdaf),
                          child: Icon(IconsaxPlusBroken.notification_1,
                              color: Colors.white),
                        ),
                        title: Text(
                          AppLocalizations.of(context)!.thereIsNotification,
                          style: TextStyle(
                            fontSize: height(14),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notification[index],
                              style: TextStyle(
                                fontSize: height(12),
                                color: const Color(0xff81bdaf),
                              ),
                            ),
                            if (notification[index] == "تقييم الخدمة")
                              GestureDetector(
                                child: Icon(
                                  Icons.archive_rounded,
                                  color: Colors.black26,
                                  size: 30,
                                ),
                                onTap: () {
                                  buildRateDialog(context);
                                },
                              ),
                          ],
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "13Aug",
                              style: TextStyle(
                                fontSize: height(10),
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              'منذ ساعتين ',
                              style: TextStyle(
                                fontSize: height(10),
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column buildRate(
      PagesProvider provider, String title, RatingType ratingType) {
    int rateIndex = ratingType == RatingType.service
        ? provider.serviceIndex
        : ratingType == RatingType.driver
            ? provider.driverIndex
            : provider.callCenterIndex;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Service Rating
        Text(
          title,
          style: TextStyle(
            fontSize: height(14),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            emojis.length,
            (index) => GestureDetector(
              onTap: () {
                provider.setIndex(index, ratingType);
              },
              child: Container(
                decoration: index == rateIndex
                    ? BoxDecoration(
                        border: Border.all(
                          color: Colors.black54,
                          width: 2,
                        ),
                        shape: BoxShape.circle,
                      )
                    : null,
                child: Text(
                  emojis[index],
                  style: TextStyle(
                    fontSize: width(35),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<dynamic> buildRateDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          AppLocalizations.of(context)!.pleaseRate,
          style: TextStyle(
            fontSize: height(20),
            fontWeight: FontWeight.bold,
            color: ColorPallate.primary,
          ),
        ),
        content: Consumer<PagesProvider>(
          builder: (context, provider, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildRate(provider, AppLocalizations.of(context)!.service,
                    RatingType.service),
                buildRate(provider, AppLocalizations.of(context)!.driver,
                    RatingType.driver),
                buildRate(provider, AppLocalizations.of(context)!.callCenter,
                    RatingType.callCenter),
                Gap(30),
                TextField(
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.pleaseEnterComment,
                    hintStyle: TextStyle(
                      fontSize: height(14),
                      color: ColorPallate.primary,
                    ),
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
              ],
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              AppLocalizations.of(context)!.cancel,
              style: TextStyle(
                color: ColorPallate.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              // Handle all ratings submission here
              Navigator.pop(context);
            },
            child: Text(
              AppLocalizations.of(context)!.send,
              style: TextStyle(
                color: ColorPallate.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
