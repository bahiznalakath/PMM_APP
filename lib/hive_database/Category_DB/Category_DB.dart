import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import '../../model/Category_model/category_model.dart';


const CATEGORY_DB_NAME = 'category-database';

abstract class CategorydbFunctions {
  Future<List<CategoryModel>> getCategories();

  Future<void> insertCategory(CategoryModel value);
  Future<void>deletCategory(String CategoryID);
}

class CategoryBD implements CategorydbFunctions {
  CategoryBD._internal();

  static CategoryBD instance = CategoryBD._internal();

  factory CategoryBD() {
    return instance;
  }

  ValueNotifier<List<CategoryModel>> incomeCategoryListListenabler =
      ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenseCategoryListListenabler =
      ValueNotifier([]);

  @override
  Future<void> insertCategory(CategoryModel value) async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await _categoryDB.add(value);
    refreshUI();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return _categoryDB.values.toList();
  }

  Future<void> refreshUI() async {
    final _allCategoris = await getCategories();
    incomeCategoryListListenabler.value.clear();
    expenseCategoryListListenabler.value.clear();
    await Future.forEach(_allCategoris, (CategoryModel category) {
      if (category.type == CategoryType.income) {
        incomeCategoryListListenabler.value.add(category);
      } else {
        expenseCategoryListListenabler.value.add(category);
      }
    });
    incomeCategoryListListenabler.notifyListeners();
    expenseCategoryListListenabler.notifyListeners();
  }

  @override
  Future<void> deletCategory(String CategoryID) async{
    final categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    categoryDB.delete(CategoryID);
    refreshUI();

  }
}
