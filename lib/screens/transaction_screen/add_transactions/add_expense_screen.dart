import 'dart:io';
import 'package:fin_trackr/constant/constant.dart';
import 'package:fin_trackr/db/functions/account_group_function.dart';
import 'package:fin_trackr/db/functions/category_functions.dart';
import 'package:fin_trackr/db/functions/currency_function.dart';
import 'package:fin_trackr/db/functions/transaction_function.dart';
import 'package:fin_trackr/db/models/account_group/account_group_model_db.dart';
import 'package:fin_trackr/db/models/category/category_model_db.dart';
import 'package:fin_trackr/db/models/transactions/transaction_model_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';

XFile? images;

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  DateTime selectedDate = DateTime.now();

  final _amountController = TextEditingController();
  String? _categoryID;
  CategoryType selectedCategoryType = CategoryType.expense;
  String? accountType;
  CategoryModel? selectedcategoryModel;
  final _noteController = TextEditingController();

  // ignore: non_constant_identifier_names
  final _FormKey = GlobalKey<FormState>();

  File? image;

  @override
  Widget build(BuildContext context) {
    getAllAccountGroup();
    CategoryDB().getAllCategory();
    final double screenWidth = MediaQuery.of(context).size.width;

    double fontSize =
        9; // default font size for screen width between 280 and 350

    if (screenWidth > 350) {
      fontSize = 16; // increase font size for screen width above 350
    }
    return Scaffold(
      backgroundColor: AppColor.ftScafoldColor,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _FormKey,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const SizedBox(
                      width: 80,
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Date ',
                          style: TextStyle(
                            color: AppColor.ftTextTertiaryColor,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        // keyboardType: ,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Date';
                          } else {
                            return null;
                          }
                        },

                        cursorColor: AppColor.ftTextSecondayColor,
                        style: const TextStyle(
                          color: AppColor.ftTextSecondayColor,
                        ),
                        decoration: InputDecoration(
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColor.ftTabBarSelectorColor,
                            ),
                          ),
                          suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () async {
                                  final DateTime? date = await showDatePicker(
                                    context: context,
                                    initialDate: selectedDate,
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100),
                                  );

                                  if (date != null && date != selectedDate) {
                                    setState(
                                      () {
                                        selectedDate = date;
                                      },
                                    );
                                  }
                                },
                                icon: const Icon(
                                  Ionicons.calendar_outline,
                                ),
                              ),
                            ],
                          ),
                          suffixIconColor: AppColor.ftTabBarSelectorColor,
                        ),
                        controller: TextEditingController(
                          text:
                              '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}', // display selected date in text field
                        ),
                        readOnly: true,
                        onTap: () async {
                          final DateTime? date = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );

                          if (date != null && date != selectedDate) {
                            setState(
                              () {
                                selectedDate = date;
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    const SizedBox(
                      width: 80,
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Amount ',
                          style: TextStyle(
                            color: AppColor.ftTextTertiaryColor,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required Feild';
                          } else {
                            return null;
                          }
                        },
                        controller: _amountController,
                        cursorColor: AppColor.ftTextSecondayColor,
                        style: const TextStyle(
                          color: AppColor.ftTextSecondayColor,
                        ),
                        decoration: InputDecoration(
                          prefixText: "${currencySymboleUpdate.value} ",
                          prefixStyle: const TextStyle(
                              color: AppColor.ftTextSecondayColor),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColor.ftTabBarSelectorColor,
                            ),
                          ),
                        ),
                        readOnly: false,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 80,
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Account ',
                          style: TextStyle(
                            color: AppColor.ftTextTertiaryColor,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        child: Theme(
                      data: Theme.of(context).copyWith(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                      ),
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColor.ftTabBarSelectorColor,
                            ),
                          ),
                        ),
                        hint: const Text(
                          'Select account type',
                          style: TextStyle(color: Colors.transparent),
                        ),
                        value: accountType,
                        items: accountGroupNotifier.value
                            .map((e) => DropdownMenuItem(
                                  value: e.id,
                                  child: Text(
                                    e.name,
                                    style: const TextStyle(
                                      color: AppColor.ftTextSecondayColor,
                                    ),
                                  ),
                                  onTap: () {},
                                ))
                            .toList(),
                        onChanged: (selectedValue) {
                          setState(() {
                            accountType = selectedValue;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required Feild';
                          } else {
                            return null;
                          }
                        },
                        isExpanded: true,
                        icon: Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: const Icon(Icons.arrow_drop_down,
                                color: AppColor.ftTabBarSelectorColor),
                          ),
                        ),
                        dropdownColor: AppColor.ftAppBarColor,
                      ),
                    )),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 80,
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Category ',
                          style: TextStyle(
                            color: AppColor.ftTextTertiaryColor,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        child: Theme(
                      data: Theme.of(context).copyWith(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                      ),
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColor.ftTabBarSelectorColor,
                            ),
                          ),
                        ),
                        hint: const Text(
                          'Select category',
                          style: TextStyle(color: Colors.transparent),
                        ),
                        value: _categoryID,
                        items: CategoryDB()
                            .incomeCategoryNotifier
                            .value
                            .where(
                                (e) => e.categoryType == CategoryType.expense)
                            .map((e) => DropdownMenuItem(
                                  value: e.id,
                                  child: Text(
                                    e.name,
                                    style: const TextStyle(
                                      color: AppColor.ftTextSecondayColor,
                                    ),
                                  ),
                                  onTap: () {
                                    // ignore: avoid_print
                                    print(e.categoryType);
                                    selectedcategoryModel = e;
                                  },
                                ))
                            .toList(),
                        onChanged: (selectedValue) {
                          setState(() {
                            _categoryID = selectedValue;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required Feild';
                          } else {
                            return null;
                          }
                        },
                        isExpanded: true,
                        icon: Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: const Icon(Icons.arrow_drop_down,
                                color: AppColor.ftTabBarSelectorColor),
                          ),
                        ),
                        dropdownColor: AppColor.ftAppBarColor,
                      ),
                    )),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 80,
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Note ',
                          style: TextStyle(
                            color: AppColor.ftTextTertiaryColor,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required Feild';
                          } else {
                            return null;
                          }
                        },
                        controller: _noteController,
                        cursorColor: AppColor.ftTextSecondayColor,
                        style: const TextStyle(
                          color: AppColor.ftTextSecondayColor,
                        ),
                        decoration: InputDecoration(
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColor.ftTabBarSelectorColor,
                            ),
                          ),
                          suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  showPopupMenu1();
                                },
                                icon: const Icon(
                                  Ionicons.camera_outline,
                                ),
                              ),
                            ],
                          ),
                          suffixIconColor: AppColor.ftTabBarSelectorColor,
                        ),
                        readOnly: false,
                      ),
                    ),
                  ],
                ),
                image != null
                    ? Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Expanded(
                          child: GestureDetector(
                            onTap: () {},
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: AppColor.ftTextTertiaryColor,
                                      width: 1,
                                    ),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1,
                                      ),
                                    ),
                                    margin: const EdgeInsets.all(3),
                                    child: Image.file(
                                      image!,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                      width:
                                          MediaQuery.of(context).size.width * 2,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 5,
                                  right: 5,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Color(0x81000000),
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: IconButton(
                                      icon: const Icon(Icons.delete,
                                          color:
                                              AppColor.ftTabBarSelectorColor),
                                      onPressed: () {
                                        setState(() {
                                          image = null;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container(),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.ftTextPrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          textStyle: TextStyle(fontSize: fontSize),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 25),
                        ),
                        onPressed: () async {
                          if (_FormKey.currentState!.validate()) {
                            await addExpenseTransaction();
                          }
                        },
                        child: const Text(
                          ' Save ',
                          style: TextStyle(
                            color: AppColor.ftTextSecondayColor,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.ftTransactionColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          textStyle: TextStyle(fontSize: fontSize),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 25),
                        ),
                        onPressed: () {
                          textFeildClear();
                        },
                        child: const Text(
                          'Clear ',
                          style: TextStyle(
                            color: AppColor.ftTextSecondayColor,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.ftTransactionColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          textStyle: TextStyle(fontSize: fontSize),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 25),
                        ),
                        onPressed: () {
                          if (_FormKey.currentState!.validate()) {}
                        },
                        child: const Text(
                          'Delete',
                          style: TextStyle(
                            color: AppColor.ftTextSecondayColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showPopupMenu1() async {
    await showMenu(
      color: AppColor.ftAppBarColor,
      context: context,
      position: const RelativeRect.fromLTRB(100, 80, 10, 10),
      items: [
        PopupMenuItem(
            onTap: () => getImage(ImageSource.camera),
            child: const Text(
              'Camera',
              style:
                  TextStyle(fontSize: 14, color: AppColor.ftTextSecondayColor),
            )),
        PopupMenuItem(
            onTap: () => getImage(ImageSource.gallery),
            child: const Text(
              'Gallery',
              style:
                  TextStyle(fontSize: 14, color: AppColor.ftTextSecondayColor),
            )),
      ],
      elevation: 1,
    );
  }

  Future getImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);

      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print('Faild to pick image: $e');
    }
  }

  void textFeildClear() {
    setState(() {
      selectedDate = DateTime.now();
      _amountController.clear();
      _categoryID = null;
      _noteController.clear();
      image = null;
    });
  }

  Future addExpenseTransaction() async {
    final note = _noteController.text;
    final amount = _amountController.text;
    final parsedAmount = double.tryParse(amount);

    final model = TransactionModel(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      date: DateFormat('yyyy-MM-dd').format(selectedDate),
      amount: parsedAmount ?? 0.0,
      account: getAccountTypeFromString(accountType) ?? AccountType.cash,
      categoryType: selectedCategoryType,
      category: selectedcategoryModel!,
      note: note.trim(),
      image: image?.path,
    );

    await TransactionDB.instance.addTransaction(model);
    textFeildClear();

    // ignore: avoid_print
    print("$model is printed for verification");
  }

  AccountType? getAccountTypeFromString(String? str) {
    switch (str?.toLowerCase().trim()) {
      case 'cash':
        return AccountType.cash;
      case 'account':
        return AccountType.account;
      default:
        return AccountType.cash;
    }
  }
}
