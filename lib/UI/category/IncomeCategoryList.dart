import 'package:flutter/material.dart';
import '../../DB/ category/Category_DB.dart';
import '../../model/category/category_model.dart';

class IncomeCategoryList extends StatelessWidget {
  const IncomeCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CategoryBD().incomeCategoryListListenabler,
        builder: (BuildContext, List<CategoryModel> newList, Widget? _) {
          return ListView.separated(
              itemBuilder: (context, index) {
                final _catogroy = newList[index];
                return Card(
                  child: ListTile(
                    title: Text(_catogroy.name),
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
                  child: Divider(),
                );
              },
              itemCount: newList.length);
        });
  }
}