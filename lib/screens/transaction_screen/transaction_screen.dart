import 'package:fin_trackr/constant/constant.dart';
import 'package:fin_trackr/db/functions/currency_function.dart';
import 'package:fin_trackr/screens/accounts_screen/accounts_screen.dart';
import 'package:fin_trackr/screens/calculator/calculator_screen.dart';
import 'package:fin_trackr/screens/transaction_screen/all_transaction_screen.dart';
import 'package:fin_trackr/screens/transaction_screen/widget/transaction_preview.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';

// ignore: must_be_immutable
class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  DateTime selectedDate = DateTime.now();

  final _transactionPreview = [
    'Transaction 1',
    'Transaction 2',
    'Transaction 3',
    'Transaction 4',
  ];

  @override
  Widget build(BuildContext context) {
    getCurrency();
    return Scaffold(
      backgroundColor: AppColor.ftPrimaryColor,
      appBar: AppBar(
        backgroundColor: AppColor.ftScafoldColor,
        elevation: 0,
        titleSpacing: 0.0,
        title: Row(
          children: [
            Row(
              children: [
                IconButton(
                  alignment: Alignment.centerRight,
                  icon: const Icon(Icons.arrow_back_ios,
                      color: AppColor.ftTextSecondayColor, size: 16),
                  onPressed: () {
                    setState(
                      () {
                        selectedDate = DateTime(
                            selectedDate.year, selectedDate.month - 1, 1);
                      },
                    );
                  },
                ),
                SizedBox(
                  width: 95,
                  child: TextButton(
                    onPressed: () async {
                      // ignore: unused_local_variable, no_leading_underscores_for_local_identifiers
                      final DateTime? date = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );

                      if (date != null && date != selectedDate) {
                        setState(
                          () {
                            selectedDate = date;
                          },
                        );
                      }
                    },
                    child: Text(
                      DateFormat('MMM  yyyy').format(selectedDate),
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColor.ftTextSecondayColor),
                    ),
                  ),
                ),
                IconButton(
                  alignment: Alignment.centerLeft,
                  icon: const Icon(Icons.arrow_forward_ios,
                      color: AppColor.ftTextSecondayColor, size: 16),
                  onPressed: () {
                    setState(
                      () {
                        selectedDate = DateTime(
                            selectedDate.year, selectedDate.month + 1, 1);
                      },
                    );
                  },
                ),
              ],
            ),
            const Spacer(
              flex: 1,
            ),
            Row(
              children: [
                IconButton(
                  alignment: Alignment.centerRight,
                  icon: const Icon(Ionicons.swap_horizontal,
                      color: AppColor.ftTextSecondayColor, size: 18),
                  onPressed: () {
                    // Handle forward button press
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ViewAllScreen(),
                      ),
                    );
                  },
                ),
                IconButton(
                  // alignment: Alignment.centerRight,
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
      body: Column(
        children: [
          //------------------------------------Income, Expense and Balance Preview --------------------------
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.04,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.ftTransactionColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: AppColor.ftShadowColor,
                    spreadRadius: 0,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AccountsScreen()),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Wrap(
                        spacing: 10.0,
                        runSpacing: 10.0,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.09,
                            width: MediaQuery.of(context).size.width * 0.41,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColor.ftIncomeColor,
                              boxShadow: const [
                                BoxShadow(
                                  color: AppColor.ftShadowColor,
                                  spreadRadius: 0,
                                  blurRadius: 5,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),

                            // --------------------------Income-------------------------

                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    'Income',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: AppColor.ftTextSecondayColor,
                                      fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width >=
                                              300
                                          ? 16
                                          : MediaQuery.of(context).size.width *
                                              0.035,
                                    ),
                                  ),
                                ),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5, top: 2),
                                    child: Text(
                                      '25,000.00',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: AppColor.ftTextSecondayColor,
                                        fontSize:
                                            MediaQuery.of(context).size.width >=
                                                    300
                                                ? 20
                                                : MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.06,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //------------------------------Expense-------------------------

                          Container(
                            height: MediaQuery.of(context).size.height * 0.09,
                            width: MediaQuery.of(context).size.width * 0.41,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColor.ftExpenseColor,
                              boxShadow: const [
                                BoxShadow(
                                  color: AppColor.ftShadowColor,
                                  spreadRadius: 0,
                                  blurRadius: 5,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    'Expense',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: AppColor.ftTextSecondayColor,
                                      fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width >=
                                              300
                                          ? 16
                                          : MediaQuery.of(context).size.width *
                                              0.035,
                                    ),
                                  ),
                                ),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5, top: 2),
                                    child: Text(
                                      '2,780.00',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: AppColor.ftTextSecondayColor,
                                        fontSize:
                                            MediaQuery.of(context).size.width >=
                                                    300
                                                ? 20
                                                : MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.06,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // -------------------------------- Balance Start ----------------------------------------------
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LayoutBuilder(
                                builder: (BuildContext context,
                                    BoxConstraints constraints) {
                                  return FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Balance',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            // fontFamily:
                                            //     GoogleFonts.monda().fontFamily,
                                            color: AppColor.ftTextSecondayColor,
                                            fontSize: 20,
                                            // constraints.maxWidth >=
                                            //         480
                                            //     ? 20
                                            //     : constraints.maxWidth * 0.05,
                                            // textBaseline:
                                            //     TextBaseline.alphabetic,
                                          ),
                                        ),
                                        Text(
                                          '${currencySymboleUpdate.value} 22,220.00',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            // fontFamily:
                                            //     GoogleFonts.monda().fontFamily,
                                            color: AppColor.ftTextSecondayColor,
                                            // fontSize: constraints.maxWidth >=
                                            //         480
                                            //     ? 28
                                            //     : constraints.maxWidth * 0.12,
                                            fontSize: 35,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),

                      //       ------------------------------------Income, Expense and Balance Preview End --------------------------
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ----------------------------------- Transaction History ----------------------------------------
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 9),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: _transactionPreview.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.04,
                      // vertical: MediaQuery.of(context).size.height * 0.02,
                    ),
                    child: TransactionPreview(
                      child: _transactionPreview[index],
                    ),
                  );
                },
              ),
            ),
          ),
          // ----------------------------------- Transaction History End----------------------------------------
        ],
      ),
    );
  }
}
