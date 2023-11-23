import 'package:flutter/material.dart';
import '../../hive_database/Category_DB/Category_DB.dart';
import '../../model/Category_model/category_model.dart';

class ExpenseCategoryList extends StatelessWidget {
  const ExpenseCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CategoryBD().expenseCategoryListListenabler,
        builder: (BuildContext, List<CategoryModel> newList, Widget? _) {
          return ListView.separated(
              itemBuilder: (context, index) {
                final catogroy = newList[index];
                return Card(
                  child: ListTile(
                    title: Text(catogroy.name),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        CategoryBD.instance.deletCategory(catogroy.id);
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
