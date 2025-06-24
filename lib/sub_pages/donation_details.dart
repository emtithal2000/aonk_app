import 'package:aonk_app/l10n/app_localizations.dart';
import 'package:aonk_app/providers/pages_provider.dart';
import 'package:aonk_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class DonationDetails extends StatelessWidget {
  const DonationDetails({super.key});

  @override
  Widget build(BuildContext context) {
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
              height: height(230),
              width: width(300),
              child: GridView.builder(
                itemCount: provider.donationTypes.length,
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
                      if (provider.selected
                          .contains(provider.donationTypes[index].id)) {
                        provider
                            .removeSelected(provider.donationTypes[index].id!);
                      } else {
                        provider.addSelected(provider.donationTypes[index].id!);
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: provider.selected
                                  .contains(provider.donationTypes[index].id!)
                              ? const Color(0xFF81bdaf)
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Text(
                        provider.donationTypes[index].nameAr ?? '',
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
            provider.selected.isNotEmpty
                ? customButton(
                    () {
                      provider.nextPage(false);
                    },
                    AppLocalizations.of(context)!.next,
                  )
                : Container(),
          ],
        );
      },
    );
  }
}
