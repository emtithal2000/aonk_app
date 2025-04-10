import 'package:aonk_app/l10n/app_localizations.dart';
import 'package:aonk_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DriverPage extends StatefulWidget {
  const DriverPage({super.key});

  @override
  State<DriverPage> createState() => _DriverPageState();
}

class _DriverPageState extends State<DriverPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/aonk-background.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.8),
              BlendMode.srcOver,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          spacing: height(10),
          children: [
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Text(
                AppLocalizations.of(context)!.orders,
                style: TextStyle(
                  fontSize: height(22),
                  fontFamily: 'Marhey',
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff52b8a0),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  left: width(30),
                  right: width(30),
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: height(20)),
                      child: Row(
                        children: [
                          Expanded(
                            child: Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: SizedBox(
                                height: height(50),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText:
                                        AppLocalizations.of(context)!.search,
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
                                  onChanged: (value) {
                                    // Implement search functionality
                                  },
                                ),
                              ),
                            ),
                          ),
                          Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.filter_list,
                                color: Color(0xff52b8a0),
                              ),
                              onPressed: () {
                                // Show filter options
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) => Container(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Filter Orders',
                                          style: TextStyle(
                                            fontSize: height(18),
                                            fontFamily: 'Marhey',
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Divider(),
                                        ListTile(
                                          title: const Text('All Orders'),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                        ListTile(
                                          title: const Text('Pending Orders'),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                        ListTile(
                                          title: const Text('Completed Orders'),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    ExpansionTile(
                      title: Text(
                        'Order #123',
                        style: TextStyle(
                          fontSize: height(18),
                          fontFamily: 'Marhey',
                          color: const Color(0xff52b8a0),
                        ),
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
                                'Name: John Doe',
                                style: TextStyle(
                                  fontSize: height(16),
                                  fontFamily: 'Marhey',
                                ),
                              ),
                              Gap(height(5)),
                              Text(
                                'ID: DRV-2024-123',
                                style: TextStyle(
                                  fontSize: height(16),
                                  fontFamily: 'Marhey',
                                ),
                              ),
                              Gap(height(5)),
                              Text(
                                'Time: 10:30 AM',
                                style: TextStyle(
                                  fontSize: height(16),
                                  fontFamily: 'Marhey',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
