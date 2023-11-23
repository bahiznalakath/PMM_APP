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
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),),
          elevation: 2,
          title: const Text('Add Category'),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _nameEditingcontroller,
                decoration:  InputDecoration(
                    hintText: 'Category Name', border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
              ),
            ),
            const SizedBox(height: 5,),
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
            const SizedBox(height: 5,),
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
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: const Text('ADD')),
            ),
            const SizedBox(height: 5,),
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
