import 'package:aonk_app/pages/pages_provider.dart';
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
                'أدخل معلومات الشخص',
                style: TextStyle(
                  fontSize: width(15),
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Marhey',
                ),
              ),
              Gap(height(15)),
              customInput(
                'الاسم',
                provider.name,
              ),
              Gap(height(10)),
              customInput(
                'رقم الهاتف',
                provider.phone,
              ),
              Gap(height(10)),
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
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: width(10),
        ),
      ),
    );
  }
}
