import 'package:fin_trackr/constant/constant.dart';
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
                  text:
                      '''\nLast updated:  ${AppText.appUpdateDate} \nApp Version: ${AppText.appVersionNumber} \n''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                  ),
                ),
                const TextSpan(
                  text:
                      '\nThis Privacy Policy describes Our policies and procedures on the collection, use and disclosure of Your information when You use the Service and tells You about Your privacy rights and how the law protects You. We use Your Personal data to provide and improve the Service. By using the Service, you agree to the collection and use of information in accordance with this Privacy Policy. This Privacy Policy has been created with the help of the Free Privacy Policy Generator.',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                  ),
                ),
                const TextSpan(
                  text: '\n\n\nInterpretation and Definitions ',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text: '\n\nInterpretation',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text:
                      '\nThe words of which the initial letter is capitalized have meanings defined under the following conditions. The following definitions shall have the same meaning regardless of whether they appear in singular or in plural.',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                  ),
                ),
                const TextSpan(
                  text: '\n\nDefinitions',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text: '\nFor the purposes of this Privacy Policy:',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                  ),
                ),
                const TextSpan(
                  text:
                      '''\n\nAn "Account" refers to a unique and personalized account that is created for you to access our Service or specific parts of it. This account ensures a secure and tailored experience while using our platform. An "Affiliate" represents an entity that shares a significant level of control with another party, where "control" denotes ownership of 50% or more of the shares, equity interest, or other securities that have the authority to vote for the election of directors or other managing personnel. These affiliates may be related companies or organizations closely linked to us. The term "Application" refers to ${AppText.appName}, our software program designed to provide users with comprehensive financial tracking and management capabilities. It is through this application that users can access our services. In this context, "Company" refers to ${AppText.appName}, the entity responsible for providing the ${AppText.appName} Application and its associated services. The "Country" pertains to Kerala, India, the geographical location where our Company operates, and where our services are primarily offered. A "Device" denotes any electronic device capable of accessing our Service, such as computers, smartphones, tablets, or other similar digital devices. These devices enable users to interact with the ${AppText.appName} Application and avail themselves of its features and functionalities. "Personal Data" comprises information that is directly or indirectly related to an identified or identifiable individual. This may include details such as names, contact information, or any data that uniquely identifies a person. The term "Service" refers to the ${AppText.appName} Application and its functionalities provided by our Company to assist users in tracking and managing their finances effectively. A "Service Provider" is an external entity, either a company or an individual, that we engage to facilitate our Service or provide related services on behalf of the Company. These third-party entities may assist in aspects such as data processing, analysis, or support for the smooth functioning of the ${AppText.appName} Application.''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                  ),
                ),
                const TextSpan(
                  text: '\n\n\nCollecting and Using Your Personal Data',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text: '\n\nTypes of Data Collected:',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text:
                      '''\n\nPersonal Data: While using Our Service, we may ask You to provide Us with certain personally identifiable information that can be used to contact or identify You. Personally identifiable information may include, but is not limited to - First name and last name.\n\nUsage Data: Usage Data is collected automatically when using the Service. Usage Data may include information such as Your Device's Internet Protocol address (IP address), browser type, browser version, the pages of our Service that You visit, the time and date of Your visit, the time spent on those pages, unique device identifiers and other diagnostic data.\n\nWhen You access the Service by or through a mobile device, we may collect certain information automatically, including, but not limited to, the type of mobile device You use, your mobile device unique ID, the IP address of Your mobile device, Your mobile operating system, the type of mobile Internet browser You use, unique device identifiers and other diagnostic data.\n\nWe may also collect information that Your browser sends whenever You visit our Service or when You access the Service by or through a mobile device.''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                  ),
                ),
                const TextSpan(
                  text: '\n\n\nUse of Your Personal Data',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text:
                      '\n\nThe Company may use Personal Data for the following purposes:',
                  style: TextStyle(
                      fontSize: 13,
                      color: AppColor.ftTextTertiaryColor,
                      height: 1.5,
                      fontStyle: FontStyle.italic),
                ),
                const TextSpan(
                  text:
                      '''\n\nTo provide and maintain our Service, including to monitor the usage of our Service. \n\nTo manage Your Account: to manage Your registration as a user of the Service. The Personal Data You provide can give You access to different functionalities of the Service that are available to You as a registered user.\n\nFor the performance of a contract: the development, compliance and undertaking of the purchase contract for the products, items or services You have purchased or of any other contract with Us through the Service.\n\nTo contact You by email, telephone calls, SMS, or other equivalent forms of electronic communication, such as a mobile application's push notifications regarding updates or informative communications related to the functionalities, products or contracted services, including the security updates, when necessary or reasonable for their implementation.\n\nTo provide You with news, special offers and general information about other goods, services and events which we offer that are similar to those that you have already purchased or enquired about unless You have opted not to receive such information.\n\nTo manage Your requests: To attend and manage Your requests to Us.\n\nFor business transfers: We may use Your information to evaluate or conduct a merger, divestiture, restructuring, reorganization, dissolution, or other sale or transfer of some or all of Our assets, whether as a going concern or as part of bankruptcy, liquidation, or similar proceeding, in which Personal Data held by Us about our Service users is among the assets transferred.\n\nFor other purposes: We may use Your information for other purposes, such as data analysis, identifying usage trends, determining the effectiveness of our promotional campaigns and to evaluate and improve our Service, products, services, marketing and your experience.''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                  ),
                ),
                const TextSpan(
                  text:
                      '\n\nWe may share Your personal information in the following situations:',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const TextSpan(
                  text:
                      '''\n\nWith Service Providers: We may share Your personal information with Service Providers to monitor and analyse the use of our Service, to contact You.\n\nFor business transfers: We may share or transfer Your personal information in connection with, or during negotiations of, any merger, sale of Company assets, financing, or acquisition of all or a portion of Our business to another company.\n\nWith Affiliates: We may share Your information with Our affiliates, in which case we will require those affiliates to honor this Privacy Policy. Affiliates include Our parent company and any other subsidiaries, joint venture partners or other companies that We control or that are under common control with Us.\n\nWith business partners: We may share Your information with Our business partners to offer You certain products, services or promotions.\n\nWith other users: when You share personal information or otherwise interact in the public areas with other users, such information may be viewed by all users and may be publicly distributed outside.\n\nWith Your consent: We may disclose Your personal information for any other purpose with Your consent.''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                  ),
                ),
                const TextSpan(
                  text: '\n\n\nRetention of Your Personal Data',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text:
                      '''\n\nThe Company will retain Your Personal Data only for as long as is necessary for the purposes set out in this Privacy Policy. We will retain and use Your Personal Data to the extent necessary to comply with our legal obligations (for example, if we are required to retain your data to comply with applicable laws), resolve disputes, and enforce our legal agreements and policies.\n\nThe Company will also retain Usage Data for internal analysis purposes. Usage Data is generally retained for a shorter period of time, except when this data is used to strengthen the security or to improve the functionality of Our Service, or We are legally obligated to retain this data for longer time periods.''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                  ),
                ),
                const TextSpan(
                  text: '\n\n\nTransfer of Your Personal Data',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text:
                      '''\n\nYour information, including Personal Data, is processed at the Company's operating offices and in any other places where the parties involved in the processing are located. It means that this information may be transferred to — and maintained on — computers located outside of Your state, province, country or other governmental jurisdiction where the data protection laws may differ than those from Your jurisdiction.\n\nYour consent to this Privacy Policy followed by Your submission of such information represents Your agreement to that transfer.\n\nThe Company will take all steps reasonably necessary to ensure that Your data is treated securely and in accordance with this Privacy Policy and no transfer of Your Personal Data will take place to an organization or a country unless there are adequate controls in place including the security of Your data and other personal information.''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                  ),
                ),
                const TextSpan(
                  text: '\n\n\nDelete Your Personal Data',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text:
                      '''\n\nYou have the right to delete or request that We assist in deleting the Personal Data that We have collected about You.\n\nOur Service may give You the ability to delete certain information about You from within the Service.\n\nYou may update, amend, or delete Your information at any time by signing in to Your Account, if you have one, and visiting the account settings section that allows you to manage Your personal information. You may also contact Us to request access to, correct, or delete any personal information that You have provided to Us.\n\nPlease note, however, that We may need to retain certain information when we have a legal obligation or lawful basis to do so.''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                  ),
                ),
                const TextSpan(
                  text: '\n\n\nDisclosure of Your Personal Data',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text:
                      '''\n\nBusiness Transactions: If the Company is involved in a merger, acquisition or asset sale, Your Personal Data may be transferred. We will provide notice before Your Personal Data is transferred and becomes subject to a different Privacy Policy.\n\nLaw enforcement: Under certain circumstances, the Company may be required to disclose Your Personal Data if required to do so by law or in response to valid requests by public authorities (e.g. a court or a government agency).''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                  ),
                ),
                const TextSpan(
                  text: '\n\nOther legal requirements:',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const TextSpan(
                  text:
                      '''\n\nThe Company may disclose Your Personal Data in the good faith belief that such action is necessary to: Comply with a legal obligation, Protect and defend the rights or property of the Company, Prevent or investigate possible wrongdoing in connection with the Service, Protect the personal safety of Users of the Service or the public, Protect against legal liability''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                  ),
                ),
                const TextSpan(
                  text: '\n\n\nSecurity of Your Personal Data',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text:
                      '''\n\nThe security of Your Personal Data is important to Us, but remember that no method of transmission over the Internet, or method of electronic storage is 100% secure. While We strive to use commercially acceptable means to protect Your Personal Data, We cannot guarantee its absolute security.''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                  ),
                ),
                const TextSpan(
                  text: '\n\n\n' '''Children's Privacy''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text:
                      '''\n\nOur Service does not address anyone under the age of 13. We do not knowingly collect personally identifiable information from anyone under the age of 13. If You are a parent or guardian and You are aware that Your child has provided Us with Personal Data, please contact Us. If We become aware that We have collected Personal Data from anyone under the age of 13 without verification of parental consent, We take steps to remove that information from Our servers.\n\nIf We need to rely on consent as a legal basis for processing Your information and Your country requires consent from a parent, We may require Your parent's consent before We collect and use that information.''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                  ),
                ),
                const TextSpan(
                  text: '\n\n\n' '''Links to Other Websites''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text:
                      '''\n\nOur Service may contain links to other websites that are not operated by Us. If You click on a third party link, You will be directed to that third party's site. We strongly advise You to review the Privacy Policy of every site You visit.\n\nWe have no control over and assume no responsibility for the content, privacy policies or practices of any third party sites or services.''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                  ),
                ),
                const TextSpan(
                  text: '\n\n\n' '''Changes to this Privacy Policy''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text:
                      '''\n\nWe may update Our Privacy Policy from time to time. We will notify You of any changes by posting the new Privacy Policy on this page.\n\nWe will let You know via email and/or a prominent notice on Our Service, prior to the change becoming effective and update the "Last updated" date at the top of this Privacy Policy.\n\nYou are advised to review this Privacy Policy periodically for any changes. Changes to this Privacy Policy are effective when they are posted on this page.''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                  ),
                ),
                const TextSpan(
                  text: '\n\n\n' '''Contact Us''',
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
