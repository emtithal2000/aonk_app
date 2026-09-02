import 'package:intl/intl.dart';

const kApiBaseUrl = 'https://api.aonk.app';

Uri buildDriverDonationsUri({
  required String driverName,
  required String username,
  DateTime? deliveryDate,
}) {
  final params = <String, String>{
    'driver_name': driverName,
    'username': username,
  };

  if (deliveryDate != null) {
    params['delivery_date'] = DateFormat('yyyy-MM-dd').format(deliveryDate);
  }

  return Uri.parse('$kApiBaseUrl/customer_donations').replace(
    queryParameters: params,
  );
}

Uri get driverLoginUri => Uri.parse('$kApiBaseUrl/driver/login');

Uri get deliveryStatusUri => Uri.parse('$kApiBaseUrl/delivery_status');
