import 'package:aonk_app/pages/pages_provider.dart';
import 'package:aonk_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PagesProvider>(
      builder: (_, provider, __) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'قم بإرفاق الصورة',
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
                    Provider.of<PagesProvider>(context, listen: false)
                        .selectImage(true);
                  },
                  child: buildSelection('camera2'),
                ),
                GestureDetector(
                  onTap: () {
                    Provider.of<PagesProvider>(context, listen: false)
                        .selectImage(false);
                  },
                  child: buildSelection('gallery'),
                ),
              ],
            ),
            Gap(height(15)),
            customButton(context, provider, () {
              if (provider.image != null) {
                Navigator.pop(context);
              }
            }),
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
