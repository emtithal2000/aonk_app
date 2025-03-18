import 'package:aonk_app/providers/pages_provider.dart';
import 'package:aonk_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:aonk_app/l10n/app_localizations.dart';
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
                AppLocalizations.of(context)!.enterPersonalData,
                style: TextStyle(
                  fontSize: width(15),
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF81bdaf),
                  fontFamily: 'Marhey',
                ),
              ),
              Gap(height(15)),
              customInput(
                AppLocalizations.of(context)!.name,
                provider.controllers[5],
                context,
              ),
              Gap(height(10)),
              customInput(
                AppLocalizations.of(context)!.phoneNumber,
                provider.controllers[6],
                context,
              ),
              Gap(height(15)),
              customButton(context, provider, () {
                if (provider.formKey.currentState!.validate()) {
                  provider.nextPage(false);
                }
              }, AppLocalizations.of(context)!.next),
            ],
          ),
        );
      },
    );
  }

  Widget customInput(
    String hintText,
    TextEditingController controller,
    BuildContext context,
  ) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value!.isEmpty) {
          return '${AppLocalizations.of(context)!.pleaseEnter} $hintText';
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
