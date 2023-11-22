import 'package:hive/hive.dart';
import 'package:personal_money_management_app/model/category/category_model.dart';
part 'transaction_model.g.dart';

@HiveType(typeId: 3)
class TransactionModel {
  @HiveField(0)
  final String puepose;
  @HiveField(1)
  final double amount;
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
  final CategoryType type;
  @HiveField(4)
  final CategoryModel category;
  @HiveField(5)
   String? id ;
  TransactionModel({
    required this.puepose,
    required this.amount,
    required this.date,
    required this.type,
    required this.category,
  })
  {
    id = DateTime.now().microsecondsSinceEpoch.toString();
}
}
