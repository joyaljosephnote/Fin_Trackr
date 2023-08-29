import 'package:fin_trackr/constants/default/app_default.dart';
import 'package:fin_trackr/models/category/category_model_db.dart';
import 'package:fin_trackr/screens/app_settings_screen/expense_category_settings/expense_category_provider.dart';
import 'package:flutter/material.dart';
import 'package:fin_trackr/constants/constant.dart';
import 'package:fin_trackr/db/functions/category_functions.dart';

class ExpenseCategoryList extends StatefulWidget {
  const ExpenseCategoryList({super.key});

  @override
  State<ExpenseCategoryList> createState() => _ExpenseCategoryListState();
}

class _ExpenseCategoryListState extends State<ExpenseCategoryList> {
  TextEditingController expenseCategoryController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late CategoryModel categoryExpenseModel;
  bool? defaultFlag = true;
  bool textFeildEdit = false;

  List<CategoryModel> selectedExpenseCategory = [];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = 9;
    if (screenWidth > 350) {
      fontSize = 16;
    }
    CategoryDB().getAllCategory();
    return Scaffold(
      backgroundColor: AppColor.ftScafoldColor,
      appBar: AppBar(
        backgroundColor: AppColor.ftScafoldColor,
        title: const Text('Expense Category', style: TextStyle(fontSize: 18)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(children: <Widget>[
                        const SizedBox(
                            width: 80,
                            child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text('Name ',
                                    style: TextStyle(
                                        color: AppColor.ftTextTertiaryColor)))),
                        Expanded(
                            child: TextFormField(
                                textCapitalization:
                                    TextCapitalization.sentences,
                                keyboardType: TextInputType.text,
                                maxLength: 14,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Required Feild';
                                  } else {
                                    return null;
                                  }
                                },
                                controller: expenseCategoryController,
                                cursorColor: AppColor.ftTextSecondayColor,
                                style: const TextStyle(
                                    color: AppColor.ftTextSecondayColor),
                                decoration: const InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColor
                                                .ftTabBarSelectorColor))),
                                readOnly: false))
                      ]),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.ftTextPrimaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  textStyle: const TextStyle(fontSize: 16),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 25)),
                              onPressed: () {
                                if (textFeildEdit == false) {
                                  if (_formKey.currentState!.validate()) {
                                    ExpenseCategoryProvider()
                                        .onAddExpenseCategorySavedButton(
                                            expenseCategoryController);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            duration: Duration(seconds: 2),
                                            elevation: 2,
                                            behavior: SnackBarBehavior.floating,
                                            padding: EdgeInsets.all(15),
                                            backgroundColor:
                                                AppColor.ftAppBarColor,
                                            content: Text('Saved',
                                                style: TextStyle(
                                                    color: Colors.white))));
                                  }
                                } else if (textFeildEdit == true) {
                                  categoryExpenseModel.name =
                                      expenseCategoryController.text;
                                  ExpenseCategoryProvider().editCategoryDetails(
                                      categoryExpenseModel,
                                      expenseCategoryController);
                                  textFeildEdit = false;
                                  expenseCategoryController.clear();
                                }
                              },
                              child: Text(' Save ',
                                  style: TextStyle(
                                      color: AppColor.ftTextSecondayColor,
                                      fontSize: fontSize))),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.ftTransactionColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  textStyle: const TextStyle(fontSize: 16),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 25)),
                              onPressed: () {
                                textFeildEdit = false;
                                expenseCategoryController.clear();
                              },
                              child: Text('Clear ',
                                  style: TextStyle(
                                      color: AppColor.ftTextSecondayColor,
                                      fontSize: fontSize))),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.ftTransactionColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  textStyle: const TextStyle(fontSize: 16),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 25)),
                              onPressed: () {
                                defaultFlag = true;
                                ExpenseCategoryProvider().addDefaultCategory(
                                    AppDefaultExpenseCategory()
                                        .appDefaultExpenseCategory);
                                CategoryDB().getAllCategory();
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        duration: Duration(seconds: 2),
                                        elevation: 2,
                                        behavior: SnackBarBehavior.floating,
                                        padding: EdgeInsets.all(15),
                                        backgroundColor: AppColor.ftAppBarColor,
                                        content: Text('Updated.',
                                            style: TextStyle(
                                                color: Colors.white))));
                              },
                              child: Text('Default',
                                  style: TextStyle(
                                      color: AppColor.ftTextSecondayColor,
                                      fontSize: fontSize)))
                        ],
                      ),
                      const SizedBox(height: 35),
                      const Divider(
                          thickness: 3, color: AppColor.ftSecondaryDividerColor)
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: CategoryDB().expenseCategoryNotifier,
                builder: (BuildContext ctx,
                    List<CategoryModel> expenseCategoryList, Widget? child) {
                  final filterdList = expenseCategoryList
                      .where(
                          (model) => model.categoryType == CategoryType.expense)
                      .toList();
                  return filterdList.isNotEmpty
                      ? ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (ctx, index) {
                            final data = filterdList[index];
                            return Row(
                              children: [
                                Container(
                                    alignment: Alignment.centerLeft,
                                    height: 40,
                                    child: Text(data.name,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            color:
                                                AppColor.ftTextSecondayColor))),
                                const Spacer(),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        textFeildEdit = true;
                                        expenseCategoryController =
                                            TextEditingController(
                                                text: data.name);
                                      });
                                      categoryExpenseModel = data;
                                    },
                                    icon: const Icon(Icons.edit_outlined,
                                        color: AppColor.ftTextTertiaryColor)),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        filterdList[index].isDeleted =
                                            !filterdList[index].isDeleted;
                                        if (filterdList[index].isDeleted ==
                                            true) {
                                          selectedExpenseCategory.add(
                                              CategoryModel(
                                                  id: data.id,
                                                  name: data.name,
                                                  categoryType:
                                                      data.categoryType,
                                                  isDeleted: true));
                                        } else if (filterdList[index]
                                                .isDeleted ==
                                            false) {
                                          selectedExpenseCategory.removeWhere(
                                              (element) =>
                                                  element.id ==
                                                  filterdList[index].id);
                                        }
                                      });
                                    },
                                    icon: data.isDeleted
                                        ? const Icon(Icons.check_circle_rounded,
                                            color:
                                                AppColor.ftTabBarSelectorColor)
                                        : const Icon(Icons.dangerous_outlined,
                                            color:
                                                AppColor.ftTextTertiaryColor))
                              ],
                            );
                          },
                          separatorBuilder: (ctx, index) {
                            return const Divider(
                                thickness: 1,
                                color: AppColor.ftSecondaryDividerColor);
                          },
                          itemCount: filterdList.length)
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Column(
                                  children: [
                                    const Text(
                                        "Please add a new category or click the 'Default Categories' button to add default categories.",
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.grey)),
                                    const SizedBox(height: 25),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColor
                                                .ftBottomNavigatorSelectorColor,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            textStyle:
                                                const TextStyle(fontSize: 16),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 25)),
                                        onPressed: () {
                                          defaultFlag = true;
                                          if (defaultFlag == true) {
                                            ExpenseCategoryProvider()
                                                .addDefaultCategory(
                                                    AppDefaultExpenseCategory()
                                                        .appDefaultExpenseCategory);
                                            defaultFlag = false;
                                          }
                                          CategoryDB().getAllCategory();
                                        },
                                        child: const Text('Default Categories',
                                            style: TextStyle(
                                                color: AppColor
                                                    .ftTextSecondayColor)))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                },
              ),
            ),
            selectedExpenseCategory.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.ftTextPrimaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            textStyle: const TextStyle(fontSize: 16),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 25)),
                        onPressed: () {
                          deleteDialog();
                        },
                        child: Text(
                            'Delete (${selectedExpenseCategory.length})',
                            style: const TextStyle(
                                color: AppColor.ftTextSecondayColor))))
                : Container()
          ],
        ),
      ),
    );
  }

  deleteDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: AppColor.ftWaveColor,
          title: const Text('Do you want to delete ?',
              style: TextStyle(
                  color: AppColor.ftTextQuaternaryColor,
                  fontWeight: FontWeight.bold)),
          content: const Text(
              'All the releted datas will be cleared from the database!'),
          actions: [
            TextButton(
                onPressed: () {
                  for (var category in selectedExpenseCategory) {
                    CategoryDB().deleteCategory(category.id!);
                    setState(() {
                      selectedExpenseCategory = [];
                    });
                  }
                  Navigator.of(context).pop();
                },
                child: const Text('Yes',
                    style: TextStyle(
                        color: AppColor.ftTextQuaternaryColor,
                        fontWeight: FontWeight.bold))),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('No',
                    style: TextStyle(
                        color: AppColor.ftTextQuaternaryColor,
                        fontWeight: FontWeight.bold)))
          ],
        );
      },
    );
  }
}
