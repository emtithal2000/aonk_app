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
      body: SafeArea(
        child: Container(
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(50.0),
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width(30)),
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
                                    onChanged: (value) {},
                                  ),
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
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.now()
                                        .add(const Duration(days: 365)),
                                  );
                                  if (selectedDate != null) {}
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: 7,
                        separatorBuilder: (context, index) {
                          return Gap(height(5));
                        },
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 2,
                            color: Colors.white,
                            child: ExpansionTile(
                              title: Text(
                                '${AppLocalizations.of(context)!.order} ${index + 1}',
                                style: TextStyle(
                                  fontSize: height(14),
                                  fontFamily: 'Marhey',
                                  color: const Color(0xff52b8a0),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Name: Emtithal',
                                        style: TextStyle(
                                          fontSize: height(12),
                                          fontFamily: 'Marhey',
                                        ),
                                      ),
                                      Gap(height(5)),
                                      Text(
                                        ' Date: 10/04/2025',
                                        style: TextStyle(
                                          fontSize: height(10),
                                          fontFamily: 'Marhey',
                                        ),
                                      ),
                                      Gap(height(5)),
                                      Text(
                                        'Time: 10:30 AM',
                                        style: TextStyle(
                                          fontSize: height(10),
                                          fontFamily: 'Marhey',
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
                                                    AlertDialog(
                                                  title: Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .orderStatus,
                                                    style: const TextStyle(
                                                      fontFamily: 'Marhey',
                                                      color: Color(0xff52b8a0),
                                                    ),
                                                  ),
                                                  content: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      ListTile(
                                                        leading: const Icon(
                                                            Icons
                                                                .check_circle_outline_rounded,
                                                            color: Color(
                                                                0xff52b8a0)),
                                                        title: const Text(
                                                            'Received'),
                                                        onTap: () =>
                                                            Navigator.pop(
                                                                context),
                                                      ),
                                                      ListTile(
                                                        leading: const Icon(
                                                            Icons
                                                                .pending_actions,
                                                            color:
                                                                Colors.black),
                                                        title: const Text(
                                                            'Postponed'),
                                                        onTap: () =>
                                                            Navigator.pop(
                                                                context),
                                                      ),
                                                      ListTile(
                                                        leading: const Icon(
                                                            Icons
                                                                .cancel_outlined,
                                                            color: Colors.red),
                                                        title: const Text(
                                                            'Cancelled'),
                                                        onTap: () =>
                                                            Navigator.pop(
                                                                context),
                                                      ),
                                                      ListTile(
                                                        leading: const Icon(
                                                            Icons
                                                                .pending_outlined,
                                                            color: Colors
                                                                .blueGrey),
                                                        title: const Text(
                                                            'No response'),
                                                        onTap: () =>
                                                            Navigator.pop(
                                                                context),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                          IconButton(
                                            icon: const Icon(
                                              Icons.share,
                                              size: 20,
                                              color: Color(0xff52b8a0),
                                            ),
                                            onPressed: () {},
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
