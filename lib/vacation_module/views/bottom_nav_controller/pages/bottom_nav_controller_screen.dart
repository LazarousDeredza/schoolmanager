// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_final_fields, depend_on_referenced_packages

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:schoolmanager/constant/app_strings.dart';
import 'package:get/get.dart';
import 'package:schoolmanager/constant/constant.dart';
import 'package:intl/intl.dart' as intl;
import '../../../../constant/app_colors.dart';

class BottomNavControllerScreen extends StatefulWidget {
  final bool isAdmin;


  BottomNavControllerScreen({super.key, required this.isAdmin});

  @override
  State<BottomNavControllerScreen> createState() => _BottomNavControllerScreenState();
}

class _BottomNavControllerScreenState extends State<BottomNavControllerScreen> {
  RxInt _currentIndex = 0.obs;

  RxBool _drawer = false.obs;

  @override
  Widget build(BuildContext context) {


    return Obx(
      () => AnimatedPositioned(
        duration: Duration(milliseconds: 400),
        top: _drawer.value == false ? 0 : 100.h,
        bottom: _drawer.value == false ? 0 : 100.h,
        left: _drawer.value == false ? 0 : 200.w,
        right: _drawer.value == false ? 0 : -100.w,
        child: Container(
          decoration: BoxDecoration(),
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                appName,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 20),
              ),
              leading: _drawer.value == false
                  ? IconButton(
                      onPressed: () {
                        _drawer.value = true;
                      },
                      icon: Icon(
                        Icons.menu,
                        color: Colors.black,
                      ),
                    )
                  : IconButton(
                      onPressed: () {
                        _drawer.value = false;
                      },
                      icon: Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                    ),
              actions: [
                Center(
                  child: Text(
                    intl.DateFormat('EEE, MMM d, ' 'yy').format(DateTime.now()),
                    style:
                        TextStyle(color: AppColors.textColor, fontSize: 18.sp),
                  ),
                ),
                SizedBox(width: 15.w),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: AppColors.scaffoldColor,
              selectedItemColor: AppColors.textColor,
              elevation: 0,
              onTap: (value) {
                if(value==1 && !widget.isAdmin){
                  
                  showDialogBox("Permission Denied","Only Admin can use this function");
                  return;
                }
                 _currentIndex.value = value;
              },
              currentIndex: _currentIndex.value,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_outlined,
                    size: 30,
                  ),
                  label: "Home".tr,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add),
                  label: "Add".tr,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: "Settings".tr,
                ),
              ],
            ),
            body: pages[_currentIndex.value],
          ),
        ),
      ),
    );
  }

  showDialogBox(String title, String message) => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'Cancel');
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
}