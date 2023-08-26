import 'package:fin_trackr/db/functions/account_group_function.dart';
import 'package:fin_trackr/db/functions/transaction_function.dart';
import 'package:fin_trackr/models/account_group/account_group_model_db.dart';
import 'package:fin_trackr/models/category/category_model_db.dart';
import 'package:flutter/widgets.dart';

ValueNotifier<double> incomenotifier = ValueNotifier(0);
ValueNotifier<double> expensenotifier = ValueNotifier(0);
ValueNotifier<double> totalnotifier = ValueNotifier(0);
ValueNotifier<double> incomeCurrentMonthNotifier = ValueNotifier(0);
ValueNotifier<double> expenseCurrentMonthNotifier = ValueNotifier(0);
ValueNotifier<double> totalCurrentMonthNotifier = ValueNotifier(0);
ValueNotifier<double> accountAmountGroupNotifier = ValueNotifier(0);
ValueNotifier<double> cashAmountGroupNotifier = ValueNotifier(0);
ValueNotifier<double> assetAmountGroupNotifier = ValueNotifier(0);
ValueNotifier<double> liabiliteAmountGroupNotifier = ValueNotifier(0);
ValueNotifier<double> incomePercentageNotifier = ValueNotifier(0);
ValueNotifier<double> expensePercentageNotifier = ValueNotifier(0);

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

Future<void> balanceAmountOfCurrentMonth() async {
  await TransactionDB.instance.getTransactionsForCurrentMonth().then((value) {
    incomeCurrentMonthNotifier.value = 0;
    expenseCurrentMonthNotifier.value = 0;
    totalCurrentMonthNotifier.value = 0;
    incomePercentageNotifier.value = 0;
    expensePercentageNotifier.value = 0;

    for (var item in value) {
      if (item.categoryType == CategoryType.income) {
        incomeCurrentMonthNotifier.value += item.amount;
      } else {
        expenseCurrentMonthNotifier.value += item.amount;
      }
    }
    totalCurrentMonthNotifier.value =
        incomeCurrentMonthNotifier.value - expenseCurrentMonthNotifier.value;

    incomePercentageNotifier.value =
        (incomeCurrentMonthNotifier.value - expenseCurrentMonthNotifier.value) /
            (incomeCurrentMonthNotifier.value);

    expensePercentageNotifier.value =
        (incomeCurrentMonthNotifier.value - expenseCurrentMonthNotifier.value) /
            (incomeCurrentMonthNotifier.value);
  });
}

Future<void> accountGroupBalanceAmount() async {
  await getAllAccountAmount().then((value) {
    accountAmountGroupNotifier.value = 0;
    cashAmountGroupNotifier.value = 0;
    for (var item in value) {
      if (item.accountType == AccountType.account) {
        accountAmountGroupNotifier.value += item.amount!;
      } else {
        cashAmountGroupNotifier.value += item.amount!;
      }
    }

    assetAmountGroupNotifier.value =
        accountAmountGroupNotifier.value + cashAmountGroupNotifier.value;
  });
}
