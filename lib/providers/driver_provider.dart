import 'dart:developer';

import 'package:aonk_app/l10n/app_localizations.dart';
import 'package:aonk_app/models/customer_model.dart';
import 'package:aonk_app/models/driver_session.dart';
import 'package:aonk_app/services/driver_api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get_storage/get_storage.dart';

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
  static const _sessionKey = 'driver_login';

  final Dio _dio = Dio();
  final username = TextEditingController();
  final password = TextEditingController();

  List<CustomerDonation> _donations = [];
  DonationStatus? _selectedStatus;
  DateTime? _selectedDate;

  bool _isLoading = false;
  String? _error;
  String? _driverName;
  String? _username;
  bool _isSearchFilterActive = false;

  List<CustomerDonation> filteredDonations = [];
  List<CustomerDonation> get donations => _donations;
  String? get driverName => _driverName;
  String? get usernameValue => _username;
  String? get error => _error;
  bool get isLoading => _isLoading;
  bool get isSearchFilterActive => _isSearchFilterActive;
  DateTime? get selectedDate => _selectedDate;
  bool get hasSession =>
      _driverName != null &&
      _driverName!.isNotEmpty &&
      _username != null &&
      _username!.isNotEmpty;

  DonationStatus? get selectedStatus => _selectedStatus;

  Future<bool> restoreSession() async {
    final stored = GetStorage().read(_sessionKey);
    if (stored is! Map) {
      return false;
    }

    try {
      final session = DriverSession.fromJson(Map<String, dynamic>.from(stored));
      if (!session.isValid) {
        await clearDriverLogin();
        return false;
      }

      _driverName = session.name;
      _username = session.username;
      notifyListeners();
      return true;
    } catch (e) {
      log('Failed to restore driver session: $e');
      await clearDriverLogin();
      return false;
    }
  }

  Future<void> clearSelectedDate() async {
    _selectedDate = null;
    notifyListeners();
    await fetchDonations();
  }

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
      await _dio.put(
        deliveryStatusUri.toString(),
        data: FormData.fromMap({
          'request_id': requestId,
          'delivery_status': _selectedStatus?.displayName,
        }),
      );

      if (_selectedStatus != null) {
        final donationIndex =
            _donations.indexWhere((d) => d.requestId == requestId);
        if (donationIndex != -1) {
          _donations[donationIndex].deliveryStatus =
              _selectedStatus!.displayName;
        }

        final filteredIndex =
            filteredDonations.indexWhere((d) => d.requestId == requestId);
        if (filteredIndex != -1) {
          filteredDonations[filteredIndex].deliveryStatus =
              _selectedStatus!.displayName;
        }

        notifyListeners();
      }

      return true;
    } on DioException catch (e) {
      log(e.response?.data.toString() ?? 'No response data');
      return false;
    }
  }

  Future<void> fetchDonations() async {
    if (!hasSession) {
      _error = 'Driver session not found';
      notifyListeners();
      return;
    }

    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final deliveryDate = _selectedDate ?? DateTime.now();
      final uri = buildDriverDonationsUri(
        driverName: _driverName!,
        username: _username!,
        deliveryDate: deliveryDate,
      );

      final response = await _dio.get(uri.toString());

      final jsonData = response.data['driver_donations'] as List<dynamic>;
      _donations = jsonData.map((e) => CustomerDonation.fromJson(e)).toList();
      _isSearchFilterActive = false;
      filteredDonations = List.from(_donations);
      _sortDonationsByDeliveryTime();

      _isLoading = false;
      notifyListeners();
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        _error = e.response?.data?['error']?.toString() ??
            'Invalid delivery date format';
        _selectedDate = null;
        _isLoading = false;
        notifyListeners();
        await fetchDonations();
        return;
      }

      _error = e.response?.data?.toString() ?? 'Failed to fetch donations';
      _isLoading = false;
      notifyListeners();
      log(e.response?.data.toString() ?? 'No response data');
    }
  }

  Future<bool> login() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final response = await _dio.post(
        driverLoginUri.toString(),
        data: {
          'username': username.text,
          'password': password.text,
        },
      );

      if (response.statusCode == 200) {
        _driverName = response.data['name'] as String?;
        _username = response.data['username'] as String? ?? username.text;

        if (_driverName == null || _driverName!.isEmpty || _username!.isEmpty) {
          _error = 'Invalid login response';
          _isLoading = false;
          notifyListeners();
          return false;
        }

        await GetStorage().write(
          _sessionKey,
          DriverSession(name: _driverName!, username: _username!).toJson(),
        );

        _isLoading = false;
        notifyListeners();
        return true;
      }

      _isLoading = false;
      notifyListeners();
      return false;
    } on DioException catch (e) {
      _error = e.response?.data?.toString() ?? 'Login failed';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> clearDriverLogin() async {
    await GetStorage().remove(_sessionKey);
    _driverName = null;
    _username = null;
    _donations = [];
    filteredDonations = [];
    _selectedDate = null;
    _error = null;
    clearLogin();
    notifyListeners();
  }

  Future<List<CustomerDonation>> searchRequestById(String requestId) async {
    if (requestId.isEmpty) {
      return [];
    }
    return _donations
        .where((donation) => donation.requestId.toString().contains(requestId))
        .toList();
  }

  void filterToRequest(CustomerDonation donation) {
    filteredDonations = [donation];
    _isSearchFilterActive = true;
    notifyListeners();
  }

  void clearSearchFilter() {
    if (!_isSearchFilterActive) return;
    _isSearchFilterActive = false;
    filteredDonations = List.from(_donations);
    _sortDonationsByDeliveryTime();
    notifyListeners();
  }

  Future<void> setSelectedDate(DateTime? date) async {
    _selectedDate = date;
    notifyListeners();
    await fetchDonations();
  }

  void setSelectedStatus(DonationStatus status) {
    _selectedStatus = status;
    notifyListeners();
  }

  void _sortDonationsByDeliveryTime() {
    final dateFormat = DateFormat('dd-MM-yyyy h:mm a');
    filteredDonations.sort((a, b) {
      final aDate = a.deliveryDate != null
          ? dateFormat.parse(a.deliveryDate!)
          : DateTime(2100);
      final bDate = b.deliveryDate != null
          ? dateFormat.parse(b.deliveryDate!)
          : DateTime(2100);
      return aDate.compareTo(bDate);
    });
  }

  String formetDate(DateTime date, String format) {
    final dateFormat = DateFormat(format);
    return dateFormat.format(date);
  }

  String handleDate(DateTime? date, BuildContext context) {
    if (date == null) {
      return '${AppLocalizations.of(context)!.todayOrders}:';
    }
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final dateFormat = isArabic ? 'yyyy-MM-dd' : 'dd-MM-yyyy';
    return '${AppLocalizations.of(context)!.orders} ${formetDate(date, dateFormat)}:';
  }
}
