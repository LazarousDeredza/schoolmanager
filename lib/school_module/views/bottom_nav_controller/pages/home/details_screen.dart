// ignore_for_file: prefer_const_constructors, must_be_immutable, use_build_context_synchronously

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:schoolmanager/constant/app_colors.dart';
import 'package:schoolmanager/constant/app_colors.dart';
import 'package:get/get.dart';
import 'package:schoolmanager/constant/constant.dart';
import 'package:schoolmanager/route/route.dart';
import 'package:schoolmanager/school_module/services/firestore_services.dart';
import 'package:schoolmanager/school_module/views/screens/schoolmanagement_home_screen.dart';
import 'package:schoolmanager/school_module/views/widgets/custom_text_field.dart';
import 'package:schoolmanager/school_module/views/widgets/violetButton.dart';

class DetailsScreen extends StatefulWidget {
  final Map detailsData;

  DetailsScreen({Key? key, required this.detailsData}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  RxBool darkMode = false.obs;

  Future _exitDialog(context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Are you sure to close this app?"),
          content: Row(
            children: [
              ElevatedButton(
                onPressed: () => Get.back(),
                child: Text("No"),
              ),
              SizedBox(
                width: 20.w,
              ),
              ElevatedButton(
                onPressed: () => SystemNavigator.pop(),
                child: Text("Yes"),
              ),
            ],
          ),
        );
      },
    );
  }

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _dobController = TextEditingController();

  //final TextEditingController _gradeController = TextEditingController();
  final TextEditingController _feesPaidController = TextEditingController();
  final TextEditingController _feesTopUpController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _phoneNumberController = TextEditingController();

  final TextEditingController _addressController = TextEditingController();

  final TextEditingController _parentNameController = TextEditingController();

  final TextEditingController _parentPhoneNumberController =
      TextEditingController();

  RxBool isLoading = false.obs;

  static List<String> classes = [
    "1A",
    "1B",
    "1C",
    "2A",
    "2B",
    "2C",
    "3A",
    "3B",
    "3C",
    "4A",
    "4B",
    "4C",
    "5A",
    "5B",
    "5C",
    "6A",
    "6B",
    "6C",
    "7A",
    "7B",
    "7C",
  ];

  String selectedClass = classes.first;

  static List<int> grade = [1, 2, 3, 4, 5, 6, 7];

  int selectedGrade = grade.first;

  @override
  void initState() {
    _nameController.text = widget.detailsData['name'];
    _dobController.text = widget.detailsData['dob'];
    _feesPaidController.text = widget.detailsData['feesPaid'].toString();
    _emailController.text = widget.detailsData['email'];
    _phoneNumberController.text = widget.detailsData['phoneNumber'];
    _addressController.text = widget.detailsData['address'];
    _parentNameController.text = widget.detailsData['parentName'];
    _parentPhoneNumberController.text = widget.detailsData['parentPhoneNumber'];
    _feesTopUpController.text = '0';
    selectedGrade = widget.detailsData['grade'];
    selectedClass = widget.detailsData['class'];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Student Details".tr,
          style: TextStyle(color: AppColors.textColor),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                _exitDialog(context);
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child:
                    Text("Date Enrolled : ${widget.detailsData['date_time']}"),
              ),
              customTextField(
                  "Student Name", _nameController, TextInputType.text,
                  onlyRead: true),
              customTextField(
                  "Date Of Birth", _dobController, TextInputType.text,
                  onlyRead: true),
              customTextField(
                  "Fees Paid", _feesPaidController, TextInputType.number,
                  onlyRead: true),
              
              customTextField(
                  "Email", _emailController, TextInputType.emailAddress,
                  onlyRead: true),
              customTextField(
                  "Phone Number", _phoneNumberController, TextInputType.number,
                  onlyRead: true),
              customTextField("Address", _addressController, TextInputType.text,
                  onlyRead: true),
              const Center(
                  child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Grade"),
              )),
              Center(
                child: DropdownMenu<int>(
                  initialSelection: selectedGrade,
                  enabled: false,
                 
                  dropdownMenuEntries:
                      grade.map<DropdownMenuEntry<int>>((int value) {
                    return DropdownMenuEntry(
                        value: value, label: value.toString());
                  }).toList(),
                ),
              ),
              const Center(
                  child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Class"),
              )),
              Center(
                child: DropdownMenu<String>(
                  initialSelection: selectedClass,
                 enabled: false,
                  dropdownMenuEntries:
                      classes.map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry(value: value, label: value);
                  }).toList(),
                ),
              ),
              SizedBox(
                height: 40.h,
                child: Center(child: Text("Parent Details")),
              ),
              customTextField(
                  "Parent Name", _parentNameController, TextInputType.text,
                  onlyRead: true),
              customTextField("Parent Phone Number",
                  _parentPhoneNumberController, TextInputType.number,
                  onlyRead: true),
              SizedBox(height: 20.h),
             
            ],
          ),
        ),
      ),
    );
  }

 }
