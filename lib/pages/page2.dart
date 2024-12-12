import 'package:aonk_app/pages/pages_provider.dart';
import 'package:aonk_app/size_config.dart';
import 'package:aonk_app/value.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PagesProvider>(
      builder: (__, provider, _) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'إختر نوع التبرع',
              style: TextStyle(
                fontSize: width(15),
                fontWeight: FontWeight.w500,
                fontFamily: 'Marhey',
                color: provider.selected.isEmpty ? Colors.red : Colors.black,
              ),
            ),
            Gap(height(15)),
            SizedBox(
              height: height(300),
              width: width(300),
              child: GridView.builder(
                itemCount: 8,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: height(15),
                  crossAxisSpacing: width(15),
                  childAspectRatio: width(2),
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (provider.selected.contains(donationDetails[index])) {
                        provider.removeSelected(donationDetails[index]);
                      } else {
                        provider.addSelected(donationDetails[index]);
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Provider.of<PagesProvider>(context)
                                  .selected
                                  .contains(donationDetails[index])
                              ? Colors.blue
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Text(
                        donationDetails[index],
                        style: TextStyle(
                          fontSize: width(15),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Gap(height(10)),
            customButton(context, provider, () {
              if (provider.selected.isNotEmpty) {
                provider.nextPage(false);
              }
            }),
          ],
        );
      },
    );
  }
}
