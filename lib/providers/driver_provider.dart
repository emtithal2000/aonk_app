import 'package:flutter/material.dart';

class DriverProvider extends ChangeNotifier {
  OrderStatus _selectedStatus = OrderStatus.all;
  final List<String> _status = [
    "كل الطلبات",
    "قيد المعالجة",
    "مكتملة",
  ];

  OrderStatus get selectedStatus => _selectedStatus;
  List<String> get status => _status;

  void setSelectedStatus(OrderStatus status) {
    _selectedStatus = status;
    notifyListeners();
  }

  String convertStatusToArabic(OrderStatus status) {
    switch (status) {
      case OrderStatus.all:
        return "كل الطلبات";
      case OrderStatus.inProgress:
        return "قيد المعالجة";
      case OrderStatus.completed:
        return "مكتملة";
    }
  }
}

enum OrderStatus {
  all,
  inProgress,
  completed,
}
