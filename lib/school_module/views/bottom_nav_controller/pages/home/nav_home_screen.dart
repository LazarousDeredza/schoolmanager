// ignore_for_file: prefer_const_constructors, prefer_is_empty

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolmanager/constant/app_colors.dart';
import 'package:get/get.dart';
import 'package:schoolmanager/school_module/constants/image_strings.dart';
import 'package:schoolmanager/school_module/services/firestore_services.dart';
import 'package:schoolmanager/school_module/views/widgets/nav_home_categories.dart';

import 'details_screen.dart';
import 'all_students.dart';

class NavHomeScreen extends StatefulWidget {
  const NavHomeScreen({super.key});

  @override
  State<NavHomeScreen> createState() => _NavHomeScreenState();
}

class _NavHomeScreenState extends State<NavHomeScreen> {
  final List _carouselImages = [
    'assets/images/img-1.png',
    'assets/images/img-2.png',
    'assets/images/img-3.png',
  ];

  final RxInt _currentIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            // !-----------------CarouselSlider---------------------
            StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return CarouselSlider(
                  options: CarouselOptions(
                    height: 180.h,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    viewportFraction: 1,
                    onPageChanged: (val, carouselPageChangedReason) {
                      setState(() {
                        _currentIndex.value = val;
                      });
                    },
                  ),
                  items: _carouselImages.map((image) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage(image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
            SizedBox(height: 5.h),
            Obx(
              () => DotsIndicator(
                dotsCount:
                    _carouselImages.length == 0 ? 1 : _carouselImages.length,
                position: _currentIndex.value.toInt(),
              ),
            ),
            // !---------------------All Package--------------
            navHomeCategories(
              "All Students",
              () => Get.to(
                () => SeeAllScreen(
                  query: 0,
                  all: true,
                  fees: false,
                  grade: false,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                height: 180.h,
                child: FutureBuilder<QuerySnapshot>(
                  future: FirestoreServices.getAllStudents(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasError) {
                      print("has error ....");
                      return Text("Error");
                    }
                    if (snapshot.hasData &&  parseData(snapshot.data).length>0) {
                      List<Map> items = parseData(snapshot.data);
                        print("has data ....");
                          print(items);
                      return AllStudentsWidget(items);
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      print("loading ....");
                      return Center(child: CircularProgressIndicator());
                                            

                    }
                     if (snapshot.connectionState == ConnectionState.done&& !snapshot.hasData) {
                     print("no data ....");
                      return Center(child: Text("No Data"));
                    }
                    return Text("No Data");
                  },
                ),
              ),
            ),

            SizedBox(height: 15.h),
            // !---------------------Top Place--------------
            navHomeCategories(
              "Grade 1",
              () => Get.to(
                () => SeeAllScreen(
                  query: 1,
                  all: false,
                  fees: false,
                  grade: true,
                ),
              ),
            ),
            //shamiso chivizhe
            SizedBox(height: 10.h),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                height:  200.h,
                child: FutureBuilder<QuerySnapshot>(
                  future: FirestoreServices.getStudentsbyGrade(1),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                     if (snapshot.hasError) {
                      print("has error ....");
                      return Text("Error");
                    }
                    if (snapshot.hasData &&  parseData(snapshot.data).length>0) {
                      List<Map> items = parseData(snapshot.data);
                        print("has data ....");
                          print(items);
                      return StudentsByGradeWidget(items);
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      print("loading ....");
                      return Center(child: CircularProgressIndicator());
                                            

                    }
                     if (snapshot.connectionState == ConnectionState.done&& !snapshot.hasData) {
                     print("no data ....");
                      return Center(child: Text("No Data"));
                    }
                    return Text("No Data");
                  },
                ),
              ),
            ),
            SizedBox(height: 25.h),
            navHomeCategories(
              "Grade 2",
              () => Get.to(
                () => SeeAllScreen(
                  query: 2,
                  all: false,
                  fees: false,
                  grade: true,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                height:  200.h,
                child: FutureBuilder<QuerySnapshot>(
                  future: FirestoreServices.getStudentsbyGrade(2),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                     if (snapshot.hasError) {
                      print("has error ....");
                      return Text("Error");
                    }
                    if (snapshot.hasData &&  parseData(snapshot.data).length>0) {
                      List<Map> items = parseData(snapshot.data);
                        print("has data ....");
                          print(items);
                      return StudentsByGradeWidget(items);
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      print("loading ....");
                      return Center(child: CircularProgressIndicator());
                                            

                    }
                     if (snapshot.connectionState == ConnectionState.done&& !snapshot.hasData) {
                     print("no data ....");
                      return Center(child: Text("No Data"));
                    }
                    return Text("No Data");
                  },
                ),
              ),
            ),
            SizedBox(height: 25.h),

