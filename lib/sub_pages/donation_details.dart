import 'package:aonk_app/l10n/app_localizations.dart';
import 'package:aonk_app/providers/pages_provider.dart';
import 'package:aonk_app/size_config.dart';
import 'package:aonk_app/static_values.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class DonationDetails extends StatelessWidget {
  const DonationDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final donationDetails = getDonationDetails(context);
    return Consumer<PagesProvider>(
      builder: (__, provider, _) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppLocalizations.of(context)!.donationType,
              style: TextStyle(
                fontSize: width(15),
                fontWeight: FontWeight.bold,
                color: provider.selected.isEmpty
                    ? const Color(0xFF81bdaf)
                    : const Color(0xFF81bdaf),
              ),
            ),
            Gap(height(15)),
            SizedBox(
              height: height(200),
              width: width(300),
              child: GridView.builder(
                itemCount: donationDetails.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: height(15),
                  crossAxisSpacing: width(15),
                  childAspectRatio: width(2.5),
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
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Provider.of<PagesProvider>(context)
                                  .selected
                                  .contains(donationDetails[index])
                              ? const Color(0xFF81bdaf)
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Text(
                        donationDetails[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: width(14),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            customButton(
              context,
              provider,
              () {
                if (provider.selected.isNotEmpty) {
                  provider.nextPage(false);
                }
              },
              AppLocalizations.of(context)!.next,
            ),
          ],
        );
      },
    );
  }

  List<String> getDonationDetails(BuildContext context) {
    final storage = GetStorage();
    final country = storage.read('userData')['country'];
    final locale = Localizations.localeOf(context).languageCode;

    if (country == 'Qatar' || country == 'قطر') {
      return donationDetailsQatar['Qatar']![locale]!;
    } else {
      return donationDetailsOman['Oman']![locale]!;
    }
  }
}
