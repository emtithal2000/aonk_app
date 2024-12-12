import 'package:aonk_app/pages/pages_provider.dart';
import 'package:aonk_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PagesProvider>(
      builder: (_, provider, __) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'إختر طبيعة التبرع',
              style: TextStyle(
                fontSize: width(15),
                fontWeight: FontWeight.w500,
                fontFamily: 'Marhey',
              ),
            ),
            Gap(height(15)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    provider.nextPage(false);
                  },
                  child: buildSelection('gift'),
                ),
                GestureDetector(
                  onTap: () {
                    provider.nextPage(true);
                  },
                  child: buildSelection('clothes'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget buildSelection(String image) {
    return Container(
      height: height(100),
      width: width(100),
      padding: EdgeInsets.all(height(10)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 10,
          ),
        ],
      ),
      child: Image.asset('assets/images/$image.png'),
    );
  }
}
