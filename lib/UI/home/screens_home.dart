import 'package:flutter/material.dart';
import 'package:personal_money_management_app/UI/Transations/screen_transaction.dart';
import 'package:personal_money_management_app/UI/add_transaction/screen_add_transaction.dart';
import 'package:personal_money_management_app/UI/category/category_add_popup.dart';
import 'package:personal_money_management_app/UI/home/widgets/bottom_navigation.dart';
import '../category/screen_category.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);
  final _pages = const [
    ScreenTransaction(),
    CategoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        floatingActionButton: FloatingActionButton(
          elevation: 5,
          backgroundColor: Colors.pink,
          onPressed: () {
            if (selectedIndexNotifier.value == 0) {
              Navigator.of(context).pushNamed(ScreenAddTransaction.routeName);
            } else {
              showCategoryAddpop(context);
            }
          },
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: const CustomBottomNavigation(),
        // appBar: AppBar(title: const Text('MONEY MANAGER'), centerTitle: true,backgroundColor: Colors.pink,),
        body: SafeArea(
          child: ValueListenableBuilder(
              valueListenable: selectedIndexNotifier,
              builder: (BuildContext context, int updated, _) {
                return _pages[updated];
              }),
        ));
  }
}
