class CustomerModel {
  int? id;
  String charityName;
  String donationType;
  bool gift;
  String? giftName;
  String? giftPhone;
  List<String> donationList;
  String donationImage;
  String country;
  String city;
  String name;
  String phone;
  String email;
  String street;
  String building;

  CustomerModel({
    this.id,
    required this.charityName,
    required this.donationType,
    required this.gift,
    this.giftName,
    this.giftPhone,
    required this.donationList,
    required this.donationImage,
    required this.country,
    required this.city,
    required this.name,
    required this.phone,
    required this.email,
    required this.street,
    required this.building,
  });

  // Factory constructor to create an instance from a JSON map
  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'],
      charityName: json['charity_name'],
      donationType: json['donation_type'],
      gift: json['gift'],
      giftName: json['gift_name'],
      giftPhone: json['gift_phone'],
      donationList: List<String>.from(json['donation_list']),
      donationImage: json['donation_image'],
      country: json['country'],
      city: json['city'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      street: json['street'],
      building: json['building'],
    );
  }

  // Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'charity_name': charityName,
      'donation_type': donationType,
      'gift': gift,
      'gift_name': giftName,
      'gift_phone': giftPhone,
      'donation_list': donationList,
      'donation_image': donationImage,
      'country': country,
      'city': city,
      'name': name,
      'phone': phone,
      'email': email,
      'street': street,
      'building': building,
    };
  }
}
