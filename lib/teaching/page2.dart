import 'package:aonk_app/teaching/provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'نوع الوسيلة',
          style: TextStyle(fontSize: 25),
        ),
        const Gap(15),
        buildInput('الاسم'),
        const Gap(15),
        buildInput('رقم الهاتف'),
        const Gap(15),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: FloatingActionButton(
            onPressed: () {
              Provider.of<PageProvider>(context, listen: false).nextPage();
            },
            child: const Text(
              'التالي',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
