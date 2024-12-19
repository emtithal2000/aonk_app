import 'package:aonk_app/providers/pages_provider.dart';
import 'package:aonk_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:provider/provider.dart';

class CustomerInfo extends StatelessWidget {
  const CustomerInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PagesProvider>(
      builder: (_, provider, __) {
        return Form(
          key: provider.loginKey,
          child: SingleChildScrollView(
            child: Column(
              spacing: height(10),
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Gap(height(20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: Colors.white,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          padding: EdgeInsets.symmetric(
                            horizontal: width(15),
                          ),
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
                          elevation: 1,
                          borderRadius: BorderRadius.circular(30),
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
                      ),
                    ),
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: Colors.white,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          padding: EdgeInsets.symmetric(
                            horizontal: width(15),
                          ),
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
                          elevation: 1,
                          borderRadius: BorderRadius.circular(30),
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
                      ),
                    ),
                  ],
                ),
                buildInput(
                    'الاسم', IconsaxPlusBroken.user, provider.controllers[0]),
                buildInput('رقم الهاتف', IconsaxPlusBroken.call,
                    provider.controllers[1]),
                buildInput('البريد الإلكتروني', IconsaxPlusBroken.sms,
                    provider.controllers[2]),
                buildInput('رقم الشارع', IconsaxPlusBroken.home,
                    provider.controllers[3]),
                buildInput('رقم المبنى', IconsaxPlusBroken.building_4,
                    provider.controllers[4]),
                Gap(height(10)),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: FloatingActionButton(
                    onPressed: () {
                      if (provider.formKey.currentState!.validate()) {}
                    },
                    backgroundColor: const Color(0xff81bdaf),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      'حفظ ',
                      style: TextStyle(
                        fontSize: height(18),
                        color: Colors.white,
                        fontFamily: 'Marhey',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildInput(
      String hintText, IconData icon, TextEditingController controller) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: controller,
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
          isDense: true,
          hintStyle: TextStyle(
            color: const Color(0xff84beb0),
            fontSize: height(16),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15),
          ),
          prefixIcon: Icon(
            icon,
            color: const Color(0xff52b8a0),
          ),
        ),
        onChanged: (value) {},
      ),
    );
  }
}
