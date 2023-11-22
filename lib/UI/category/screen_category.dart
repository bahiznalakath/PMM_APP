import 'package:flutter/material.dart';
import 'package:personal_money_management_app/UI/category/ExpenseCategoryList.dart';
import 'package:personal_money_management_app/UI/category/IncomeCategoryList.dart';
import '../../hive_database/Category_DB/Category_DB.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    CategoryBD().refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          controller: _tabController,
          tabs: const [
            Tab(
              text: 'INCOME',
            ),
            Tab(
              text: 'EXPENSE',
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [IncomeCategoryList(), ExpenseCategoryList()],
          ),
        ),
      ],
    );
  }
}
