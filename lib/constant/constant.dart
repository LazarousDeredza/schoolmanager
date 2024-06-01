// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schoolmanager/school_module/views/bottom_nav_controller/pages/home/fees_home.dart';
import 'package:schoolmanager/school_module/views/bottom_nav_controller/pages/home/nav_home_screen.dart';


import 'package:schoolmanager/school_module/views/bottom_nav_controller/pages/add_student/add_student.dart';

//Page
List pages = [
  NavHomeScreen(),
  PackageAddPage(),
   FeesHomeScreen(),
   //UpdateScreen(),
];
//Firebase
var firebaseAuth = FirebaseAuth.instance;
var firestore = FirebaseFirestore.instance;
var firebaseStorage = FirebaseStorage.instance;

//Firebase collection name
const allStudents = "all-students";

