import 'package:fin_trackr/models/transactions/transaction_model_db.dart';
import 'package:flutter/material.dart';

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
