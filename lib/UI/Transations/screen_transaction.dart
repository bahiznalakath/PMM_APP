import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../Provider/total_expense_notifier.dart';
import '../../Provider/total_income_notifier.dart';
import '../../hive_database/Category_DB/Category_DB.dart';
import '../../hive_database/Transaction DB/Transaction_DB.dart';
import '../../model/Category_model/category_model.dart';
import '../../model/Expense_model/expense.dart';
import '../../model/Transaction_model/transaction_model.dart';
import '../home/widgets/incomeexpensecard.dart';

class ScreenTransaction extends StatefulWidget {
  const ScreenTransaction({Key? key}) : super(key: key);

  @override
  State<ScreenTransaction> createState() => _ScreenTransactionState();
}

class _ScreenTransactionState extends State<ScreenTransaction> {
  @override
  void initState() {
    fetchDataAndBuildUI();
    super.initState();
  }

  Future<void> fetchDataAndBuildUI() async {
    var totalIncomeNotifier = context.read<TotalIncomeNotifier>();
    var totalExpenseNotifier = context.read<TotalExpenseNotifier>();

    totalIncomeNotifier.setTotalIncome(await calculateTotalAmount(CategoryType.income));
    totalExpenseNotifier.setTotalExpense(await calculateTotalAmount(CategoryType.expense));
  }

  @override
  Widget build(BuildContext context) {
    double totalIncome = context.watch<TotalIncomeNotifier>().totalIncome;
    double totalExpense = context.watch<TotalExpenseNotifier>().totalExpense;

    CategoryBD.instance.refreshUI();
    TransactionBD.instance.refresh();

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: IncomeExpenseCard(
                    expenseData: ExpenseData(
                      "Income",
                      totalIncome.toString(),
                      Icons.arrow_upward_rounded,
                    ),
                  ),
                ),
                const SizedBox(
                  width: defaultSpacing, // Make sure to define defaultSpacing somewhere
                ),
                Expanded(
                  child: IncomeExpenseCard(
                    expenseData: ExpenseData(
                      "Expense",
                      totalExpense.toString(),
                      Icons.arrow_downward_rounded,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            height: 615,
            child: ValueListenableBuilder(
              valueListenable: TransactionBD.instance.transactionListNotifier,
              builder: (BuildContext context, List<TransactionModel> newList, Widget? _) {
                return ListView.separated(
                  padding: const EdgeInsets.all(10),
                  itemBuilder: (context, index) {
                    final values = newList[index];
                    return Slidable(
                      key: Key(values.id!),
                      startActionPane: ActionPane(motion: ScrollMotion(), children: [
                        SlidableAction(
                          onPressed: (context) {
                            TransactionBD.instance.deleteTransaction(values.id!);
                          },
                          icon: Icons.delete,
                        )
                      ]),
                      child: Card(
                        elevation: 5,
                        child: ListTile(
                          title: Text(
                            "RS ${values.amount}",
                          ),
                          leading: CircleAvatar(
                            radius: 60,
                            backgroundColor: values.type == CategoryType.income
                                ? Colors.green
                                : Colors.red,
                            child: Text(
                              parseDate(values.date),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          subtitle: Text(values.category.name),
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
                  itemCount: newList.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String parseDate(DateTime date) {
    final date0 = DateFormat.MMMd().format(date);
    final splitDate = date0.split('');
    return '${splitDate.last}\n ${splitDate.first}';
  }

  Future<double> calculateTotalAmount(CategoryType type) async {
    final transactions = await TransactionBD.instance.getTransactionList();
    double totalAmount = 0;

    for (var transaction in transactions) {
      if (transaction.type == type) {
        totalAmount += transaction.amount;
      }
    }

    return totalAmount;
  }
}
