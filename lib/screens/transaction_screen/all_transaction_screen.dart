import 'package:fin_trackr/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import 'widget/transaction_preview.dart';

class ViewAllScreen extends StatefulWidget {
  const ViewAllScreen({super.key});

  @override
  State<ViewAllScreen> createState() => _ViewAllScreenState();
}

class _ViewAllScreenState extends State<ViewAllScreen> {
  ValueNotifier<bool> searchBarNotifier = ValueNotifier<bool>(false);
  var clearcontroller = TextEditingController();

  final _transactionPreview = [
    'Transaction 1',
    'Transaction 2',
    'Transaction 3',
    'Transaction 4',
    'Transaction 4',
    'Transaction 4',
  ];

  @override
  Widget build(BuildContext context) {
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
        ],
      ),
    );
  }
}
