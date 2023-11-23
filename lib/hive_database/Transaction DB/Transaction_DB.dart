import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import '../../model/Transaction_model/transaction_model.dart';

const TRANSACTION_DB_NAME = 'transaction-db';

abstract class TransactionBDFuctions {
  Future<void> addTransaction(TransactionModel obj);

  Future<List<TransactionModel>> getAllTransaction();

  Future<List<TransactionModel>> getTransactionList();

  Future<void> deleteTransaction(String id);
}

class TransactionBD implements TransactionBDFuctions {
  TransactionBD._internal();

  static TransactionBD instance = TransactionBD._internal();

  factory TransactionBD() {
    return instance;
  }

  ValueNotifier<List<TransactionModel>> transactionListNotifier =
      ValueNotifier([]);

  @override
  Future<void> addTransaction(TransactionModel obj) async {
    final db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await db.put(obj.id, obj);
  }


  Future<void> refresh() async {
    final list = await getAllTransaction();
    list.sort((first, second) => second.date.compareTo(first.date));
    transactionListNotifier.value.clear();
    transactionListNotifier.value.addAll(list);
    transactionListNotifier.notifyListeners();
  }

  Future<List<TransactionModel>> getTransactionList() async {
    final db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    final List<TransactionModel> transactions = db.values.toList();
    transactions.sort((first, second) => second.date.compareTo(first.date));
    return transactions;
  }

  @override
  Future<List<TransactionModel>> getAllTransaction() async {
    final db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    return db.values.toList();

  }

  @override
  Future<void> deleteTransaction(String id) async {
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await _db.delete(id);
    refresh();
  }


}
