import 'package:device_preview/device_preview.dart';
import 'package:flockergym/Classes/class_2.dart';
import 'package:flockergym/NewBackend/PushNoifications/FirebaseAPI.dart';
import 'package:flockergym/Plans/Inbody/body_history.dart';
import 'package:flockergym/Plans/Inbody/inbody_screen.dart';
import 'package:flockergym/Plans/Inbody/obesity_analysis.dart';
import 'package:flockergym/Plans/Nutrition/newmeal_data.dart';
import 'package:flockergym/Splash/SplashScreen.dart';
import 'package:flockergym/firebase_options.dart';
import 'package:flockergym/navigation/app_navigation.dart';
import 'package:flockergym/navigation/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

late SharedPreferences prefs ;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotifications();
  prefs = await SharedPreferences.getInstance();
  runApp(
      DevicePreview(
        enabled: false,
          builder: (context) => MyApp()
      ),
  );
}
class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  Widget build(BuildContext context){
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ScreenUtilInit(
      designSize: Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_ , child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        );
      },
    );
  }
}
