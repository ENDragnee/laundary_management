import 'package:flutter/material.dart';
import 'package:laundary_management/core/constants/order_status.dart';

class DashboardController extends ChangeNotifier {
  static const int pageSize = 10; // 10 items per page

  int _currentPage = 1;
  OrderStatus? _selectedStatus;
  bool _isDescending = true;

  int get currentPage => _currentPage;
  int get offset => (_currentPage - 1) * pageSize;
  OrderStatus? get selectedStatus => _selectedStatus;
  bool get isDescending => _isDescending;

  void setPage(int page) {
    if (page < 1) return;
    _currentPage = page;
    notifyListeners();
  }

  void setStatus(OrderStatus? status) {
    _selectedStatus = status;
    _currentPage = 1; // Reset to page 1 on filter change
    notifyListeners();
  }

  void toggleSort() {
    _isDescending = !_isDescending;
    _currentPage = 1; // Reset to page 1 on sort change
    notifyListeners();
  }
}
