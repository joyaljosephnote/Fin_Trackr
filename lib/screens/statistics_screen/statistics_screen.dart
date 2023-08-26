import 'package:fin_trackr/constant/constant.dart';
import 'package:fin_trackr/db/functions/category_functions.dart';
import 'package:fin_trackr/db/functions/statistics_cart_function.dart';
import 'package:fin_trackr/db/functions/transaction_function.dart';
import 'package:fin_trackr/models/statistics/statistics_model.db.dart';
import 'package:fin_trackr/screens/statistics_screen/category_wise_statiscs.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen>
    with TickerProviderStateMixin {
  List<ChartDatas> dataExpense = chartLogic(expenseNotifier1.value);
  List<ChartDatas> dataIncome = chartLogic(incomeNotifier1.value);
  List<ChartDatas> overview = chartLogic(overviewNotifier.value);
  List<ChartDatas> customDate = chartLogic(customDateNotifier.value);
  List<ChartDatas> yesterday = chartLogic(yesterdayNotifier.value);
  List<ChartDatas> today = chartLogic(todayNotifier.value);
  List<ChartDatas> month = chartLogic(lastMonthNotifier.value);
  List<ChartDatas> week = chartLogic(lastWeekNotifier.value);
  List<ChartDatas> todayIncome = chartLogic(incomeTodayNotifier.value);
  List<ChartDatas> incomeYesterday = chartLogic(incomeYesterdayNotifier.value);
  List<ChartDatas> incomeWeek = chartLogic(incomeLastWeekNotifier.value);
  List<ChartDatas> incomeMonth = chartLogic(incomeLastMonthNotifier.value);
  List<ChartDatas> todayExpense = chartLogic(expenseTodayNotifier.value);
  List<ChartDatas> expenseYesterday =
      chartLogic(expenseYesterdayNotifier.value);
  List<ChartDatas> expenseweek = chartLogic(expenseLastWeekNotifier.value);
  List<ChartDatas> expensemonth = chartLogic(expenseLastMonthNotifier.value);

  late TabController tabController;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    _tooltipBehavior = TooltipBehavior(enable: true);
    filterFunction();
    CategoryDB.instance.getAllCategory();
    TransactionDB.instance.refresh();
    super.initState();
  }

  String categoryId2 = 'Month';
  int touchIndex = 1;

  @override
  Widget build(BuildContext context) {
    CategoryDB.instance.getAllCategory();
    TransactionDB.instance.refresh();
    filterFunction();
    chartdivertFunctionOverview();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColor.ftScafoldColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.ftScafoldColor,
        title: const Padding(
          padding: EdgeInsets.only(left: 9),
          child: Text(
            'Statistics',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Ionicons.swap_horizontal,
                color: AppColor.ftTextSecondayColor, size: 18),
            onPressed: () {
              // Handle forward button press
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CategoryWiseStatistics(),
                ),
              );
            },
          ),
          IconButton(
              alignment: Alignment.centerLeft,
              onPressed: () {
                showPopupMenu2();
              },
              icon: const Icon(Ionicons.calendar_outline, size: 22)),
        ],
      ),
      body: SingleChildScrollView(
        child: ValueListenableBuilder(
          valueListenable: expenseNotifier1,
          builder: (context, value, Widget? _) => Column(
            children: [
              Container(
                color: AppColor.ftScafoldColor,
                width: width * 0.9,
                child: TabBar(
                  indicatorColor: Colors.transparent,
                  unselectedLabelStyle: const TextStyle(color: Colors.grey),
                  labelStyle: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w500),
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  controller: tabController,
                  labelColor: AppColor.ftTextSecondayColor,
                  unselectedLabelColor: AppColor.ftTextTertiaryColor,
                  tabs: const [
                    Tab(
                      text: 'All',
                    ),
                    Tab(
                      text: 'Income',
                    ),
                    Tab(
                      text: 'Expense',
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.0263,
              ),
              SizedBox(
                width: double.maxFinite,
                height: height * 0.526,
                child: TabBarView(
                  controller: tabController,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(
                        16,
                      ),
                      child: chartdivertFunctionOverview().isEmpty
                          ? Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 150,
                                    child: Lottie.asset('assets/noSearch.json'),
                                  ),
                                  const Text(
                                    "No transactions yet !",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: AppColor.ftTextTertiaryColor),
                                  ),
                                ],
                              ),
                            )
                          : SfCircularChart(
                              legend: const Legend(
                                title: LegendTitle(
                                  text: 'Categories',
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
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
                                  dataSource: chartdivertFunctionOverview(),
                                  xValueMapper: (ChartDatas data, _) =>
                                      data.category,
                                  yValueMapper: (ChartDatas data, _) =>
                                      data.amount,
                                  explode: true,
                                  dataLabelSettings: const DataLabelSettings(
                                    showZeroValue: false,
                                    isVisible: false,
                                    labelPosition:
                                        ChartDataLabelPosition.inside,
                                    useSeriesColor: true,
                                    connectorLineSettings:
                                        ConnectorLineSettings(
                                            type: ConnectorType.curve),
                                  ),
                                ),
                              ],
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(
                        16,
                      ),
                      child: chartdivertFunctionIncome().isEmpty
                          ? Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 150,
                                    child: Lottie.asset('assets/noSearch.json'),
                                  ),
                                  const Text(
                                    "No transactions yet !",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: AppColor.ftTextTertiaryColor),
                                  ),
                                ],
                              ),
                            )
                          : SfCircularChart(
                              legend: const Legend(
                                title: LegendTitle(
                                  text: 'Categories',
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
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
                                  dataSource: chartdivertFunctionIncome(),
                                  xValueMapper: (ChartDatas data, _) =>
                                      data.category,
                                  yValueMapper: (ChartDatas data, _) =>
                                      data.amount,
                                  explode: true,
                                  dataLabelSettings: const DataLabelSettings(
                                    showZeroValue: false,
                                    isVisible: false,
                                    labelPosition:
                                        ChartDataLabelPosition.inside,
                                    useSeriesColor: true,
                                    connectorLineSettings:
                                        ConnectorLineSettings(
                                            type: ConnectorType.curve),
                                  ),
                                ),
                              ],
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(
                        16,
                      ),
                      child: chartdivertFunctionExpense().isEmpty
                          ? Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 150,
                                    child: Lottie.asset('assets/noSearch.json'),
                                  ),
                                  const Text(
                                    "No transactions yet !",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: AppColor.ftTextTertiaryColor),
                                  ),
                                ],
                              ),
                            )
                          : SfCircularChart(
                              legend: const Legend(
                                title: LegendTitle(
                                  text: 'Categories',
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
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
                                  dataSource: chartdivertFunctionExpense(),
                                  xValueMapper: (ChartDatas data, _) =>
                                      data.category,
                                  yValueMapper: (ChartDatas data, _) =>
                                      data.amount,
                                  explode: true,
                                  dataLabelSettings: const DataLabelSettings(
                                    showZeroValue: false,
                                    isVisible: false,
                                    labelPosition:
                                        ChartDataLabelPosition.inside,
                                    useSeriesColor: true,
                                    connectorLineSettings:
                                        ConnectorLineSettings(
                                            type: ConnectorType.curve),
                                  ),
                                ),
                              ],
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

  chartdivertFunctionOverview() {
    if (categoryId2 == 'All') {
      return overview;
    }
    if (categoryId2 == 'Today') {
      return today;
    }
    if (categoryId2 == 'Yesterday') {
      return yesterday;
    }
    if (categoryId2 == 'This week') {
      return week;
    }
    if (categoryId2 == 'Month') {
      return month;
    }
    if (categoryId2 == 'Custom') {
      return customDate;
    }
  }

  chartdivertFunctionIncome() {
    if (categoryId2 == 'All') {
      return dataIncome;
    }
    if (categoryId2 == 'Today') {
      return todayIncome;
    }
    if (categoryId2 == 'Yesterday') {
      return incomeYesterday;
    }
    if (categoryId2 == 'This week') {
      return incomeWeek;
    }
    if (categoryId2 == 'Month') {
      return incomeMonth;
    }
  }

  chartdivertFunctionExpense() {
    if (categoryId2 == 'All') {
      return dataExpense;
    }
    if (categoryId2 == 'Today') {
      return todayExpense;
    }
    if (categoryId2 == 'Yesterday') {
      return expenseYesterday;
    }
    if (categoryId2 == 'This week') {
      return expenseweek;
    }
    if (categoryId2 == 'Month') {
      return expensemonth;
    }
  }

  void showPopupMenu2() async {
    await showMenu(
      color: AppColor.ftAppBarColor,
      context: context,
      position: const RelativeRect.fromLTRB(100, 80, 10, 10),
      items: [
        PopupMenuItem(
            onTap: () {
              setState(() {
                categoryId2 = 'All';
              });
            },
            child: const Text(
              'All',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColor.ftTextSecondayColor),
            )),
        PopupMenuItem(
            onTap: () {
              setState(() {
                categoryId2 = 'Today';
              });
            },
            child: const Text(
              'Today',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColor.ftTextSecondayColor),
            )),
        PopupMenuItem(
            onTap: () {
              setState(() {
                categoryId2 = 'Yesterday';
              });
            },
            child: const Text(
              'Yesterday',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColor.ftTextSecondayColor),
            )),
        PopupMenuItem(
            onTap: () {
              setState(() {
                categoryId2 = 'This week';
              });
            },
            child: const Text(
              'Last Week',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColor.ftTextSecondayColor),
            )),
        PopupMenuItem(
            onTap: () {
              setState(() {
                categoryId2 = 'Month';
              });
            },
            child: const Text(
              'Last Month',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColor.ftTextSecondayColor),
            )),
      ],
      elevation: 8.0,
    );
  }
}
