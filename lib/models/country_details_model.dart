class CountryDetails {
  final String country;
  final String detailsAr;
  final String detailsEn;
  final int detailsId;
  final String instaLink;
  final int whatsappNumber;
  final String xLink;

  CountryDetails({
    required this.country,
    required this.detailsAr,
    required this.detailsEn,
    required this.detailsId,
    required this.instaLink,
    required this.whatsappNumber,
    required this.xLink,
  });

  factory CountryDetails.fromJson(Map<String, dynamic> json) {
    return CountryDetails(
      country: json['country'] as String,
      detailsAr: json['details_ar'] as String,
      detailsEn: json['details_en'] as String,
      detailsId: json['details_id'] as int,
      instaLink: json['insta_link'] as String,
      whatsappNumber: json['whatsapp_number'] as int,
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
      'whatsapp_number': whatsappNumber,
      'x_link': xLink,
    };
  }
}
