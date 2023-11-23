import 'package:flutter/material.dart';

class TotalExpenseNotifier extends ChangeNotifier {
  double _totalExpense = 0;

  double get totalExpense => _totalExpense;

  void setTotalExpense(double value) {
    _totalExpense = value;
    notifyListeners();
  }
}
