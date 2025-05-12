import 'dart:developer';

import 'package:aonk_app/models/customer_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

/// Enum representing the possible statuses for a donation
enum DonationStatus {
  received,
  postponed,
  cancelled,
  noResponse;

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
    }
  }

  String get displayName {
    switch (this) {
      case DonationStatus.received:
        return 'received';
      case DonationStatus.postponed:
        return 'postponed';
      case DonationStatus.cancelled:
        return 'cancelled';
      case DonationStatus.noResponse:
        return 'no_response';
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

  bool _isLoading = false;
  String? _error;

  List<CustomerDonation> get donations => _donations;
  String? get error => _error;

  bool get isLoading => _isLoading;
  DonationStatus? get selectedStatus => _selectedStatus;

  /// Clears the selected status
  void clearSelectedStatus() {
    _selectedStatus = null;
    notifyListeners();
  }

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  /// Fetches donations for a specific driver
  Future<void> getDonations(String driverName) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final response = await Dio().get(
        'https://api.aonk.app/customer_donations?driver_name=$driverName',
      );

      final jsonData = response.data['driver_donations'] as List<dynamic>;
      _donations = jsonData.map((e) => CustomerDonation.fromJson(e)).toList();

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
        final driverName = response.data['name'] as String;
        await getDonations(driverName);
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

  /// Sets the currently selected status
  void setSelectedStatus(DonationStatus status) {
    _selectedStatus = status;
    notifyListeners();
  }

  /// Updates the status of a donation
  Future<bool> updateDonationStatus(
      int requestId, DonationStatus status) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final response = await Dio().post(
        'https://api.aonk.app/update_donation_status',
        data: {
          'request_id': requestId,
          'status': status.displayName,
        },
      );

      if (response.statusCode == 200) {
        // Update the local donation status
        final index = _donations.indexWhere((d) => d.requestId == requestId);
        if (index != -1) {
          _donations[index] = CustomerDonation(
            requestId: _donations[index].requestId,
            city: _donations[index].city,
            requestDate: _donations[index].requestDate,
            deliveryDate: _donations[index].deliveryDate,
            deliveryStatus: _donations[index].deliveryStatus,
            donationTypes: _donations[index].donationTypes,
            driverName: _donations[index].driverName,
            name: _donations[index].name,
            phone: _donations[index].phone,
            status: status.displayName,
          );
        }
        _isLoading = false;
        notifyListeners();
        return true;
      }
      return false;
    } on DioException catch (e) {
      _error = e.response?.data?.toString() ?? 'Failed to update status';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
