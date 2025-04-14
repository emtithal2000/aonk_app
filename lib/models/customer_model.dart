class CustomerDonation {
  final int id;
  final String city;
  final String? date;
  final String? deliveryDate;
  final String? deliveryStatus;
  final String? deliveryTime;
  final List<String> donationTypes;
  final String? driverName;
  final String name;
  final String phone;
  final String status;

  CustomerDonation({
    required this.id,
    required this.city,
    this.date,
    this.deliveryDate,
    this.deliveryStatus,
    this.deliveryTime,
    required this.donationTypes,
    this.driverName,
    required this.name,
    required this.phone,
    required this.status,
  });

  factory CustomerDonation.fromJson(Map<String, dynamic> json) {
    return CustomerDonation(
      id: json['id'] as int,
      city: json['city'] as String,
      date: json['date'] as String?,
      deliveryDate: json['delivery_date'] as String?,
      deliveryStatus: json['delivery_status'] as String?,
      deliveryTime: json['delivery_time'] as String?,
      donationTypes: _parseDonationTypes(json['donation_types']),
      driverName: json['driver_name'] as String?,
      name: json['name'] as String,
      phone: json['phone'] as String,
      status: json['status'] as String,
    );
  }

  static List<String> _parseDonationTypes(String donationTypesStr) {
    try {
      // Remove the brackets and split the string
      String cleanStr =
          donationTypesStr.replaceAll('[', '').replaceAll(']', '');
      if (cleanStr.isEmpty) return [];

      // Split by comma and trim each element, handling Arabic text
      return cleanStr.split(',').map((e) => e.trim()).toList();
    } catch (e) {
      // Return empty list if parsing fails
      return [];
    }
  }
}
