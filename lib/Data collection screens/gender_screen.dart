import 'package:flockergym/Data%20collection%20screens/age_screen.dart';
import 'package:flockergym/Data%20collection%20screens/name_screen.dart';
import 'package:flockergym/Methods/colors_methods.dart';
import 'package:flockergym/NewBackend/DataCollectionBack/DataCollectionMethods.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class GenderScreen extends StatefulWidget {
  const GenderScreen({super.key});

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}
bool isMale = true;
bool x = true;
bool y = false;
bool z = false;

class _GenderScreenState extends State<GenderScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black,
          leading: BackButton(
            color: Colors.white,
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: 20.h,),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Choose your gender...',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                InkWell(
                  onTap: (){
                    setState(() {
                      if (x == false) {
                        x = true;
                        y = false;
                        z = false;
                      } else if (x == true) {
                        x = false;
                      }
                    });
                  },
                  child: Container(
                    width: 300.w,
                    height: 60.h,
                    decoration: BoxDecoration(
                      color: x ? lightyellow : darkgrey,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Male',
                                style: TextStyle(fontWeight: FontWeight.bold, color: x ? darkgrey : Colors.white, fontSize: 16.sp),
                              ),
                              Image(
                                image: AssetImage('assets/male.png'),
                                color: x ? darkgrey : Colors.white,
                                height: 35.h,
                                width: 35.w,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15.h,),
                InkWell(
                  onTap: (){
                    setState(() {
                      if (y == false) {
                        y = true;
                        x = false;
                        z = false;
                      } else if (y == true) {
                        y = false;
                      }
                    });
                  },
                  child: Container(
                    width: 300.w,
                    height: 60.h,
                    decoration: BoxDecoration(
                      color: y ? lightyellow : darkgrey,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Female',
                                style: TextStyle(fontWeight: FontWeight.bold, color: y ? darkgrey : Colors.white, fontSize: 16.sp),
                              ),
                              Image(
                                image: AssetImage('assets/female.png'),
                                color: y ? darkgrey : Colors.white,
                                height: 35.h,
                                width: 35.w,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: ()async{
                      if(isMale){
                        await DataCollectionMethods().savestringdata('gender', 'Male');
                      }else{
                        await DataCollectionMethods().savestringdata('gender', 'Female');
                      }
                      Get.off(AgeScreen());
                    },
                    child: Container(
                      width: 280.w,
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
            )
          ],
        ),
      ),
      onWillPop: ()async{
        DataCollectionMethods().readdata('issocial')!?
        Get.off(NameScreen()):
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        return false;
      },
    );
  }
}
