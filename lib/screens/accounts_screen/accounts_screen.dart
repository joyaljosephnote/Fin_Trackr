import 'package:fin_trackr/constant/constant.dart';
import 'package:fin_trackr/db/functions/account_group_function.dart';
import 'package:fin_trackr/db/functions/category_functions.dart';
import 'package:fin_trackr/db/functions/currency_function.dart';
import 'package:fin_trackr/db/functions/transaction_function.dart';
import 'package:fin_trackr/screens/accounts_screen/balance_calculation.dart';
import 'package:fin_trackr/screens/calculator/calculator_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';

class AccountsScreen extends StatelessWidget {
  const AccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    NumberFormat formatter = NumberFormat('#,##0.00');
    TransactionDB.instance.refresh();
    CategoryDB.instance.getAllCategory();
    getAllAccountGroup();
    accountGroupBalanceAmount();
    balanceAmount();
    return Scaffold(
      backgroundColor: AppColor.ftScafoldColor,
      appBar: AppBar(
        backgroundColor: AppColor.ftScafoldColor,
        elevation: 0,
        title: Row(
          children: [
            const Text(
              'Accounts',
              style: TextStyle(fontSize: 18),
            ),
            const Spacer(),
            Column(
              children: [
                IconButton(
                  alignment: Alignment.centerRight,
                  icon: const Icon(Ionicons.calculator,
                      color: AppColor.ftTextSecondayColor, size: 18),
                  onPressed: () {
                    // Handle forward button press
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
          ],
        ),
      ),
      body: Center(
        child: SizedBox(
          width: 600,
          child: Column(
            children: [
              const Divider(
                thickness: 2.0,
                color: AppColor.ftPrimaryDividerColor,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        const Text(
                          'Assets',
                          style: TextStyle(
                            color: AppColor.ftTextTertiaryColor,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ValueListenableBuilder(
                          valueListenable: assetAmountGroupNotifier,
                          builder: (context, value, child) {
                            return Text(
                              "${currencySymboleUpdate.value} ${formatter.format(assetAmountGroupNotifier.value)}",
                              style: const TextStyle(
                                color: AppColor.ftTextQuinaryColor,
                                fontSize: 14,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Text(
                          'Libilities',
                          style: TextStyle(
                            color: AppColor.ftTextTertiaryColor,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ValueListenableBuilder(
                          valueListenable: assetAmountGroupNotifier,
                          builder: (context, value, child) {
                            return Text(
                              "${currencySymboleUpdate.value} ${formatter.format(assetAmountGroupNotifier.value - totalnotifier.value)}",
                              style: const TextStyle(
                                color: AppColor.ftTextExpenseColor,
                                fontSize: 14,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    ValueListenableBuilder(
                      valueListenable: totalnotifier,
                      builder: (context, value, child) {
                        return Column(
                          children: [
                            const Text(
                              'Balance',
                              style: TextStyle(
                                color: AppColor.ftTextTertiaryColor,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${currencySymboleUpdate.value} ${formatter.format(totalnotifier.value)}",
                              style: const TextStyle(
                                color: AppColor.ftTextSecondayColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 2.0,
                color: AppColor.ftPrimaryDividerColor,
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: ValueListenableBuilder(
                      valueListenable: accountAmountGroupNotifier,
                      builder: (context, value, child) {
                        return SizedBox(
                          height: 35,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Account',
                                  style: TextStyle(
                                      color: AppColor.ftTextSecondayColor,
                                      fontSize: 14),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  '${currencySymboleUpdate.value} ${formatter.format(accountAmountGroupNotifier.value)}',
                                  style: const TextStyle(
                                      color: AppColor.ftTextSecondayColor,
                                      fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const Divider(
                    thickness: 2.0,
                    color: AppColor.ftPrimaryDividerColor,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: ValueListenableBuilder(
                      valueListenable: cashAmountGroupNotifier,
                      builder: (context, value, child) {
                        return SizedBox(
                          height: 35,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Cash',
                                  style: TextStyle(
                                      color: AppColor.ftTextSecondayColor,
                                      fontSize: 14),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  '${currencySymboleUpdate.value} ${formatter.format(cashAmountGroupNotifier.value)}',
                                  style: const TextStyle(
                                      color: AppColor.ftTextSecondayColor,
                                      fontSize: 14),
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
              const Divider(
                thickness: 2.0,
                color: AppColor.ftPrimaryDividerColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
