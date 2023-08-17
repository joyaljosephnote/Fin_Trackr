import 'package:fin_trackr/constant/constant.dart';
// ignore: unused_import
import 'package:fin_trackr/db/functions/account_group_function.dart';
import 'package:fin_trackr/db/functions/category_functions.dart';
import 'package:fin_trackr/db/functions/currency_function.dart';
import 'package:fin_trackr/db/functions/transaction_function.dart';
import 'package:fin_trackr/db/models/account_group/account_group_model_db.dart';
import 'package:fin_trackr/db/models/currency/curency_model.db.dart';
import 'package:fin_trackr/db/models/transactions/transaction_model_db.dart';

import 'package:fin_trackr/screens/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'db/models/category/category_model_db.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }
  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }
  if (!Hive.isAdapterRegistered(CurrencyModelAdapter().typeId)) {
    Hive.registerAdapter(CurrencyModelAdapter());
  }
  if (!Hive.isAdapterRegistered(AccountTypeAdapter().typeId)) {
    Hive.registerAdapter(AccountTypeAdapter());
  }
  if (!Hive.isAdapterRegistered(AccountGroupModelAdapter().typeId)) {
    Hive.registerAdapter(AccountGroupModelAdapter());
  }

  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }
  await addInitialData();

  TransactionDB.instance.refresh();
  CategoryDB.instance.getAllCategory();
  getAllAccountGroup();
  getCurrency();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Disables landscape and portrait mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'FinTrackr',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        splashFactory: NoSplash.splashFactory,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColor.ftScafoldColor),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
