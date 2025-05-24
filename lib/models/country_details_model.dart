class DetailedCountry {
  final String country;
  final String detailsAr;
  final String detailsEn;
  final int detailsId;
  final String instaLink;
  final String whatsappLink;
  final String xLink;

  DetailedCountry({
    required this.country,
    required this.detailsAr,
    required this.detailsEn,
    required this.detailsId,
    required this.instaLink,
    required this.whatsappLink,
    required this.xLink,
  });

  factory DetailedCountry.fromJson(Map<String, dynamic> json) {
    return DetailedCountry(
      country: json['country'] as String,
      detailsAr: json['details_ar'] as String,
      detailsEn: json['details_en'] as String,
      detailsId: json['details_id'] as int,
      instaLink: json['insta_link'] as String,
      whatsappLink: json['whatsapp_link'] as String,
      xLink: json['x_link'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'country': country,
      'details_ar': detailsAr,
      'details_en': detailsEn,
      'details_id': detailsId,
      'insta_link': instaLink,
      'whatsapp_link': whatsappLink,
      'x_link': xLink,
    };
  }
}
