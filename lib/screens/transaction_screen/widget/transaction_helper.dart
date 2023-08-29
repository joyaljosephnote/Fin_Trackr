import 'dart:io';

import 'package:fin_trackr/constants/constant.dart';
import 'package:fin_trackr/db/functions/currency_function.dart';
import 'package:fin_trackr/db/functions/transaction_function.dart';
import 'package:fin_trackr/models/category/category_model_db.dart';
import 'package:fin_trackr/models/transactions/transaction_model_db.dart';
import 'package:fin_trackr/screens/accounts_screen/balance_calculation.dart';
import 'package:fin_trackr/screens/transaction_screen/add_transactions/add_transactions_selector.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SelectDate {
  selectePreviousMonth() {
    DateTimeRange selectedDate = DateTimeRange(
      start: DateTime(DateTime.now().year, DateTime.now().month - 1, 1),
      end: DateTime(DateTime.now().year, DateTime.now().month, 0),
    );
    return selectedDate;
  }

  selecteNextMonth() {
    DateTimeRange selectedDate = DateTimeRange(
      start: DateTime(DateTime.now().year, DateTime.now().month, 1),
      end: DateTime(DateTime.now().year, DateTime.now().month + 1, 0),
    );
    return selectedDate;
  }

  currentDateForCalenderSelection() {
    var daterange = DateTimeRange(
      start: DateTime(DateTime.now().year, DateTime.now().month),
      end: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      ),
    );

    return daterange;
  }

  Map<String, List<TransactionModel>> sortByDate(
      List<TransactionModel> models) {
    Map<String, List<TransactionModel>> mapList = {};
    for (TransactionModel model in models) {
      if (!mapList.containsKey(model.date)) {
        mapList[model.date] = [];
      }
      mapList[model.date]!.add(model);
    }
    return mapList;
  }
}

class FilterFunction {
  void showPopupMenu1(BuildContext context) async {
    await showMenu(
      color: AppColor.ftAppBarColor,
      context: context,
      position: const RelativeRect.fromLTRB(100, 80, 10, 10),
      items: [
        PopupMenuItem(
            onTap: () {
              TransactionDB.instance.filter('All');
              TransactionDB.instance.refresh();
            },
            child: const Text(
              'All',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColor.ftTextSecondayColor),
            )),
        PopupMenuItem(
            onTap: () {
              TransactionDB.instance.filter('Income');
            },
            child: const Text(
              'Income',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColor.ftTextSecondayColor),
            )),
        PopupMenuItem(
            onTap: () {
              TransactionDB.instance.filter('Expense');
            },
            child: const Text(
              'Expense',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColor.ftTextSecondayColor),
            )),
      ],
      elevation: 8.0,
    );
  }

  void showPopupMenu2(BuildContext context) async {
    await showMenu(
      color: AppColor.ftAppBarColor,
      context: context,
      position: const RelativeRect.fromLTRB(100, 80, 10, 10),
      items: [
        PopupMenuItem(
            onTap: () {
              TransactionDB.instance.filterDataByDate('all');
            },
            child: const Text(
              'All',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColor.ftTextSecondayColor),
            )),
        PopupMenuItem(
            onTap: () {
              TransactionDB.instance.filterDataByDate('today');
            },
            child: const Text(
              'Today',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColor.ftTextSecondayColor),
            )),
        PopupMenuItem(
            onTap: () {
              TransactionDB.instance.filterDataByDate('yesterday');
            },
            child: const Text(
              'Yesterday',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColor.ftTextSecondayColor),
            )),
        PopupMenuItem(
            onTap: () {
              TransactionDB.instance.filterDataByDate('last week');
            },
            child: const Text(
              'Last Week',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColor.ftTextSecondayColor),
            )),
        PopupMenuItem(
          onTap: () async {
            var daterange = DateTimeRange(
              start: DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day - 7),
              end: DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day),
            );
            DateTimeRange? picked = await showDateRangePicker(
                context: context,
                builder: (context, child) {
                  return Theme(
                    data: ThemeData.dark().copyWith(
                        colorScheme: const ColorScheme.dark(
                            onPrimary: AppColor.ftAppBarColor,
                            onSurface: AppColor.ftTextSecondayColor,
                            primary: AppColor.ftTextTertiaryColor),
                        dialogBackgroundColor: AppColor.ftAppBarColor),
                    child: child!,
                  );
                },
                firstDate: DateTime(DateTime.now().year - 1),
                lastDate: DateTime.now(),
                initialDateRange: daterange);
            if (picked != null) {
              TransactionDB.instance.filterByDate(picked.start, picked.end);
            }
          },
          child: const Text(
            'Custom Date',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColor.ftTextSecondayColor),
          ),
        ),
      ],
      elevation: 8.0,
    );
  }
}

class TransactionsCategory extends StatefulWidget {
  const TransactionsCategory({
    required this.newList,
    super.key,
  });

  final List<TransactionModel> newList;

  @override
  State<TransactionsCategory> createState() => _TransactionsCategoryState();
}

class _TransactionsCategoryState extends State<TransactionsCategory> {
  final NumberFormat formatter = NumberFormat('#,##0.00');

  bool screenExpand = false;
  @override
  Widget build(BuildContext context) {
    balanceAmount();
    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: widget.newList.length,
      itemBuilder: (context, index) {
        final data = widget.newList[index];
        return GestureDetector(
          onTap: () {
            if (screenExpand == false) {
              setState(() {
                screenExpand = true;
              });
            } else if (screenExpand == true) {
              setState(() {
                screenExpand = false;
              });
            }
          },
          onLongPress: () {
            int tabIndex = 2;
            if (data.categoryType == CategoryType.income) {
              tabIndex = 0;
            } else if (data.categoryType == CategoryType.expense) {
              tabIndex = 1;
            }
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    TransactionScreenSelector(tabIndex: tabIndex, model: data),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: SizedBox(
                        width: 100,
                        child: Text(
                          data.category.name,
                          style: const TextStyle(
                            color: AppColor.ftTextTertiaryColor,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(
                        data.account.name.substring(0, 1).toUpperCase() +
                            data.account.name.substring(1).toLowerCase(),
                        style: const TextStyle(
                          color: AppColor.ftTextTertiaryColor,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        data.categoryType == CategoryType.income
                            ? '+ ${currencySymboleUpdate.value} ${formatter.format(data.amount)}'
                            : '- ${currencySymboleUpdate.value} ${formatter.format(data.amount)}',
                        style: const TextStyle(
                          color: AppColor.ftTextTertiaryColor,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
                screenExpand == true
                    ? Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                'Note : ${data.note}',
                                style: const TextStyle(
                                  color: AppColor.ftTextTertiaryColor,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                ),
                              ),
                              margin: const EdgeInsets.only(top: 5),
                              child: data.image != null
                                  ? Image.file(
                                      File(data.image.toString()),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                      width:
                                          MediaQuery.of(context).size.width * 2,
                                      fit: BoxFit.cover,
                                    )
                                  : const SizedBox.shrink(),
                            ),
                            const Divider(
                              color: AppColor.ftSecondaryDividerColor,
                            )
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Container(),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
