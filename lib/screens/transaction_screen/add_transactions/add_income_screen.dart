// ignore_for_file: avoid_print, prefer_final_fields, unrelated_type_equality_checks

import 'dart:io';

import 'package:clipboard/clipboard.dart';
import 'package:fin_trackr/constants/constant.dart';
import 'package:fin_trackr/db/functions/account_group_function.dart';
import 'package:fin_trackr/db/functions/category_functions.dart';
import 'package:fin_trackr/db/functions/currency_function.dart';
import 'package:fin_trackr/db/functions/transaction_function.dart';
import 'package:fin_trackr/models/account_group/account_group_model_db.dart';
import 'package:fin_trackr/models/category/category_model_db.dart';
import 'package:fin_trackr/models/transactions/transaction_model_db.dart';
import 'package:fin_trackr/screens/accounts_screen/balance_calculation.dart';
import 'package:fin_trackr/screens/transaction_screen/widget/camera_previre.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';

XFile? images;

class AddIncomeScreen extends StatefulWidget {
  const AddIncomeScreen({super.key, this.modelFromTransation});

  @override
  State<AddIncomeScreen> createState() => _AddIncomeScreenState();
  final TransactionModel? modelFromTransation;
}

class _AddIncomeScreenState extends State<AddIncomeScreen> {
  DateTime selectedDate = DateTime.now();
  TextEditingController _amountController = TextEditingController();
  String? _categoryID;
  CategoryType selectedCategoryType = CategoryType.income;
  String? accountType;
  CategoryModel? selectedcategoryModel;
  TextEditingController _noteController = TextEditingController();

  // ignore: non_constant_identifier_names
  final _FormKey = GlobalKey<FormState>();

  File? image;

  @override
  void initState() {
    if (widget.modelFromTransation != null) {
      String categoryFromTransaction =
          widget.modelFromTransation!.category.id.toString();
      String accountTypeFromTransaction = '';
      if (widget.modelFromTransation!.account == AccountType.account) {
        accountTypeFromTransaction = 'account';
      } else if (widget.modelFromTransation!.account == AccountType.cash) {
        accountTypeFromTransaction = 'cash';
      }
      selectedDate = DateTime.parse(widget.modelFromTransation!.date);
      _amountController.text = widget.modelFromTransation!.amount.toString();
      accountType = accountTypeFromTransaction;
      _categoryID = categoryFromTransaction;
      _noteController.text = widget.modelFromTransation!.note;
      selectedcategoryModel = widget.modelFromTransation!.category;
      if (widget.modelFromTransation!.image != null) {
        image = File(widget.modelFromTransation!.image!);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refresh();
    CategoryDB.instance.getAllCategory();
    getAllAccountGroup();
    accountGroupBalanceAmount();
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
                                    builder: (context, child) {
                                      return Theme(
                                        data: ThemeData.dark().copyWith(
                                            colorScheme: const ColorScheme.dark(
                                                onPrimary:
                                                    AppColor.ftAppBarColor,
                                                onSurface: AppColor
                                                    .ftTextSecondayColor,
                                                primary: AppColor
                                                    .ftTextTertiaryColor),
                                            dialogBackgroundColor:
                                                AppColor.ftAppBarColor),
                                        child: child!,
                                      );
                                    },
                                    initialDate: selectedDate,
                                    firstDate: DateTime.now()
                                        .subtract(const Duration(days: 90)),
                                    lastDate: DateTime.now(),
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
                            builder: (context, child) {
                              return Theme(
                                data: ThemeData.dark().copyWith(
                                    colorScheme: const ColorScheme.dark(
                                        onPrimary: AppColor.ftAppBarColor,
                                        onSurface: AppColor.ftTextSecondayColor,
                                        primary: AppColor.ftTextTertiaryColor),
                                    dialogBackgroundColor:
                                        AppColor.ftAppBarColor),
                                child: child!,
                              );
                            },
                            initialDate: selectedDate,
                            firstDate: DateTime(2000),
                            lastDate: DateTime.now(),
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
                            suffixIcon: IconButton(
                                onPressed: () {
                                  FlutterClipboard.paste().then((value) {
                                    setState(() {
                                      _amountController.text = value;
                                    });
                                  });
                                },
                                icon: const Icon(
                                  Ionicons.clipboard_outline,
                                  size: 20,
                                  color: AppColor.ftTabBarSelectorColor,
                                ))),
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
                            .where((e) => e.categoryType == CategoryType.income)
                            .map((e) => DropdownMenuItem(
                                  value: e.id,
                                  child: Text(
                                    e.name,
                                    style: const TextStyle(
                                      color: AppColor.ftTextSecondayColor,
                                    ),
                                  ),
                                  onTap: () {
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
                        textCapitalization: TextCapitalization.sentences,
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
                        child: GestureDetector(
                          onTap: () {
                            if (image == null) return;
                            if (image != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ImagePreview(
                                    imageFile: File(image!.path),
                                  ),
                                ),
                              );
                            }
                          },
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
                                    height: MediaQuery.of(context).size.height *
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
                                        color: AppColor.ftTabBarSelectorColor),
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
                            await addIncomeTransaction();
                          }
                        },
                        child: Text(
                          widget.modelFromTransation == null
                              ? ' Save '
                              : 'Update',
                          style: const TextStyle(
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
                          if (widget.modelFromTransation != null) {
                            deleteTransaction();
                          }
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

  Future addIncomeTransaction() async {
    final note = _noteController.text;
    final amount = _amountController.text;
    final parsedAmount = double.tryParse(amount);

    if (widget.modelFromTransation == null) {
      final model = TransactionModel(
        id: DateTime.now().day + DateTime.now().hour + DateTime.now().second,
        date: DateFormat('yyyy-MM-dd').format(selectedDate),
        amount: parsedAmount ?? 0.0,
        account: getAccountTypeFromString(accountType) ?? AccountType.cash,
        categoryType: selectedCategoryType,
        category: selectedcategoryModel!,
        note: note.trim(),
        image: image?.path,
      );
      await TransactionDB.instance.addTransaction(model);
    } else {
      print('in side else case');
      final model = TransactionModel(
        id: widget.modelFromTransation!.id,
        date: DateFormat('yyyy-MM-dd').format(selectedDate),
        amount: parsedAmount ?? 0.0,
        account: getAccountTypeFromString(accountType) ?? AccountType.cash,
        categoryType: selectedCategoryType,
        category: selectedcategoryModel!,
        note: note.trim(),
        image: image?.path,
      );
      await TransactionDB.instance.editTransactionDb(model.id!, model);
    }
    textFeildClear();
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

  deleteTransaction() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: AppColor.ftWaveColor,
          content: const Text(
              'All the related datas will be cleared from the database!'),
          title: const Text(
            'Do you want to delete?',
            style: TextStyle(
              color: AppColor.ftTextQuaternaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                TransactionDB.instance
                    .deleteTransaction(widget.modelFromTransation!);
                textFeildClear();
                Navigator.of(context).pop();
              },
              child: const Text(
                'Yes',
                style: TextStyle(
                  color: AppColor.ftTextQuaternaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'No',
                style: TextStyle(
                  color: AppColor.ftTextQuaternaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
