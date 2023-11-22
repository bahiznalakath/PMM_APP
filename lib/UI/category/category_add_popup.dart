import 'package:flutter/material.dart';
import '../../hive_database/Category_DB/Category_DB.dart';
import '../../model/Category_model/category_model.dart';


ValueNotifier<CategoryType> selectedCategoryNotifier =
    ValueNotifier(CategoryType.income);

Future<void> showCategoryAddpop(BuildContext context) async {
  final _nameEditingcontroller = TextEditingController();
  showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Add category'),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _nameEditingcontroller,
                decoration: const InputDecoration(
                    hintText: 'category name', border: OutlineInputBorder()),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  RadioButton(
                    title: 'Income',
                    type: CategoryType.income,
                  ),
                  RadioButton(
                    title: 'Expense',
                    type: CategoryType.expense,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    final _name = _nameEditingcontroller.text;
                    final _type = selectedCategoryNotifier.value;
                    if (_name.isEmpty) {
                      return;
                    }
                    final _category = CategoryModel(
                        id: DateTime.now().microsecondsSinceEpoch.toString(),
                        name: _name,
                        type: _type);
                    CategoryBD.instance.insertCategory(_category);
                    Navigator.of(context).pop();
                  },
                  child: const Text('ADD')),
            )
          ],
        );
      });
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;

  // final CategoryType selectedCategoryType;

  const RadioButton({
    super.key,
    required this.title,
    required this.type,
  });
  // CategoryType?_type;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: selectedCategoryNotifier,
          builder: (BuildContext context, CategoryType newCategory, Widget? _) {
            return Radio<CategoryType>(
                value: type,
                groupValue: selectedCategoryNotifier.value,
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  selectedCategoryNotifier.value = value;
                  selectedCategoryNotifier.notifyListeners();
                  // setState(() {
                  //   _type = value;
                  // });
                });
          },
        ),
        Text(title)
      ],
    );
  }
}
