// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
//import 'package:velocity_x/velocity_x.dart';

import '../../../constant/app_strings.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Privacy Policy".tr,
        style: TextStyle(fontSize: 25.sp),
      )),
      body: Padding(
        padding: EdgeInsets.all(18.h),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                introEng.tr,
                style: TextStyle(
                  color: Colors.black,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 10.h,),
              Text(
                headingEng.tr,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontSize: 20.sp,
                ),
              ),
             // 15.h.heightBox,
              SizedBox(height: 15.h,),
              customDescriptionText(title: title1Eng, desc: desc1Eng),
              SizedBox(height: 10.h,),
              customDescriptionText(title: title2Eng, desc: desc2Eng),
              SizedBox(height: 10.h,),
              customDescriptionText(title: title3Eng, desc: desc3Eng),
               SizedBox(height: 10.h,),
              customDescriptionText(title: title4Eng, desc: desc4Eng),
               SizedBox(height: 10.h,),
              customDescriptionText(title: title5Eng, desc: desc5Eng),
               SizedBox(height: 10.h,),
              customDescriptionText(title: title6Eng, desc: desc6Eng),
               SizedBox(height: 10.h,),
              customDescriptionText(title: title7Eng, desc: desc7Eng),
              SizedBox(height: 10.h,),
              customDescriptionText(title: title8Eng, desc: desc8Eng),
              SizedBox(height: 10.h,),
              customDescriptionText(title: title8Eng, desc: desc8Eng),
              SizedBox(height: 10.h,),
              Text(
                conclusionEng.tr,
                style: TextStyle(color: Colors.black, fontSize: 16.sp),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget customDescriptionText({required String title, required String desc}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.tr,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
          ),
        ),
        SizedBox(height: 5.h,),
        Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: Text(
            desc.tr,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w300,
              fontSize: 16.sp,
            ),
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}