import 'package:fin_trackr/constants/constant.dart';
import 'package:fin_trackr/db/functions/category_functions.dart';
import 'package:fin_trackr/db/functions/currency_function.dart';
import 'package:fin_trackr/db/functions/transaction_function.dart';
import 'package:fin_trackr/screens/accounts_screen/balance_calculation.dart';
import 'package:fin_trackr/screens/calculator/calculator_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class AccountsScreen extends StatelessWidget {
  const AccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('MMM yyyy').format(now);
    NumberFormat formatter = NumberFormat('#,##0.00');
    TransactionDB.instance.refresh();
    CategoryDB.instance.getAllCategory();
    accountGroupBalanceAmount();
    balanceAmountOfCurrentMonth();
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: SizedBox(
            width: 600,
            child: Column(
              children: [
                const Divider(
                  thickness: 2.0,
                  color: AppColor.ftPrimaryDividerColor,
                ),
                Container(
                  alignment: Alignment.center,
                  height: 30,
                  child: Text(
                    'Balance Sheet of $formattedDate',
                    style: const TextStyle(
                        color: AppColor.ftTextTertiaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const Divider(
                  thickness: 2.0,
                  color: AppColor.ftPrimaryDividerColor,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              const Text(
                                'Income',
                                style: TextStyle(
                                  color: AppColor.ftTextTertiaryColor,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ValueListenableBuilder(
                                valueListenable: incomeCurrentMonthNotifier,
                                builder: (context, value, child) {
                                  return Text(
                                    "${currencySymboleUpdate.value} ${formatter.format(incomeCurrentMonthNotifier.value)}",
                                    style: const TextStyle(
                                      color: AppColor.ftTextIncomeColor,
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
                                'Expense',
                                style: TextStyle(
                                  color: AppColor.ftTextTertiaryColor,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ValueListenableBuilder(
                                valueListenable: expenseCurrentMonthNotifier,
                                builder: (context, value, child) {
                                  return Text(
                                    "${currencySymboleUpdate.value} ${formatter.format(expenseCurrentMonthNotifier.value)}",
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
                            valueListenable: totalCurrentMonthNotifier,
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
                                    "${currencySymboleUpdate.value} ${formatter.format(totalCurrentMonthNotifier.value)}",
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
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ValueListenableBuilder(
                        valueListenable: incomePercentageNotifier,
                        builder: (context, value, child) {
                          return CircularPercentIndicator(
                            radius: 45.0,
                            lineWidth: 8.0,
                            animation: true,
                            percent: incomePercentageNotifier.value > 0 ||
                                    expensePercentageNotifier.value > 0
                                ? (incomePercentageNotifier.value * 100) / 100
                                : 0,
                            center: Text(
                              "${incomePercentageNotifier.value > 0 || expensePercentageNotifier.value > 0 ? (incomePercentageNotifier.value * 100).toDouble().toStringAsFixed(0) : 0}%",
                              style: const TextStyle(
                                color: AppColor.ftTextSecondayColor,
                                fontSize: 14,
                              ),
                            ),
                            footer: const Text(
                              "Income",
                              style: TextStyle(
                                  height: 1.9,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0,
                                  color: AppColor.ftTextTertiaryColor),
                            ),
                            circularStrokeCap: CircularStrokeCap.round,
                            backgroundColor: const Color(0xFF474242),
                            progressColor: AppColor.ftTextIncomeColor,
                          );
                        },
                      ),
                      ValueListenableBuilder(
                        valueListenable: expensePercentageNotifier,
                        builder: (context, value, child) {
                          return CircularPercentIndicator(
                            radius: 45.0,
                            lineWidth: 8.0,
                            animation: true,
                            percent: incomePercentageNotifier.value > 0 ||
                                    expensePercentageNotifier.value > 0
                                ? (100 -
                                        (expensePercentageNotifier.value *
                                            100)) /
                                    100
                                : 0,
                            center: Text(
                              "${incomePercentageNotifier.value > 0 || expensePercentageNotifier.value > 0 ? (100 - (expensePercentageNotifier.value * 100)).toDouble().toStringAsFixed(0) : 0}%",
                              style: const TextStyle(
                                color: AppColor.ftTextSecondayColor,
                                fontSize: 14,
                              ),
                            ),
                            footer: const Text(
                              "Expense",
                              style: TextStyle(
                                  height: 1.9,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0,
                                  color: AppColor.ftTextTertiaryColor),
                            ),
                            circularStrokeCap: CircularStrokeCap.round,
                            backgroundColor: const Color(0xFF474242),
                            progressColor: AppColor.ftTextExpenseColor,
                          );
                        },
                      )
                    ],
                  ),
                ),
                const Divider(
                  thickness: 2.0,
                  color: AppColor.ftPrimaryDividerColor,
                ),
                Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 35,
                      child: const Text(
                        'Actual Balance',
                        style: TextStyle(
                            color: AppColor.ftTextTertiaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Divider(
                      thickness: 2.0,
                      color: AppColor.ftPrimaryDividerColor,
                    ),
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
                                        color: AppColor.ftTextTertiaryColor,
                                        fontSize: 14),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    '${currencySymboleUpdate.value} ${formatter.format(accountAmountGroupNotifier.value)}',
                                    style: const TextStyle(
                                        color: AppColor.ftTextTertiaryColor,
                                        fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
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
                                        color: AppColor.ftTextTertiaryColor,
                                        fontSize: 14),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    '${currencySymboleUpdate.value} ${formatter.format(cashAmountGroupNotifier.value)}',
                                    style: const TextStyle(
                                        color: AppColor.ftTextTertiaryColor,
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
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: ValueListenableBuilder(
                    valueListenable: assetAmountGroupNotifier,
                    builder: (context, value, child) {
                      return SizedBox(
                        height: 35,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Total Balance',
                                style: TextStyle(
                                    color: AppColor.ftTextLinkColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                '${currencySymboleUpdate.value} ${formatter.format(assetAmountGroupNotifier.value)}',
                                style: const TextStyle(
                                    color: AppColor.ftTextLinkColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
