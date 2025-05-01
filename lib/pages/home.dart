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
                  itemCount: provider.charities.length,
                  clipBehavior: Clip.none,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Consumer<LocaleProvider>(
                    builder: (context, localeProvider, _) => Card(
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
                              context
                                          .watch<LocaleProvider>()
                                          .locale
                                          .languageCode ==
                                      'ar'
                                  ? provider.charities[index].charityAr
                                  : provider.charities[index].charityEn,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: height(12),
                                fontFamily: 'Marhey',
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
                                provider.setCharity(
                                    provider.charities[index].charityEn);
                                showDialog(
                                  context: context,
                                  builder: (dialogContext) =>
                                      Consumer<PagesProvider>(
                                    builder: (_, dialogProvider, __) =>
                                        AlertDialog(
                                      title: Text(
                                        context
                                                    .watch<LocaleProvider>()
                                                    .locale
                                                    .languageCode ==
                                                'ar'
                                            ? provider
                                                .charities[index].charityAr
                                            : provider
                                                .charities[index].charityEn,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: width(20),
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Marhey',
                                        ),
                                      ),
                                      content: dialogProvider
                                          .pages[dialogProvider.currentPage],
                                    ),
                                  ),
                                ).whenComplete(() {
                                  Future.delayed(
                                      const Duration(milliseconds: 500), () {
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
                                showDialog(
                                  context: context,
                                  builder: (dialogContext) =>
                                      Consumer<PagesProvider>(
                                    builder: (_, dialogProvider, __) {
                                      return AlertDialog(
                                        title: Text(
                                          provider.charities[index].charityEn,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: height(22),
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Marhey',
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
                  ),
                ),
              ),
            ],
          );
        },
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
