// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolmanager/constant/app_colors.dart';
import 'package:schoolmanager/constant/app_strings.dart';
import 'package:get/get.dart';
import 'package:schoolmanager/controllers/language_controller.dart';
import 'package:schoolmanager/vacation_module/views/bottom_nav_controller/pages/home/my_vac_orders.dart';
import 'package:schoolmanager/vacation_module/views/drawer_page/approve_travels.dart';
import 'package:schoolmanager/vacation_module/views/drawer_page/faq_screen.dart';
import 'package:schoolmanager/vacation_module/views/drawer_page/privacy_policy_screen.dart';
import 'package:schoolmanager/vacation_module/views/drawer_page/settings/settings_screen.dart';
import 'package:schoolmanager/vacation_module/views/drawer_page/support_screen.dart';
import 'package:schoolmanager/vacation_module/views/widgets/drawer_item.dart';

class DrawerScreen extends StatefulWidget {


  final bool isAdmin;

  const DrawerScreen({super.key, required this.isAdmin});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final controller = Get.put(LanguageControler());

    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: AppColors.scaffoldColor,
        child: Padding(
          padding: EdgeInsets.only(left: 20.w, top: 50.h, bottom: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Text(
               appName,
                style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 40.h),
              drawerItem(
                itemName: 'Support'.tr,
                onClick: () => Get.to(() => SupportScreen()),
              ),
              SizedBox(height: 10.h),
              drawerItem(
                itemName: 'Privacy'.tr,
                onClick: () => Get.to(() => PrivacyPolicyScreen()),
              ),
              SizedBox(height: 10.h),
              drawerItem(
                itemName: 'Faq'.tr,
                onClick: () => Get.to(
                  () => FaqScreen(),
                ),
              ),
              SizedBox(height: 10.h),
             drawerItem(
                itemName: 'My Bookings'.tr,
                onClick: () => Get.to(
                  () => MyVacationBookings(),
                ),
              ),
               SizedBox(height: 10.h),
              SizedBox(
                width: 150.w,
                child: ExpansionTile(
                  title: Text("Language".tr,style: TextStyle(fontSize: 20.sp),),
                  tilePadding: EdgeInsets.all(0.0),
                  childrenPadding: EdgeInsets.all(0.0),
                  children: [
                   
                    Obx(() {
                      return Row(
                        children: [
                          Radio(
                            value: "English",
                            groupValue: controller.selectedLanguage.value,
                            onChanged: (value) {
                              controller.changeLanguage(value);
                              Get.updateLocale(const Locale('en', 'US'));
                            },
                          ),
                          Text("English".tr),
                        ],
                      );
                    }),
                  ],
                ),
              ),
              Expanded(child: SizedBox()),
              InkWell(
                onTap: () => Get.to(() => SettingScreen()),
                child: Text(
                  "Settings".tr,

                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600,),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
