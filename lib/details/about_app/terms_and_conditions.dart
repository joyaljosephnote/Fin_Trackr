import 'package:fin_trackr/constants/constant.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.ftScafoldColor,
      appBar: AppBar(
        backgroundColor: AppColor.ftScafoldColor,
        title: const Text(
          'Terms and Conditions',
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
                  text: '\nTerms and Conditions ',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text:
                      '\n\nLast updated: ${AppText.appTermsConditonUpdateDate}',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                  ),
                ),
                const TextSpan(
                  text:
                      '\nPlease read these terms and conditions carefully before using Our Service.',
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
                  text: '\n\nInterpretation ',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text:
                      '''\nThe words of which the initial letter is capitalized have meanings defined under the following conditions. The following definitions shall have the same meaning regardless of whether they appear in singular or in plural.''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                  ),
                ),
                const TextSpan(
                  text: '\n\nDefinitions ',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text: '\nFor the purposes of these Terms and Conditions:\n',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const TextSpan(
                  text:
                      '''\nApplication means the software program provided by the Company downloaded by You on any electronic device, named ${AppText.appName}\n\nApplication Store means the digital distribution service operated and developed by Apple Inc. (Apple App Store) or Google Inc. (Google Play Store) in which the Application has been downloaded.\n\nAffiliate means an entity that controls, is controlled by or is under common control with a party, where "control" means ownership of 50% or more of the shares, equity interest or other securities entitled to vote for election of directors or other managing authority.\n\nCountry refers to: Kerala, India\n\nCompany (referred to as either "the Company", "We", "Us" or "Our" in this Agreement) refers to ${AppText.appName}.\n\nDevice means any device that can access the Service such as a computer, a cell phone or a digital tablet.\n\nService refers to the Application.\n\nTerms and Conditions (also referred as "Terms") mean these Terms and Conditions that form the entire agreement between You and the Company regarding the use of the Service. This Terms and Conditions agreement has been created with the help of the Free Terms and Conditions Generator.\n\nThird-party Social Media Service means any services or content (including data, information, products or services) provided by a third-party that may be displayed, included or made available by the Service.\n\nYou means the individual accessing or using the Service, or the company, or other legal entity on behalf of which such individual is accessing or using the Service, as applicable.''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                  ),
                ),
                const TextSpan(
                  text: '''\n\n\nAcknowledgment''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text:
                      '''\n\nThese are the Terms and Conditions governing the use of this Service and the agreement that operates between You and the Company. These Terms and Conditions set out the rights and obligations of all users regarding the use of the Service.\n\nYour access to and use of the Service is conditioned on Your acceptance of and compliance with these Terms and Conditions. These Terms and Conditions apply to all visitors, users and others who access or use the Service.\n\nBy accessing or using the Service You agree to be bound by these Terms and Conditions. If You disagree with any part of these Terms and Conditions then You may not access the Service.\n\nYou represent that you are over the age of 18. The Company does not permit those under 18 to use the Service.\n\nYour access to and use of the Service is also conditioned on Your acceptance of and compliance with the Privacy Policy of the Company. Our Privacy Policy describes Our policies and procedures on the collection, use and disclosure of Your personal information when You use the Application or the Website and tells You about Your privacy rights and how the law protects You. Please read Our Privacy Policy carefully before using Our Service.''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                  ),
                ),
                const TextSpan(
                  text: '''\n\n\nLinks to Other Websites''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text:
                      '''\n\nOur Service may contain links to third-party web sites or services that are not owned or controlled by the Company.\n\nThe Company has no control over, and assumes no responsibility for, the content, privacy policies, or practices of any third party web sites or services. You further acknowledge and agree that the Company shall not be responsible or liable, directly or indirectly, for any damage or loss caused or alleged to be caused by or in connection with the use of or reliance on any such content, goods or services available on or through any such web sites or services.\n\nWe strongly advise You to read the terms and conditions and privacy policies of any third-party web sites or services that You visit.''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                  ),
                ),
                const TextSpan(
                  text: '''\n\n\nTermination''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text:
                      '''\n\nWe may terminate or suspend Your access immediately, without prior notice or liability, for any reason whatsoever, including without limitation if You breach these Terms and Conditions.\n\nUpon termination, Your right to use the Service will cease immediately.''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                  ),
                ),
                const TextSpan(
                  text: '''\n\n\nLimitation of Liability''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text:
                      '''\n\nNotwithstanding any damages that You might incur, the entire liability of the Company and any of its suppliers under any provision of this Terms and Your exclusive remedy for all of the foregoing shall be limited to the amount actually paid by You through the Service or 100 USD if You haven't purchased anything through the Service.\n\nTo the maximum extent permitted by applicable law, in no event shall the Company or its suppliers be liable for any special, incidental, indirect, or consequential damages whatsoever (including, but not limited to, damages for loss of profits, loss of data or other information, for business interruption, for personal injury, loss of privacy arising out of or in any way related to the use of or inability to use the Service, third-party software and/or third-party hardware used with the Service, or otherwise in connection with any provision of this Terms), even if the Company or any supplier has been advised of the possibility of such damages and even if the remedy fails of its essential purpose.\n\nSome states do not allow the exclusion of implied warranties or limitation of liability for incidental or consequential damages, which means that some of the above limitations may not apply. In these states, each party's liability will be limited to the greatest extent permitted by law.\n\n"AS IS" and "AS AVAILABLE" Disclaimer\n\nThe Service is provided to You "AS IS" and "AS AVAILABLE" and with all faults and defects without warranty of any kind. To the maximum extent permitted under applicable law, the Company, on its own behalf and on behalf of its Affiliates and its and their respective licensors and service providers, expressly disclaims all warranties, whether express, implied, statutory or otherwise, with respect to the Service, including all implied warranties of merchantability, fitness for a particular purpose, title and non-infringement, and warranties that may arise out of course of dealing, course of performance, usage or trade practice. Without limitation to the foregoing, the Company provides no warranty or undertaking, and makes no representation of any kind that the Service will meet Your requirements, achieve any intended results, be compatible or work with any other software, applications, systems or services, operate without interruption, meet any performance or reliability standards or be error free or that any errors or defects can or will be corrected.\n\nWithout limiting the foregoing, neither the Company nor any of the company's provider makes any representation or warranty of any kind, express or implied: (i) as to the operation or availability of the Service, or the information, content, and materials or products included thereon; (ii) that the Service will be uninterrupted or error-free; (iii) as to the accuracy, reliability, or currency of any information or content provided through the Service; or (iv) that the Service, its servers, the content, or e-mails sent from or on behalf of the Company are free of viruses, scripts, trojan horses, worms, malware, timebombs or other harmful components.\n\nSome jurisdictions do not allow the exclusion of certain types of warranties or limitations on applicable statutory rights of a consumer, so some or all of the above exclusions and limitations may not apply to You. But in such a case the exclusions and limitations set forth in this section shall be applied to the greatest extent enforceable under applicable law.''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                  ),
                ),
                const TextSpan(
                  text: '''\n\n\nGoverning Law''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text:
                      '''\n\nThe laws of the Country, excluding its conflicts of law rules, shall govern this Terms and Your use of the Service. Your use of the Application may also be subject to other local, state, national, or international laws.''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                  ),
                ),
                const TextSpan(
                  text: '''\n\n\nDisputes Resolution''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text:
                      '''\n\nIf You have any concern or dispute about the Service, You agree to first try to resolve the dispute informally by contacting the Company.''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                  ),
                ),
                const TextSpan(
                  text: '''\n\n\nFor European Union (EU) Users''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text:
                      '''\n\nIf You are a European Union consumer, you will benefit from any mandatory provisions of the law of the country in which you are resident in.''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                  ),
                ),
                const TextSpan(
                  text: '''\n\n\nSeverability and Waiver''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text: '''\n\nSeverability''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text:
                      '''\nIf any provision of these Terms is held to be unenforceable or invalid, such provision will be changed and interpreted to accomplish the objectives of such provision to the greatest extent possible under applicable law and the remaining provisions will continue in full force and effect.''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                  ),
                ),
                const TextSpan(
                  text: '''\n\nWaiver''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text:
                      '''\nExcept as provided herein, the failure to exercise a right or to require performance of an obligation under these Terms shall not effect a party's ability to exercise such right or require such performance at any time thereafter nor shall the waiver of a breach constitute a waiver of any subsequent breach.''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                  ),
                ),
                const TextSpan(
                  text: '''\n\n\nTranslation Interpretation''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text:
                      '''\n\nThese Terms and Conditions may have been translated if We have made them available to You on our Service. You agree that the original English text shall prevail in the case of a dispute.''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                  ),
                ),
                const TextSpan(
                  text: '''\n\n\nChanges to These Terms and Conditions''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text:
                      '''\n\nWe reserve the right, at Our sole discretion, to modify or replace these Terms at any time. If a revision is material We will make reasonable efforts to provide at least 30 days' notice prior to any new terms taking effect. What constitutes a material change will be determined at Our sole discretion.\n\nBy continuing to access or use Our Service after those revisions become effective, You agree to be bound by the revised terms. If You do not agree to the new terms, in whole or in part, please stop using the website and the Service.''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                  ),
                ),
                const TextSpan(
                  text: '\n\n\nContact Us',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text:
                      '''\n\nIf you have any questions about these Terms and Conditions, You can contact us:\n\nBy email: ''',
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
                  text: '''.''',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.ftTextTertiaryColor,
                    height: 1.5,
                  ),
                ),
                const TextSpan(
                  text: '''\n\n\n\n''',
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
