// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:schoolmanager/constant/constant.dart';
import 'package:schoolmanager/controllers/profile_controller.dart';
import 'package:schoolmanager/vacation_module/services/firestore_services.dart';
import 'package:schoolmanager/vacation_module/views/bottom_nav_controller/pages/bottom_nav_controller_screen.dart';
import 'package:schoolmanager/vacation_module/views/screens/drawer_screen.dart';

class VacationHomeScreen extends StatefulWidget {
  const VacationHomeScreen({Key? key}) : super(key: key);

  @override
  State<VacationHomeScreen> createState() => _VacationHomeScreenState();
}

class _VacationHomeScreenState extends State<VacationHomeScreen> {
  late StreamSubscription<List<ConnectivityResult>> subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  var email = "";
  bool isAdmin = false;
  String level='user';

  final controller = Get.put(ProfileController());

  @override
  void initState() {
    getConnectivity();
    // need for add package screen
    controller.getUserData(uid: firebaseAuth.currentUser!.uid);

//     FirebaseFirestore.instance
//         .collection("users")
//         .doc(firebaseAuth.currentUser!.uid)
//         .get()
//         .then((value) {
//       setState(() {
//         //userName = value.data()!["name"];
//         email = value.data()!["email"];
//         level=value.data()!["level"];

//         print("Email : ........ $email");
// //gzutravelagency@gmail.com
//         if (email.toLowerCase() == "ninja.ld49@gmail.com"||level=="admin"||email.toLowerCase()=="gzutravelagency@gmail.com") {
//           isAdmin = true;
//           print("is admin : "+isAdmin.toString());
//         }
//       });
//     });

    super.initState();
  }

  getConnectivity()  {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> connectivityResult) {
      // Received changes in available connectivity types!

// This condition is for demo purposes only to explain every connection type.
// Use conditions which work for your requirements.
      if (connectivityResult.contains(ConnectivityResult.mobile)) {
        // Mobile network available.
        print("Connected to Mobile");
      } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
        // Wi-fi is available.
        // Note for Android:
        // When both mobile and Wi-Fi are turned on system will return Wi-Fi only as active network type
                print("Connected to Wifi");

      } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
        // Ethernet connection available.
        print("Connected to Ethernet");

      } else if (connectivityResult.contains(ConnectivityResult.vpn)) {
        // Vpn connection active.
        // Note for iOS and macOS:
        // There is no separate network interface type for [vpn].
        // It returns [other] on any device (also simulator)
        print("Connected to VPN");

      } else if (connectivityResult.contains(ConnectivityResult.none)) {
        // No available network types
        print("Connected to None");

        showDialogBox();
        setState(() => isAlertSet = true);
      }
    });
  }

  //  getConnectivity() =>
  // subscription = Connectivity().onConnectivityChanged.listen(
  //   (List<ConnectivityResult> results) async {
  //     ConnectivityResult result = results as ConnectivityResult;
  //     isDeviceConnected = await InternetConnectionChecker().hasConnection;
  //     if (!isDeviceConnected && isAlertSet == false) {
  //       showDialogBox();
  //       setState(() => isAlertSet = true);
  //     }
  //   },
  // );

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
         _exitDialog(context);
       
         return Future.value(false);
      },
      child: Scaffold(
        body: Stack(
          children: [
            DrawerScreen(isAdmin: isAdmin,),
            BottomNavControllerScreen(isAdmin: isAdmin,),
          ],
        ),
      ),
    );
  }

  showDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('No Connection'),
          content: const Text('Please check your internet connectivity'),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                setState(() => isAlertSet = false);
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected && isAlertSet == false) {
                  showDialogBox();
                  setState(() => isAlertSet = true);
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
}
