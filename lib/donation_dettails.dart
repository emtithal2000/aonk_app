import 'package:aonk_app/mobile_provider.dart';
import 'package:aonk_app/size_config.dart';
import 'package:aonk_app/value.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class DonationDetails extends StatelessWidget {
  const DonationDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background2.png'),
              opacity: 0.5,
              fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              height: height(600),
              width: width(350),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xff84beb0).withOpacity(0.7),
                    blurRadius: 10,
                    // spreadRadius: 4,
                  ),
                ],
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: associationName[context
                                .watch<MobileProvider>()
                                .selectedAssociationIndex],
                            style: TextStyle(
                              fontSize: height(22),
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Marhey',
                            ),
                          ),
                          const TextSpan(
                            text: '\n',
                          ),
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
                  Gap(height(30)),
                  SizedBox(
                    height:
                        height(300), // Reduced height since it was overflowing
                    child: GridView.builder(
                      itemCount: donationDetails.length,
                      padding: EdgeInsets.symmetric(horizontal: width(20)),
                      shrinkWrap: true,
                      physics:
                          const BouncingScrollPhysics(), // Changed to allow scrolling
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Reduced to 2 rows instead of 4
                        mainAxisSpacing: width(15), // Adjusted spacing
                        crossAxisSpacing: height(15),
                        childAspectRatio:
                            2.29, // Added to maintain square items
                      ),
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          // Toggle selection when tapped
                          context
                              .read<MobileProvider>()
                              .toggleSelectedItem(index);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.4),
                                blurRadius: 10,
                              ),
                            ],
                            color: context
                                    .watch<MobileProvider>()
                                    .selectedItems
                                    .contains(index)
                                ? const Color(0xff81bdaf).withOpacity(0.5)
                                : Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: Text(
                                  donationDetails[index],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: height(15),
                                    color: Colors.black,
                                    fontFamily: 'Marhey',
                                  ),
                                ),
                              ),
                              if (context
                                  .watch<MobileProvider>()
                                  .selectedItems
                                  .contains(index))
                                const Positioned(
                                  right: 8,
                                  top: 8,
                                  child: Icon(
                                    Icons.check_circle,
                                    color: Color(0xff18af89),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Gap(height(30)),
                  ElevatedButton(
                    onPressed: () {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.success,
                        animType: AnimType.scale,
                        title: 'تم تاكيد الطلب',
                        titleTextStyle: TextStyle(
                          fontSize: height(20),
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Marhey',
                        ),
                        desc: 'سيتم التواصل معك من قبل الجمعية',
                        descTextStyle: TextStyle(
                          fontSize: height(15),
                          color: Colors.black,
                          fontFamily: 'Marhey',
                        ),
                        btnOkOnPress: () {},
                        btnOkColor: const Color(0xff81bdaf),
                        btnOkText: 'حسناً',
                        buttonsTextStyle: TextStyle(
                          color: Colors.white,
                          fontSize: height(15),
                          fontFamily: 'Marhey',
                        ),
                      ).show();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff81bdaf),
                      minimumSize: Size(width(300), height(50)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      'تأكيد',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: height(19),
                        fontFamily: 'Marhey',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
