import 'package:fin_trackr/db/functions/category_functions.dart';
import 'package:fin_trackr/db/models/category/category_model_db.dart';

class ExpenseCategoryProvider {
  Future<void> editCategoryDetails(
      editCategoryModel, categoryController) async {
    final name = categoryController.text;
    // ignore: unnecessary_null_comparison
    if (name.isEmpty == null) {
      return;
    } else {
      CategoryDB().editCategory(
          editCategoryModel: editCategoryModel,
          name: categoryController.text,
          id: editCategoryModel.id);
      CategoryDB().getAllCategory();
    }
  }

  Future<void> addDefaultCategory(appDefaultExpenseCategory) async {
    // ignore: no_leading_underscores_for_local_identifiers
    List<String> _addExpenseDefaultCategory =
        appDefaultExpenseCategory.toList();
    // ignore: no_leading_underscores_for_local_identifiers
    String _expenseCategoryName;
    for (var element in _addExpenseDefaultCategory) {
      _expenseCategoryName = element;
      // ignore: no_leading_underscores_for_local_identifiers
      final _expenseCategory = CategoryModel(
        id: "${_expenseCategoryName.toLowerCase()}+${CategoryType.expense}",
        isDeleted: false,
        name: _expenseCategoryName,
        categoryType: CategoryType.expense,
      );
      CategoryDB().addCategory(_expenseCategory);
      CategoryDB.instance.getAllCategory();
    }
  }

  Future<void> onAddExpenseCategorySavedButton(categoryController) async {
    // ignore: no_leading_underscores_for_local_identifiers
    final _expenseCategory = CategoryModel(
        name: categoryController.text.trim(),
        categoryType: CategoryType.expense,
        id: "${categoryController.text.trim().toLowerCase()}+${CategoryType.expense}",
        isDeleted: false);
    CategoryDB().addCategory(_expenseCategory);
    categoryController.clear();
  }
}
