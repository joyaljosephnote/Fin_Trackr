import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:fin_trackr/db/models/category/category_model_db.dart';
import 'package:flutter/material.dart';

// ignore: constant_identifier_names
const CATEGORY_DB_NAME = 'category-database';

ValueNotifier<CategoryType> selectedCategoryNotifier =
    ValueNotifier(CategoryType.income);

ValueNotifier<List<CategoryModel>> incomeCategoryNotifier = ValueNotifier([]);
ValueNotifier<List<CategoryModel>> expenseCategoryNotifier = ValueNotifier([]);

Future<void> addCategory(CategoryModel value) async {
  final categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);

  await categoryDB.put(value.id, value);
  getAllCategory();
}

Future<void> getAllCategory() async {
  final categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
  incomeCategoryNotifier.value.clear();
  expenseCategoryNotifier.value.clear();

  incomeCategoryNotifier.value.addAll(categoryDB.values);
  expenseCategoryNotifier.value.addAll(categoryDB.values);
  // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
  incomeCategoryNotifier.notifyListeners();
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  expenseCategoryNotifier.notifyListeners();
}

Future<void> deleteCategory(String id) async {
  final categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
  await categoryDB.delete(id);
  getAllCategory();
}

late CategoryModel editCategoryModel;
editCategory({
  required CategoryModel editCategoryModel,
  required String id,
  required String name,
}) async {
  // ignore: unused_local_variable
  final categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
  editCategoryModel.id = id;
  editCategoryModel.name = name;
  editCategoryModel.save();
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  incomeCategoryNotifier.notifyListeners();
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  expenseCategoryNotifier.notifyListeners();
}
