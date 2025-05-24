class Charity {
  final int charityId;
  final String charityAr;
  final String charityEn;
  final String contactPhone;
  final String country;
  final String descriptionAr;
  final String descriptionEn;
  final bool isnamed;
  final String logo;
  final String website;
  final String place;

  Charity({
    required this.charityId,
    required this.charityAr,
    required this.charityEn,
    required this.contactPhone,
    required this.country,
    required this.descriptionAr,
    required this.descriptionEn,
    required this.isnamed,
    required this.logo,
    required this.website,
    required this.place,
  });

  factory Charity.fromJson(Map<String, dynamic> json) {
    return Charity(
      charityId: json['charity_id'],
      charityAr: json['charity_ar'],
      charityEn: json['charity_en'],
      contactPhone: json['contact_phone'],
      country: json['country'],
      descriptionAr: json['description_ar'],
      descriptionEn: json['description_en'],
      isnamed: json['isnamed'],
      logo: json['logo'],
      website: json['website'],
      place: json['place'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'charity_id': charityId,
      'charity_ar': charityAr,
      'charity_en': charityEn,
      'contact_phone': contactPhone,
      'country': country,
      'description_ar': descriptionAr,
      'description_en': descriptionEn,
      'isnamed': isnamed,
      'logo': logo,
      'website': website,
      'place': place,
    };
  }
}
