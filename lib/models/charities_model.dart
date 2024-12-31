class Charity {
  final int charityId;
  final String charityName;
  final String contactPhone;
  final String description;
  final String logo;
  final String website;

  Charity({
    required this.charityId,
    required this.charityName,
    required this.contactPhone,
    required this.description,
    required this.logo,
    required this.website,
  });

  factory Charity.fromJson(Map<String, dynamic> json) {
    return Charity(
      charityId: json['charity_id'],
      charityName: json['charity_name'],
      contactPhone: json['contact_phone'],
      description: json['description'],
      logo: json['logo'],
      website: json['website'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'charity_id': charityId,
      'charity_name': charityName,
      'contact_phone': contactPhone,
      'description': description,
      'logo': logo,
      'website': website,
    };
  }
}