            navHomeCategories(
              "Grade 3",
              () => Get.to(
                () => SeeAllScreen(
                  query: 3,
                  all: false,
                  fees: false,
                  grade: true,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                height:  200.h,
                child: FutureBuilder<QuerySnapshot>(
                  future: FirestoreServices.getStudentsbyGrade(3),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasError) {
                      print("has error ....");
                      return Text("Error");
                    }
                    if (snapshot.hasData &&  parseData(snapshot.data).length>0) {
                      List<Map> items = parseData(snapshot.data);
                        print("has data ....");
                          print(items);
                      return StudentsByGradeWidget(items);
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      print("loading ....");
                      return Center(child: CircularProgressIndicator());
                                            

                    }
                     if (snapshot.connectionState == ConnectionState.done&& !snapshot.hasData) {
                     print("no data ....");
                      return Center(child: Text("No Data"));
                    }
                    return Text("No Data");
                  },
                ),
              ),
            ),
            SizedBox(height: 25.h),

            navHomeCategories(
              "Grade 4",
              () => Get.to(
                () => SeeAllScreen(
                  query: 4,
                  all: false,
                  fees: false,
                  grade: true,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                height: 200.h,
                child: FutureBuilder<QuerySnapshot>(
                  future: FirestoreServices.getStudentsbyGrade(4),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasError) {
                      print("has error ....");
                      return Text("Error");
                    }
                    if (snapshot.hasData &&  parseData(snapshot.data).length>0) {
                      List<Map> items = parseData(snapshot.data);
                        print("has data ....");
                          print(items);
                      return StudentsByGradeWidget(items);
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      print("loading ....");
                      return Center(child: CircularProgressIndicator());
                                            

                    }
                     if (snapshot.connectionState == ConnectionState.done&& !snapshot.hasData) {
                     print("no data ....");
                      return Center(child: Text("No Data"));
                    }
                    return Text("No Data");
                  },
                ),
              ),
            ),
            SizedBox(height: 25.h),

            navHomeCategories(
              "Grade 5",
              () => Get.to(
                () => SeeAllScreen(
                  query: 5,
                  all: false,
                  fees: false,
                  grade: true,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                height: 200.h,
                child: FutureBuilder<QuerySnapshot>(
                  future: FirestoreServices.getStudentsbyGrade(5),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasError) {
                      print("has error ....");
                      return Text("Error");
                    }
                    if (snapshot.hasData &&  parseData(snapshot.data).length>0) {
                      List<Map> items = parseData(snapshot.data);
                        print("has data ....");
                          print(items);
                      return StudentsByGradeWidget(items);
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      print("loading ....");
                      return Center(child: CircularProgressIndicator());
                                            

                    }
                     if (snapshot.connectionState == ConnectionState.done&& !snapshot.hasData) {
                     print("no data ....");
                      return Center(child: Text("No Data"));
                    }
                    return Text("No Data");
                  },
                ),
              ),
            ),
            SizedBox(height: 25.h),

            navHomeCategories(
              "Grade 6",
              () => Get.to(
                () => SeeAllScreen(
                  query: 6,
                  all: false,
                  fees: false,
                  grade: true,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                height: 200.h,
                child: FutureBuilder<QuerySnapshot>(
                  future: FirestoreServices.getStudentsbyGrade(6),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                     if (snapshot.hasError) {
                      print("has error ....");
                      return Text("Error");
                    }
                    if (snapshot.hasData &&  parseData(snapshot.data).length>0) {
                      List<Map> items = parseData(snapshot.data);
                        print("has data ....");
                          print(items);
                      return StudentsByGradeWidget(items);
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      print("loading ....");
                      return Center(child: CircularProgressIndicator());
                                            

                    }
                     if (snapshot.connectionState == ConnectionState.done&& !snapshot.hasData) {
                     print("no data ....");
                      return Center(child: Text("No Data"));
                    }
                    return Text("No Data");
                  },
                ),
              ),
            ),
            SizedBox(height: 25.h),
            navHomeCategories(
              "Grade 7",
              () => Get.to(
                () => SeeAllScreen(
                  query: 7,
                  all: false,
                  fees: false,
                  grade: true,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                height: 200.h,
                child: FutureBuilder<QuerySnapshot>(
                  future: FirestoreServices.getStudentsbyGrade(7),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                     if (snapshot.hasError) {
                      print("has error ....");
                      return Text("Error");
                    }
                    if (snapshot.hasData &&  parseData(snapshot.data).length>0) {
                      List<Map> items = parseData(snapshot.data);
                        print("has data ....");
                          print(items);
                      return StudentsByGradeWidget(items);
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      print("loading ....");
                      return Center(child: CircularProgressIndicator());
                                            

                    }
                     if (snapshot.connectionState == ConnectionState.done&& !snapshot.hasData) {
                     print("no data ....");
                      return Center(child: Text("No Data"));
                    }
                    return Text("No Data");
                  },
                ),
              ),
            ),
            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }
}

