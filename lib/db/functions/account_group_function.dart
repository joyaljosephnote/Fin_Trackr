import 'package:fin_trackr/db/models/account_group/account_group_model_db.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ignore: constant_identifier_names
const ACCOUNT_DB_NAME = 'account-group-database';
ValueNotifier<List<AccountGroupModel>> accountGroupNotifier = ValueNotifier([]);

Future<void> addAccountGroup(AccountGroupModel value) async {
  final accountGroupDB = await Hive.openBox<AccountGroupModel>(ACCOUNT_DB_NAME);

  await accountGroupDB.put(value.id, value);
}

Future<void> getAllAccountGroup() async {
  final accountGroupDB = await Hive.openBox<AccountGroupModel>(ACCOUNT_DB_NAME);
  accountGroupNotifier.value.clear();

  accountGroupNotifier.value.addAll(accountGroupDB.values);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  accountGroupNotifier.notifyListeners();
}
