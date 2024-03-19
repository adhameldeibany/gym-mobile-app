import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:flockergym/NewBackend/SplashBack/SplashMethods.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

late String version;
class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState(){
    super.initState();

    Timer(Duration(milliseconds: 500), () {
      PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
        version = packageInfo.version.split("\.")[0];
        print(version);
        Get.off(SplashMethods().start(version, context));
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      duration: Duration(milliseconds: 500),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Image(
          fit: BoxFit.cover,
          image: AssetImage('assets/splash.png',),
        ),
      ),
    );
  }
}
