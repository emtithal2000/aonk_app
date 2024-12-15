import 'package:aonk_app/association_info.dart';
import 'package:aonk_app/pages/pages_provider.dart';
import 'package:aonk_app/size_config.dart';
import 'package:aonk_app/value.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class DonationPage extends StatelessWidget {
  const DonationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background2.png'),
            opacity: 0.3,
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: height(120),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xff81bdaf),
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(35),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        blurRadius: 6,
                        spreadRadius: 8,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Text(
                      'اختر الجهة او الجمعية',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: height(20),
                        // color: const Color(0xff52b8a0),
                        color: Colors.black.withOpacity(0.8),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Marhey',
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: height(100),
                  left: width(38),
                  child: Container(
                    height: height(45),
                    width: width(300),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 6,
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        prefixIconColor: Colors.grey,
                        border: InputBorder.none,
                        hintText: 'بحث',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: height(18),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SizedBox(
                width: width(310),
                child: GridView.builder(
                  clipBehavior: Clip.none,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: height(50),
                    crossAxisSpacing: width(20),
                    childAspectRatio: 1.6,
                  ),
                  itemCount: images.length,
                  itemBuilder: (context, index) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 10,
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          top: height(-40),
                          left: width(110),
                          child: Container(
                            height: height(110),
                            width: width(100),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white,
                            ),
                            child: Image.asset(
                              images[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            associationName[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: height(15),
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.6),
                              fontFamily: 'Marhey',
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
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
                                        content: dialogProvider
                                            .pages[dialogProvider.currentPage],
                                      ),
                                    ),
                                  ).whenComplete(() {
                                    Future.delayed(
                                        const Duration(milliseconds: 500), () {
                                      if (context.mounted) {
                                        Provider.of<PagesProvider>(context,
                                                listen: false)
                                            .reset();
                                      }
                                    });
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.only(bottom: height(15)),
                                  padding: EdgeInsets.all(height(3)),
                                  height: height(30),
                                  width: width(90),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0xff81bdaf),
                                  ),
                                  child: Text(
                                    'تبرع الان',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: height(15),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
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
                                            fontSize: width(22),
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Marhey',
                                            color: const Color(0xff81bdaf),
                                          ),
                                        ),
                                        content: const AssociationInfo(),
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.only(bottom: height(15)),
                                  padding: EdgeInsets.all(height(3)),
                                  height: height(30),
                                  width: width(90),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0xff81bdaf),
                                  ),
                                  child: Text(
                                    'معلومات',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: height(15),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> buildDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: const Color(0xff18af89).withOpacity(0.5),
        child: Container(
          padding: const EdgeInsets.all(10.0),
          height: height(320),
          width: width(330),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: const Color(0xff18af89).withOpacity(0.5),
                blurRadius: 10,
                // spreadRadius: 4,
              ),
            ],
            color: Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Gap(height(30)),
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'جمعية دار العطاء',
                        style: TextStyle(
                          fontSize: height(20),
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Marhey',
                        ),
                      ),
                      const TextSpan(text: '\n'),
                      TextSpan(
                        text: 'اختر نوع التبرع',
                        style: TextStyle(
                          fontSize: height(18),
                          color: Colors.black,
                          fontFamily: 'Marhey',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height(140),
                width: width(320),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: height(10),
                    crossAxisSpacing: width(20),
                    childAspectRatio: 0.5,
                  ),
                  itemBuilder: (context, index) => Column(
                    children: [
                      Container(
                        height: height(100),
                        width: width(100),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.4),
                              blurRadius: 10,
                            ),
                          ],
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: donationTypeImages[index],
                        ),
                      ),
                      Gap(height(15)),
                      Text(
                        donationType[index],
                        style: TextStyle(
                          fontSize: height(16),
                          fontFamily: 'Marhey',
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  itemCount: donationTypeImages.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
