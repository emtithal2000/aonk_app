class DetailedCountry {
  final String countryAr;
  final String countryEn;
  final int countryId;
  final String detailsAr;
  final String detailsEn;
  final int detailsId;
  final String instaLink;
  final String whatsappLink;
  final String xLink;
  final int phone;

  DetailedCountry({
    required this.countryAr,
    required this.countryEn,
    required this.countryId,
    required this.detailsAr,
    required this.detailsEn,
    required this.detailsId,
    required this.instaLink,
    required this.whatsappLink,
    required this.xLink,
    required this.phone,
  });

  factory DetailedCountry.fromJson(Map<String, dynamic> json) {
    return DetailedCountry(
      countryAr: json['country_ar'] as String,
      countryEn: json['country_en'] as String,
      countryId: json['country_id'] as int,
      detailsAr: json['details_ar'] as String,
      detailsEn: json['details_en'] as String,
      detailsId: json['details_id'] as int,
      instaLink: json['insta_link'] as String,
      whatsappLink: json['whatsapp_link'] as String,
      xLink: json['x_link'] as String,
      phone: json['contact_number'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'country_ar': countryAr,
      'country_en': countryEn,
      'country_id': countryId,
      'details_ar': detailsAr,
      'details_en': detailsEn,
      'details_id': detailsId,
      'insta_link': instaLink,
      'whatsapp_link': whatsappLink,
      'x_link': xLink,
      'contact_number': phone,
    };
  }
}
