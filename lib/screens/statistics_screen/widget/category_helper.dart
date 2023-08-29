import 'package:fin_trackr/constants/constant.dart';
import 'package:fin_trackr/db/functions/transaction_function.dart';
import 'package:fin_trackr/models/transactions/transaction_model_db.dart';
import 'package:flutter/material.dart';

class CategoryFilter {
  void showPopupMenu1(BuildContext context) async {
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

  void showPopupMenu2(BuildContext context) async {
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
