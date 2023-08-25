import 'package:fin_trackr/db/functions/category_functions.dart';
import 'package:fin_trackr/models/category/category_model_db.dart';

class IncomeCategoryProvider {
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

  Future<void> addDefaultCategory(appDefaultIncomeCategory) async {
    // ignore: no_leading_underscores_for_local_identifiers
    List<String> _addIncomeDefaultCategory = appDefaultIncomeCategory.toList();
    // ignore: no_leading_underscores_for_local_identifiers
    String _incomeCategoryName;
    for (var element in _addIncomeDefaultCategory) {
      _incomeCategoryName = element;
      // ignore: no_leading_underscores_for_local_identifiers
      final _incomeCategory = CategoryModel(
        id: "${_incomeCategoryName.toLowerCase()}+${CategoryType.income}",
        isDeleted: false,
        name: _incomeCategoryName,
        categoryType: CategoryType.income,
      );
      CategoryDB().addCategory(_incomeCategory);
      CategoryDB.instance.getAllCategory();
    }
  }

  Future<void> onAddIncomeCategorySavedButton(categoryController) async {
    // ignore: no_leading_underscores_for_local_identifiers
    final _incomeCategery = CategoryModel(
        name: categoryController.text.trim(),
        categoryType: CategoryType.income,
        id: "${categoryController.text.trim().toLowerCase()}+${CategoryType.income}",
        isDeleted: false);
    CategoryDB().addCategory(_incomeCategery);
    CategoryDB().getAllCategory();
    categoryController.clear();
  }
}
