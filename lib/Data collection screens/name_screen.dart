import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flockergym/Data%20collection%20screens/gender_screen.dart';
import 'package:flockergym/Methods/colors_methods.dart';
import 'package:flockergym/NewBackend/DataCollectionBack/DataCollectionMethods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NameScreen extends StatefulWidget {

  @override
  State<NameScreen> createState() => _NameScreenState();
}

TextEditingController controller = TextEditingController();
var firstnamecontroller = TextEditingController();
var lastnamecontroller = TextEditingController();


class _NameScreenState extends State<NameScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: BackButton(
          color: Colors.black,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(height: 10.h,),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'What\'s your name ?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 15.h,),
                    Text(
                      'This helps us create your personalized plan',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 145.w,
                  height: 50.h,
                  child: TextFormField(
                    controller: firstnamecontroller,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      labelStyle: TextStyle(color: lightyellow, fontSize: 15.sp),
                      hintText: 'First name',
                      hoverColor: Colors.white,
                      hintStyle: TextStyle(color: Colors.white54, fontSize: 15.sp),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey,)),
                      border: OutlineInputBorder(borderSide: BorderSide(color: lightyellow,)),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: lightyellow,width: 2.w)),
                    ),
                  ),
                ),
                SizedBox(
                  width: 145.w,
                  height: 50.h,
                  child: TextFormField(
                    controller: lastnamecontroller,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      labelStyle: TextStyle(color: lightyellow, fontSize: 15.sp),
                      hintText: 'Last name',
                      hoverColor: Colors.white,
                      hintStyle: TextStyle(color: Colors.white54, fontSize: 15.sp),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey,)),
                      border: OutlineInputBorder(borderSide: BorderSide(color: lightyellow,)),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: lightyellow,width: 2.w)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async{
                    if (firstnamecontroller.text.length == 0 && lastnamecontroller.text.length == 0) {
                      final snackBar = SnackBar(
                        duration: Duration(milliseconds: 1500,),
                        elevation: 0,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          title: 'Error',
                          message: 'Name Can\'t Be Empty.',
                          contentType: ContentType.failure,
                        ),
                      );
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackBar);
                    }else{
                    await DataCollectionMethods().savestringdata('name', firstnamecontroller.text.toString() + " "+ lastnamecontroller.text.toString());
                    Get.off(GenderScreen());
                    }
                  },
                  child: Container(
                    width: 300.w,
                    height: 45.h,
                    decoration: BoxDecoration(
                      color: lightyellow,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Next',
                          style: TextStyle(color: darkgrey, fontSize: 18.sp,fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}