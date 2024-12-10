import 'package:aonk_app/mobile_provider.dart';
import 'package:aonk_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MobileProvider>(
        builder: (_, provider, __) {
          return SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  opacity: 0.2,
                  image: AssetImage('assets/images/background2.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  Gap(height(90)),
                  Text(
                    'ادخل بياناتك',
                    style: TextStyle(
                      fontSize: height(28),
                      color: const Color(0xff52b8a0),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Marhey',
                    ),
                  ),
                  Gap(height(40)),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    height: height(500),
                    width: width(330),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xff84beb0).withOpacity(0.7),
                          blurRadius: 8,
                        ),
                      ],
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              DropdownButton<String>(
                                hint: Text(
                                  'الولاية',
                                  style: TextStyle(
                                    fontSize: height(16),
                                    color: const Color(0xff52b8a0),
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Color(0xff52b8a0),
                                ),
                                dropdownColor: Colors.white,
                                borderRadius: BorderRadius.circular(
                                    25), // Made more circular
                                elevation: 4,
                                items: <String>[
                                  'الرياض',
                                  'جدة',
                                  'الدمام',
                                  'مكة المكرمة',
                                  'المدينة المنورة'
                                ].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                        fontSize: height(16),
                                        color: const Color(0xff52b8a0),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  provider.setCity(newValue!);
                                },
                                value: provider.selectedCity,
                              ),
                              DropdownButton<String>(
                                hint: Text(
                                  'المنطقة',
                                  style: TextStyle(
                                    fontSize: height(16),
                                    color: const Color(0xff52b8a0),
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Color(0xff52b8a0),
                                ),
                                dropdownColor: Colors.white,
                                borderRadius: BorderRadius.circular(
                                    25), // Made more circular
                                elevation: 4,
                                items: <String>[
                                  'الرياض',
                                  'جدة',
                                  'الدمام',
                                  'مكة المكرمة',
                                  'المدينة المنورة'
                                ].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                        fontSize: height(16),
                                        color: const Color(0xff52b8a0),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  provider.setCountry(newValue!);
                                },
                                value: provider.selectedCountry,
                              ),
                            ],
                          ),
                          Gap(height(15)),
                          buildInput('الاسم', IconsaxPlusBold.user),
                          Gap(height(15)),
                          buildInput('رقم الهاتف', IconsaxPlusBold.call),
                          Gap(height(15)),
                          buildInput('البريد الإلكتروني', IconsaxPlusBold.sms),
                          Gap(height(15)),
                          buildInput('رقم الشارع', IconsaxPlusBold.home),
                          Gap(height(15)),
                          buildInput('رقم المبنى', IconsaxPlusBold.building_4),
                          Gap(height(20)),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff52b8a0),
                              minimumSize: Size(width(320), height(50)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                            ),
                            child: Text(
                              'حفظ ',
                              style: TextStyle(
                                fontSize: height(18),
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildInput(String hintText, IconData icon) {
    return TextFormField(
      controller: TextEditingController(),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: const Color(0xff84beb0),
          fontSize: height(16),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: const BorderSide(
            color: Color(0xff52b8a0),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: const BorderSide(
            color: Color(0xff52b8a0),
          ),
        ),
        prefixIcon: Icon(
          icon,
          color: const Color(0xff52b8a0),
        ),
      ),
      textAlign: TextAlign.right,
      onChanged: (value) {},
    );
  }
}
