import 'package:aonk_app/l10n/app_localizations.dart';
import 'package:aonk_app/providers/pages_provider.dart';
import 'package:aonk_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class DonationType extends StatelessWidget {
  const DonationType({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PagesProvider>(
      builder: (_, provider, __) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppLocalizations.of(context)!.donationType,
              style: TextStyle(
                fontSize: width(15),
                fontWeight: FontWeight.w500,
              ),
            ),
            Gap(height(15)),
            Row(
              spacing: width(15),
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(
                          AppLocalizations.of(context)!.comingSoon,
                          style: TextStyle(
                            fontSize: width(16),
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              AppLocalizations.of(context)!.ok,
                              style: TextStyle(
                                fontSize: width(14),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  child: buildSelection(context, 'gift'),
                ),
                GestureDetector(
                  onTap: () {
                    provider.setDonationType('clothes');
                    provider.nextPage(true);
                  },
                  child: buildSelection(context, 'clothes'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget buildSelection(BuildContext context, String image) {
    return Column(
      children: [
        Container(
          height: height(100),
          width: width(100),
          padding: EdgeInsets.all(height(10)),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.withOpacity(0.3),
              style: BorderStyle.solid,
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 10,
              ),
            ],
          ),
          child: Image.asset('assets/images/$image.png'),
        ),
        Gap(height(10)),
        Text(
          image == 'gift'
              ? AppLocalizations.of(context)!.giftDonation
              : AppLocalizations.of(context)!.personalDonation,
          style: TextStyle(
            fontSize: height(14),
            color: Colors.black.withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}
