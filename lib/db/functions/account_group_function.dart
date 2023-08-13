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
  );

  var defaultModel2 = AccountGroupModel(
    accountType: AccountType.cash,
    name: 'Cash',
    id: 'cash',
  );

  await box.put('account', defaultModel1);
  await box.put('cash', defaultModel2);
}

Future<void> addAccountGroup(AccountGroupModel value) async {
  final accountGroupDB = await Hive.openBox<AccountGroupModel>(ACCOUNT_DB_NAME);
  await accountGroupDB.put(value.id, value);
  getAllAccountGroup();
}

Future<void> getAllAccountGroup() async {
  final accountGroupDB = await Hive.openBox<AccountGroupModel>(ACCOUNT_DB_NAME);
  accountGroupNotifier.value.clear();

  accountGroupNotifier.value.addAll(accountGroupDB.values);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  accountGroupNotifier.notifyListeners();
}
