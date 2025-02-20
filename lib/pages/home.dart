import 'package:aonk_app/providers/pages_provider.dart';
import 'package:aonk_app/size_config.dart';
import 'package:aonk_app/sub_pages/association_info.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width(30)),
      child: Consumer<PagesProvider>(
        builder: (context, provider, _) {
          return FutureBuilder(
              future: provider.getCharities(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Column(
                  children: [
                    Gap(height(10)),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: height(20),
                          crossAxisSpacing: width(10),
                          childAspectRatio: 0.8,
                        ),
                        itemCount: provider.charities.length,
                        clipBehavior: Clip.none,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => Card(
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
                              // Gap(height(8)),
                              SizedBox(
                                width: width(120),
                                child: Text(
                                  provider.charities[index].charityName,
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
                                        provider.charities[index].charityName);
                                    showDialog(
                                      context: context,
                                      builder: (dialogContext) =>
                                          Consumer<PagesProvider>(
                                        builder: (_, dialogProvider, __) =>
                                            AlertDialog(
                                          title: Text(
                                            provider
                                                .charities[index].charityName,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: width(20),
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Marhey',
                                            ),
                                          ),
                                          content: dialogProvider.pages[
                                              dialogProvider.currentPage],
                                        ),
                                      ),
                                    ).whenComplete(() {
                                      Future.delayed(
                                          const Duration(milliseconds: 500),
                                          () {
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
                                  child: const Text('تبرع الان'),
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
                                              provider
                                                  .charities[index].charityName,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: height(22),
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Marhey',
                                                color: const Color(0xff81bdaf),
                                              ),
                                            ),
                                            content: AssociationInfo(
                                              charity:
                                                  provider.charities[index],
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
                                  child: const Text('معلومات'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              });
        },
      ),
    );
  }
}
