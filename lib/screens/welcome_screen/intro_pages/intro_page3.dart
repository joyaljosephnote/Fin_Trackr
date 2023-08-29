import 'package:fin_trackr/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPageThree extends StatelessWidget {
  const IntroPageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.ftBottomNavigatorColor,
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: 400,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 60,
                ),
                Container(
                  child: Lottie.asset('assets/privacy.json', width: 300),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: const TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: 'We respect your privacy!\n\n',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: AppColor.ftTextSecondayColor,
                                  height: 1,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'Your financial data never reaches our servers!\nOur commitment to upholding user privacy remains unwavering and resolute.',
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
      ),
    );
  }
}
