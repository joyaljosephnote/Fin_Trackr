import 'package:fin_trackr/constants/constant.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.ftScafoldColor,
      appBar: AppBar(
        backgroundColor: AppColor.ftScafoldColor,
        title: const Text(
          'Contact Us',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      const TextSpan(
                        text: '\nContact Us - ${AppText.companyName} ',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColor.ftTextTertiaryColor,
                          height: 1.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const TextSpan(
                        text: '\n\nHello there!',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColor.ftTextTertiaryColor,
                          height: 1.5,
                        ),
                      ),
                      const TextSpan(
                        text:
                            '''\n\nWe're thrilled to hear from you. If you have any questions, feedback, or suggestions related to the ${AppText.appName} app, please don't hesitate to get in touch. We appreciate your engagement and are dedicated to providing you with the best possible experience..''',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColor.ftTextTertiaryColor,
                          height: 1.5,
                        ),
                      ),
                      const TextSpan(
                        text: '\n\nContact Information:\n',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColor.ftTextTertiaryColor,
                          height: 1.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const TextSpan(
                        text: '''Email: ''',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColor.ftTextTertiaryColor,
                          height: 1.5,
                        ),
                      ),
                      TextSpan(
                        text: AppText.email,
                        style: const TextStyle(
                            color: AppColor.ftTextLinkColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            email();
                          },
                      ),
                      const TextSpan(
                        text: '''\nLinkidin: ''',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColor.ftTextTertiaryColor,
                          height: 1.5,
                        ),
                      ),
                      TextSpan(
                        text: AppText.linkedin,
                        style: const TextStyle(
                            color: AppColor.ftTextLinkColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            linkidin();
                          },
                      ),
                      const TextSpan(
                        text: '\n\nWebsite and Social Media:',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColor.ftTextTertiaryColor,
                          height: 1.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const TextSpan(
                        text:
                            '''\nFor more information about ${AppText.companyName} and its offerings, please visit our official website: ''',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColor.ftTextTertiaryColor,
                          height: 1.5,
                        ),
                      ),
                      TextSpan(
                        text: AppText.website,
                        style: const TextStyle(
                            color: AppColor.ftTextLinkColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            website();
                          },
                      ),
                      const TextSpan(
                        text:
                            '''\n\nStay connected with us on social media to stay up-to-date with the latest tech news, app updates, and tech-related tips.''',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColor.ftTextTertiaryColor,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        gitHub();
                      },
                      icon: const Icon(
                        Ionicons.logo_github,
                        color: AppColor.ftBottomNavigatorUnSelectorColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        youTube();
                      },
                      icon: const Icon(
                        Ionicons.logo_youtube,
                        color: AppColor.ftBottomNavigatorUnSelectorColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        instagram();
                      },
                      icon: const Icon(
                        Ionicons.logo_instagram,
                        color: AppColor.ftBottomNavigatorUnSelectorColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        facebook();
                      },
                      icon: const Icon(
                        Ionicons.logo_facebook,
                        color: AppColor.ftBottomNavigatorUnSelectorColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      text: const TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                ''''We're always here to assist you and provide you with the latest tech insights in Malayalam.\n\nThank you for being a part of the ''',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColor.ftTextTertiaryColor,
                              height: 1.5,
                            ),
                          ),
                          TextSpan(
                            text: AppText.companyName,
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColor.ftTextTertiaryColor,
                              height: 1.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: ''' Team\n\n''',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColor.ftTextTertiaryColor,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
