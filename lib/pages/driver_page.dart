import 'package:aonk_app/l10n/app_localizations.dart';
import 'package:aonk_app/providers/driver_provider.dart';
import 'package:aonk_app/providers/locale_provider.dart';
import 'package:aonk_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(height(15)),
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
                            Navigator.pop(context);
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
                  Text(
                    AppLocalizations.of(context)!.orders,
                    style: TextStyle(
                      color: Color(0xff52b8a0),
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(height(15)),
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: AppLocalizations.of(context)!.search,
                              isDense: true,
                              hintStyle: TextStyle(
                                color: const Color(0xff84beb0),
                                fontSize: height(16),
                              ),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Color(0xff52b8a0),
                              ),
                            ),
                            onChanged: (value) {},
                          ),
                        ),
                      ),
                      Card(
                        elevation: 3,
                        color: const Color(0xff84beb0),
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
                              firstDate: DateTime(2000),
                              lastDate:
                                  DateTime.now().add(const Duration(days: 365)),
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
                        child: ExpansionTile(
                          title: Text(
                            '${AppLocalizations.of(context)!.order} ${provider.filteredDonations[index].requestId}',
                            style: TextStyle(
                              color: Color(0xff52b8a0),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${AppLocalizations.of(context)!.name}: ${provider.donations[index].name}',
                                    style: TextStyle(
                                      color: Color(0xff52b8a0),
                                      fontSize: 16,
                                    ),
                                  ),
                                  Gap(height(5)),
                                  Text(
                                    '${AppLocalizations.of(context)!.date}: ${provider.donations[index].deliveryDate}',
                                    style: TextStyle(
                                      color: Color(0xff52b8a0),
                                      fontSize: 16,
                                    ),
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
                                          showDialog(
                                            context: context,
                                            builder: (context) =>
                                                buildStatus(context, index),
                                          );
                                        },
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          await launchUrlString(
                                              "https://wa.me/${provider.donations[index].phone}");
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
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildStatus(
    BuildContext context,
    int index,
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
              ...List.generate(4, (index) {
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
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Color(0xff52b8a0),
                      content: Text(
                        provider.selectedStatus != null
                            ? '${AppLocalizations.of(context)!.statusUpdated} ${getDonationStatusDisplayName(context, provider.selectedStatus!)}'
                            : AppLocalizations.of(context)!.pleaseSelectStatus,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
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
