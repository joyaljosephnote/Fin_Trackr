// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, unused_local_variable

import 'package:fin_trackr/constant/constant.dart';
import 'package:fin_trackr/db/functions/currency_function.dart';
import 'package:fin_trackr/db/functions/transaction_function.dart';
import 'package:fin_trackr/models/statistics/statistics_model.db.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CategoryWiseStatistics extends StatefulWidget {
  const CategoryWiseStatistics({super.key});

  @override
  State<CategoryWiseStatistics> createState() => _CategoryWiseStatisticsState();
}

class _CategoryWiseStatisticsState extends State<CategoryWiseStatistics> {
  ValueNotifier<bool> searchBarNotifier = ValueNotifier<bool>(false);
  var clearcontroller = TextEditingController();

  TooltipBehavior _tooltipBehavior = TooltipBehavior();
  NumberFormat formatter = NumberFormat('#,##0.00');

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    TransactionDB.instance.filterByDate(
        DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day - 30),
        DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day));
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
          'Statistics',
          style: TextStyle(fontSize: 17),
        ),
        actions: [
          IconButton(
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
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
                                  searchBarNotifier.notifyListeners();
                                } else {
                                  searchBarNotifier.value = true;
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
                                suffixIconColor: AppColor.ftTabBarSelectorColor,
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
                                    TransactionDB.instance.filterByDate(
                                        DateTime(
                                            DateTime.now().year,
                                            DateTime.now().month,
                                            DateTime.now().day - 30),
                                        DateTime(
                                            DateTime.now().year,
                                            DateTime.now().month,
                                            DateTime.now().day));
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
            ValueListenableBuilder(
              valueListenable: TransactionDB.instance.transactionListNotifier,
              builder: (context, value, child) {
                List<ChartDatas> newData = chartLogic(value);
                double amount = newData.fold(0,
                    (previousValue, element) => previousValue + element.amount);
                return newData.isNotEmpty
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.04,
                        ),
                        child: Column(
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.only(top: 8.9, bottom: 8.9),
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
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: Text(
                                                'Total Amount',
                                                style: TextStyle(
                                                    color: AppColor
                                                        .ftTextSecondayColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            const Spacer(),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                '${currencySymboleUpdate.value} ${formatter.format(amount)}',
                                                style: const TextStyle(
                                                    color: AppColor
                                                        .ftTextSecondayColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              left: 8.0, right: 8.0),
                                          child: Divider(
                                            thickness: 2.0,
                                            color: AppColor
                                                .ftSecondaryDividerColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SfCircularChart(
                                    legend: const Legend(
                                      isVisible: true,
                                      overflowMode: LegendItemOverflowMode.wrap,
                                      position: LegendPosition.bottom,
                                      textStyle: TextStyle(
                                        color: AppColor.ftTextSecondayColor,
                                      ),
                                    ),
                                    tooltipBehavior: _tooltipBehavior,
                                    series: <CircularSeries>[
                                      DoughnutSeries<ChartDatas, String>(
                                          enableTooltip: true,
                                          dataSource: newData,
                                          xValueMapper: (ChartDatas data, _) =>
                                              data.category,
                                          yValueMapper: (ChartDatas data, _) =>
                                              data.amount,
                                          explode: true)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: newData.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 8.9,
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
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 10,
                                          bottom: 10),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child:
                                                newData[index].categoryType ==
                                                        'income'
                                                    ? const Icon(
                                                        Icons.arrow_circle_up,
                                                        color: AppColor
                                                            .ftTextIncomeColor,
                                                      )
                                                    : const Icon(
                                                        Icons.arrow_circle_down,
                                                        color: AppColor
                                                            .ftTextExpenseColor,
                                                      ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Text(
                                              newData[index]
                                                  .category
                                                  .toString(),
                                              style: const TextStyle(
                                                color: AppColor
                                                    .ftTextTertiaryColor,
                                              ),
                                            ),
                                          ),
                                          const Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              '${currencySymboleUpdate.value} ${formatter.format(newData[index].amount)}',
                                              style: const TextStyle(
                                                  color: AppColor
                                                      .ftTextTertiaryColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
            )
          ],
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
            onTap: () {
              TransactionDB.instance.filter('Income');
              TransactionDB.instance.filterByDate(
                  DateTime(DateTime.now().year, DateTime.now().month,
                      DateTime.now().day - 30),
                  DateTime(DateTime.now().year, DateTime.now().month,
                      DateTime.now().day));
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
              TransactionDB.instance.filterByDate(
                  DateTime(DateTime.now().year, DateTime.now().month,
                      DateTime.now().day - 30),
                  DateTime(DateTime.now().year, DateTime.now().month,
                      DateTime.now().day));
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
              TransactionDB.instance.filterByDate(
                  DateTime(DateTime.now().year, DateTime.now().month,
                      DateTime.now().day - 30),
                  DateTime(DateTime.now().year, DateTime.now().month,
                      DateTime.now().day));
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
                  DateTime.now().day - 30),
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
          ),
        ),
      ],
      elevation: 8.0,
    );
  }
}
