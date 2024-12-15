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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(IconsaxPlusBroken.arrow_left_2),
            color: const Color(0xff84beb0),
            iconSize: 30,
          ),
          Gap(width(10)),
        ],
      ),
      body: Consumer<MobileProvider>(
        builder: (_, provider, __) {
          return SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  opacity: 0.3,
                  image: AssetImage('assets/images/background2.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  Gap(height(100)),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                        horizontal: width(20), vertical: height(35)),
                    height: height(670),
                    width: width(330),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.6),
                          blurRadius: 10,
                        ),
                      ],
                      color: const Color(0xff84beb0).withOpacity(0.3),
                      border: Border.all(
                        color: const Color(0xff84beb0).withOpacity(0.1),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xff84beb0).withOpacity(0.5),
                          const Color(0xff84beb0).withOpacity(0.2),
                        ],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'ادخل بياناتك',
                          style: TextStyle(
                            fontSize: height(28),
                            color: const Color(0xff52b8a0),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Marhey',
                          ),
                        ),
                        Gap(height(50)),
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
                              borderRadius: BorderRadius.circular(25),
                              elevation: 1,
                              underline: const SizedBox(),
                              isDense: true,
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
                              elevation: 1,
                              underline: const SizedBox(),
                              isDense: true,
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
                        Gap(height(25)),
                        buildInput('الاسم', IconsaxPlusBroken.user),
                        Gap(height(15)),
                        buildInput('رقم الهاتف', IconsaxPlusBroken.call),
                        Gap(height(15)),
                        buildInput('البريد الإلكتروني', IconsaxPlusBroken.sms),
                        Gap(height(15)),
                        buildInput('رقم الشارع', IconsaxPlusBroken.home),
                        Gap(height(15)),
                        buildInput('رقم المبنى', IconsaxPlusBroken.building_4),
                        Gap(height(30)),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff52b8a0),
                            minimumSize: Size(width(100), height(35)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(
                            'حفظ ',
                            style: TextStyle(
                              fontSize: height(15),
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Marhey',
                            ),
                          ),
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
    );
  }

  Widget buildInput(String hintText, IconData icon) {
    return SizedBox(
      height: height(45),
      child: TextFormField(
        controller: TextEditingController(),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value!.isEmpty) {
            return 'يرجى إدخال $hintText';
          }
          return null;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15),
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(
            color: const Color(0xff84beb0),
            fontSize: height(16),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(25),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(25),
          ),
          prefixIcon: Icon(
            icon,
            color: const Color(0xff52b8a0),
          ),
        ),
        textAlign: TextAlign.right,
        onChanged: (value) {},
      ),
    );
  }
}
