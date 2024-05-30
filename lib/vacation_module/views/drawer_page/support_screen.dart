// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolmanager/constant/app_colors.dart';
import 'package:schoolmanager/constant/app_strings.dart';
import 'package:get/get.dart';
import 'package:schoolmanager/vacation_module/views/widgets/support_feild.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Support".tr,
          style: TextStyle(fontSize: 25.sp),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
        child: Column(
          children: [
            Text(
              supportMessageEng,
              style: TextStyle(
                fontSize: 18.sp,
              ),
              textAlign: TextAlign.justify,
            ),
            Divider(
              color: AppColors.textColor,
            ),
             supportField("Admin".tr, "Loveness"),
            supportField("Phone".tr, "+263 782 958 537"),
            supportField("Email".tr, "gzutravelagency@gmail.com"),
            supportField("Facebook".tr, "http://facebook.com/"),
          ],
        ),
      ),
    );
  }
}
