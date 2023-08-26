import 'dart:developer';
import 'package:fin_trackr/models/transactions/transaction_model_db.dart';

class ChartDatas {
  String category;
  double amount;
  String? categoryType;
  ChartDatas({required this.category, required this.amount, this.categoryType});
}

chartLogic(List<TransactionModel> model) {
  double value;
  String categoryName;
  String categoryType;
  List<ChartDatas> newData = [];
  List visited = [];

  for (var i = 0; i < model.length; i++) {
    visited.add(0);
  }
  for (var i = 0; i < model.length; i++) {
    value = model[i].amount.toDouble();
    categoryName = model[i].category.name;
    categoryType = model[i].categoryType.name;

    log(model[i].category.categoryType.toString());
    for (var j = i + 1; j < model.length; j++) {
      if (model[i].category.name == model[j].category.name) {
        value += model[j].amount;
        visited[j] = -1;
        log(value.toString());
      }
    }
    if (visited[i] != -1) {
      newData.add(ChartDatas(
          amount: value, category: categoryName, categoryType: categoryType));
    }
    newData.sort((a, b) => a.category.compareTo(b.category));
  }
  return newData;
}
