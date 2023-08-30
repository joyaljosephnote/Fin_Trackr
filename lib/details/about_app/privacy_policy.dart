import 'package:fin_trackr/constants/constant.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.ftScafoldColor,
      appBar: AppBar(
        backgroundColor: AppColor.ftScafoldColor,
        title: const Text(
          'Privacy Policy',
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
                  text: '\nPrivacy Policy \n',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text: '''\nEffective Date:  ${AppText.appUpdateDate}\n''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                  ),
                ),
                const TextSpan(
                  text: '\n1. Introduction\n',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text:
                      '''\nThank you for using ${AppText.appName} App, developed by ${AppText.companyName}. This Privacy Policy is designed to help you understand how we collect, use, and safeguard the information you provide to us through the App.\n''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                  ),
                ),
                const TextSpan(
                  text: '\n2. Information We Collect\n',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text: '\n2.1. Camera Access',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text:
                      '''\nThe App may request access to your device's camera to provide features that require image or video capture. We do not store or transmit any media captured through the camera without your explicit consent.\n''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                  ),
                ),
                const TextSpan(
                  text: '\n2.2. Internet Access',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text:
                      '''\nThe App may require internet access to function properly. We collect limited technical information, such as device identifiers, IP addresses, and browsing activity, solely for the purpose of improving App functionality and user experience..\n''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                  ),
                ),
                const TextSpan(
                  text: '\n2.3. Storage Access',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text:
                      '''\nThe App may require access to your device's storage to save user-generated content or app-related data. We do not access or retrieve personal files from your device without your permission.\n''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                  ),
                ),
                const TextSpan(
                  text: '\n2.4. Network Information',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text:
                      '''\nThe App may collect information about your device's network connections, such as Wi-Fi and cellular data connections, to optimize performance and ensure a stable user experience.\n''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                  ),
                ),
                const TextSpan(
                  text: '\n3. How We Use Your Information',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text: '\n3.1. Camera Data',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text:
                      '''\nCamera data collected by the App is used solely for the purpose of providing features that require image or video capture, such as [list specific features]. We do not share or distribute this data to third parties unless required by law.\n''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                  ),
                ),
                const TextSpan(
                  text: '\n3.2. Internet Data',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text:
                      '''\nInternet-related data, such as device identifiers and IP addresses, may be used to analyze trends, administer the App, track user engagement, and gather demographic information. This information is anonymized and aggregated for analytical purposes.\n''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                  ),
                ),
                const TextSpan(
                  text: '\n3.3. Storage Data',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text:
                      '''\nData stored on your device through the App remains under your control. We do not access, retrieve, or share personal files without your explicit consent.\n''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                  ),
                ),
                const TextSpan(
                  text: '\n3.4. Network Information',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text:
                      '''\nNetwork information is utilized to ensure seamless connectivity and optimize App performance. It is not used for any other purposes.\n''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                  ),
                ),
                const TextSpan(
                  text: '\n4. Third-Party Services',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text:
                      '''\n\nThe App may integrate with third-party services or APIs to enhance its functionality. These third parties may collect and process your data according to their own privacy policies. We encourage you to review the privacy policies of these third parties before using their services through the App.\n''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                  ),
                ),
                const TextSpan(
                  text: '\n5. Security',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text:
                      '''\n\nWe take reasonable measures to protect the information collected through the App from unauthorized access, alteration, disclosure, or destruction. However, no data transmission over the internet or electronic storage is completely secure, and we cannot guarantee absolute security.\n''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                  ),
                ),
                const TextSpan(
                  text: '\n' '''Contact Us''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text:
                      '''\n\nIf you have any questions about this Privacy Policy, You can contact by email: ''',
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
                      '''\n\nBy using the App, you agree to the terms of this Privacy Policy. If you do not agree with the terms outlined herein, please do not use the App.''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                  ),
                ),
                const TextSpan(
                  text: '''\n\n\n''',
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
