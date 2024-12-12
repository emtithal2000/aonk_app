import 'package:aonk_app/size_config.dart';
import 'package:aonk_app/value.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DonationType extends StatelessWidget {
  const DonationType({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AlertDialog(
          contentPadding: const EdgeInsets.all(10.0),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildDonationItem(0),
                  _buildDonationItem(1),
                ],
              ),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          backgroundColor: Colors.white.withOpacity(0.5),
        ),
      ],
    );
  }

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
}
