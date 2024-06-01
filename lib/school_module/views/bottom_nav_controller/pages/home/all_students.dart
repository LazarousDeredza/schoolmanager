// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_typing_uninitialized_variables, unused_field

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolmanager/constant/app_colors.dart';
import 'package:get/get.dart';
import 'package:schoolmanager/constant/constant.dart';
import 'package:schoolmanager/school_module/constants/image_strings.dart';
import 'package:schoolmanager/school_module/services/firestore_services.dart';
import 'package:schoolmanager/school_module/views/bottom_nav_controller/pages/home/nav_home_screen.dart';
import 'package:schoolmanager/school_module/views/drawer_page/settings/update_screen.dart';

import 'details_screen.dart';

class SeeAllScreen extends StatefulWidget {
  var query;
  bool grade;
  bool all;
  bool fees;
  SeeAllScreen(
      {super.key,
      required this.query,
      required this.all,
      required this.fees,
      required this.grade});

  @override
  State<SeeAllScreen> createState() => _SeeAllScreenState();
}

class _SeeAllScreenState extends State<SeeAllScreen> {
  //collectionName
  final CollectionReference _refference = firestore.collection('all-students');

  //queryName
  late Future<QuerySnapshot> _futureAllStudents;
  late Future<QuerySnapshot> _futureGetStudentsByFees;
  late Future<QuerySnapshot> _futureGetStudentsByNotFullFees;

  late Future<QuerySnapshot> _futureGetStudentByGrade;

  @override
  void initState() {
    _futureAllStudents = FirestoreServices.getAllStudents();

    _futureGetStudentByGrade =
        FirestoreServices.getStudentsbyGrade(widget.query);

    _futureGetStudentsByFees =
        FirestoreServices.getStudentsByFees(widget.query);

    _futureGetStudentsByNotFullFees =
        FirestoreServices.getStudentsByFeesNotFull(widget.query);

    super.initState();
  }

  condition() {
    if (widget.query == 0 && widget.all) {
      return _futureAllStudents;
    } else if (widget.grade) {
      return _futureGetStudentByGrade;
    } else if (widget.fees && widget.query == 300) {
      return _futureGetStudentsByFees;
    } else if (widget.fees && widget.query < 300) {
      return _futureGetStudentsByNotFullFees;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        title: Text(
          "Students".tr,
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: FutureBuilder<QuerySnapshot>(
          future: condition(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return Text("Error");
            }
            if (snapshot.hasData) {
              List<Map> items = parseData(snapshot.data);
              return forYouBuildGridview(items);
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

GridView forYouBuildGridview(List<Map<dynamic, dynamic>> itemList) {
  return GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.7),
    itemCount: itemList.length,
    itemBuilder: (_, i) {
      Map thisItem = itemList[i];
      return InkWell(
        onTap: () => Get.to(
          () => DetailsScreen(detailsData: thisItem),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[500],
            borderRadius: BorderRadius.all(
              Radius.circular(7.r),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(7.r),
                  topRight: Radius.circular(7.r),
                ),
                child: Image.asset(
                  imagesUrls[0],
                  height: 80.h,
                  width: 80.h,
                  fit: BoxFit.fill,
                  filterQuality: FilterQuality.high,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  thisItem['name'],
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: Color.fromARGB(255, 59, 80, 27),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Text(
                "Grade : ${thisItem['grade']}",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                "Class : ${thisItem['class']}",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                "Fees Paid : \$${thisItem['feesPaid']}",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                      onPressed: () {
                        Get.to(() => UpdateScreen(detailsData: thisItem,));
                      },
                      child: Text("Update")),
                  IconButton(
                      onPressed: () {
                        Get.to(() => UpdateScreen(detailsData: thisItem,));
                      },
                      icon: Icon(Icons.edit))
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
