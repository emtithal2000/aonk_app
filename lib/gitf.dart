import 'package:aonk_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class GiftPage extends StatelessWidget {
  const GiftPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: ElevatedButton(
          onPressed: () => showGiftDialog(context),
          child: const Text('Show Gift Dialog'),
        ),
      ),
    );
  }

  void showGiftDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(10.0),
          content: SizedBox(
            height: height(320),
            width: width(330),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'ادخل بيانات الشخص',
                      style: TextStyle(
                        fontSize: height(20),
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Marhey',
                      ),
                    ),
                  ),
                ),
                Gap(height(20)),
                _buildTextField('ادخل الاسم'),
                Gap(height(20)),
                _buildTextField('الرقم'),
              ],
            ),
          ),
        );
      },
    );
  }

  // Common text field decoration
  InputDecoration _buildInputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
        color: Colors.grey,
        fontSize: height(16),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      prefixIcon: const Icon(
        IconsaxPlusBold.user,
        color: Colors.black,
      ),
    );
  }

  // Common text form field
  Widget _buildTextField(String hintText) {
    return SizedBox(
      height: height(40),
      width: width(250),
      child: TextFormField(
        controller: TextEditingController(),
        decoration: _buildInputDecoration(hintText),
        textAlign: TextAlign.right,
        onChanged: (value) {},
      ),
    );
  }
}
