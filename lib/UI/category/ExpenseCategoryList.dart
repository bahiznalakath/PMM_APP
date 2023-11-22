import 'package:flutter/material.dart';
import 'package:personal_money_management_app/DB/%20category/Category_DB.dart';
import '../../DB/ category/Category_DB.dart';
import '../../model/category/category_model.dart';

class ExpenseCategoryList extends StatelessWidget {
  const ExpenseCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(valueListenable: CategoryBD().expenseCategoryListListenabler, builder:(BuildContext, List<CategoryModel>newList, Widget? _){
      return ListView.separated(
          itemBuilder: (context, index) {
            final _catogroy = newList[index];
            return Card(
              child: ListTile(
                title:  Text(_catogroy.name),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    CategoryBD.instance.deletCategory(_catogroy.id);
                  },
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 10,
            );
          },
          itemCount: newList.length);
    });
  }
}
