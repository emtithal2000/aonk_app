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
                  child: buildSelection('camera'),
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
            customButton(() async {
              await provider.postDonation().then((value) {
                if (context.mounted) {
                  showCompleted(context, value).show();
                }
              });
            },
                provider.image != null
                    ? AppLocalizations.of(context)!.next
                    : AppLocalizations.of(context)!.skip),
            Gap(height(15)),
          ],
        );
      },
    );
  }

  AwesomeDialog showCompleted(BuildContext context, bool success) {
    return AwesomeDialog(
      context: context,
      dialogType: success ? DialogType.success : DialogType.error,
      animType: AnimType.scale,
      title: success
          ? AppLocalizations.of(context)!.success
          : AppLocalizations.of(context)!.error,
      desc: success
          ? AppLocalizations.of(context)!.successDescription
          : AppLocalizations.of(context)!.errorDescription,
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
