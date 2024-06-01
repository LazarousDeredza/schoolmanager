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

class UpdateScreen extends StatefulWidget {
  final Map detailsData;

  UpdateScreen({Key? key, required this.detailsData}) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
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
          "Update Student".tr,
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
                  onlyRead: false),
              customTextField(
                  "Date Of Birth", _dobController, TextInputType.text,
                  onlyRead: false),
              customTextField(
                  "Fees Paid", _feesPaidController, TextInputType.number,
                  onlyRead: true),
              customTextField(
                  "Fees Top Up", _feesTopUpController, TextInputType.number,
                  onlyRead: false),
              customTextField(
                  "Email", _emailController, TextInputType.emailAddress,
                  onlyRead: false),
              customTextField(
                  "Phone Number", _phoneNumberController, TextInputType.number,
                  onlyRead: false),
              customTextField("Address", _addressController, TextInputType.text,
                  onlyRead: false),
              const Center(
                  child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Grade"),
              )),
              Center(
                child: DropdownMenu<int>(
                  initialSelection: selectedGrade,
                  onSelected: (value) {
                    setState(() {
                      selectedGrade = value!;
                      print(value);
                    });
                  },
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
                  onSelected: (value) {
                    setState(() {
                      selectedClass = value!;
                      print(value);
                    });
                  },
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
                  onlyRead: false),
              customTextField("Parent Phone Number",
                  _parentPhoneNumberController, TextInputType.number,
                  onlyRead: false),
              SizedBox(height: 10.h),
              Obx(() {
                return VioletButton(
                  isLoading: isLoading.value,
                  title: "Update".tr,
                  onAction: () async {
                    if (_nameController.text.isEmpty) {
                      Fluttertoast.showToast(msg: "Please Enter Student Name");
                      return;
                    }
                    if (_dobController.text.isEmpty) {
                      Fluttertoast.showToast(msg: "Please Enter Date Of Birth");
                      return;
                    } else {
                      final dateRegex = RegExp(r'^(\d{2})\/(\d{2})\/(\d{4})$');

                      final dateString = _dobController.text;
                      final match = dateRegex.firstMatch(dateString);
                      if (match != null) {
                        final day = int.parse(match.group(1)!);
                        final month = int.parse(match.group(2)!);
                        final year = int.parse(match.group(3)!);
                        print('Day: $day, Month: $month, Year: $year');
                      } else {
                        Fluttertoast.showToast(
                            msg: "Please Enter Valid Date Of Birth");
                        return;
                      }
                    }

                    if (_emailController.text.isEmpty) {
                      Fluttertoast.showToast(msg: "Please Enter Student Email");
                      return;
                    } else {
                      final emailRegex =
                          RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

                      final email = _emailController.text.trim();
                      if (emailRegex.hasMatch(email)) {
                        print('Valid email address');
                      } else {
                        Fluttertoast.showToast(
                            msg: "Please Enter Valid Student Email");
                        return;
                      }
                    }

                    if (_feesPaidController.text.isEmpty) {
                      Fluttertoast.showToast(msg: "Please Enter Fees Paid");
                      return;
                    }

                    if (_phoneNumberController.text.isEmpty ||
                        _phoneNumberController.text.toString().trim().length <
                            10 ||
                        _phoneNumberController.text.toString().trim().length >
                            10) {
                      Fluttertoast.showToast(msg: "Invalid Phone Number");
                    } else if (_addressController.text.isEmpty) {
                      Fluttertoast.showToast(msg: "Please Enter address");
                    } else if (_parentNameController.text.isEmpty) {
                      Fluttertoast.showToast(msg: "Please enter parent name");
                    } else if (_parentPhoneNumberController.text.isEmpty ||
                        _parentPhoneNumberController.text.length < 10 ||
                        _parentPhoneNumberController.text.length > 10) {
                      Fluttertoast.showToast(
                          msg: "Please Enter valid parent phone number");
                    } else {
                      isLoading(true);
                      await updateStudent();
                      isLoading(false);
                      //Get.back();
                    }
                  },
                );
              }),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }

  updateStudent() async {
    final data = await firestore
        .collection(allStudents)
        .where('id', isEqualTo: widget.detailsData['id'])
        .get();

    log('data.....: ${data.docs}');
    log('Doc Id......: ${data.docs.first.id}');

    if (data.docs.isNotEmpty) {
      firestore.collection(allStudents).doc(data.docs.first.id).update(
        {
          'id': widget.detailsData['id'],
          "name": _nameController.text,
          'dob': _dobController.text,
          "feesPaid": int.parse(_feesPaidController.text) +
              int.parse(_feesTopUpController.text),
          "grade": selectedGrade,
          "class": selectedClass,
          "email": _emailController.text.trim(),
          "phoneNumber": _phoneNumberController.text,
          "address": _addressController.text,
          "parentName": _parentNameController.text,
          "parentPhoneNumber": _parentPhoneNumberController.text,
          'date_time': widget.detailsData['date_time'],
        },
      ).whenComplete(() {
        Get.snackbar("Successful", "Student Updated successfully.");
      });
      Get.to(
        () => SchoolManagementHomeScreen(),
      );
    }
  }
}
