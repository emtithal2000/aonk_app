import 'dart:developer';

import 'package:aonk_app/models/customer_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DriverProvider extends ChangeNotifier {
  final username = TextEditingController();
  final password = TextEditingController();
  var formKey = GlobalKey<FormState>();

  List<CustomerDonation> donations = [];

  Future<void> getDonations(String driverName) async {
    try {
      final response = await Dio().get(
          'https://api.aonk.app/customer_donations?driver_name=$driverName');

      final jsonData = response.data['driver_donations'] as List<dynamic>;

      donations = jsonData.map((e) => CustomerDonation.fromJson(e)).toList();

      notifyListeners();
    } on DioException catch (e) {
      log(e.response?.data.toString() ?? 'No response data');
    }
  }

  Future<bool> login() async {
    try {
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
    } on DioException catch (_) {
      return false;
    }
  }
}
