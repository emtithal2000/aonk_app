import 'package:aonk_app/l10n/app_localizations.dart';
import 'package:aonk_app/providers/pages_provider.dart';
import 'package:aonk_app/size_config.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

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
              ),
            ),
            Gap(height(15)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              spacing: width(15),
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
            provider.image != null
                ? customButton(() {
                    if (provider.image != null) {
                      provider.postDonation().whenComplete(() {
                        if (context.mounted) {
                          completed(context, provider).show();
                        }
                      });
                    }
                  }, AppLocalizations.of(context)!.next)
                : const SizedBox(),
            Gap(height(15)),
            customButton(() {
              provider.image = null;
              provider.postDonation().whenComplete(() {
                if (context.mounted) {
                  completed(context, provider).show();
                }
              });
            }, AppLocalizations.of(context)!.skip),
          ],
        );
      },
    );
  }

  AwesomeDialog completed(BuildContext context, PagesProvider provider) {
    return AwesomeDialog(
      context: context,
      dialogType:
          provider.image == null ? DialogType.error : DialogType.success,
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
      btnOk: customButton(
        () {
          Navigator.pop(context);
        },
        AppLocalizations.of(context)!.ok,
      ),
      btnOkOnPress: () {
        Navigator.pop(context);
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
