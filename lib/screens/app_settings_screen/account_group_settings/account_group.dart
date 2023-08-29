// ignore_for_file: unrelated_type_equality_checks

import 'package:clipboard/clipboard.dart';
import 'package:fin_trackr/db/functions/account_group_function.dart';
import 'package:fin_trackr/db/functions/category_functions.dart';
import 'package:fin_trackr/db/functions/currency_function.dart';
import 'package:fin_trackr/models/account_group/account_group_model_db.dart';
import 'package:fin_trackr/models/category/category_model_db.dart';
import 'package:fin_trackr/screens/accounts_screen/balance_calculation.dart';
import 'package:fin_trackr/screens/calculator/calculator_screen.dart';
import 'package:flutter/material.dart';
import 'package:fin_trackr/constants/constant.dart';
import 'package:ionicons/ionicons.dart';

// ignore: must_be_immutable
class AccountGroup extends StatefulWidget {
  const AccountGroup({super.key});

  @override
  State<AccountGroup> createState() => _AccountGrouptState();
}

class _AccountGrouptState extends State<AccountGroup> {
  // ignore: prefer_final_field, non_constant_identifier_names
  TextEditingController accountGroupNameController = TextEditingController();
  TextEditingController accountGroupAmountController = TextEditingController();

  // ignore: non_constant_identifier_names
  final _formKey = GlobalKey<FormState>();
  //it is used for updation
  late AccountGroupModel accountGroupModel;

  // this flag for defauilt income category button check;
  bool? defaultFlag = true;

  //textFeildEdit button is used for change theSave button updation
  bool textFeildEdit = false;

  List<CategoryModel> selectedIncomeCategory = [];

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
      appBar: AppBar(
        backgroundColor: AppColor.ftScafoldColor,
        title: const Text(
          'Account Group',
          style: TextStyle(fontSize: 18),
        ),
        actions: [
          IconButton(
            alignment: Alignment.centerLeft,
            icon: const Icon(Ionicons.calculator,
                color: AppColor.ftTextSecondayColor, size: 18),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CalculatorScreen(),
                ),
              );
            },
          ),
        ],
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
                      Row(
                        children: <Widget>[
                          const SizedBox(
                            width: 80,
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                'Acc. group',
                                style: TextStyle(
                                    color: AppColor.ftTextTertiaryColor),
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                                textCapitalization:
                                    TextCapitalization.sentences,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Required Feild';
                                  } else {
                                    return null;
                                  }
                                },
                                controller: accountGroupNameController,
                                cursorColor: AppColor.ftTextSecondayColor,
                                style: const TextStyle(
                                    color: AppColor.ftTextSecondayColor),
                                decoration: const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColor.ftTabBarSelectorColor),
                                  ),
                                ),
                                readOnly: true),
                          )
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
                              controller: accountGroupAmountController,
                              cursorColor: AppColor.ftTextSecondayColor,
                              style: const TextStyle(
                                color: AppColor.ftTextSecondayColor,
                              ),
                              decoration: InputDecoration(
                                  prefixText: '${currencySymboleUpdate.value} ',
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
                                            accountGroupAmountController.text =
                                                value;
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
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.ftTextPrimaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              textStyle: const TextStyle(fontSize: 16),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 25),
                            ),
                            onPressed: () {
                              final accountGroupModel = AccountGroupModel(
                                id: accountGroupNameController.text
                                    .toLowerCase()
                                    .trim(),
                                name: accountGroupNameController.text.trim(),
                                accountType:
                                    accountGroupNameController.text == 'Account'
                                        ? AccountType.account
                                        : AccountType.cash,
                                amount: double.parse(
                                    accountGroupAmountController.text),
                              );
                              addAccountGroup(accountGroupModel);
                              accountGroupBalanceAmount();
                              accountGroupAmountController.clear();
                              accountGroupNameController.clear();
                            },
                            child: Text(
                              ' Save ',
                              style: TextStyle(
                                  color: AppColor.ftTextSecondayColor,
                                  fontSize: fontSize),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.ftTransactionColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              textStyle: const TextStyle(fontSize: 16),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 25),
                            ),
                            onPressed: () {
                              accountGroupAmountController.clear();
                              accountGroupNameController.clear();
                            },
                            child: Text(
                              'Clear',
                              style: TextStyle(
                                  color: AppColor.ftTextSecondayColor,
                                  fontSize: fontSize),
                            ),
                          ),
                        ],
                      ),
                      RichText(
                        text: const TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: '\nImportant : ',
                              style: TextStyle(
                                  color: AppColor.ftTextTertiaryColor,
                                  height: 1.3,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text:
                                  'Once the account group balance is updated, the existing account group balance will change according to the newly entered amount.\n',
                              style: TextStyle(
                                  color: AppColor.ftTextTertiaryColor,
                                  height: 1.3,
                                  fontSize: 12),
                            )
                          ],
                        ),
                      ),
                      const Divider(
                          thickness: 1,
                          color: AppColor.ftSecondaryDividerColor),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: accountGroupNotifier,
                builder: (BuildContext ctx,
                    List<AccountGroupModel> accountGroupNameList,
                    Widget? child) {
                  return accountGroupNameList.isNotEmpty
                      ? ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (ctx, index) {
                            final data = accountGroupNameList[index];
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      height: 40,
                                      child: Text(
                                        data.name,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            color:
                                                AppColor.ftTextSecondayColor),
                                      ),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      onPressed: () {
                                        setState(
                                          () {
                                            accountGroupNameController =
                                                TextEditingController(
                                                    text: data.name);
                                          },
                                        );
                                        accountGroupModel = data;
                                      },
                                      icon: const Icon(Icons.edit_outlined,
                                          color: AppColor.ftTextTertiaryColor),
                                    ),
                                  ],
                                ),
                                const Divider(
                                    thickness: 1,
                                    color: AppColor.ftSecondaryDividerColor),
                              ],
                            );
                          },
                          separatorBuilder: (ctx, index) {
                            return Container();
                          },
                          itemCount: accountGroupNameList.length)
                      : Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
