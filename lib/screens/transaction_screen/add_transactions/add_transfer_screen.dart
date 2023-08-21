import 'package:fin_trackr/constant/constant.dart';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class AddTransferScreen extends StatefulWidget {
  const AddTransferScreen({super.key});

  @override
  State<AddTransferScreen> createState() => _AddTransferScreenState();
}

class _AddTransferScreenState extends State<AddTransferScreen> {
  DateTime selectedDate = DateTime.now();

  final _amountController = TextEditingController();
  final _accountFromController = TextEditingController();
  final _accountToController = TextEditingController();
  final _noteController = TextEditingController();

  // ignore: non_constant_identifier_names
  final _FormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                                  firstDate: DateTime.now()
                                      .subtract(const Duration(days: 30)),
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
                        'From ',
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
                      controller: _accountFromController,
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
                        'To ',
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
                      controller: _accountToController,
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
                        if (_FormKey.currentState!.validate()) {
                          onAddTransferSavedButton(context);
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
    );
  }

  Future<void> onAddTransferSavedButton(context) async {
    _FormKey.currentState!.reset;
    textFeildClear();
  }

  void textFeildClear() {
    _amountController.clear();
    _accountFromController.clear();
    _accountToController.clear();
    _noteController.clear();
  }
}
