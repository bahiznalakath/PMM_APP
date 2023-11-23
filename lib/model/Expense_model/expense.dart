import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
part 'expense.g.dart';


@HiveType(typeId: 4)
class ExpenseData {
  @HiveField(0)
  final String label;
  @HiveField(1)
  final String amount;
  @HiveField(2)
  final IconData icon;

  const ExpenseData(this.label, this.amount, this.icon);
}
