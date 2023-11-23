import 'package:flutter/material.dart';
import '../../hive_database/Category_DB/Category_DB.dart';
import '../../model/Category_model/category_model.dart';

class IncomeCategoryList extends StatelessWidget {
  const IncomeCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CategoryBD().incomeCategoryListListenabler,
        builder: (BuildContext, List<CategoryModel> newList, Widget? _) {
          return ListView.separated(
              itemBuilder: (context, index) {
                final category = newList[index];
                return Card(
                  child: ListTile(
                    title: Text(category.name),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        CategoryBD.instance.deletCategory(category.id);
                      },
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 10,
                  child: Divider(),
                );
              },
              itemCount: newList.length);
        });
  }
}
