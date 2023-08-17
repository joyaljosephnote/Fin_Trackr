import 'package:fin_trackr/db/functions/transaction_function.dart';
import 'package:fin_trackr/db/models/category/category_model_db.dart';
import 'package:flutter/widgets.dart';

ValueNotifier<double> incomenotifier = ValueNotifier(0);
ValueNotifier<double> expensenotifier = ValueNotifier(0);
ValueNotifier<double> totalnotifier = ValueNotifier(0);

Future<void> balanceAmount() async {
  await TransactionDB.instance.getAllTransactions().then((value) {
    incomenotifier.value = 0;
    expensenotifier.value = 0;
    totalnotifier.value = 0;

    for (var item in value) {
      if (item.categoryType == CategoryType.income) {
        incomenotifier.value += item.amount;
      } else {
        expensenotifier.value += item.amount;
      }
    }
    totalnotifier.value = incomenotifier.value - expensenotifier.value;
  });
}
