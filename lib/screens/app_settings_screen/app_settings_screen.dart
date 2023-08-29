import 'package:fin_trackr/constants/constant.dart';
import 'package:fin_trackr/details/about_app/about_app.dart';
import 'package:fin_trackr/screens/app_settings_screen/account_group_settings/account_group.dart';
import 'package:fin_trackr/screens/app_settings_screen/contact_us.dart';
import 'package:fin_trackr/screens/app_settings_screen/currency_selector/currency_selector.dart';
import 'package:fin_trackr/screens/app_settings_screen/expense_category_settings/expense_category_list_view.dart';
import 'package:fin_trackr/screens/app_settings_screen/income_category_settings/income_category_list_view.dart';
import 'package:fin_trackr/screens/app_settings_screen/user_guide/user_guide_settings.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'dart:math' as math;

import 'reset_app_settings/reset_app_settings.dart';

class AppSettingsScreen extends StatelessWidget {
  const AppSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.ftScafoldColor,
      appBar: AppBar(
        backgroundColor: AppColor.ftScafoldColor,
        title: const Padding(
          padding: EdgeInsets.only(left: 8),
          child: Text(
            'App Settings',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      ),
      body: Center(
        child: SizedBox(
          width: 600,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView(
              // physics: const NeverScrollableScrollPhysics(),
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              children: [
                InkWell(
                  splashFactory: NoSplash.splashFactory,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const IncomeCategoryList(),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Transform.rotate(
                          angle: 180 * math.pi / 180,
                          child: const Icon(
                            Ionicons.share_outline,
                            size: 25,
                            color: AppColor.ftBottomNavigatorUnSelectorColor,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Income',
                          style: TextStyle(
                            color: AppColor.ftBottomNavigatorUnSelectorColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  splashFactory: NoSplash.splashFactory,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ExpenseCategoryList(),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Ionicons.share_outline,
                          size: 25,
                          color: AppColor.ftBottomNavigatorUnSelectorColor,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Expense',
                          style: TextStyle(
                            color: AppColor.ftBottomNavigatorUnSelectorColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  splashFactory: NoSplash.splashFactory,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AccountGroup(),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Ionicons.shuffle,
                          size: 25,
                          color: AppColor.ftBottomNavigatorUnSelectorColor,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Acct. Group',
                          style: TextStyle(
                            color: AppColor.ftBottomNavigatorUnSelectorColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  splashFactory: NoSplash.splashFactory,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CurencySelection(),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Ionicons.cash_outline,
                          size: 25,
                          color: AppColor.ftBottomNavigatorUnSelectorColor,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Currency',
                          style: TextStyle(
                            color: AppColor.ftBottomNavigatorUnSelectorColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  splashFactory: NoSplash.splashFactory,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UserGuide(),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.auto_stories_outlined,
                          size: 25,
                          color: AppColor.ftBottomNavigatorUnSelectorColor,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'User Guide',
                          style: TextStyle(
                            color: AppColor.ftBottomNavigatorUnSelectorColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  splashFactory: NoSplash.splashFactory,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ResetAppSettings(),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.settings_backup_restore_outlined,
                          size: 25,
                          color: AppColor.ftBottomNavigatorUnSelectorColor,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Reset App',
                          style: TextStyle(
                            color: AppColor.ftBottomNavigatorUnSelectorColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  splashFactory: NoSplash.splashFactory,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AboutApp(),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Ionicons.information_circle_outline,
                          size: 25,
                          color: AppColor.ftBottomNavigatorUnSelectorColor,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'About App',
                          style: TextStyle(
                            color: AppColor.ftBottomNavigatorUnSelectorColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  splashFactory: NoSplash.splashFactory,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ContactUs(),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Ionicons.mail_open_outline,
                          size: 25,
                          color: AppColor.ftBottomNavigatorUnSelectorColor,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Contact Us',
                          style: TextStyle(
                            color: AppColor.ftBottomNavigatorUnSelectorColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
