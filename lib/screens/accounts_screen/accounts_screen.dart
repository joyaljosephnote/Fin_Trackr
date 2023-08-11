import 'package:fin_trackr/constant/constant.dart';
import 'package:fin_trackr/screens/calculator/calculator_screen.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class AccountsScreen extends StatelessWidget {
  AccountsScreen({super.key});

  final _accountGroup = [
    'Cash',
    'Account',
    'Card',
  ];
  final _accountBalance = [
    '₹ 2,580.00',
    '₹ 21,140.00',
    '₹ - 1,500.00',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.ftScafoldColor,
      appBar: AppBar(
        backgroundColor: AppColor.ftScafoldColor,
        elevation: 0,
        title: Row(
          children: [
            const Text(
              'Accounts',
              style: TextStyle(fontSize: 18),
            ),
            const Spacer(),
            Column(
              children: [
                IconButton(
                  alignment: Alignment.centerRight,
                  icon: const Icon(Ionicons.calculator,
                      color: AppColor.ftTextSecondayColor, size: 18),
                  onPressed: () {
                    // Handle forward button press
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CalculatorScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      body: Center(
        child: SizedBox(
          width: 600,
          child: Column(
            children: [
              const Divider(
                thickness: 2.0,
                color: AppColor.ftPrimaryDividerColor,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Assets',
                          style: TextStyle(
                            color: AppColor.ftTextTertiaryColor,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '₹ 23,720.00',
                          style: TextStyle(
                            color: AppColor.ftTextQuinaryColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Libilities',
                          style: TextStyle(
                            color: AppColor.ftTextTertiaryColor,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '₹ 1,500.00',
                          style: TextStyle(
                            color: AppColor.ftTextPrimaryColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Balance',
                          style: TextStyle(
                            color: AppColor.ftTextTertiaryColor,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '₹ 22,220.00',
                          style: TextStyle(
                            color: AppColor.ftTextSecondayColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 2.0,
                color: AppColor.ftPrimaryDividerColor,
              ),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: _accountGroup.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 5, top: 5),
                          child: Row(
                            children: [
                              Text(
                                _accountGroup[index],
                                style: const TextStyle(
                                  color: AppColor.ftTextTertiaryColor,
                                  fontSize: 14,
                                ),
                              ),
                              const Spacer(flex: 1),
                              Text(
                                _accountBalance[index],
                                style: const TextStyle(
                                  color: AppColor.ftTextSecondayColor,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: 2.0,
                          color: AppColor.ftPrimaryDividerColor,
                        ),
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
