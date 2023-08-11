import 'package:fin_trackr/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  late List<ExpenseData> _chartData;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  List<String> items = <String>[
    'Income',
    'Expense',
  ];

  String dropdownValue = 'Income';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.ftScafoldColor,
      appBar: AppBar(
        backgroundColor: AppColor.ftScafoldColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Statustucs',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Container(
              width: 100,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColor.ftTextTransferColor),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  isDense: true,
                  iconSize: 20,
                  iconEnabledColor: AppColor.ftTextTransferColor,
                  icon: const Icon(Icons.arrow_drop_down_circle_outlined),
                  value: dropdownValue,
                  dropdownColor: AppColor.ftScafoldColor,
                  style: const TextStyle(
                    color: AppColor.ftWaveColor,
                    fontSize: 13,
                  ),
                  onTap: () {},
                  onChanged: (value) {
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                  items: items.map<DropdownMenuItem<String>>(
                    (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    },
                  ).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SfCircularChart(
        legend: const Legend(
          isVisible: true,
          overflowMode: LegendItemOverflowMode.wrap,
        ),
        tooltipBehavior: _tooltipBehavior,
        series: <CircularSeries>[
          DoughnutSeries<ExpenseData, String>(
            radius: '95',
            dataSource: _chartData,
            xValueMapper: (ExpenseData data, _) => data.continent,
            yValueMapper: (ExpenseData data, _) => data.expense,
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              labelPosition: ChartDataLabelPosition.outside,
              textStyle: TextStyle(
                  color: Color.fromARGB(255, 245, 245, 245),
                  fontWeight: FontWeight.bold),
            ),
            enableTooltip: true,
          ),
        ],
      ),
    );
  }

  List<ExpenseData> getChartData() {
    final List<ExpenseData> charData = [
      ExpenseData('Food', 1600),
      ExpenseData('Travel', 2000),
      ExpenseData('Fashion', 4380),
      ExpenseData('Home', 12000),
      ExpenseData('Rent', 3600),
      ExpenseData('Socal Life', 1600),
      ExpenseData('Household', 2450),
      ExpenseData('Helth', 750),
      ExpenseData('Culture', 850),
      ExpenseData('Apparel', 2530),
      ExpenseData('Other', 400),
    ];
    return charData;
  }
}

class ExpenseData {
  ExpenseData(this.continent, this.expense);
  final String continent;
  final int expense;
}
