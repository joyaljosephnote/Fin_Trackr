import 'package:fin_trackr/db/functions/account_group_function.dart';
import 'package:fin_trackr/db/functions/category_functions.dart';
import 'package:fin_trackr/db/functions/currency_function.dart';
import 'package:fin_trackr/db/models/account_group/account_group_model_db.dart';
import 'package:fin_trackr/db/models/category/category_model_db.dart';
import 'package:flutter/material.dart';
import 'package:fin_trackr/constant/constant.dart';

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
        title: const Text('Account Group', style: TextStyle(fontSize: 18)),
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
                              ),
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
                            onPressed: () {},
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
                            onPressed: () {},
                            child: Text(
                              'Clear',
                              style: TextStyle(
                                  color: AppColor.ftTextSecondayColor,
                                  fontSize: fontSize),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      const Divider(
                          thickness: 3, color: AppColor.ftSecondaryDividerColor)
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
                            return Row(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  height: 40,
                                  child: Text(
                                    data.name,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        color: AppColor.ftTextSecondayColor),
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
                            );
                          },
                          separatorBuilder: (ctx, index) {
                            return const Divider(
                                thickness: 1,
                                color: AppColor.ftSecondaryDividerColor);
                          },
                          itemCount: accountGroupNameList.length)
                      : const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Column(
                                  children: [
                                    Text(
                                      "Please add a new category or click the 'Default Categories' button to add default categories.",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                    SizedBox(height: 25),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
