// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:schoolmanager/home/constant/app_colors.dart';
import 'package:get/get.dart';
import 'package:schoolmanager/constant/app_colors.dart';
//import 'package:velocity_x/velocity_x.dart';

import '../../../constant/app_strings.dart';

class ApproveTravels extends StatelessWidget {
  const ApproveTravels({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(18.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
                  Center(
                    child: Text(
                      'Faq',
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w500,
                    
                        color: Colors.blue,
                      ),
                    ),
                  ),
              SizedBox(height: 40.h,),
              customExpansionTile(
                  title: faqTitle1.tr, description: faqDescription1.tr),
              SizedBox(height: 5.h,),
              Divider(),
              SizedBox(height: 5.h,),
              SizedBox(height: 5.h,),
              customExpansionTile(
                  title: faqTitle2.tr, description: faqDescription2.tr),
              SizedBox(height: 5.h,),
              Divider(),
             SizedBox(height: 5.h,),
              customExpansionTile(
                  title: faqTitle3.tr, description: faqDescription3.tr),
              SizedBox(height: 5.h,),
              Divider(),
              SizedBox(height: 5.h,),
              customExpansionTile(
                  title: faqTitle4.tr, description: faqDescription4.tr),
             SizedBox(height: 5.h,),
              Divider(),
              SizedBox(height: 5.h,),
              customExpansionTile(
                  title: faqTitle5.tr, description: faqDescription5.tr),
            ],
          ),
        ),
      ),
    );
  }

  ExpansionTile customExpansionTile(
      {required String title, required String description}) {
    return ExpansionTile(
      backgroundColor: AppColors.scaffoldColor,
      collapsedTextColor: AppColors.textColor,
      iconColor: AppColors.textColor,
      textColor: AppColors.textColor,
      childrenPadding: EdgeInsets.all(10.h),
      title: Text(title),
      children: [
        Text(description,style: TextStyle(color: Colors.black),)
        ],
    );
  }
}