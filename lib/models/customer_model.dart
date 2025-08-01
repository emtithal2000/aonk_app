import 'package:aonk_app/models/countries_model.dart';

class CustomerDonation {
  final int requestId;
  final City city;
  final String? requestDate;
  final String? deliveryDate;
  String? deliveryStatus; // Changed to mutable
  final List<String> donationTypes;
  final String? driverName;
  final String name;
  final String phone;
  final String status;

  CustomerDonation({
    required this.requestId,
    required this.city,
    this.requestDate,
    this.deliveryDate,
    this.deliveryStatus,
    required this.donationTypes,
    this.driverName,
    required this.name,
    required this.phone,
    required this.status,
  });

  factory CustomerDonation.fromJson(Map<String, dynamic> json) {
    return CustomerDonation(
      requestId: json['request_id'] as int,
      city: City.fromJson(json['city']),
      requestDate: json['request_date'] as String?,
      deliveryDate: json['delivery_date'] as String?,
      deliveryStatus: json['delivery_status'] as String?,
      donationTypes:
          (json['donation_types'] as List).map((e) => e.toString()).toList(),
      driverName: json['driver_name'] as String?,
      name: json['name'] as String,
      phone: json['phone'] as String,
      status: json['status'] as String,
    );
  }
}

class DriverDonationsResponse {
  final List<CustomerDonation> driverDonations;

  DriverDonationsResponse({
    required this.driverDonations,
  });

  factory DriverDonationsResponse.fromJson(Map<String, dynamic> json) {
    return DriverDonationsResponse(
      driverDonations: (json['driver_donations'] as List)
          .map((e) => CustomerDonation.fromJson(e))
          .toList(),
    );
  }
}
