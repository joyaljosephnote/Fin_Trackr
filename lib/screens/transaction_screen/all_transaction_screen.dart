import 'package:fin_trackr/constant/constant.dart';
import 'package:fin_trackr/db/functions/currency_function.dart';
import 'package:fin_trackr/db/functions/transaction_function.dart';
import 'package:fin_trackr/db/models/category/category_model_db.dart';
import 'package:fin_trackr/db/models/transactions/transaction_model_db.dart';
import 'package:fin_trackr/screens/accounts_screen/balance_calculation.dart';
import 'package:fin_trackr/screens/transaction_screen/add_transactions/add_transactions_selector.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter/src/material/date_picker.dart';
import 'dart:io';
import 'package:lottie/lottie.dart';

class ViewAllScreen extends StatefulWidget {
  const ViewAllScreen({super.key});

  @override
  State<ViewAllScreen> createState() => _ViewAllScreenState();
}

class _ViewAllScreenState extends State<ViewAllScreen> {
  ValueNotifier<bool> searchBarNotifier = ValueNotifier<bool>(false);
  var clearcontroller = TextEditingController();
  NumberFormat formatter = NumberFormat('#,##0.00');

  @override
  void initState() {
    TransactionDB.instance.refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.ftScafoldColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.ftScafoldColor,
        title: const Text(
          'All Transactions',
          style: TextStyle(fontSize: 18),
        ),
        actions: [
          IconButton(
              alignment: Alignment.centerRight,
              onPressed: () {
                showPopupMenu1();
              },
              icon: const Icon(Icons.sort_rounded)),
          IconButton(
              alignment: Alignment.centerLeft,
              onPressed: () {
                showPopupMenu2();
              },
              icon: const Icon(Ionicons.calendar_outline, size: 22)),
        ],
      ),
      body: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.04,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColor.ftTransactionColor,
                    boxShadow: const [
                      BoxShadow(
                        color: AppColor.ftShadowColor,
                        spreadRadius: 0,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ValueListenableBuilder<bool>(
                    valueListenable: searchBarNotifier,
                    builder: (context, boolValue, child) => Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Stack(
                            alignment: Alignment.centerRight,
                            children: [
                              TextField(
                                controller: clearcontroller,
                                onChanged: (value) {
                                  TransactionDB.instance.search(value);

                                  if (value.isEmpty) {
                                    searchBarNotifier.value = false;
                                    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                                    searchBarNotifier.notifyListeners();
                                  } else {
                                    searchBarNotifier.value = true;
                                    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                                    searchBarNotifier.notifyListeners();
                                  }
                                },
                                cursorColor: AppColor.ftTextSecondayColor,
                                style: const TextStyle(
                                    color: AppColor.ftTextSecondayColor),
                                decoration: InputDecoration(
                                  suffixIcon: searchBarNotifier.value == false
                                      ? const Icon(Ionicons.search_outline)
                                      : null,
                                  suffixIconColor:
                                      AppColor.ftTabBarSelectorColor,
                                  hintText: 'Search by category name',
                                  hintStyle: const TextStyle(
                                      color: AppColor.ftTextTertiaryColor),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColor.ftSecondaryDividerColor,
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: searchBarNotifier.value,
                                child: IconButton(
                                  onPressed: () {
                                    clearcontroller.clear();
                                    setState(() {
                                      searchBarNotifier.value = false;
                                    });
                                  },
                                  icon: const Icon(
                                    Ionicons.close_circle_outline,
                                    color: AppColor.ftTabBarSelectorColor,
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
            ],
          ),
          ValueListenableBuilder(
            valueListenable: TransactionDB.instance.transactionListNotifier,
            builder: (context, newList, child) {
              Map<String, List<TransactionModel>> mapList = sortByDate(newList);
              List<String> keys = mapList.keys.toList();
              return keys.isNotEmpty
                  ? Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 9),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: keys.length,
                          itemBuilder: (context, index) {
                            List<TransactionModel> calculationList =
                                mapList[keys[index]]!;
                            double incomeData = calculationList.fold(0,
                                (previousValue, transaction) {
                              if (transaction.categoryType ==
                                  CategoryType.income) {
                                return previousValue + transaction.amount;
                              }
                              return previousValue;
                            });
                            double expenseData = calculationList.fold(0,
                                (previousValue, transaction) {
                              if (transaction.categoryType ==
                                  CategoryType.expense) {
                                previousValue += transaction.amount;
                              }
                              return previousValue;
                            });
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.04,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 8.8),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColor.ftTransactionColor,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: AppColor.ftShadowColor,
                                        spreadRadius: 0,
                                        blurRadius: 5,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10, top: 10),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  width: 65,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: AppColor
                                                        .ftTextLinkColor2,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(5),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      DateFormat('dd ')
                                                              .format(DateTime
                                                                  .parse(keys[
                                                                      index]))
                                                              .toString() +
                                                          DateFormat('EEE')
                                                              .format(DateTime
                                                                  .parse(keys[
                                                                      index]))
                                                              .toString(),
                                                      style: const TextStyle(
                                                        color: AppColor
                                                            .ftTextSecondayColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Text(
                                                    DateFormat('MM.yyyy')
                                                        .format(DateTime.parse(
                                                            keys[index]))
                                                        .toString(),
                                                    style: const TextStyle(
                                                      color: AppColor
                                                          .ftTextTertiaryColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                const Spacer(),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      '+ ${currencySymboleUpdate.value} ${formatter.format(incomeData)}',
                                                      style: const TextStyle(
                                                        color: AppColor
                                                            .ftTextIncomeColor,
                                                        fontSize: 13,
                                                        // fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      '- ${currencySymboleUpdate.value} ${formatter.format(expenseData)}',
                                                      style: const TextStyle(
                                                        color: AppColor
                                                            .ftTextExpenseColor,
                                                        fontSize: 13,
                                                        // fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            const Divider(
                                              color: AppColor
                                                  .ftSecondaryDividerColor,
                                              thickness: 2,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: TransactionsCategory(
                                          newList: mapList[keys[index]]!,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 120,
                          ),
                          Container(
                            alignment: Alignment.center,
                          ),
                          SizedBox(
                            width: 180,
                            child: Lottie.asset(
                              'assets/nodata.json',
                            ),
                          ),
                          const Text(
                            "No transactions yet !",
                            style: TextStyle(
                              fontSize: 15,
                              color: AppColor.ftTextTertiaryColor,
                            ),
                          ),
                        ],
                      ),
                    );
            },
          ),
        ],
      ),
    );
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

  void showPopupMenu1() async {
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

  void showPopupMenu2() async {
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
            )),
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
                      // ignore: avoid_unnecessary_containers
                      child: Container(
                        child: Text(
                          data.account.name.substring(0, 1).toUpperCase() +
                              data.account.name.substring(1).toLowerCase(),
                          style: const TextStyle(
                            color: AppColor.ftTextTertiaryColor,
                            fontSize: 13,
                          ),
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
                                // data.note,
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
