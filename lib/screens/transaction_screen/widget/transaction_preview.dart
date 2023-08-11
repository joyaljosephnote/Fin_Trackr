import 'package:fin_trackr/constant/constant.dart';
import 'package:flutter/material.dart';

class TransactionPreview extends StatelessWidget {
  final String child;

  TransactionPreview({super.key, required this.child});

  final _transactionsHistory = [
    'Trans 1',
    'Trans 1',
    'Trans 1',
  ];

  final _transactionCategory = [
    'Salary',
    'Entertainment',
    'Food',
    'Drink',
    'Other',
  ];

  final _transactionAccount = [
    'Cash',
    'Account',
    'Card',
  ];
  final _transactionAmount = [
    '+ ₹ 25,000.00',
    '- ₹ 2,000.00',
    '- ₹ 780.00',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColor.ftTransactionColor,
          boxShadow: const [
            BoxShadow(
              color: AppColor.ftShadowColor,
              spreadRadius: 0,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: AppColor.ftTextLinkColor2,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            '12 Sat',
                            style: TextStyle(
                              color: AppColor.ftTextSecondayColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          '07. 2023',
                          style: TextStyle(
                            color: AppColor.ftTextTertiaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Spacer(),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '+ ₹ 25,000.00',
                            style: TextStyle(
                              color: AppColor.ftTextIncomeColor,
                              fontSize: 13,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '- ₹ 2,780.00',
                            style: TextStyle(
                              color: AppColor.ftTextExpenseColor,
                              fontSize: 13,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(
                    color: AppColor.ftSecondaryDividerColor,
                    thickness: 2,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: _transactionsHistory.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: SizedBox(
                            width: 100,
                            child: Text(
                              _transactionCategory[index],
                              style: const TextStyle(
                                color: AppColor.ftTextTertiaryColor,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          // ignore: avoid_unnecessary_containers
                          child: Container(
                            child: Text(
                              _transactionAccount[index],
                              style: const TextStyle(
                                color: AppColor.ftTextTertiaryColor,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            _transactionAmount[index],
                            style: const TextStyle(
                              color: AppColor.ftTextTertiaryColor,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
