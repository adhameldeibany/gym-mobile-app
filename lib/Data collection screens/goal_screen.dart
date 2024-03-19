import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flockergym/Data%20collection%20screens/height_screen.dart';
import 'package:flockergym/Data%20collection%20screens/motivate_screen.dart';
import 'package:flockergym/Methods/colors_methods.dart';
import 'package:flockergym/NewBackend/DataCollectionBack/DataCollectionMethods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class GoalScreen extends StatefulWidget {

  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

TextEditingController controller = TextEditingController();


class _GoalScreenState extends State<GoalScreen> {

  bool x = false;
  bool y = false;
  bool z = false;

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
            onPressed: (){
              Get.off(HeightScreen());
            },
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: 40.h,),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'What\'s your main goal ?',
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
                      padding: const EdgeInsets.only(left: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text('Lose Weight',
                                textAlign: TextAlign.start,
                                style: TextStyle(fontWeight: FontWeight.bold, color: x ? darkgrey : Colors.white, fontSize: 16.sp),
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
                      padding: const EdgeInsets.only(left: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text('Build Muscle',
                                textAlign: TextAlign.start,
                                style: TextStyle(fontWeight: FontWeight.bold, color: y ? darkgrey : Colors.white, fontSize: 16.sp),
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
                      if (z == false) {
                        z = true;
                        x = false;
                        y = false;
                      } else if (z == true) {
                        z = false;
                      }
                    });
                  },
                  child: Container(
                    width: 300.w,
                    height: 60.h,
                    decoration: BoxDecoration(
                        color: z ? lightyellow : darkgrey,
                        borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text('Keep Fit',
                                textAlign: TextAlign.start,
                                style: TextStyle(fontWeight: FontWeight.bold, color: z ? darkgrey : Colors.white, fontSize: 16.sp),
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
                    onTap: () async{
                      if (x == true) {
                        await DataCollectionMethods().savestringdata('goal',"Lose Weight");
                      }else if (y == true) {
                        await DataCollectionMethods().savestringdata('goal',"Build Muscle");
                      }else if (z == true) {
                        await DataCollectionMethods().savestringdata('goal',"Keep Fit");
                      }else{
                        final snackBar = SnackBar(
                          duration: Duration(milliseconds: 1500,),
                          elevation: 0,
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          content: AwesomeSnackbarContent(
                            title: 'Wrong',
                            message: 'Please Choose An Option',
                            contentType: ContentType.failure,
                          ),
                        );
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(snackBar);
                        return;
                      }
                      Get.off(MotivatesScreen());
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
            ),
          ],
        ),
      ),
        onWillPop: ()async{
          Get.off(HeightScreen());
          return false;
        });
  }
}
