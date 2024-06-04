// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
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

  uploadToDB() async {

    //
    
    
    // CollectionReference data = firestore.collection(allStudents);
    // data.doc().set(
    //   {
    //     'id': generateRandomString(),
    //     "name": _nameController.text,
    //     'dob': _dobController.text,
    //     "feesPaid": int.parse(_feesPaidController.text),
    //     "grade": selectedGrade,
    //     "class": selectedClass,
    //     "email": _emailController.text.trim(),
    //     "phoneNumber": _phoneNumberController.text,
    //     "address": _addressController.text,
    //     "parentName": _parentNameController.text,
    //     "parentPhoneNumber": _parentPhoneNumberController.text,
    //     'date_time': _formatDateTime(DateTime.now().toString()),
    //   },
    // ).whenComplete(() {
    //   Get.snackbar("Successful", "Student Added successfully.");
    //   Clear();
    // });
    // Get.to(
    //   () => SchoolManagementHomeScreen(),
    // );


CollectionReference data = firestore.collection(allStudents);

// Retrieve the class lengths
Map<String, int> classLengths = await getClassLengths();

// Determine the selected class based on the selected grade and class lengths
int? currentClassLength = 0;
String selectedclass=selectedClass;
switch (selectedGrade) {
  case 1:
    if (classLengths['1A']! < 30) {
      selectedclass = '1A';
      currentClassLength = classLengths['1A'];
    } else if (classLengths['1B']! < 30) {
      selectedclass = '1B';
      currentClassLength = classLengths['1B'];
    } else {
      selectedclass = '1C';
      currentClassLength = classLengths['1C'];
    }
    break;
  case 2:
    if (classLengths['2A']! < 30) {
      selectedclass = '2A';
      currentClassLength = classLengths['2A'];
    } else if (classLengths['2B']! < 30) {
      selectedclass = '2B';
      currentClassLength = classLengths['2B'];
    } else {
      selectedclass = '2C';
      currentClassLength = classLengths['2C'];
    }
    break;
  case 3:
    if (classLengths['3A']! < 30) {
      selectedclass = '3A';
      currentClassLength = classLengths['3A'];
    } else if (classLengths['3B']! < 30) {
      selectedclass = '3B';
      currentClassLength = classLengths['3B'];
    } else {
      selectedclass = '3C';
      currentClassLength = classLengths['3C'];
    }
    break;
  case 4:
    if (classLengths['4A']! < 30) {
      selectedclass = '4A';
      currentClassLength = classLengths['4A'];
    } else if (classLengths['4B']! < 30) {
      selectedclass = '4B';
      currentClassLength = classLengths['4B'];
    } else {
      selectedclass = '4C';
      currentClassLength = classLengths['4C'];
    }
    break;
  case 5:
    if (classLengths['5A']! < 30) {
      selectedclass = '5A';
      currentClassLength = classLengths['5A'];
    } else if (classLengths['5B']! < 30) {
      selectedclass = '5B';
      currentClassLength = classLengths['5B'];
    } else {
      selectedclass = '5C';
      currentClassLength = classLengths['5C'];
    }
    break;
  case 6:
    if (classLengths['6A']! < 30) {
      selectedclass = '6A';
      currentClassLength = classLengths['6A'];
    } else if (classLengths['6B']! < 30) {
      selectedclass = '6B';
      currentClassLength = classLengths['6B'];
    } else {
      selectedclass = '6C';
      currentClassLength = classLengths['6C'];
    }
    break;
  case 7:
    if (classLengths['7A']! < 30) {
      selectedclass = '7A';
      currentClassLength = classLengths['7A'];
    } else if (classLengths['7B']! < 30) {
      selectedclass = '7B';
      currentClassLength = classLengths['7B'];
    } else {
      selectedclass = '7C';
      currentClassLength = classLengths['7C'];
    }
    break;
  default:
    // Handle cases where the selected grade is not found
    break;
}

// Save the student data to Firestore
data.doc().set(
  {
    'id': generateRandomString(),
    "name": _nameController.text,
    'dob': _dobController.text,
    "feesPaid": int.parse(_feesPaidController.text),
    "grade": selectedGrade,
    "class": selectedclass,
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


Future<Map<String, int>> getClassLengths() async {
  Map<String, int> classLengths = {};

  // Retrieve the lengths for each class
  classLengths['1A'] = (await firestore.collection(allStudents).where('class', isEqualTo: '1A').get()).size;
  classLengths['1B'] = (await firestore.collection(allStudents).where('class', isEqualTo: '1B').get()).size;
  classLengths['1C'] = (await firestore.collection(allStudents).where('class', isEqualTo: '1C').get()).size;
  classLengths['2A'] = (await firestore.collection(allStudents).where('class', isEqualTo: '2A').get()).size;
  classLengths['2B'] = (await firestore.collection(allStudents).where('class', isEqualTo: '2B').get()).size;
  classLengths['2C'] = (await firestore.collection(allStudents).where('class', isEqualTo: '2C').get()).size;
  classLengths['3A'] = (await firestore.collection(allStudents).where('class', isEqualTo: '3A').get()).size;
  classLengths['3B'] = (await firestore.collection(allStudents).where('class', isEqualTo: '3B').get()).size;
  classLengths['3C'] = (await firestore.collection(allStudents).where('class', isEqualTo: '3C').get()).size;
  classLengths['4A'] = (await firestore.collection(allStudents).where('class', isEqualTo: '4A').get()).size;
  classLengths['4B'] = (await firestore.collection(allStudents).where('class', isEqualTo: '4B').get()).size;
  classLengths['4C'] = (await firestore.collection(allStudents).where('class', isEqualTo: '4C').get()).size;
  classLengths['5A'] = (await firestore.collection(allStudents).where('class', isEqualTo: '5A').get()).size;
  classLengths['5B'] = (await firestore.collection(allStudents).where('class', isEqualTo: '5B').get()).size;
  classLengths['5C'] = (await firestore.collection(allStudents).where('class', isEqualTo: '5C').get()).size;
  classLengths['6A'] = (await firestore.collection(allStudents).where('class', isEqualTo: '6A').get()).size;
  classLengths['6B'] = (await firestore.collection(allStudents).where('class', isEqualTo: '6B').get()).size;
  classLengths['6C'] = (await firestore.collection(allStudents).where('class', isEqualTo: '6C').get()).size;
  classLengths['7A'] = (await firestore.collection(allStudents).where('class', isEqualTo: '7A').get()).size;
  classLengths['7B'] = (await firestore.collection(allStudents).where('class', isEqualTo: '7B').get()).size;
  classLengths['7C'] = (await firestore.collection(allStudents).where('class', isEqualTo: '7C').get()).size;

  return classLengths;
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
                Visibility(
                  visible: false,
                  maintainSize: false,
                  child: const Center(
                  
                      child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Select Class"),
                  )),
                ),
                Visibility(
                  visible: false,
                  maintainSize: false,
                  child: Center(
                  
                    child: DropdownMenu<String>(
                      initialSelection: classes.first,
                      enabled: false,
                  
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
