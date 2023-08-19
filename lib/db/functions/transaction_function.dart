import 'dart:core';

import 'package:fin_trackr/db/models/category/category_model_db.dart';
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
  ValueNotifier<List<TransactionModel>> transactionMonthListNotifier =
      ValueNotifier([]);
  String? selectedCatogory;

  @override
  Future<void> addTransaction(TransactionModel value) async {
    final transactionDB =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await transactionDB.put(value.id, value);
  }

  // Future<void> refresh() async {
  //   final list = await getAllTransactions();
  //   list.sort((first, second) => second.date.compareTo(first.date));
  //   final listForMonth = await getAllTransactions();
  //   listForMonth.sort((first, second) => second.date.compareTo(first.date));
  //   transactionListNotifier.value.clear();
  //   transactionMonthListNotifier.value.clear();
  //   transactionListNotifier.value.addAll(list);
  //   transactionMonthListNotifier.value.addAll(listForMonth);
  //   // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  //   transactionListNotifier.notifyListeners();
  //   // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  //   transactionMonthListNotifier.notifyListeners();
  // }

  Future<void> refresh() async {
    final list = await getAllTransactions();
    list.sort((first, second) => second.date.compareTo(first.date));
    final listForMonth = await getTransactionsForCurrentMonth();
    listForMonth.sort((first, second) => second.date.compareTo(first.date));
    transactionListNotifier.value.clear();
    transactionMonthListNotifier.value.clear();
    transactionListNotifier.value.addAll(list);
    transactionMonthListNotifier.value.addAll(listForMonth);
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    transactionListNotifier.notifyListeners();
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    transactionMonthListNotifier.notifyListeners();
  }

  Future<List<TransactionModel>> getTransactionsForCurrentMonth() async {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final endOfMonth = DateTime(now.year, now.month + 1, 0);

    // Step 4: Use Hive queries instead of SQLite queries
    final box = Hive.box<TransactionModel>(TRANSACTION_DB_NAME);
    final results = box.values.where((trxn) =>
        DateTime.parse(trxn.date)
            .isAfter(startOfMonth.subtract(const Duration(days: 1))) &&
        DateTime.parse(trxn.date)
            .isBefore(endOfMonth.add(const Duration(days: 1))));

    return results.toList();
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
    await db.delete(id);
    refresh();
  }

  Future<void> editTransactionDb(int id, TransactionModel model) async {
    final db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await db.put(id, model);
    // transactionListNotifier.value.clear();
    // transactionListNotifier.value.addAll(db.values);
    // getAllTransactions();
    refresh();
  }

  Future<void> search(String text) async {
    final db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    List<TransactionModel>? filteredList;

    if (selectedCatogory == 'Income') {
      filteredList = db.values
          .where((element) =>
              element.categoryType == CategoryType.income &&
              element.category.name
                  .toLowerCase()
                  .trim()
                  .contains(text.toLowerCase()))
          .toList()
        ..sort((first, second) => second.date.compareTo(first.date));
      // ..sort((first, second) => second.id!.compareTo(first.id!));
    } else if (selectedCatogory == 'Expense') {
      filteredList = db.values
          .where((element) =>
              element.categoryType == CategoryType.expense &&
              element.category.name
                  .toLowerCase()
                  .trim()
                  .contains(text.toLowerCase()))
          .toList()
        ..sort((first, second) => second.date.compareTo(first.date));
    } else if (selectedCatogory == "All") {
      filteredList = db.values
          .where((element) => element.category.name
              .toLowerCase()
              .trim()
              .contains(text.toLowerCase()))
          .toList()
        ..sort((first, second) => second.date.compareTo(first.date));
    } else {
      filteredList = db.values
          .where((element) => element.category.name
              .toLowerCase()
              .trim()
              .contains(text.toLowerCase()))
          .toList()
        ..sort((first, second) => second.date.compareTo(first.date));
    }
    transactionListNotifier.value.clear();
    transactionListNotifier.value.addAll(filteredList);
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    transactionListNotifier.notifyListeners();
  }

  Future<void> filter(String text) async {
    if (text == 'Income') {
      final transactionDB =
          await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
      transactionListNotifier.value.clear();
      transactionListNotifier.value.addAll(transactionDB.values
          .where((element) => element.categoryType == CategoryType.income)
          .toList()
        ..sort((first, second) => second.date.compareTo(first.date)));
      selectedCatogory = "Income";
      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      transactionListNotifier.notifyListeners();
    } else if (text == 'Expense') {
      final transactionDB =
          await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
      transactionListNotifier.value.clear();
      transactionListNotifier.value.addAll(transactionDB.values
          .where((element) => element.categoryType == CategoryType.expense)
          .toList()
        ..sort((first, second) => second.date.compareTo(first.date)));
      selectedCatogory = "Expense";

      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      transactionListNotifier.notifyListeners();
    } else if (text == "All") {
      selectedCatogory = "All";
      refresh();
      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      transactionListNotifier.notifyListeners();
    }
  }

  Future<void> filterDataByDate(String dateRange) async {
    // ignore: non_constant_identifier_names
    final TransactionDb =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    List<TransactionModel> dateFilterList = [];
    if (dateRange == 'today') {
      if (selectedCatogory == "Income") {
        dateFilterList = TransactionDb.values
            .where((element) =>
                element.categoryType == CategoryType.income &&
                DateTime.parse(element.date).day == DateTime.now().day &&
                DateTime.parse(element.date).month == DateTime.now().month &&
                DateTime.parse(element.date).year == DateTime.now().year)
            .toList()
          ..sort((first, second) => second.date.compareTo(first.date));
      } else if (selectedCatogory == "Expense") {
        dateFilterList = TransactionDb.values
            .where((element) =>
                element.categoryType == CategoryType.expense &&
                DateTime.parse(element.date).day == DateTime.now().day &&
                DateTime.parse(element.date).month == DateTime.now().month &&
                DateTime.parse(element.date).year == DateTime.now().year)
            .toList()
          ..sort((first, second) => second.date.compareTo(first.date));
      } else {
        dateFilterList = TransactionDb.values
            .where((element) =>
                DateTime.parse(element.date).day == DateTime.now().day &&
                DateTime.parse(element.date).month == DateTime.now().month &&
                DateTime.parse(element.date).year == DateTime.now().year)
            .toList()
          ..sort((first, second) => second.date.compareTo(first.date));
        // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
        transactionListNotifier.notifyListeners();
      }
    } else if (dateRange == 'yesterday') {
      if (selectedCatogory == "Income") {
        dateFilterList = TransactionDb.values
            .where((element) =>
                element.categoryType == CategoryType.income &&
                DateTime.parse(element.date).day == DateTime.now().day - 1 &&
                DateTime.parse(element.date).month == DateTime.now().month &&
                DateTime.parse(element.date).year == DateTime.now().year)
            .toList()
          ..sort((first, second) => second.date.compareTo(first.date));
      } else if (selectedCatogory == "Expense") {
        dateFilterList = TransactionDb.values
            .where((element) =>
                element.categoryType == CategoryType.expense &&
                DateTime.parse(element.date).day == DateTime.now().day - 1 &&
                DateTime.parse(element.date).month == DateTime.now().month &&
                DateTime.parse(element.date).year == DateTime.now().year)
            .toList()
          ..sort((first, second) => second.date.compareTo(first.date));
      } else {
        dateFilterList = TransactionDb.values
            .where((element) =>
                DateTime.parse(element.date).day == DateTime.now().day - 1 &&
                DateTime.parse(element.date).month == DateTime.now().month &&
                DateTime.parse(element.date).year == DateTime.now().year)
            .toList()
          ..sort((first, second) => second.date.compareTo(first.date));
        // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
        transactionListNotifier.notifyListeners();
      }
    } else if (dateRange == 'last week') {
      final DateTime today = DateTime.now();
      final DateTime weekAgo = today.subtract(const Duration(days: 7));

      if (selectedCatogory == "Income") {
        dateFilterList = TransactionDb.values
            .where((element) =>
                element.categoryType == CategoryType.income &&
                DateTime.parse(element.date).isAfter(weekAgo) &&
                DateTime.parse(element.date).isBefore(today))
            .toList()
          ..sort((first, second) => second.date.compareTo(first.date));
      } else if (selectedCatogory == "Expense") {
        dateFilterList = TransactionDb.values
            .where((element) =>
                element.categoryType == CategoryType.expense &&
                DateTime.parse(element.date).isAfter(weekAgo) &&
                DateTime.parse(element.date).isBefore(today))
            .toList()
          ..sort((first, second) => second.date.compareTo(first.date));
      } else {
        dateFilterList = TransactionDb.values
            .where((element) =>
                DateTime.parse(element.date).isAfter(weekAgo) &&
                DateTime.parse(element.date).isBefore(today))
            .toList()
          ..sort((first, second) => second.date.compareTo(first.date));
      }
    } else if (dateRange == 'all') {
      refresh();
    } else {
      TransactionDb.values.toList();
    }
    transactionListNotifier.value.clear();
    transactionListNotifier.value = dateFilterList;
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    transactionListNotifier.notifyListeners();
  }

  Future<void> filterByDate(DateTime start, DateTime end) async {
    // ignore: non_constant_identifier_names
    final TransactionDb =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    List<TransactionModel> dateFilterList = [];

    if (selectedCatogory == "Income") {
      dateFilterList = TransactionDb.values
          .where((element) =>
              element.categoryType == CategoryType.income &&
              DateTime.parse(element.date)
                  .isAfter(start.subtract(const Duration(days: 1))) &&
              DateTime.parse(element.date).isBefore(
                end.add(
                  const Duration(days: 1),
                ),
              ))
          .toList()
        ..sort((first, second) => second.date.compareTo(first.date));
    } else if (selectedCatogory == "Expense") {
      dateFilterList = TransactionDb.values
          .where((element) =>
              element.categoryType == CategoryType.expense &&
              DateTime.parse(element.date)
                  .isAfter(start.subtract(const Duration(days: 1))) &&
              DateTime.parse(element.date).isBefore(
                end.add(
                  const Duration(days: 1),
                ),
              ))
          .toList()
        ..sort((first, second) => second.date.compareTo(first.date));
    } else {
      dateFilterList = TransactionDb.values
          .where((element) =>
              DateTime.parse(element.date)
                  .isAfter(start.subtract(const Duration(days: 1))) &&
              DateTime.parse(element.date).isBefore(
                end.add(
                  const Duration(days: 1),
                ),
              ))
          .toList()
        ..sort((first, second) => second.date.compareTo(first.date));
    }

    transactionListNotifier.value.clear();
    transactionListNotifier.value = dateFilterList;
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    transactionListNotifier.notifyListeners();
  }

  Future<void> filterForHome(DateTime start, DateTime end) async {
    // ignore: non_constant_identifier_names
    final TransactionDb =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    List<TransactionModel> dateFilterList = [];

    if (selectedCatogory == "Income") {
      dateFilterList = TransactionDb.values
          .where((element) =>
              element.categoryType == CategoryType.income &&
              DateTime.parse(element.date)
                  .isAfter(start.subtract(const Duration(days: 1))) &&
              DateTime.parse(element.date).isBefore(
                end.add(
                  const Duration(days: 1),
                ),
              ))
          .toList()
        ..sort((first, second) => second.date.compareTo(first.date));
    } else if (selectedCatogory == "Expense") {
      dateFilterList = TransactionDb.values
          .where((element) =>
              element.categoryType == CategoryType.expense &&
              DateTime.parse(element.date)
                  .isAfter(start.subtract(const Duration(days: 1))) &&
              DateTime.parse(element.date).isBefore(
                end.add(
                  const Duration(days: 1),
                ),
              ))
          .toList()
        ..sort((first, second) => second.date.compareTo(first.date));
    } else {
      dateFilterList = TransactionDb.values
          .where((element) =>
              DateTime.parse(element.date)
                  .isAfter(start.subtract(const Duration(days: 1))) &&
              DateTime.parse(element.date).isBefore(
                end.add(
                  const Duration(days: 1),
                ),
              ))
          .toList()
        ..sort((first, second) => second.date.compareTo(first.date));
    }

    transactionMonthListNotifier.value.clear();
    transactionMonthListNotifier.value = dateFilterList;
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    transactionMonthListNotifier.notifyListeners();
  }
}
