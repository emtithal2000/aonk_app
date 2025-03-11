class CustomerDonation {
  final int id;
  final String building;
  final String charityName;
  final String city;
  final String country;
  final String date;
  final String donationImage;
  final List<String> donationTypes;
  final String email;
  final bool gift;
  final String giftName;
  final String giftPhone;
  final String name;
  final String phone;
  final String street;

  CustomerDonation({
    required this.id,
    required this.building,
    required this.charityName,
    required this.city,
    required this.country,
    required this.date,
    required this.donationImage,
    required this.donationTypes,
    required this.email,
    required this.gift,
    required this.giftName,
    required this.giftPhone,
    required this.name,
    required this.phone,
    required this.street,
  });

  factory CustomerDonation.fromJson(Map<String, dynamic> json) {
    return CustomerDonation(
      id: json['id'] as int,
      building: json['building'] as String,
      charityName: json['charity_name'] as String,
      city: json['city'] as String,
      country: json['country'] as String,
      date: json['date'] as String,
      donationImage: json['donation_image'] as String,
      donationTypes: _parseDonationTypes(json['donation_types']),
      email: json['email'] as String,
      gift: json['gift'] as bool,
      giftName: json['gift_name'] as String,
      giftPhone: json['gift_phone'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      street: json['street'] as String,
    );
  }

  static List<String> _parseDonationTypes(String donationTypesStr) {
    // Remove the brackets and split the string
    String cleanStr = donationTypesStr.replaceAll('[', '').replaceAll(']', '');
    if (cleanStr.isEmpty) return [];

    // Split by comma and trim each element
    return cleanStr.split(',').map((e) => e.trim()).toList();
  }
}
