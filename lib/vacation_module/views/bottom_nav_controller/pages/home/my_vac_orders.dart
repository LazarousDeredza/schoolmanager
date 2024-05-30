// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_typing_uninitialized_variables, unused_field

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:schoolmanager/constant/app_colors.dart';
import 'package:get/get.dart';
import 'package:schoolmanager/constant/constant.dart';
import 'package:schoolmanager/vacation_module/services/firestore_services.dart';
import 'package:schoolmanager/vacation_module/views/bottom_nav_controller/pages/home/nav_home_screen.dart';
import 'package:schoolmanager/vacation_module/views/bottom_nav_controller/pages/onebookingdetails_screen.dart';

import 'details_screen.dart';

class MyVacationBookings extends StatefulWidget {

  MyVacationBookings({super.key});

  @override
  State<MyVacationBookings> createState() => _MyVacationBookingsState();
}

class _MyVacationBookingsState extends State<MyVacationBookings> {
  //collectionName
 // final CollectionReference _refference = firestore.collection('all-data');

  //queryName
  late Future<QuerySnapshot> _futureDataForYour;

  @override
  void initState() {
    _futureDataForYour = FirestoreServices.getMyBookings();

    super.initState();
  }

  condition() {
      return _futureDataForYour;
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        title: Text(
          "Your Bookings".tr,
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
              List<Map> items = parseData2(snapshot.data);
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
        crossAxisCount: 1,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.9),
    itemCount: itemList.length,
    itemBuilder: (_, i) {
      Map thisItem = itemList[i];
      return InkWell(
        onTap: () => Get.to(
          () => OneBookingDetailsScreen(detailsData: thisItem),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[500],
            borderRadius: BorderRadius.all(
              Radius.circular(7.r),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(7.r),
                  topRight: Radius.circular(7.r),
                ),
                child: CachedNetworkImage(
                  imageUrl: thisItem['list_images'][0],
                  height: 220.h,
                  width: double.infinity,
                  fit: BoxFit.fill,
                  filterQuality: FilterQuality.high,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  thisItem['list_destination'],
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: Color.fromARGB(255, 59, 80, 27),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Text(
                "\$ ${thisItem['list_cost']}\/day",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                "From : "+getFormattedDateTime(thisItem['list_date']),
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w400),
              ),
               SizedBox(
                height: 2.h,
              ),
              Text(
                "To : "+getFormattedDateTime(thisItem['list_end_date']),
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w400),
              ),
               Text(
                "Paid \: \$${thisItem['list_total_cost']} Using Ecocash",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w400),
              ),
               SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ),
      );
    },
  );


  

}

 String getFormattedDateTime(Timestamp time) {
  DateTime t=DateTime.fromMillisecondsSinceEpoch(time.millisecondsSinceEpoch);
    final formatter = DateFormat('dd/MM/yyyy HH:mm');
    return formatter.format(t);
  }