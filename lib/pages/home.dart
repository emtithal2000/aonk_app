import 'package:aonk_app/l10n/app_localizations.dart';
import 'package:aonk_app/providers/locale_provider.dart';
import 'package:aonk_app/providers/pages_provider.dart';
import 'package:aonk_app/size_config.dart';
import 'package:aonk_app/sub_pages/association_info.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width(30)),
      child: Consumer<PagesProvider>(
        builder: (context, provider, _) {
          if (provider.charities.isEmpty) {
            return _buildShimmerLoading();
          }
          return Column(
            mainAxisAlignment: provider.charities.length < 2
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              Gap(height(10)),
              provider.charities.length < 2
                  ? buildSingleCard(provider, 0, context)
                  : Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: height(10),
                          crossAxisSpacing: height(20),
                          childAspectRatio: 0.75,
                        ),
                        itemCount: provider.charities.length,
                        clipBehavior: Clip.none,
                        shrinkWrap: true,
                        itemBuilder: (context, index) =>
                            Consumer<LocaleProvider>(
                          builder: (context, localeProvider, _) =>
                              buildCard(provider, index, context),
                        ),
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }

  Widget buildCard(PagesProvider provider, int index, BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 6,
      color: Colors.white,
      child: Column(
        children: [
          Gap(height(10)),
          Image.network(
            provider.charities[index].logo,
            height: height(60),
          ),
          SizedBox(
            width: width(120),
            child: Text(
              context.watch<LocaleProvider>().locale.languageCode == 'ar'
                  ? provider.charities[index].charityAr
                  : provider.charities[index].charityEn,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: height(12),
                color: const Color.fromARGB(181, 0, 0, 0),
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Gap(height(10)),
          SizedBox(
            height: height(30),
            width: width(100),
            child: FloatingActionButton(
              heroTag: null,
              onPressed: () {
                provider.setCharity(provider.charities[index].charityEn);
                buildDonation(context, provider, index).whenComplete(() {
                  Future.delayed(const Duration(milliseconds: 500), () {
                    if (context.mounted) {
                      provider.reset();
                    }
                  });
                });
              },
              backgroundColor: const Color(0xff81bdaf),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                AppLocalizations.of(context)!.donate,
              ),
            ),
          ),
          Gap(height(10)),
          SizedBox(
            height: height(30),
            width: width(100),
            child: FloatingActionButton(
              heroTag: null,
              onPressed: () {
                buildINformation(context, provider, index);
              },
              backgroundColor: const Color(0xff81bdaf),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                AppLocalizations.of(context)!.information,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> buildDonation(
      BuildContext context, PagesProvider provider, int index) {
    return showDialog(
      context: context,
      builder: (dialogContext) => Consumer<PagesProvider>(
        builder: (_, dialogProvider, __) => AlertDialog(
          title: Text(
            context.watch<LocaleProvider>().locale.languageCode == 'ar'
                ? provider.charities[index].charityAr
                : provider.charities[index].charityEn,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: width(20),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: dialogProvider.pages[dialogProvider.currentPage],
        ),
      ),
    );
  }

  Future<dynamic> buildINformation(
      BuildContext context, PagesProvider provider, int index) {
    return showDialog(
      context: context,
      builder: (dialogContext) => Consumer<PagesProvider>(
        builder: (_, dialogProvider, __) {
          return AlertDialog(
            title: Text(
              context.watch<LocaleProvider>().locale.languageCode == 'ar'
                  ? provider.charities[index].charityAr
                  : provider.charities[index].charityEn,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: height(22),
                fontWeight: FontWeight.bold,
                color: const Color(0xff81bdaf),
              ),
            ),
            content: AssociationInfo(
              charity: provider.charities[index],
            ),
          );
        },
      ),
    );
  }

  Widget buildSingleCard(
      PagesProvider provider, int index, BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 6,
      color: Colors.white,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: width(10), vertical: height(25)),
        child: Column(
          children: [
            Image.network(
              provider.charities[index].logo,
              height: height(100),
            ),
            SizedBox(
              width: width(200),
              child: Text(
                context.watch<LocaleProvider>().locale.languageCode == 'ar'
                    ? provider.charities[index].charityAr
                    : provider.charities[index].charityEn,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: height(16),
                  color: const Color.fromARGB(181, 0, 0, 0),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Gap(height(20)),
            SizedBox(
              height: height(40),
              width: width(150),
              child: FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  provider.setCharity(provider.charities[index].charityEn);
                  buildDonation(context, provider, index).whenComplete(() {
                    Future.delayed(const Duration(milliseconds: 500), () {
                      if (context.mounted) {
                        provider.reset();
                      }
                    });
                  });
                },
                backgroundColor: const Color(0xff81bdaf),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  AppLocalizations.of(context)!.donate,
                ),
              ),
            ),
            Gap(height(20)),
            SizedBox(
              height: height(40),
              width: width(150),
              child: FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  buildINformation(context, provider, index);
                },
                backgroundColor: const Color(0xff81bdaf),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  AppLocalizations.of(context)!.information,
                ),
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
    Provider.of<PagesProvider>(context, listen: false).getCharities();
  }

  Widget _buildShimmerLoading() {
    return Column(
      children: [
        Gap(height(10)),
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: height(10),
              crossAxisSpacing: height(20),
              childAspectRatio: 0.75,
            ),
            itemCount: 6, // Show 6 shimmer items while loading
            clipBehavior: Clip.none,
            shrinkWrap: true,
            itemBuilder: (context, index) => Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.white,
                child: Column(
                  children: [
                    Gap(height(10)),
                    Container(
                      height: height(60),
                      width: height(60),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Gap(height(10)),
                    Container(
                      width: width(120),
                      height: height(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    Gap(height(10)),
                    Container(
                      height: height(30),
                      width: width(100),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Gap(height(10)),
                    Container(
                      height: height(30),
                      width: width(100),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
