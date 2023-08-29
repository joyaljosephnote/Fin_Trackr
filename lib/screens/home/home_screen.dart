import 'package:fin_trackr/constants/constant.dart';
import 'package:fin_trackr/db/functions/category_functions.dart';
import 'package:fin_trackr/screens/accounts_screen/accounts_screen.dart';
import 'package:fin_trackr/screens/home/widget/bottom_navigation.dart';
import 'package:fin_trackr/screens/home/widget/floatting_action_button.dart';
import 'package:fin_trackr/screens/app_settings_screen/app_settings_screen.dart';
import 'package:fin_trackr/screens/statistics_screen/category_wise_statiscs.dart';
import 'package:flutter/material.dart';
import '../transaction_screen/transaction_screen.dart';

class HoemeScreen extends StatelessWidget {
  HoemeScreen({super.key});

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  final _pages = [
    const TransactionScreen(),
    const CategoryWiseStatistics(),
    const AccountsScreen(),
    const AppSettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    CategoryDB().getAllCategory();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColor.ftScafoldColor,
        bottomNavigationBar: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: const FinTrackrBottomNavigation(),
        ),
        body: SafeArea(
          child: ValueListenableBuilder(
            valueListenable: selectedIndexNotifier,
            builder: (BuildContext context, int updatedIndex, _) {
              return _pages[updatedIndex];
            },
          ),
        ),
        floatingActionButton: ValueListenableBuilder(
          valueListenable: selectedIndexNotifier,
          builder: (BuildContext context, int updatedIndex, _) {
            if (updatedIndex == 0 || updatedIndex == 2) {
              return CustomFloatingActionButton(index: updatedIndex);
            } else {
              // hide FAB otherwise
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
