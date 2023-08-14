import 'package:fin_trackr/constant/constant.dart';
import 'package:fin_trackr/db/functions/currency_function.dart';
import 'package:fin_trackr/db/functions/transaction_function.dart';
import 'package:fin_trackr/db/models/category/category_model_db.dart';
import 'package:fin_trackr/db/models/transactions/transaction_model_db.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class ViewAllScreen extends StatefulWidget {
  const ViewAllScreen({super.key});

  @override
  State<ViewAllScreen> createState() => _ViewAllScreenState();
}

class _ViewAllScreenState extends State<ViewAllScreen> {
  ValueNotifier<bool> searchBarNotifier = ValueNotifier<bool>(false);
  var clearcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refresh();
    return Scaffold(
      backgroundColor: AppColor.ftScafoldColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.ftScafoldColor,
        title: const Text(
          'All Transactions',
          style: TextStyle(fontSize: 18),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.sort_rounded)),
          IconButton(
              alignment: Alignment.centerLeft,
              onPressed: () {},
              icon: const Icon(Ionicons.calendar_outline, size: 22)),
        ],
      ),
      body: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.04,
                ),
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
                  child: ValueListenableBuilder<bool>(
                    valueListenable: searchBarNotifier,
                    builder: (context, boolValue, child) => Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Stack(
                            alignment: Alignment.centerRight,
                            children: [
                              TextField(
                                controller: clearcontroller,
                                onChanged: (value) {},
                                cursorColor: AppColor.ftTextSecondayColor,
                                style: const TextStyle(
                                    color: AppColor.ftTextSecondayColor),
                                decoration: const InputDecoration(
                                  suffixIcon: Icon(Ionicons.search_outline),
                                  suffixIconColor:
                                      AppColor.ftTabBarSelectorColor,
                                  hintText: 'Search',
                                  hintStyle: TextStyle(
                                      color: AppColor.ftTextTertiaryColor),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColor.ftSecondaryDividerColor,
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: searchBarNotifier.value,
                                child: IconButton(
                                  onPressed: () {
                                    clearcontroller.clear();
                                    setState(() {
                                      searchBarNotifier.value = false;
                                    });
                                  },
                                  icon: const Icon(
                                    Ionicons.close_circle_outline,
                                    color: AppColor.ftTabBarSelectorColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          ValueListenableBuilder(
            valueListenable: TransactionDB.instance.transactionListNotifier,
            builder: (context, newList, child) {
              return newList.isNotEmpty
                  ? Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 9),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.04,
                                // vertical: MediaQuery.of(context).size.height * 0.02,
                              ),
                              child: Padding(
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
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10, top: 10),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: AppColor
                                                        .ftTextLinkColor2,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(5),
                                                    ),
                                                  ),
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Text(
                                                      '12 Sat',
                                                      style: TextStyle(
                                                        color: AppColor
                                                            .ftTextSecondayColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 10),
                                                  child: Text(
                                                    '07. 2023',
                                                    style: TextStyle(
                                                      color: AppColor
                                                          .ftTextTertiaryColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                const Spacer(),
                                                const Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      '+ ₹ 25,000.00',
                                                      style: TextStyle(
                                                        color: AppColor
                                                            .ftTextIncomeColor,
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
                                                        color: AppColor
                                                            .ftTextExpenseColor,
                                                        fontSize: 13,
                                                        // fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            const Divider(
                                              color: AppColor
                                                  .ftSecondaryDividerColor,
                                              thickness: 2,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: TransactionsCategory(
                                          newList: newList,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  : Container(
                      alignment: Alignment.bottomCenter,
                      child: const Text(
                        "  No transactions yet !",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                      ),
                    );
            },
          ),
        ],
      ),
    );
  }
}

class TransactionsCategory extends StatelessWidget {
  const TransactionsCategory({
    required this.newList,
    super.key,
  });

  final List<TransactionModel> newList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: newList.length,
      itemBuilder: (context, index) {
        final data = newList[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: SizedBox(
                  width: 100,
                  child: Text(
                    data.category.name,
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
                    data.account.name.substring(0, 1).toUpperCase() +
                        data.account.name.substring(1).toLowerCase(),
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
                  data.categoryType == CategoryType.income
                      ? '+ ${currencySymboleUpdate.value} ${data.amount.toStringAsFixed(2)}'
                      : '- ${currencySymboleUpdate.value} ${data.amount}',
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
    );
  }
}
