import 'package:fin_trackr/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPageOne extends StatelessWidget {
  const IntroPageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.ftBottomNavigatorColor,
      body: Center(
        child: SizedBox(
          width: 400,
          child: Column(
            children: [
              Container(
                child: Lottie.asset(
                  'assets/introIndianRupee.json',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: const TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Simple and intuitive\n\n',
                              style: TextStyle(
                                fontSize: 25,
                                color: AppColor.ftTextSecondayColor,
                                height: 1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text:
                                  'Take charge of your financial journey with our ',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColor.ftTextSecondayColor,
                                height: 1.5,
                              ),
                            ),
                            TextSpan(
                              text: AppText.appName,
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColor.ftTextSecondayColor,
                                height: 1.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text:
                                  ' App. \nEmpower yourself to track, manage, and achieve your financial goals like never before.',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColor.ftTextSecondayColor,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
