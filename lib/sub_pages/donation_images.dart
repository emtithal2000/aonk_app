import 'package:aonk_app/providers/pages_provider.dart';
import 'package:aonk_app/size_config.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DonationImages extends StatelessWidget {
  const DonationImages({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PagesProvider>(
      builder: (_, provider, __) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppLocalizations.of(context)!.attachImages,
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
                provider.postDonation().whenComplete(() {
                  if (context.mounted) {
                    AwesomeDialog(
                      context: context,
                      dialogType: provider.image == null
                          ? DialogType.error
                          : DialogType.success,
                      animType: AnimType.rightSlide,
                      title: provider.image == null
                          ? AppLocalizations.of(context)!.error
                          : AppLocalizations.of(context)!.success,
                      desc: provider.image == null
                          ? AppLocalizations.of(context)!.errorDescription
                          : AppLocalizations.of(context)!.successDescription,
                      titleTextStyle: const TextStyle(fontFamily: 'Marhey'),
                      descTextStyle: const TextStyle(fontFamily: 'Marhey'),
                      buttonsTextStyle: const TextStyle(fontFamily: 'Marhey'),
                      btnOkText: AppLocalizations.of(context)!.ok,
                      btnOkOnPress: () {
                        Navigator.pop(context);
                      },
                    ).show();
                  }
                });
              }
            }, AppLocalizations.of(context)!.next),
            Gap(height(15)),
            customButton(context, provider, () {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.success,
                animType: AnimType.rightSlide,
                title: AppLocalizations.of(context)!.success,
                desc: AppLocalizations.of(context)!.successDescription,
                titleTextStyle: const TextStyle(fontFamily: 'Marhey'),
                descTextStyle: const TextStyle(fontFamily: 'Marhey'),
                buttonsTextStyle: const TextStyle(fontFamily: 'Marhey'),
                btnOkText: AppLocalizations.of(context)!.ok,
                btnOkOnPress: () {
                  Navigator.pop(context);
                },
              ).show();
            }, AppLocalizations.of(context)!.skip),
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
        borderRadius: BorderRadius.circular(20),
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
