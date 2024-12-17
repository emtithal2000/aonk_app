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
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height(35)),
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xff81bdaf),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(50),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    blurRadius: 5,
                    spreadRadius: 5,
                  ),
                ],
              ),
            ),
            Positioned(
              top: height(50),
              child: Text(
                'الجهات/الجمعيات',
                style: TextStyle(
                  fontSize: height(20),
                  fontFamily: 'Marhey',
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              top: height(90),
              width: width(300),
              child: Card(
                shadowColor: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 5,
                child: TextField(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: width(15),
                    ),
                    prefixIcon: const Icon(Icons.search),
                    prefixIconColor: Colors.black.withOpacity(0.8),
                    hintText: 'بحث',
                    hintStyle: TextStyle(
                      fontSize: height(16),
                      fontFamily: 'Marhey',
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: width(35)),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background2.png'),
            opacity: 0.3,
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Gap(height(85)),
            Expanded(
              child: ListView.separated(
                itemCount: associationName.length,
                // physics: const BouncingScrollPhysics(),

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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
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
                                              Provider.of<PagesProvider>(
                                                      context,
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
                                                    color:
                                                        const Color(0xff81bdaf),
                                                  ),
                                                ),
                                                content:
                                                    const AssociationInfo(),
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
        ),
      ),
    );
  }
}
