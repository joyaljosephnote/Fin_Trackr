// ignore_for_file: avoid_print

import 'package:fin_trackr/db/models/category/category_model_db.dart';
import 'package:fin_trackr/db/models/transactions/transaction_model_db.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:fin_trackr/db/models/account_group/account_group_model_db.dart';
import 'package:flutter/material.dart';

// ignore: constant_identifier_names
const ACCOUNT_DB_NAME = 'account-group-database';
ValueNotifier<List<AccountGroupModel>> accountGroupNotifier = ValueNotifier([]);

Future<void> addInitialData() async {
  var box = await Hive.openBox<AccountGroupModel>(ACCOUNT_DB_NAME);

  var defaultModel1 = AccountGroupModel(
    accountType: AccountType.account,
    name: 'Account',
    id: 'account',
    amount: 0,
  );

  var defaultModel2 = AccountGroupModel(
    accountType: AccountType.cash,
    name: 'Cash',
    id: 'cash',
    amount: 0,
  );

  await box.put('account', defaultModel1);
  await box.put('cash', defaultModel2);
}

Future<void> addAccountGroup(AccountGroupModel value) async {
  final accountGroupDB = await Hive.openBox<AccountGroupModel>(ACCOUNT_DB_NAME);
  await accountGroupDB.put(value.id, value);
  getAllAccountGroup();
}

Future<void> editAccountGroup(TransactionModel model) async {
  final accountGroupDB = await Hive.openBox<AccountGroupModel>(ACCOUNT_DB_NAME);
  final accountModel = accountGroupDB.values
      .where((element) => element.id == model.account.name.toLowerCase())
      .first;
  if (model.categoryType == CategoryType.income) {
    accountModel.amount = accountModel.amount! - model.amount;
  } else {
    accountModel.amount = accountModel.amount! + model.amount;
  }
  await accountGroupDB.put(accountModel.id, accountModel);
}

Future<void> updateAccountGroup(TransactionModel model,
    [bool isDeleting = false]) async {
  final accountGroupDB = await Hive.openBox<AccountGroupModel>(ACCOUNT_DB_NAME);
  final accountModel = accountGroupDB.values
      .where((element) => element.id == model.account.name.toLowerCase())
      .first;
  if (model.categoryType == CategoryType.income) {
    if (isDeleting) {
      accountModel.amount = accountModel.amount! - model.amount;
    } else {
      accountModel.amount = accountModel.amount! + model.amount;
    }
  } else {
    if (isDeleting) {
      accountModel.amount = accountModel.amount! + model.amount;
    } else {
      accountModel.amount = accountModel.amount! - model.amount;
    }
  }
  await accountGroupDB.put(accountModel.id, accountModel);
  getAllAccountGroup();
}

Future<void> selfTransfer(
    {required String accountType, required double amount}) async {
  final accountGroupDB = await Hive.openBox<AccountGroupModel>(ACCOUNT_DB_NAME);
  final accountModel = accountGroupDB.values
      .where((element) => element.id == accountType.toLowerCase())
      .first;
  accountModel.amount = accountModel.amount! - amount;
  await accountGroupDB.put(accountModel.id, accountModel);
  final accountModel2 = accountGroupDB.values
      .where((element) => element.id != accountType.toLowerCase())
      .first;
  accountModel2.amount = accountModel2.amount! + amount;
  await accountGroupDB.put(accountModel2.id, accountModel2);
  getAllAccountGroup();
}

Future<List<AccountGroupModel>> getAllAccountAmount() async {
  final accountGroupDB = await Hive.openBox<AccountGroupModel>(ACCOUNT_DB_NAME);
  // accountGroupNotifier.value.clear();
  // accountGroupNotifier.value.addAll(accountGroupDB.values);
  // // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  // accountGroupNotifier.notifyListeners();
  List<AccountGroupModel> temp = accountGroupDB.values.toList();
  print("${temp[0].amount} from db 1");
  print("${temp[1].amount} from db 2");
  return accountGroupDB.values.toList();
}

Future<void> getAllAccountGroup() async {
  final accountGroupDB = await Hive.openBox<AccountGroupModel>(ACCOUNT_DB_NAME);
  accountGroupNotifier.value.clear();

  accountGroupNotifier.value.addAll(accountGroupDB.values);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  accountGroupNotifier.notifyListeners();
}
