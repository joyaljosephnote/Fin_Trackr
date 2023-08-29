// ignore_for_file: use_build_context_synchronously, duplicate_ignore

import 'package:fin_trackr/constants/constant.dart';
import 'package:fin_trackr/db/functions/category_functions.dart';
import 'package:fin_trackr/db/functions/transaction_function.dart';
import 'package:fin_trackr/models/category/category_model_db.dart';
import 'package:fin_trackr/models/transactions/transaction_model_db.dart';
import 'package:fin_trackr/screens/home/home_screen.dart';
import 'package:fin_trackr/screens/welcome_screen/welcome_screen1.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResetAppSettings extends StatelessWidget {
  const ResetAppSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.ftScafoldColor,
      appBar: AppBar(
        backgroundColor: AppColor.ftScafoldColor,
        title: const Text('Reset App', style: TextStyle(fontSize: 18)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 15),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  height: 40,
                  child: const Text(
                    'Complete Reset',
                    style: TextStyle(
                        fontSize: 15, color: AppColor.ftTextSecondayColor),
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    resetApp(context);
                  },
                  icon: const Icon(Icons.delete_forever_outlined,
                      color: AppColor.ftTextTertiaryColor),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  height: 40,
                  child: const Text(
                    'Reset Transactions Only',
                    style: TextStyle(
                        fontSize: 15, color: AppColor.ftTextSecondayColor),
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    resetTransactionsOnly(context);
                  },
                  icon: const Icon(Icons.delete_forever_outlined,
                      color: AppColor.ftTextTertiaryColor),
                ),
              ],
            ),
            const Divider(
                thickness: 1, color: AppColor.ftSecondaryDividerColor),
          ],
        ),
      ),
    );
  }

  resetApp(value) {
    showDialog(
      context: value,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: AppColor.ftWaveColor,
          content: const Text('Reseting app will erase all your data.'),
          title: const Text(
            'Do you want to reset app?',
            style: TextStyle(
              color: AppColor.ftTextQuaternaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                await preferences.clear();
                SharedPreferences textcontrol =
                    await SharedPreferences.getInstance();
                await textcontrol.clear();
                final categoryDb =
                    await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
                final transactionDB =
                    await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
                categoryDb.clear();
                transactionDB.clear();
                HoemeScreen.selectedIndexNotifier = ValueNotifier(0);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const WelcomeScreenOne()));
              },
              child: const Text(
                'Yes',
                style: TextStyle(
                  color: AppColor.ftTextQuaternaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'No',
                style: TextStyle(
                  color: AppColor.ftTextQuaternaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  resetTransactionsOnly(value) {
    showDialog(
      context: value,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: AppColor.ftWaveColor,
          content: const Text(
              'Reseting transaction will erase all your transaction data.'),
          title: const Text(
            'Do you want to delete all transactions?',
            style: TextStyle(
              color: AppColor.ftTextQuaternaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                final transactionDB =
                    await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
                transactionDB.clear();
                Navigator.of(context).pop();
              },
              child: const Text(
                'Yes',
                style: TextStyle(
                  color: AppColor.ftTextQuaternaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'No',
                style: TextStyle(
                  color: AppColor.ftTextQuaternaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
