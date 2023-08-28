import 'package:fin_trackr/constant/constant.dart';
import 'package:fin_trackr/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateHome();
  }

  _navigateHome() async {
    await Future.delayed(const Duration(seconds: 2), () {});
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HoemeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.ftScafoldColor,
      body: Container(
        color: AppColor.ftScafoldColor,
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: size.width,
                child: Text(
                  AppText.appName,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.ubuntu().fontFamily,
                    color: AppColor.ftWaveColor,
                  ),
                ),
              ),
              Positioned(
                bottom: 35,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 25,
                          height: 25,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/image/appLogo.png'),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          height: 30,
                          child: Column(
                            children: [
                              const Text(
                                'from  ',
                                style: TextStyle(
                                  height: 1.1,
                                  fontSize: 12,
                                  color: AppColor.ftTextTertiaryColor,
                                ),
                              ),
                              Text(
                                'Hello Tech',
                                style: TextStyle(
                                  height: 1.2,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: GoogleFonts.ubuntu().fontFamily,
                                  color: AppColor.ftTextTertiaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
