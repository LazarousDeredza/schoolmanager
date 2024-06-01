// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:schoolmanager/constant/constant.dart';
import 'package:schoolmanager/school_module/views/widgets/custom_text_field.dart';
import 'package:schoolmanager/school_module/views/widgets/violetButton.dart';

import '../../../screens/schoolmanagement_home_screen.dart';

class PackageAddPage extends StatefulWidget {
  const PackageAddPage({Key? key}) : super(key: key);

  @override
  State<PackageAddPage> createState() => _PackageAddPageState();
}

class _PackageAddPageState extends State<PackageAddPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  //final TextEditingController _gradeController = TextEditingController();
  //final TextEditingController _classController = TextEditingController();
  final TextEditingController _feesPaidController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _parentNameController = TextEditingController();
  final TextEditingController _parentPhoneNumberController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
  }

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

  uploadToDB() {
    CollectionReference data = firestore.collection(allStudents);
    data.doc().set(
      {
        'id': generateRandomString(),
        "name": _nameController.text,
        'dob': _dobController.text,
        "feesPaid": int.parse(_feesPaidController.text),
        "grade": selectedGrade,
        "class": selectedClass,
        "email": _emailController.text.trim(),
        "phoneNumber": _phoneNumberController.text,
        "address": _addressController.text,
        "parentName": _parentNameController.text,
        "parentPhoneNumber": _parentPhoneNumberController.text,
        'date_time': _formatDateTime(DateTime.now().toString()),
      },
    ).whenComplete(() {
      Get.snackbar("Successful", "Student Added successfully.");
      Clear();
    });
    Get.to(
      () => SchoolManagementHomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20.h),
                customTextField(
                  "Student Name".tr,
                  _nameController,
                  TextInputType.text,
                  onlyRead: false,
                ),
                customTextField(
                  "Date Of Birth (dd/mm/yyyy)".tr,
                  _dobController,
                  TextInputType.text,
                  onlyRead: false,
                ),
                // customTextField(
                //   "Grade".tr,
                //   _gradeController,
                //   TextInputType.number,
                //   onlyRead: false,
                // ),
                // customTextField(
                //   "Class".tr,
                //   _classController,
                //   TextInputType.text,
                //   onlyRead: false,
                // ),
                const Center(
                    child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Select Grade"),
                )),
                Center(
                  child: DropdownMenu<int>(
                    initialSelection: grade.first,
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
                  child: Text("Select Class"),
                )),
                Center(
                  child: DropdownMenu<String>(
                    initialSelection: classes.first,
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
                customTextField(
                  "Email".tr,
                  _emailController,
                  TextInputType.text,
                  onlyRead: false,
                ),
                customTextField(
                  "Fees Paid".tr,
                  _feesPaidController,
                  TextInputType.number,
                  onlyRead: false,
                ),
                customTextField(
                  "Phone Number".tr,
                  _phoneNumberController,
                  TextInputType.number,
                  onlyRead: false,
                ),
                customTextField(
                  "Home Address".tr,
                  _addressController,
                  TextInputType.text,
                  onlyRead: false,
                ),
                customTextField(
                  "Parent Name".tr,
                  _parentNameController,
                  TextInputType.text,
                  onlyRead: false,
                ),
                customTextField(
                  "Parent Phone Number".tr,
                  _parentPhoneNumberController,
                  TextInputType.number,
                  onlyRead: false,
                ),
                SizedBox(height: 10.h),
                Obx(() {
                  return VioletButton(
                    isLoading: isLoading.value,
                    title: "Submit".tr,
                    onAction: () async {
                      if (_nameController.text.isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Please Enter Student Name");
                        return;
                      }
                      if (_dobController.text.isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Please Enter Date Of Birth");
                        return;
                      } else {
                        final dateRegex =
                            RegExp(r'^(\d{2})\/(\d{2})\/(\d{4})$');

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
                        Fluttertoast.showToast(
                            msg: "Please Enter Student Email");
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
                        await uploadToDB();
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
      ),
    );
  }

  void Clear() {
    _nameController.clear();
    _dobController.clear();
    // _gradeController.clear();
    //  _classController.clear();
    _emailController.clear();
    _feesPaidController.clear();
    _phoneNumberController.clear();
    _addressController.clear();
    _parentNameController.clear();
    _parentPhoneNumberController.clear();
  }

  static String _formatDateTime(String dateTimeString) {
    final dateTime = DateTime.parse(dateTimeString);
    final formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(dateTime);
  }

  static String generateRandomString() {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    String randomString = '';

    for (var i = 0; i < 6; i++) {
      final randomIndex = random.nextInt(chars.length);
      randomString += chars[randomIndex];
    }

    print("generated code id $randomString");

    return randomString;
  }
}
