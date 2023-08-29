import 'package:fin_trackr/constants/constant.dart';
import 'package:fin_trackr/db/functions/account_group_function.dart';
import 'package:fin_trackr/db/functions/category_functions.dart';
import 'package:fin_trackr/constants/default/app_default.dart';
import 'package:fin_trackr/screens/app_settings_screen/expense_category_settings/expense_category_provider.dart';
import 'package:fin_trackr/screens/app_settings_screen/income_category_settings/income_category_provider.dart';
import 'package:fin_trackr/screens/splash_screen/splash_screen.dart';
import 'package:fin_trackr/screens/welcome_screen/intro_pages/intro_page1.dart';
import 'package:fin_trackr/screens/welcome_screen/intro_pages/intro_page2.dart';
import 'package:fin_trackr/screens/welcome_screen/intro_pages/intro_page3.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WelcomeScreenOne extends StatefulWidget {
  const WelcomeScreenOne({super.key});

  @override
  State<WelcomeScreenOne> createState() => _WelcomeScreenOneState();
}

class _WelcomeScreenOneState extends State<WelcomeScreenOne> {
  // ignore: unused_field
  bool _hasSeenWelcomeScreen = false;

  // ignore: prefer_final_fields
  PageController _dotController = PageController();
  bool onLastPage = false;

  @override
  void initState() {
    checkIfSeenWelcomescreen();
    super.initState();
  }

  void checkIfSeenWelcomescreen() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    bool hasSeenWelcomeScreen =
        preference.getBool('hasSeenWelcomeScreen') ?? false;
    setState(() {
      _hasSeenWelcomeScreen = hasSeenWelcomeScreen;
    });
  }

  void setHasSeenWelcomeScreen() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('hasSeenWelcomeScreen', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          PageView(
            controller: _dotController,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: const [
              IntroPageOne(),
              IntroPageTwo(),
              IntroPageThree(),
            ],
          ),
          Container(
              alignment: const Alignment(0, 0.75),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //skip
                  GestureDetector(
                    onTap: () {
                      _dotController.jumpToPage(2);
                    },
                    child: const Text(
                      'Skip',
                      style: TextStyle(color: AppColor.ftTextSecondayColor),
                    ),
                  ),
                  //dot Indicator
                  SmoothPageIndicator(controller: _dotController, count: 3),
                  onLastPage
                      ? GestureDetector(
                          onTap: () {
                            setHasSeenWelcomeScreen();
                            addInitialData();
                            ExpenseCategoryProvider().addDefaultCategory(
                                AppDefaultExpenseCategory()
                                    .appDefaultExpenseCategory);
                            IncomeCategoryProvider().addDefaultCategory(
                                AppDefaultIncomeCategory()
                                    .appDefaultIncomeCategory);
                            CategoryDB().getAllCategory();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const SplashScreen();
                                },
                              ),
                            );
                          },
                          child: const Text(
                            'Done',
                            style:
                                TextStyle(color: AppColor.ftTextSecondayColor),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            _dotController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn,
                            );
                          },
                          child: const Text(
                            'Next',
                            style:
                                TextStyle(color: AppColor.ftTextSecondayColor),
                          ),
                        ),
                  //Next or done
                ],
              )),
        ],
      ),
    );
  }
}
