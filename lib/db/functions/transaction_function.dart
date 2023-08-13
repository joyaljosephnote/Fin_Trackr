import 'package:fin_trackr/db/models/transactions/transaction_model_db.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ignore: constant_identifier_names
const TRANSACTION_DB_NAME = 'transaction-db';

ValueNotifier<List<TransactionModel>> transactionListNotifier =
    ValueNotifier([]);

Future<void> addTransaction(TransactionModel value) async {
  final transactionDB =
      await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
  await transactionDB.add(value);
}

Future<void> refresh() async {
  final list = await getAllTransactions();
  list.sort((first, second) => second.date.compareTo(first.date));
  transactionListNotifier.value.clear();
  transactionListNotifier.value.addAll(list);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  transactionListNotifier.notifyListeners();
}

Future<List<TransactionModel>> getAllTransactions() async {
  final transactionDB =
      await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
  return transactionDB.values.toList();
}
