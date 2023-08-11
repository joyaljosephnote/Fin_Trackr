import 'package:fin_trackr/db/functions/currency_function.dart';
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
  String? AccountGroupNameController;
  // ignore: non_constant_identifier_names
  final AccountGroupAmountController = TextEditingController(text: '0.00');

  // ignore: non_constant_identifier_names
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    getCurrency();
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
                                'Name ',
                                style: TextStyle(
                                  color: AppColor.ftTextTertiaryColor,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              hint: const Text(
                                'Groups',
                                style: TextStyle(
                                    color: AppColor.ftTextTertiaryColor),
                              ),
                              dropdownColor: AppColor.ftAppBarColor,
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
                              // value: ,
                              items: const [
                                DropdownMenuItem(
                                  value: 'cash',
                                  child: Text('Cash'),
                                ),
                                DropdownMenuItem(
                                  value: 'account',
                                  child: Text('Account'),
                                ),
                              ],
                              onChanged: (value) {},
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Required Feild';
                                } else {
                                  return null;
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
                              controller: AccountGroupAmountController,
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
                      const SizedBox(height: 35),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.ftTextPrimaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              textStyle: const TextStyle(fontSize: 16),
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 25,
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    duration: Duration(seconds: 2),
                                    elevation: 2,
                                    behavior: SnackBarBehavior.floating,
                                    padding: EdgeInsets.all(15),
                                    backgroundColor: AppColor.ftAppBarColor,
                                    content: Text(
                                      'Saved',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                );
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
                              textStyle: const TextStyle(fontSize: 16),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 25),
                            ),
                            onPressed: () {
                              AccountGroupAmountController.clear();
                            },
                            child: const Text(
                              'Clear ',
                              style: TextStyle(
                                color: AppColor.ftTextSecondayColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 35),
                      const Divider(
                        thickness: 3,
                        color: AppColor.ftSecondaryDividerColor,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
