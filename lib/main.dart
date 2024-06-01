// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schoolmanager/firebase_options.dart';
import 'package:schoolmanager/route/route.dart';
import 'package:schoolmanager/utils/pref_utils.dart';
import 'package:schoolmanager/utils/size_utils.dart';
import 'package:schoolmanager/school_module/onboard/onboard.dart';
import 'constant/app_colors.dart';
import 'constant/app_strings.dart';
import 'school_module/theme/theme_manager.dart';

import 'school_module/views/screens/splash_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:upgrader/upgrader.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_instance/get_instance.dart';
// import 'package:get/get_navigation/src/root/get_material_app.dart';
// import 'package:get/get_navigation/src/routes/transitions_type.dart';

int? isviewed;
late Size mq;

void main() async {
  // ! ------------Firbase initialzation-----------------

  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  PrefUtils().init();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Upgrader.clearSavedSettings();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  isviewed = prefs.getInt('onBoard');
  print("......." + isviewed.toString());
  isviewed == 0 ? Get.put(SplashScreen()) : Get.put(OnBoard());

  runApp(ProviderScope(child: App()));
}

ThemeManager themeManager = ThemeManager(ThemeMode.light);

class App extends StatelessWidget {
  //! Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization =
      Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
          .whenComplete(() => {print("....Done .....")});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return FutureBuilder(
        //! Initialize FlutterFire:
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("....error....");
            print("Error : " + snapshot.error.toString());
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            print("....screen....");
            return MyApp();
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );
    });
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    return ScreenUtilInit(
      designSize: Size(430, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          title: appName,
          debugShowCheckedModeBanner: false,

          //darkTheme: TAppTheme.darkTheme,
          themeMode: ThemeMode.system,
          defaultTransition: Transition.leftToRightWithFade,
          transitionDuration: const Duration(milliseconds: 500),

          theme: ThemeData(
              primarySwatch: Colors.blue,
              textTheme: GoogleFonts.poppinsTextTheme(
                  Theme.of(context).textTheme.apply()),
              scaffoldBackgroundColor: AppColors.scaffoldColor,
              appBarTheme: AppBarTheme(
                  elevation: 0,
                  color: Colors.transparent,
                  iconTheme: IconThemeData(color: Colors.black),
                  titleTextStyle:
                      TextStyle(color: Colors.black, fontSize: 20.sp))),
          initialRoute: isviewed != 0 ? onboard : splash,
          getPages: getPages,

          // !-----------splash screen-----------------

          home: isviewed != 0 ? const OnBoard() : SplashScreen(),
          // home: Home(), 0777017252
        );
      },
    );
  }
}
