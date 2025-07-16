import 'package:aonk_app/l10n/app_localizations.dart';
import 'package:aonk_app/pages/login.dart';
import 'package:aonk_app/providers/driver_provider.dart';
import 'package:aonk_app/providers/locale_provider.dart';
import 'package:aonk_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gap/gap.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

// Import the helper function
String getDonationStatusDisplayName(
    BuildContext context, DonationStatus status) {
  switch (status) {
    case DonationStatus.received:
      return AppLocalizations.of(context)!.received;
    case DonationStatus.postponed:
      return AppLocalizations.of(context)!.postponed;
    case DonationStatus.cancelled:
      return AppLocalizations.of(context)!.cancelled;
    case DonationStatus.noResponse:
      return AppLocalizations.of(context)!.noResponse;
    case DonationStatus.others:
      return AppLocalizations.of(context)!.others;
  }
}

class DriverPage extends StatefulWidget {
  final String driverName;

  const DriverPage({super.key, required this.driverName});

  @override
  State<DriverPage> createState() => _DriverPageState();
}

class _DriverPageState extends State<DriverPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Consumer<DriverProvider>(
        builder: (context, provider, child) {
          return Container(
            height: double.infinity,
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: width(20),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('assets/images/aonk-background.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.9),
                  BlendMode.srcOver,
                ),
              ),
            ),
            child: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: context
                                      .watch<LocaleProvider>()
                                      .locale
                                      .languageCode ==
                                  'ar'
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: IconButton(
                            onPressed: () {
                              provider.clearDriverLogin();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Login(),
                                ),
                              );
                            },
                            icon: Icon(
                              context
                                          .watch<LocaleProvider>()
                                          .locale
                                          .languageCode ==
                                      'ar'
                                  ? IconsaxPlusBroken.arrow_right_3
                                  : IconsaxPlusBroken.arrow_left_2,
                              color: const Color(0xff84beb0),
                              size: height(30),
                            ),
                          ),
                        ),
                        Card(
                          elevation: 3,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: InkWell(
                            onTap: () {
                              final localeProvider =
                                  context.read<LocaleProvider>();
                              if (localeProvider.locale.languageCode == 'ar') {
                                localeProvider.setLocale(
                                    const Locale('en'), context);
                              } else {
                                localeProvider.setLocale(
                                    const Locale('ar'), context);
                              }
                            },
                            borderRadius: BorderRadius.circular(10),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: width(6),
                                vertical: height(4),
                              ),
                              child: Text(
                                context
                                            .watch<LocaleProvider>()
                                            .locale
                                            .languageCode ==
                                        'ar'
                                    ? 'En'
                                    : 'Ar',
                                style: TextStyle(
                                  color: const Color(0xff84beb0),
                                  fontSize: height(16),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Gap(height(50)),
                    Row(
                      children: [
                        Text(
                          provider.handleDate(provider.selectedDate, context),
                          style: TextStyle(
                            color: Color(0xff52b8a0),
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Gap(width(10)),
                        Text(
                          '${provider.filteredDonations.length}',
                          style: TextStyle(
                            color: Color(0xff52b8a0),
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Gap(height(15)),
                    Row(
                      children: [
                        Expanded(
                          child: Card(
                            elevation: 3,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: TypeAheadField(
                              hideOnError: true,
                              hideOnEmpty: true,
                              hideOnLoading: true,
                              builder: (_, controller, focusNode) {
                                return TextField(
                                  controller: controller,
                                  focusNode: focusNode,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  decoration: InputDecoration(
                                    isDense: true,
                                    hintText:
                                        AppLocalizations.of(context)!.search,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                );
                              },
                              suggestionsCallback: provider.searchBoxesByName,
                              decorationBuilder: (context, child) {
                                return Material(
                                  elevation: 4,
                                  clipBehavior: Clip.hardEdge,
                                  borderRadius: BorderRadius.circular(15),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white,
                                    ),
                                    child: child,
                                  ),
                                );
                              },
                              itemBuilder: (context, suggestion) {
                                return ListTile(
                                  title: Text('${suggestion.requestId}'),
                                  trailing: Text(suggestion.name),
                                  tileColor: Colors.white,
                                );
                              },
                              onSelected: (suggestion) {},
                            ),
                          ),
                        ),
                        Card(
                          elevation: 3,
                          color: const Color(0xff52b8a0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.calendar_today,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              final selectedDate = await showDatePicker(
                                context: context,
                                initialDate:
                                    provider.selectedDate ?? DateTime.now(),
                                firstDate: DateTime.now()
                                    .subtract(const Duration(days: 1000)),
                                lastDate: DateTime.now()
                                    .add(const Duration(days: 365)),
                              );
                              if (selectedDate != null) {
                                provider.setSelectedDate(selectedDate);
                              }
                            },
                          ),
                        ),
                        if (provider.selectedDate != null)
                          Card(
                            elevation: 3,
                            color: Colors.redAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.clear,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                provider.clearSelectedDate();
                              },
                            ),
                          ),
                      ],
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: provider.filteredDonations.length,
                      separatorBuilder: (context, index) {
                        return Gap(height(5));
                      },
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 2,
                          color: Colors.white,
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                            ),
                            child: ExpansionTile(
                              title: Text(
                                '${AppLocalizations.of(context)!.order} ${provider.filteredDonations[index].requestId}',
                                style: TextStyle(
                                  color: Color(0xff52b8a0),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: provider.filteredDonations[index]
                                              .deliveryStatus !=
                                          null &&
                                      provider.filteredDonations[index]
                                          .deliveryStatus!.isNotEmpty
                                  ? Text(
                                      getDonationStatusDisplayName(
                                        context,
                                        DonationStatus.fromString(provider
                                            .filteredDonations[index]
                                            .deliveryStatus!),
                                      ),
                                      style: TextStyle(
                                        color: DonationStatus.fromString(
                                                provider
                                                    .filteredDonations[index]
                                                    .deliveryStatus!)
                                            .color,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  : null,
                              leading: () {
                                final deliveryStatus = provider
                                    .filteredDonations[index].deliveryStatus;
                                if (deliveryStatus == null ||
                                    deliveryStatus.isEmpty) {
                                  return null;
                                }
                                final status =
                                    DonationStatus.fromString(deliveryStatus);
                                return Icon(
                                  status.icon,
                                  color: status.color,
                                );
                              }(),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: width(20),
                                    vertical: height(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            '${AppLocalizations.of(context)!.name}: ',
                                            style: TextStyle(
                                              color: Color(0xff52b8a0),
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            provider
                                                .filteredDonations[index].name,
                                            style: TextStyle(
                                              color: Color(0xff52b8a0),
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Gap(height(5)),
                                      Row(
                                        children: [
                                          Text(
                                            '${AppLocalizations.of(context)!.date}: ',
                                            style: TextStyle(
                                              color: Color(0xff52b8a0),
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            '${provider.filteredDonations[index].deliveryDate}',
                                            textDirection: TextDirection.ltr,
                                            style: TextStyle(
                                              color: Color(0xff52b8a0),
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Gap(height(5)),
                                      Row(
                                        children: [
                                          Text(
                                            '${AppLocalizations.of(context)!.city}: ',
                                            style: TextStyle(
                                              color: Color(0xff52b8a0),
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            provider.filteredDonations[index]
                                                    .city.cityAr ??
                                                '',
                                            style: TextStyle(
                                              color: Color(0xff52b8a0),
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Gap(height(10)),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          IconButton(
                                            icon: const Icon(
                                              Icons.menu,
                                              color: Color(0xff52b8a0),
                                            ),
                                            onPressed: () {
                                              provider.clearSelectedStatus();
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    buildStatus(
                                                        context,
                                                        provider
                                                            .filteredDonations[
                                                                index]
                                                            .requestId),
                                              );
                                            },
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              await launchUrlString(
                                                  "https://wa.me/${provider.filteredDonations[index].phone}");
                                            },
                                            child: Image.asset(
                                              'assets/images/whatsapp.png',
                                              width: width(25),
                                              height: height(23),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildStatus(
    BuildContext context,
    int id,
  ) {
    return AlertDialog(
      title: Text(
        AppLocalizations.of(context)!.orderStatus,
        style: const TextStyle(
          color: Color(0xff52b8a0),
        ),
      ),
      content: Consumer<DriverProvider>(
        builder: (context, provider, child) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...List.generate(5, (index) {
                final status = DonationStatus.values[index];
                final isSelected = provider.selectedStatus == status;

                return Container(
                  margin: EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Color(0xff52b8a0).withOpacity(0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected
                          ? Color(0xff52b8a0)
                          : Colors.grey.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: ListTile(
                    leading: Icon(
                      status.icon,
                      color: status.color,
                    ),
                    title: Text(
                      getDonationStatusDisplayName(context, status),
                      style: TextStyle(
                        color: isSelected ? Color(0xff52b8a0) : Colors.black,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    onTap: () {
                      provider.setSelectedStatus(status);
                    },
                  ),
                );
              }),
              Gap(height(10)),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff52b8a0),
                  minimumSize: Size(double.infinity, 40),
                ),
                onPressed: () {
                  provider.updateDonationStatus(id).then(
                    (value) {
                      if (value && context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Color(0xff52b8a0),
                            content: Text(
                              provider.selectedStatus != null
                                  ? '${AppLocalizations.of(context)!.statusUpdated} ${getDonationStatusDisplayName(context, provider.selectedStatus!)}'
                                  : AppLocalizations.of(context)!
                                      .pleaseSelectStatus,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      }
                    },
                  );

                  Navigator.pop(context);
                },
                child: Text(
                  AppLocalizations.of(context)!.save,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: width(16),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Schedule the state update for the next frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<DriverProvider>().getDonations(widget.driverName);
      }
    });
  }
}
