import 'dart:developer';

import 'package:aonk_app/l10n/app_localizations.dart';
import 'package:aonk_app/models/customer_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Helper function for localization
String getDonationStatusDisplayName(
    BuildContext context, DonationStatus status) {
  switch (status) {
    case DonationStatus.received:
      return AppLocalizations.of(context)!.received;
    case DonationStatus.postponed:
      return AppLocalizations.of(context)!.postponed;
    case DonationStatus.cancelled:
      return AppLocalizations.of(context)!.cancelled;
    case DonationStatus.noResponse:
      return AppLocalizations.of(context)!.noResponse;
    case DonationStatus.others:
      return AppLocalizations.of(context)!.others;
  }
}

/// Enum representing the possible statuses for a donation
enum DonationStatus {
  received,
  postponed,
  cancelled,
  noResponse,
  others;

  Color get color {
    switch (this) {
      case DonationStatus.received:
        return const Color(0xff52b8a0);
      case DonationStatus.postponed:
        return Colors.black;
      case DonationStatus.cancelled:
        return Colors.red;
      case DonationStatus.noResponse:
        return Colors.blueGrey;
      case DonationStatus.others:
        return Colors.orange;
    }
  }

  String get displayName {
    switch (this) {
      case DonationStatus.received:
        return 'Received';
      case DonationStatus.postponed:
        return 'Postponed';
      case DonationStatus.cancelled:
        return 'Cancelled';
      case DonationStatus.noResponse:
        return 'No Response';
      case DonationStatus.others:
        return 'Others';
    }
  }

  IconData get icon {
    switch (this) {
      case DonationStatus.received:
        return Icons.check_circle_outline_rounded;
      case DonationStatus.postponed:
        return Icons.pending_actions;
      case DonationStatus.cancelled:
        return Icons.cancel_outlined;
      case DonationStatus.noResponse:
        return Icons.pending_outlined;
      case DonationStatus.others:
        return Icons.more_horiz;
    }
  }

  static DonationStatus fromString(String status) {
    return DonationStatus.values.firstWhere(
      (element) => element.displayName == status,
      orElse: () => DonationStatus.noResponse,
    );
  }
}

class DriverProvider extends ChangeNotifier {
  final username = TextEditingController();
  final password = TextEditingController();
  var formKey = GlobalKey<FormState>();

  List<CustomerDonation> _donations = [];
  DonationStatus? _selectedStatus;
  DateTime? _selectedDate;

  bool _isLoading = false;
  String? _error;
  String? _driverName;

  List<CustomerDonation> filteredDonations = [];
  List<CustomerDonation> get donations => _donations;
  String? get driverName => _driverName;
  String? get error => _error;
  bool get isLoading => _isLoading;
  DateTime? get selectedDate => _selectedDate;

  DonationStatus? get selectedStatus => _selectedStatus;

  void clearSelectedDate() {
    _selectedDate = null;
    filteredDonations = _donations;
    notifyListeners();
  }

  /// Clears the selected status
  void clearSelectedStatus() {
    _selectedStatus = null;
    notifyListeners();
  }

  void clearLogin() {
    username.clear();
    password.clear();
    notifyListeners();
  }

  Future<bool> updateDonationStatus(int requestId) async {
    try {
      await Dio().put(
        'https://api.aonk.app/delivery_status',
        data: {
          'request_id': requestId,
          'delivery_status': _selectedStatus?.name,
        },
      );
      return true;
    } on DioException catch (e) {
      log(e.response?.data.toString() ?? 'No response data');
      return false;
    }
  }

  /// Fetches donations for a specific driver
  Future<void> getDonations(String driverName) async {
    donations.clear();
    filteredDonations.clear();

    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final response = await Dio().get(
        'https://api.aonk.app/customer_donations?driver_name=$driverName',
      );

      final jsonData = response.data['driver_donations'] as List<dynamic>;
      _donations = jsonData.map((e) => CustomerDonation.fromJson(e)).toList();
      filteredDonations = _donations;

      _isLoading = false;
      notifyListeners();
    } on DioException catch (e) {
      _error = e.response?.data?.toString() ?? 'Failed to fetch donations';
      _isLoading = false;
      notifyListeners();
      log(e.response?.data.toString() ?? 'No response data');
    }
  }

  /// Handles driver login
  Future<bool> login() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final response = await Dio().post(
        'https://api.aonk.app/driver/login',
        data: {
          'username': username.text,
          'password': password.text,
        },
      );

      if (response.statusCode == 200) {
        _driverName = response.data['name'] as String;
        return true;
      }
      return false;
    } on DioException catch (e) {
      _error = e.response?.data?.toString() ?? 'Login failed';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<List<CustomerDonation>> searchBoxesByName(String requestId) async {
    return _donations
        .where((donation) => donation.requestId.toString().contains(requestId))
        .toList();
  }

  void setSelectedDate(DateTime? date) {
    _selectedDate = date;
    if (_selectedDate == null) {
      filteredDonations = _donations;
    } else {
      filteredDonations = _donations.where((donation) {
        if (donation.deliveryDate == null) {
          return false;
        }
        try {
          // Assuming the date format is 'yyyy-MM-dd' or similar.
          // Adjust DateFormat if your date string is in a different format.
          final deliveryDateTime =
              DateFormat('dd-MM-yyyy').parse(donation.deliveryDate!);
          return deliveryDateTime.year == _selectedDate!.year &&
              deliveryDateTime.month == _selectedDate!.month &&
              deliveryDateTime.day == _selectedDate!.day;
        } catch (e) {
          // Handle parsing error, e.g., log it or treat as non-matching
          log('Error parsing date: \${donation.deliveryDate}, error: \$e');
          return false;
        }
      }).toList();
    }
    notifyListeners();
  }

  /// Sets the currently selected status
  void setSelectedStatus(DonationStatus status) {
    _selectedStatus = status;
    notifyListeners();
  }
}
