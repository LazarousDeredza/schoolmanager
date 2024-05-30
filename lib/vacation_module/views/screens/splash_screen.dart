// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:schoolmanager/constant/constant.dart';
import 'package:schoolmanager/vacation_module/views/screens/vacation_home_screen.dart';

import '../../../constant/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 7), () {
         Get.to(() => VacationHomeScreen());
         print("Navigate now .....");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                "assets/logo/logo.png",
                height: 25,
                width: 25,
              ),
            ),
            CircularProgressIndicator(color: AppColors.splashScreenTextColor),
          ],
        ),
      ),
    );
  }
}