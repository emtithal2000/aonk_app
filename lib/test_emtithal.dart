// Expanded(
                                    //   child: GestureDetector(
                                    //     onTap: () {
                                    //       showCupertinoModalPopup(
                                    //         context: context,
                                    //         builder: (context) => Card(
                                    //           elevation: 3,
                                    //           shape: RoundedRectangleBorder(
                                    //             borderRadius:
                                    //                 BorderRadius.circular(15),
                                    //           ),
                                    //           child: Container(
                                    //             height: 200,
                                    //             color: Colors.white,
                                    //             child: CupertinoPicker(
                                    //               itemExtent: 32.0,
                                    //               onSelectedItemChanged:
                                    //                   (index) {
                                    //                 final countries = provider
                                    //                     .getLocalizedCountryNames(
                                    //                         context);
                                    //                 final selectedCountry =
                                    //                     countries[index];
                                    //                 provider.setCountry(
                                    //                   countryNames.keys
                                    //                       .firstWhere(
                                    //                     (key) =>
                                    //                         countryNames[
                                    //                             key]![Localizations
                                    //                                 .localeOf(
                                    //                                     context)
                                    //                             .languageCode] ==
                                    //                         selectedCountry,
                                    //                   ),
                                    //                 );
                                    //               },
                                    //               children: provider
                                    //                   .getLocalizedCountryNames(
                                    //                       context)
                                    //                   .map((country) =>
                                    //                       Text(country))
                                    //                   .toList(),
                                    //             ),
                                    //           ),
                                    //         ),
                                    //       );
                                    //     },
                                    //     child: Container(
                                    //       padding: EdgeInsets.all(12),
                                    //       decoration: BoxDecoration(
                                    //         color: Colors.white,
                                    //         borderRadius:
                                    //             BorderRadius.circular(15),
                                    //         boxShadow: [
                                    //           BoxShadow(
                                    //             color: Colors.grey
                                    //                 .withOpacity(0.2),
                                    //             spreadRadius: 1,
                                    //             blurRadius: 5,
                                    //           ),
                                    //         ],
                                    //       ),
                                    //       child: Text(
                                    //         provider.selectedCountry != null
                                    //             ? countryNames[provider
                                    //                     .selectedCountry]![
                                    //                 Localizations.localeOf(
                                    //                         context)
                                    //                     .languageCode]!
                                    //             : AppLocalizations.of(context)!
                                    //                 .country,
                                    //         style: TextStyle(
                                    //           color: const Color(0xff52b8a0),
                                    //           fontSize: height(16),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),