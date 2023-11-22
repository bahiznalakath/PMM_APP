import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import '../../hive_database/Category_DB/Category_DB.dart';
import '../../hive_database/Transaction DB/Transaction_DB.dart';
import '../../model/Category_model/category_model.dart';
import '../../model/Transaction_model/transaction_model.dart';


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
              return Slidable(
                key: Key(_values.id!),
                startActionPane: ActionPane(motion: ScrollMotion(), children: [
                  SlidableAction(
                    onPressed: (ctx) {
                      TransactionBD.instance.deleteTransaction(_values.id!);
                    },
                    icon: Icons.delete,
                  )
                ]),
                child: Card(
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

  String parseDate(DateTime date) {
    final _date = DateFormat.MMMd().format(date);
    final _splitedDate = _date.split('');
    return '${_splitedDate.last}\n ${_splitedDate.first}';
    // return '${date.day}\n${date.month}';
  }
}
