import 'package:aonk_app/providers/pages_provider.dart';
import 'package:aonk_app/size_config.dart';
import 'package:aonk_app/sub_pages/association_info.dart';
import 'package:aonk_app/value.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(height(60)),
        Expanded(
          child: ListView.separated(
            itemCount: associationName.length,
            // physics: const BouncingScrollPhysics(),
            clipBehavior: Clip.none,
            shrinkWrap: true,
            itemBuilder: (context, index) => Card(
              color: Colors.white,
              child: SizedBox(
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: -height(50),
                      child: CircleAvatar(
                        radius: height(50),
                        backgroundColor: Colors.white,
                        child: Image.asset(
                          'assets/images/${images[index]}',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: height(65),
                      ),
                      child: Column(
                        children: [
                          Text(
                            associationName[index],
                            style: TextStyle(
                              fontSize: height(16),
                              fontFamily: 'Marhey',
                              color: const Color.fromARGB(181, 0, 0, 0),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Gap(height(20)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                height: height(30),
                                width: width(75),
                                child: FloatingActionButton(
                                  heroTag: null,
                                  onPressed: () {
                                    Provider.of<PagesProvider>(context,
                                            listen: false)
                                        .setCharity(associationName[index]);
                                    showDialog(
                                      context: context,
                                      builder: (dialogContext) =>
                                          Consumer<PagesProvider>(
                                        builder: (_, dialogProvider, __) =>
                                            AlertDialog(
                                          title: Text(
                                            associationName[index],
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
                                          Provider.of<PagesProvider>(context,
                                                  listen: false)
                                              .reset();
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
                              SizedBox(
                                height: height(30),
                                width: width(75),
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
                                              associationName[index],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: height(22),
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Marhey',
                                                color: const Color(0xff81bdaf),
                                              ),
                                            ),
                                            content: const AssociationInfo(),
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
                          Gap(height(25)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            separatorBuilder: (context, index) => Gap(height(65)),
          ),
        ),
      ],
    );
  }
}
