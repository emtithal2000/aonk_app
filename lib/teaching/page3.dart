import 'package:aonk_app/teaching/provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'طريقة التبرع',
          style: TextStyle(fontSize: 25),
        ),
        const Gap(15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildCard('1'),
            buildCard('2'),
          ],
        ),
        const Gap(15),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pop();
              Provider.of<PageProvider>(context, listen: false).pageIndex = 0;
            },
            child: const Text('التالي'),
          ),
        ),
      ],
    );
  }
}
