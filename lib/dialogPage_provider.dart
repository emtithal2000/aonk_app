import 'package:aonk_app/donation_dettails.dart';
import 'package:aonk_app/donation_type.dart';
import 'package:aonk_app/size_config.dart';
import 'package:aonk_app/value.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

Widget _buildDonationItem(int index) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
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
  );
}

class DialogPageProvider extends ChangeNotifier {
  int _currentIndex = 0;
  int _selectedIndex = 0;

  String button = 'التالي';
  List<Widget> pagesContent = [
    const DonationType(),
    const DonationDetails(),
    const DonationDetails(),
  ];

  int get currentIndex => _currentIndex;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int value) {
    _selectedIndex = value;
    notifyListeners();
  }

  void nextPage() {
    if (currentIndex < associationName.length - 1) {
      _currentIndex++;
      if (_currentIndex == 2) {
        button = 'تاكيد';
      }
      notifyListeners();
    }
  }
}
