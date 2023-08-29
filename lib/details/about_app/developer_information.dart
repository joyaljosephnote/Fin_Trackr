import 'package:fin_trackr/constants/constant.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class DeveloperInformation extends StatelessWidget {
  const DeveloperInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.ftScafoldColor,
      appBar: AppBar(
        backgroundColor: AppColor.ftScafoldColor,
        title: const Text(
          'Developer Info',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: RichText(
            text: TextSpan(
              children: <TextSpan>[
                const TextSpan(
                  text:
                      '''Welcome to our app! We're excited to introduce you to the developer behind this project.\n''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                  ),
                ),
                const TextSpan(
                  text: '\nMeet the Developer: ',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text: AppText.authorName,
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text: '\n\nRole: Flutter Developer',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                  ),
                ),
                const TextSpan(
                  text:
                      '\nBio: Joyal is a highly skilled Flutter developer with a passion for crafting stunning and intuitive user interfaces. With a strong background in mobile app development, Joyal brings creativity and expertise to the table. His dedication to understanding user behavior allows him to create an aesthetically pleasing app interface that delights users. Joyal takes pride in his work and collaborates closely with the team to ensure a seamless integration of design and functionality, resulting in an exceptional user experience.',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                  ),
                ),
                const TextSpan(
                  text: '\n\n\nDevelopment Philosophy: ',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text:
                      '''\n\nAt the core of our app development process is the belief in creating a user-centric platform. We value user feedback and take it seriously in shaping the app's future. Our goal is to provide a user-friendly and efficient app that meets the needs of our valued users. Joyal's expertise in Flutter development plays a crucial role in achieving this vision.''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                  ),
                ),
                const TextSpan(
                  text: '\n\n\nGet in Touch: ',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text:
                      '''\n\nWe'd love to hear from you! If you have any questions, suggestions, or feedback, please feel free to reach out to us at ''',
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
                  text:
                      '''. Your input is invaluable in helping us build an app that continuously evolves and improves.''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                  ),
                ),
                const TextSpan(
                  text:
                      '''\n\nThank you for choosing our app and being a part of our journey!''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                  ),
                ),
                const TextSpan(
                  text: '''\n\nSincerely,\nThe Development Team\n\n\n''',
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
      ),
    );
  }
}
