import 'package:aonk_app/models/countries_model.dart';

class DonationTypeSummary {
  final int id;
  final String nameEn;
  final String nameAr;

  const DonationTypeSummary({
    required this.id,
    required this.nameEn,
    required this.nameAr,
  });

  factory DonationTypeSummary.fromJson(Map<String, dynamic> json) {
    return DonationTypeSummary(
      id: json['id'] as int,
      nameEn: json['name_en'] as String? ?? '',
      nameAr: json['name_ar'] as String? ?? '',
    );
  }
}

class CustomerDonation {
  final int requestId;
  final City city;
  final String? requestDate;
  final String? deliveryDate;
  String? deliveryStatus;
  final List<DonationTypeSummary> donationTypes;
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
      city: City.fromJson(json['city'] as Map<String, dynamic>),
      requestDate: json['request_date'] as String?,
      deliveryDate: json['delivery_date'] as String?,
      deliveryStatus: json['delivery_status'] as String?,
      donationTypes: (json['donation_types'] as List<dynamic>)
          .map((e) => DonationTypeSummary.fromJson(e as Map<String, dynamic>))
          .toList(),
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
          .map((e) => CustomerDonation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
