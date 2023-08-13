// ignore_for_file: avoid_print

import 'dart:io';

import 'package:fin_trackr/constant/constant.dart';
import 'package:fin_trackr/db/functions/account_group_function.dart';
import 'package:fin_trackr/db/functions/category_functions.dart';
import 'package:fin_trackr/db/models/category/category_model_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';

XFile? images;

class AddIncomeScreen extends StatefulWidget {
  const AddIncomeScreen({super.key});

  @override
  State<AddIncomeScreen> createState() => _AddIncomeScreenState();
}

class _AddIncomeScreenState extends State<AddIncomeScreen> {
  DateTime selectedDate = DateTime.now();

  final _amountController = TextEditingController();
  String? _categoryID;
  CategoryType selectedCategoryType = CategoryType.income;
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
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
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
                        child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: AppColor.ftTabBarSelectorColor,
                            width: 1,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                          ),
                          child: DropdownButton<String>(
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
                            underline: Container(),
                            isExpanded: true,
                            icon: const Icon(Icons.arrow_drop_down,
                                color: AppColor.ftTabBarSelectorColor),
                            dropdownColor: AppColor.ftAppBarColor,
                          ),
                        ),
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
                        child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: AppColor.ftTabBarSelectorColor,
                            width: 1,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                          ),
                          child: DropdownButton<String>(
                            hint: const Text(
                              'Select category',
                              style: TextStyle(color: Colors.transparent),
                            ),
                            value: _categoryID,
                            items: CategoryDB()
                                .incomeCategoryNotifier
                                .value
                                .where((e) =>
                                    e.categoryType == CategoryType.income)
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
                            underline: Container(),
                            isExpanded: true,
                            icon: const Icon(Icons.arrow_drop_down,
                                color: AppColor.ftTabBarSelectorColor),
                            dropdownColor: AppColor.ftAppBarColor,
                          ),
                        ),
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
                        onPressed: () {
                          if (_FormKey.currentState!.validate()) {}
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
                          // if (_formKey.currentState!.validate()) {
                          //   addMoneyProLF.addAmountButtonClicked(context: context);
                          //   addMoneyProLF.clearField();
                          // }
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
    _amountController.clear();
    // _accountController.clear();
    // _categoryController.clear();
    _noteController.clear();
  }
}
