// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:fin_trackr/models/currency/curency_model.db.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ignore: constant_identifier_names
const CURENCY_DB_NAME = 'curency-database';

ValueNotifier<List<CurrencyModel>> currencyNotifier = ValueNotifier([]);
ValueNotifier<String> currencySymboleUpdate = ValueNotifier('₹');

Future<void> addCurrency(CurrencyModel value) async {
  final currencyDB = await Hive.openBox<CurrencyModel>(CURENCY_DB_NAME);
  await currencyDB.put(value.id, value);
  getAllCurrency();
}

Future<void> getAllCurrency() async {
  final currencyDB = await Hive.openBox<CurrencyModel>(CURENCY_DB_NAME);
  currencyNotifier.value.clear();
  currencyNotifier.value.addAll(currencyDB.values);
  currencyNotifier.notifyListeners();
}

Future<void> getCurrency() async {
  var currencyDB = await Hive.openBox<CurrencyModel>(CURENCY_DB_NAME);
  currencySymboleUpdate.value = currencyDB.values.first.symbol;
  currencyNotifier.notifyListeners();
  getAllCurrency();
}
