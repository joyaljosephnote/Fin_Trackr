import 'package:fin_trackr/constants/constant.dart';
import 'package:fin_trackr/details/about_app/developer_information.dart';
import 'package:fin_trackr/details/about_app/privacy_policy.dart';
import 'package:fin_trackr/details/about_app/terms_and_conditions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.ftScafoldColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.ftScafoldColor,
        title: Row(
          children: [
            const Text(
              'About  ',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              AppText.appName,
              style: TextStyle(
                  color: AppColor.ftTextSecondayColor,
                  fontSize: 18,
                  fontFamily: GoogleFonts.ubuntu().fontFamily,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              Text(
                AppText.appName,
                style: TextStyle(
                    color: AppColor.ftTextSecondayColor,
                    fontSize: 30,
                    fontFamily: GoogleFonts.ubuntu().fontFamily,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                AppText.appVersion,
                style: TextStyle(
                    color: AppColor.ftTextTertiaryColor, fontSize: 12),
              ),
              const SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        const TextSpan(
                          text: 'About this app\n\n',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColor.ftTextTertiaryColor,
                            height: 1.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(
                          text: AppText.appName,
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColor.ftTextTertiaryColor,
                            height: 1.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(
                          text:
                              ' is a financial tracking application that helps users manage their personal finances effectively.\nWith ',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColor.ftTextTertiaryColor,
                            height: 1.5,
                          ),
                        ),
                        const TextSpan(
                          text: AppText.appName,
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColor.ftTextTertiaryColor,
                            height: 1.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(
                          text:
                              ', users can track income, expenses, and savings, and gain valuable insights into their spending habits and financial goals. The app provides a user-friendly interface and powerful features to assist users in budgeting, setting financial targets, and monitoring their progress over time. It also offers visualizations and reports to visualize financial data, enabling users to make informed decisions about their money. ',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColor.ftTextTertiaryColor,
                            height: 1.5,
                          ),
                        ),
                        const TextSpan(
                          text: AppText.appName,
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColor.ftTextTertiaryColor,
                            height: 1.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(
                          text:
                              ' strives to empower individuals in achieving their financial objectives and promoting financial wellness.',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColor.ftTextTertiaryColor,
                            height: 1.5,
                          ),
                        ),
                        TextSpan(
                          text: '\n\nDeveloper Information\n',
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColor.ftTextQuinaryColor,
                            height: 1.5,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const DeveloperInformation(),
                                ),
                              );
                            },
                        ),
                        TextSpan(
                          text: '\nPrivacy Policy\n',
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColor.ftTextQuinaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PrivacyPolicy(),
                                ),
                              );
                            },
                        ),
                        TextSpan(
                          text: '\nTerms & Conditions\n',
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColor.ftTextQuinaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const TermsAndConditions(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
