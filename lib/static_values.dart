final Map<String, Map<String, List<String>>> countryCities = {
  'Oman': {
    'en': [
      // Muscat Governorate
      'Muscat',
      'Muttrah',
      'Bousher',
      'Al Sīb',
      'Al ʻAmārat',
      'Qurayyat',

      // Al Batinah North Governorate
      'Suhar',
      'Shinas',
      'Liwa',
      'Saham',
      'Al Khabourah',
      'Al Suwaiq',

      // Al Batinah South Governorate
      'Al Rustaq',
      'Al Awabi',
      'Nakhal',
      'Wadi Al Maawil',
      'Barka',
      'Al Musannah',

      // Al Buraimi Governorate
      'Al Buraimi',
      'Mahdah',
      'Al Sinainah',

      // Al Dakhiliyah Governorate
      'Nizwa',
      'Bahla',
      'Adam',
      'Al Hamra',
      'Manah',
      'Izki',
      'Bidbid',
      'Samail',

      // Al Sharqiyah  Governorate
      'Al Mudhaibi',
      'Al Qabil',
      'Ibra',
      'Dima Wa Al Taien',
      'Sur',
      'Al Kamil Wa Al Wafi',
      'Jalan Bani Bu Hassan',
      'Jalan Bani Bu Ali',
      'Masirah',

      // Al Wusta Governorate
      'Haima',
      'Duqm',
      'Mahout',
      'Al Jazir',
      'Al Hallaniyat Islands',

      // Dhofar Governorate
      'Salalah',
      'Rakhyut',
      'Dalkut',
      'Mirbat',
      'Sadah',
      'Shalim ',
      'Taqah',
      'Thumrait',
      'Al Mazyounah',
      'Muqshin',

      // Musandam Governorate
      'Khasab',
      'Daba ',
      'Bukha',
      'Madha',
    ],
    'ar': [
      // محافظة مسقط
      'مسقط',
      'مطرح',
      'بوشر',
      'السيب',
      'العامرات',
      'قريات',

      // محافظة شمال الباطنة
      'صحار',
      'شناص',
      'لوى',
      'صحار',
      'الخابورة',
      'السويق',

      // محافظة جنوب الباطنة
      'الرستاق',
      'العوابي',
      'نخل',
      'وادي المعاول',
      'بركاء',
      'المصنعة',

      // محافظة البريمي
      'البريمي',
      'محضة',
      'السنينة',

      // محافظة الداخلية
      'نزوى',
      'بهلاء',
      'ادم',
      'الحمراء',
      'منح',
      'إزكي',
      'بدبد',
      'سمائل',

      // محافظة  الشرقية
      'المضيبي',
      'القابل',
      'إبراء',
      'دماء والطائيين',
      'صور',
      'الكامل والوافي',
      'جعلان بني بو حسن',
      'جعلان بني بو علي',
      'مصيرة',

      // محافظة الوسطى
      'هيماء',
      'الدقم',
      'محوت',
      'الجازر',
      'جزر الحلانيات',

      // محافظة ظفار
      'صلالة',
      'رخيوت',
      'ضلكوت',
      'مرباط',
      'سدح',
      'شليم',
      'طاقة',
      'ثمريت',
      'المزيونة',
      'مقشن',

      // محافظة مسندم
      'خصب',
      'دبا ',
      'بخا',
      'مدحاء',
    ],
  },
  'Qatar': {
    'en': [
      'Doha',
      'Al Wakrah',
      'Al Khor',
      'Al Rayyan',
      'Al Sheehaniya',
      'Umm Salal',
      'Al Gharrafa',
      'Al Daayen',
      'Al Wajba',
      'Al Zubarah',
      'Mesaieed',
      'Al Jumailiya',
      'Dukhan',
      'Mesaieed',
      'Lusail',
    ],
    'ar': [
      'الدوحة',
      'الوكرة',
      'الخور',
      'الريان',
      'الشيحانية',
      'أم صلال',
      'الغرفة',
      'الداين',
      'الوجبة',
      'الزبرة',
      'مسيعيد',
      'الجميلية',
      'دخان',
      'مسيعيد',
      'لوسيل',
    ],
  },
};

// Unified country information map
final Map<String, Map<String, dynamic>> countries = {
  'Oman': {
    'en': 'Oman',
    'ar': 'سلطنة عُمان',
    'code': 'OM',
    'phoneCode': '+968',
  },
  'Qatar': {
    'en': 'Qatar',
    'ar': 'قطر',
    'code': 'QR',
    'phoneCode': '+974',
  },
};

// Helper getters for backward compatibility
Map<String, Map<String, String>> get countryNames => {
      for (var entry in countries.entries)
        entry.key: {'en': entry.value['en'], 'ar': entry.value['ar']}
    };

Map<String, String> get countryPhoneCodes =>
    {for (var entry in countries.entries) entry.key: entry.value['phoneCode']};

Map<String, Map<String, String>> get countryCodeToNames => {
      for (var entry in countries.entries)
        entry.value['code']: {'en': entry.value['en'], 'ar': entry.value['ar']}
    };
