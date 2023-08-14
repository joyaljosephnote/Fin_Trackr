import 'package:fin_trackr/db/models/transactions/transaction_model_db.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ignore: constant_identifier_names
const TRANSACTION_DB_NAME = 'transaction-db';

abstract class TransactionDBFunctions {
  Future<void> addTransaction(TransactionModel objects);
  Future<List<TransactionModel>> getAllTransactions();
  Future<void> deleteTransaction(int index);
}

class TransactionDB implements TransactionDBFunctions {
  TransactionDB.internal();
  static TransactionDB instance = TransactionDB.internal();
  factory TransactionDB() {
    return instance;
  }

  ValueNotifier<List<TransactionModel>> transactionListNotifier =
      ValueNotifier([]);

  @override
  Future<void> addTransaction(TransactionModel value) async {
    final transactionDB =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await transactionDB.add(value);
  }

  Future<void> refresh() async {
    final list = await getAllTransactions();
    list.sort((first, second) => second.date.compareTo(first.date));
    print("${list.length} from database Trans");
    transactionListNotifier.value.clear();
    transactionListNotifier.value.addAll(list);
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    transactionListNotifier.notifyListeners();
  }

  @override
  Future<List<TransactionModel>> getAllTransactions() async {
    final transactionDB =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    return transactionDB.values.toList();
  }

  @override
  Future<void> deleteTransaction(int id) async {
    final db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    db.deleteAt(id);
    refresh();
  }

  Future<void> editTransactionDb(int id, TransactionModel model) async {
    final db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await db.putAt(id, model);
    // transactionListNotifier.value.clear();
    // transactionListNotifier.value.addAll(db.values);
    // getAllTransactions();
    refresh();
  }
}
