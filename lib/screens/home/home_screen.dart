import 'package:fin_trackr/constant/constant.dart';
import 'package:fin_trackr/screens/accounts_screen/accounts_screen.dart';
import 'package:fin_trackr/screens/home/widget/bottom_navigation.dart';
import 'package:fin_trackr/screens/home/widget/floatting_action_button.dart';
import 'package:fin_trackr/screens/app_settings_screen/app_settings_screen.dart';
import 'package:fin_trackr/screens/statistics_screen/statistics_screen.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:month_year_picker/month_year_picker.dart';
import '../transaction_screen/transaction_screen.dart';

class HoemeScreen extends StatelessWidget {
  HoemeScreen({super.key});

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  final _pages = [
    const TransactionScreen(),
    const StatisticsScreen(),
    AccountsScreen(),
    const AppSettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
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
      localizationsDelegates: const [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        MonthYearPickerLocalizations.delegate,
      ],
    );
  }
}
