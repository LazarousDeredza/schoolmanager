// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:schoolmanager/constant/constant.dart';
import 'package:schoolmanager/models/user_model.dart';

class AuthController extends GetxController {
  //for button loading indicator
  var isLoading = false.obs;

  Future userRegistration({
    required String name,
    required String email,
    required String password,
    required String number,
    required String address,
    required String firstName,
    required String lastname,
  }) async {
    try {
      if (name.isNotEmpty &&
          email.isNotEmpty &&
          firstName.isNotEmpty &&
          lastname.isNotEmpty &&
          password.isNotEmpty &&
          number.isNotEmpty &&
          address.isNotEmpty) {
        UserCredential userCredential =
            await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        String level = "user";
        Get.snackbar("Successful", "Registration Successfull");

        final time = DateTime.now().millisecondsSinceEpoch.toString();
        UserModel userModel = UserModel(
            name: name,
            uid: "",
            email: email,
            phoneNumber: number,
            address: address,
            id: "",
            firstName: firstName.trim(),
            lastName: lastname.trim(),
            password: password.trim(),
            level: level,
            groups: [],
            instGroups: [],
            image: "",
            createdAt: time,
            about: 'Hey there! I am using Travel Agency App',
            isOnline: false,
            lastActive: time,
            pushToken: '');
        //save user info in firebase
        await firestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .set(userModel.toJson());
      } else {
        Get.snackbar("Error", "Please enter all the field!",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar("Error", "The password provided is too weak.",
            backgroundColor: Colors.red, colorText: Colors.white);
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar("Error", "The account already exists for that email.",
            backgroundColor: Colors.red, colorText: Colors.white);
      } else if (e.code == 'invalid-email') {
        Get.snackbar("Error", "Please write right email",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Error is: $e",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  // //!-------------------for user login----------
  // Future userLogin({required String email, required String password}) async {
  //   try {
  //     if (email.isNotEmpty && password.isNotEmpty) {
  //       UserCredential userCredential = await FirebaseAuth.instance
  //           .signInWithEmailAndPassword(email: email, password: password);

  //       var authCredential = userCredential.user;
  //       if (authCredential!.uid.isNotEmpty) {
  //         Get.snackbar("Successful", "successfully Login");
  //         Get.to(() => MainHomeScreen());
  //       } else {
  //         Get.snackbar("Error", "Something is wrong!",
  //             backgroundColor: Colors.red, colorText: Colors.white);
  //       }
  //     } else {
  //       Get.snackbar("Error", "Please enter all the field!",
  //           backgroundColor: Colors.red, colorText: Colors.white);
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       Get.snackbar("Error", "No user found for that email.",
  //           backgroundColor: Colors.red, colorText: Colors.white);
  //     } else if (e.code == 'wrong-password') {
  //       Get.snackbar("Error", "Wrong password provided for that user.",
  //           backgroundColor: Colors.red, colorText: Colors.white);
  //     }
  //   } catch (e) {
  //     Get.snackbar("Error", "Error is: $e",
  //         backgroundColor: Colors.red, colorText: Colors.white);
  //   }
  // }

  // //for logout
  // signOut() async {
  //   await firebaseAuth.signOut();
  //   Fluttertoast.showToast(msg: 'Log out');
  //   Get.to(() => SignInScreen());
  // }
}
