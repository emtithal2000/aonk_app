import 'package:aonk_app/providers/pages_provider.dart';
import 'package:aonk_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class Gift extends StatelessWidget {
  const Gift({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PagesProvider>(
      builder: (_, provider, __) {
        return Form(
          key: provider.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'أدخل بيانات الشخص',
                style: TextStyle(
                  fontSize: width(15),
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF81bdaf),
                  fontFamily: 'Marhey',
                ),
              ),
              Gap(height(15)),
              customInput(
                'الاسم',
                provider.controllers[5],
              ),
              Gap(height(10)),
              customInput(
                'رقم الهاتف',
                provider.controllers[61],
              ),
              Gap(height(15)),
              customButton(context, provider, () {
                if (provider.formKey.currentState!.validate()) {
                  provider.nextPage(false);
                }
              }),
            ],
          ),
        );
      },
    );
  }

  Widget customInput(
    String hintText,
    TextEditingController controller,
  ) {
    return TextFormField(
      controller: controller,
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
        fillColor: Colors.grey.withOpacity(0.2),
        filled: true,
        hintText: hintText,
        contentPadding: EdgeInsets.symmetric(
          horizontal: width(10),
        ),
      ),
    );
  }
}
