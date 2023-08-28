import 'package:fin_trackr/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class UserGuid extends StatefulWidget {
  const UserGuid({super.key});

  @override
  State<UserGuid> createState() => _UserGuidState();
}

class _UserGuidState extends State<UserGuid> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    final videoID = YoutubePlayer.convertUrlToId(videoURL);
    _controller = YoutubePlayerController(
      initialVideoId: videoID!,
      flags: const YoutubePlayerFlags(autoPlay: false),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.ftScafoldColor,
      appBar: AppBar(
        backgroundColor: AppColor.ftScafoldColor,
        title: const Padding(
          padding: EdgeInsets.only(left: 8),
          child: Text(
            'User guid',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 35,
                  ),
                  Text(
                    AppText.appName,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: AppColor.ftTextSecondayColor),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 192,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: YoutubePlayer(
                    controller: _controller,
                    showVideoProgressIndicator: true,
                    onReady: () => debugPrint('Ready'),
                    bottomActions: [
                      CurrentPosition(),
                      ProgressBar(isExpanded: true),
                      const PlaybackSpeedButton()
                    ],
                  ),
                ),
              ),
              RichText(
                text: const TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: '\nHome tab',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColor.ftTextTertiaryColor,
                        height: 1.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text:
                          '\n\n1. Check your history with various options\n\nYou can review your status by Calender, Monthly, and Summary\n\n2. View all transactions\n\nSearch icon: You can use search function to find your previous records more easily.\n\nFilter: You can get an overview of your monetary data based on income or expense categories.\n\nCalender view: The calendar view displays your income/expanse of the Today, Yesterday, Weekly view, Monthly view and Total view.',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColor.ftTextTertiaryColor,
                        height: 1.5,
                      ),
                    ),
                    TextSpan(
                      text: '\n\nStatistics tab',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColor.ftTextTertiaryColor,
                        height: 1.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text:
                          '\n\nThe Stats chart is divided into categories of income/expenses you have recorded.\nIt helps you to capture your income/spending patterns.\n\nTab the category from the doughnut chart to see the total amount and the monthly pattern.\n\nThe default settings is Monthly view. Tap Calender Icon and choose different filters.',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColor.ftTextTertiaryColor,
                        height: 1.5,
                      ),
                    ),
                    TextSpan(
                      text: '\n\nHow to add an income and expense',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColor.ftTextTertiaryColor,
                        height: 1.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: '\n\n1) Income',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColor.ftTextTertiaryColor,
                        height: 1.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text:
                          '''\n\nIn Home tab, tap "+" button to open up the page to record your income, expense data.\n\n1. Tap "Income" button. The input page for registering your income consists of:\n\n* Date\n* Account\n* Category \n* Amount \n* Note\n\nIt is mandatory to specify the account, category, and amount.''',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColor.ftTextTertiaryColor,
                        height: 1.5,
                      ),
                    ),
                    TextSpan(
                      text: '\n\n2) Expense',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColor.ftTextTertiaryColor,
                        height: 1.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text:
                          '''\n\n1. income/expense/transfer follows somewhat similar recording methods. \n\nJust like the income registration, tap "Expense" button. Fill in the information just like the income registration.\n\n* Date\n* Account\n* Category \n* Amount \n* Note\n\nYou can fill in the contents if you wish to specify the details of the spending that you have just recorded. Also, uploading picture like a receipt is possible.''',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColor.ftTextTertiaryColor,
                        height: 1.5,
                      ),
                    ),
                    TextSpan(
                      text: '\n\n3) Transfer',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColor.ftTextTertiaryColor,
                        height: 1.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text:
                          '''\n\nThe concept of "Transfer" in money manager is a transaction between your own accounts.''',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColor.ftTextTertiaryColor,
                        height: 1.5,
                      ),
                    ),
                    TextSpan(
                      text: '\n\nAccounts tab',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColor.ftTextTertiaryColor,
                        height: 1.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text:
                          '''\n\nYou can review the total values of your account.\n\nModify amount: Tap "+" button - You will see the page where you can choose the account group. Insert amount of the account, and then save.''',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColor.ftTextTertiaryColor,
                        height: 1.5,
                      ),
                    ),
                    TextSpan(
                      text: '\n\nSettings tab',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColor.ftTextTertiaryColor,
                        height: 1.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text:
                          '''\n\nCategory: You can also change the Category name / Category deletion at Income / Expense settings section.''',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColor.ftTextTertiaryColor,
                        height: 1.5,
                      ),
                    ),
                    TextSpan(
                      text:
                          '''\n\nCurrency: You can update the current currency symbol.\n\nReset App: Reseting app option will erase all your datas.''',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColor.ftTextTertiaryColor,
                        height: 1.5,
                      ),
                    ),
                    TextSpan(
                      text: '\n\n${AppText.appName} ',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColor.ftTextTertiaryColor,
                        height: 1.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text:
                          '''Help Center\nCopyright @ 2023 ${AppText.companyName}\n\n\n''',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColor.ftTextTertiaryColor,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
