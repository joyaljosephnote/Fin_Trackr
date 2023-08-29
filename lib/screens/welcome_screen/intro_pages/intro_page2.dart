import 'package:fin_trackr/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPageTwo extends StatelessWidget {
  const IntroPageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.ftBottomNavigatorColor,
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: 400,
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Container(
                    child: Lottie.asset('assets/statistics.json', width: 300),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: const TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Get detailed analysis\n\n',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: AppColor.ftTextSecondayColor,
                                  height: 1,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'Get future predictions & informative statistics based on your behaviour.\nAlways make better & informed decisions with your money!',
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
