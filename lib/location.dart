// Define a map of countries and their respective cities
import 'package:flutter/material.dart';

final Map<String, List<String>> countryCities = {
  'سلطنة عُمان': [
    'مسقط',
    'صلالة',
    'صحار',
    'نزوى',
    'صور',
    'بركاء',
    'عبري',
    'الرستاق',
    'الدقم',
    'خصب',
    'البريمي',
    'السيب',
    'بهلاء',
    'المضيبي',
    'إبراء',
    'بدية',
    'شناص',
    'أدم',
    'سمائل',
    'الحمراء',
  ],
  'قطر': [
    'الدوحة',
    'الوكرة',
    'الخور',
    'الريان',
    'الشحانية',
    'أم صلال',
    'الغرافة',
    'الظعاين',
    'الوجبة',
    'الزبارة',
    'معيذر',
    'الجميلية',
    'دخان',
    'مسيعيد',
    'لوسيل',
  ],
  // 'الكويت': [
  //   'مدينة الكويت',
  //   'الجهراء',
  //   'السالمية',
  //   'الفحيحيل',
  //   'حولي',
  //   'الأحمدي',
  //   'مبارك الكبير',
  //   'صباح السالم',
  //   'الرميثية',
  //   'العقيلة',
  //   'الفروانية',
  //   'المنقف',
  //   'خيطان',
  //   'بيان',
  //   'مشرف',
  // ],
  // 'البحرين': [
  //   'المنامة',
  //   'المحرق',
  //   'الرفاع',
  //   'عيسى',
  //   'سترة',
  //   'البديع',
  //   'جدحفص',
  //   'الحد',
  //   'عالي',
  //   'مدينة حمد',
  //   'مدينة زايد',
  //   'الدراز',
  //   'القرية',
  //   'الهملة',
  //   'بني جمرة',
  // ],
  // 'السعودية': [
  //   'الرياض',
  //   'جدة',
  //   'مكة المكرمة',
  //   'المدينة المنورة',
  //   'الدمام',
  //   'الطائف',
  //   'الخبر',
  //   'بريدة',
  //   'أبها',
  //   'تبوك',
  //   'حائل',
  //   'نجران',
  //   'الجبيل',
  //   'خميس مشيط',
  //   'ينبع',
  //   'القطيف',
  //   'الأحساء',
  //   'عرعر',
  //   'سكاكا',
  //   'جازان',
  //   'الباحة',
  //   'المجمعة',
  //   'الزلفي',
  //   'القنفذة',
  //   'حفر الباطن',
  //   'بيشة',
  // ],
};

Widget buildContainer(BuildContext context, Widget child) {
  return Container(
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
    child: child,
  );
}

// Function to get cities for a selected country
List<String> getCitiesForCountry(String? country) {
  return countryCities[country] ?? [];
}
