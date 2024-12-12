import 'package:aonk_app/teaching/provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'نوع التبرع',
          style: TextStyle(fontSize: 25),
        ),
        const Gap(15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildCard('personal'),
            buildCard('gift'),
          ],
        ),
      ],
    );
  }
}