List<Map> parseData(QuerySnapshot querySnapshot) {
  List<QueryDocumentSnapshot> listDocs = querySnapshot.docs;
  List<Map> listItems = listDocs
      .map((e) => {
            'id': e['id']??0,
            'name': e['name'],
            'dob': e['dob'],
            'feesPaid':e['feesPaid'],
            'grade': e['grade'],
            'email': e['email'],
            'class': e['class'],
            'phoneNumber': e['phoneNumber'],
            'address': e['address'],
            'date_time':e['date_time'],
            'parentName': e['parentName'],
            'parentPhoneNumber': e['parentPhoneNumber'],
          })
      .toList();
  return listItems;
}

ListView AllStudentsWidget(List<Map<dynamic, dynamic>> items) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: items.length,
    itemBuilder: (_, index) {
      Map thisItem = items[index];
      return Padding(
        padding: EdgeInsets.only(right: 12.w),
        child: InkWell(
          onTap: () => Get.to(
            () => DetailsScreen(detailsData: thisItem),
          ),
          child: Container(
            width: 130.w,
            height: 200.h,
            decoration: BoxDecoration(
              color: Color(0xFfC4C4C4),
              borderRadius: BorderRadius.all(
                Radius.circular(7.r),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(7.r),
                    topRight: Radius.circular(7.r),
                  ),
                  child: Image.asset(
                    imagesUrls[0],
                    height: 60.h,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Center(
                    child: Text(
                      thisItem['name'],
                      style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.bold),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  "Grade : ${thisItem['grade']}",
                  style:
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  "Class : ${thisItem['class']}",
                  style:
                      TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 1.h,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

ListView StudentsByGradeWidget(List<Map<dynamic, dynamic>> items) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: items.length,
    itemBuilder: (_, index) {
      Map thisItem = items[index];
      return Padding(
        padding: EdgeInsets.only(right: 12.w),
        child: InkWell(
          onTap: () => Get.to(
            () => DetailsScreen(detailsData: thisItem),
          ),
          child: Container(
            width: 130.w,
            height: 200.h,
            decoration: BoxDecoration(
              color: Color(0xFfC4C4C4),
              borderRadius: BorderRadius.all(
                Radius.circular(7.r),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(7.r),
                    topRight: Radius.circular(7.r),
                  ),
                  child: Image.asset(
                    imagesUrls[0],
                    height: 60.h,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Center(
                    child: Text(
                      thisItem['name'],
                      style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.bold),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  "Grade : ${thisItem['grade']}",
                  style:
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  "Class : ${thisItem['class']}",
                  style:
                      TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 1.h,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
