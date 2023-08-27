import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AppColor {
  static const Color ftScafoldColor = Color(0xFF141414);
  static const Color ftBottomNavigatorColor = Color(0xFF000000);
  static const Color ftBottomNavigatorSelectorColor = Color(0xFFEA4040);
  static const Color ftBottomNavigatorUnSelectorColor = Color(0xFF959191);
  static const Color ftWaveColor = Color(0xFFF9F9F9);
  static const Color ftPrimaryColor = Color(0xFF141414);
  static const Color ftSecondaryColor = Color(0xFF2348DD);
  static const Color ftTextLinkColor = Color(0xFF03A3FF);
  static const Color ftTextLinkColor2 = Color(0xFF016AA7);
  static const Color ftLodingSpinKitColor = Color(0xFF959191);
  static const Color ftTextPrimaryColor = Color(0xFFEA4040);
  static const Color ftTextSecondayColor = Color(0xFFFFFFFF);
  static const Color ftTextTertiaryColor = Color(0xFF9E9E9E);
  static const Color ftTextIncomeColor = Color(0xFF28C216);
  static const Color ftTextExpenseColor = Color.fromARGB(255, 255, 80, 80);
  static const Color ftTextTransferColor = Color(0xFF959191);
  static const Color ftTextQuaternaryColor = Color(0xFF000000);
  static const Color ftTextQuinaryColor = Color(0xFF7C73F6);
  static const Color ftAppBarColor = Color(0xFF000000);
  static const Color ftTransactionColor = Color(0xFF1B1B1B);
  static const Color ftShadowColor = Color.fromRGBO(0, 0, 0, 1);
  static const Color ftIncomeColor = Color(0xFF159707);
  static const Color ftExpenseColor = Color(0xFFAD0606);
  static const Color ftTransferColor = Color(0xFF959191);
  static const Color ftTabBarSelectorColor = Color(0xFFEA4040);
  static const Color ftPrimaryDividerColor = Color(0xFF000000);
  static const Color ftSecondaryDividerColor = Color(0xFF4C4C4C);
}

class AppText {
  static const String appName = 'FinTrackr';
  static const String appVersion = 'Version 1.0.0';
  static const String appVersionNumber = ' 1.0.0';
  static const String appUpdateDate = '27-Aug-2023';
  static const String appTermsConditonUpdateDate = '27-Aug-2023';
  static const String authorName = 'Joyal Joseph';
  static const String companyName = 'Hello Tech Malayalam';
  static const String website = 'www.hellotechmalayalam.com';
  static const String email = 'hellotechmalayalam@gmail.com';
  static const String linkedin = 'linkedin.com/in/joyaljoseph';
  static const String contactNumber = '+91 623 8189 424';
}

email() async {
  Uri url = Uri.parse('https://mail.google.com/mail/u/0/#inbox');
  if (await launchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

youTube() async {
  Uri url = Uri.parse('https://www.youtube.com/@HelloTechMalayalam');
  if (await launchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

linkidin() async {
  Uri url = Uri.parse('https://www.linkedin.com/in/joyaljoseph/');
  if (await launchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

instagram() async {
  Uri url = Uri.parse('https://www.instagram.com/hellotechmalayalam/');
  if (await launchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

facebook() async {
  Uri url = Uri.parse('https://www.facebook.com/hellotechmalayalamonline');
  if (await launchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

website() async {
  Uri url = Uri.parse('https://hellotechmalayalam.com');
  if (await launchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

gitHub() async {
  Uri url = Uri.parse('https://github.com/joyaljosephnote');
  if (await launchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

const videoURL = 'https://youtu.be/N7WB6w0GoH8';
//User guid video
