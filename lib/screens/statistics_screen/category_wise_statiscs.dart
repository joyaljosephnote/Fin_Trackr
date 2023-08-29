// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, unused_local_variable

import 'package:fin_trackr/constants/constant.dart';
import 'package:fin_trackr/db/functions/currency_function.dart';
import 'package:fin_trackr/db/functions/transaction_function.dart';
import 'package:fin_trackr/models/statistics/statistics_model.db.dart';
import 'package:fin_trackr/models/transactions/transaction_model_db.dart';
import 'package:fin_trackr/screens/statistics_screen/widget/category_helper.dart';
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
    TransactionDB.instance.filter('Income');
    TransactionDB.instance.filterByDate(
        DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day - 30),
        DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day));
    super.initState();
  }

  @override
  void dispose() {
    TransactionDB.instance.filter('All');
    super.dispose();
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
                CategoryFilter().showPopupMenu1(context);
              },
              icon: const Icon(Icons.sort_rounded)),
          IconButton(
              alignment: Alignment.centerLeft,
              onPressed: () {
                CategoryFilter().showPopupMenu2(context);
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
                Map<String, List<TransactionModel>> model =
                    CategoryFilter().sortByDate(value);
                String? endDate;
                String? startDate;
                if (value.isNotEmpty) {
                  endDate = model.keys.first.toString();
                  startDate = model.keys.last.toString();
                }
                List<ChartDatas> newData = chartLogic(value);
                double amount = newData.fold(0,
                    (previousValue, element) => previousValue + element.amount);
                String categoryName;
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
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Text(
                                                newData.first.categoryType ==
                                                        'income'
                                                    ? categoryName =
                                                        'Total Income'
                                                    : categoryName =
                                                        'Total Expense',
                                                style: const TextStyle(
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
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Date : ${DateFormat("MMM dd").format(DateTime.parse(startDate!))} - ${DateFormat("MMM dd").format(DateTime.parse(endDate!))}",
                                                style: const TextStyle(
                                                    color: AppColor
                                                        .ftTextTertiaryColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
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
}
