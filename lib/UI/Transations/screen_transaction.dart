import 'package:flutter/material.dart';
import 'package:personal_money_management_app/DB/%20category/Category_DB.dart';
import 'package:personal_money_management_app/DB/transaction_db/transaction_bd.dart';
import 'package:personal_money_management_app/model/category/category_model.dart';

import '../../model/transaction/transaction_model.dart';

class ScreenTransaction extends StatelessWidget {
  const ScreenTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    CategoryBD.instance.refreshUI();
    TransactionBD.instance.refresh();
    return ValueListenableBuilder(
      valueListenable: TransactionBD.instance.transactionListNotifier,
      builder:
          (BuildContext context, List<TransactionModel> newList, Widget? _) {
        return ListView.separated(
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, index) {
              final _values = newList[index];
              return Card(
                elevation: 2,
                child: ListTile(
                  title: Text(
                    "RS ${_values.amount}",
                  ),
                  leading: CircleAvatar(
                    radius: 50,
                    backgroundColor: _values.type == CategoryType.income
                        ? Colors.green
                        : Colors.red,
                    child: Text(parseDate(_values.date)),
                  ),
                  subtitle: Text(_values.category.name),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 5,
                child: Divider(),
              );
            },
            itemCount: newList.length);
      },
    );
  }

  String parseDate(DateTime data) {
    return '${data.day}\n${data.month}';
  }
}
