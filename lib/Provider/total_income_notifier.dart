import 'package:flutter/material.dart';

class TotalIncomeNotifier extends ChangeNotifier {
  double _totalIncome = 0;

  double get totalIncome => _totalIncome;

  void setTotalIncome(double value) {
    _totalIncome = value;
    notifyListeners();
  }
}
