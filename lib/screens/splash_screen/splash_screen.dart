import 'package:fin_trackr/constant/constant.dart';
import 'package:fin_trackr/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
    await Future.delayed(const Duration(seconds: 4), () {});
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
    return Scaffold(
      body: Container(
        color: AppColor.ftScafoldColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppText.appName,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.ubuntu().fontFamily,
                  color: AppColor.ftWaveColor,
                ),
              ),
              const SizedBox(height: 30),
              Container(
                color: AppColor.ftScafoldColor,
                child: const Center(
                  child: SpinKitThreeBounce(
                    size: 10,
                    color: AppColor.ftLodingSpinKitColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
