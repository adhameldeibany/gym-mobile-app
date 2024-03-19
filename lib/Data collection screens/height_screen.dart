import 'package:flockergym/Data%20collection%20screens/goal_screen.dart';
import 'package:flockergym/Data%20collection%20screens/weight_screen.dart';
import 'package:flockergym/Methods/colors_methods.dart';
import 'package:flockergym/NewBackend/DataCollectionBack/DataCollectionMethods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HeightScreen extends StatefulWidget {
  const HeightScreen({super.key});

  @override
  State<HeightScreen> createState() => _HeightScreenState();
}
double height = 155.0;

class _HeightScreenState extends State<HeightScreen> {
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
              Get.off(WeightScreen());
            },
          ),
        ),
        body: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: 10.h,),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Let us know you better',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 15.h,),
                      Text(
                        'Let us know you better to help \nboost your workout result',
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 100, bottom: 100, right: 30, left: 30),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Height',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.h,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        mainAxisAlignment: MainAxisAlignment.center,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            '${height.round()}',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 30.sp,
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            'CM',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Slider(
                        activeColor: lightyellow,
                        value: height,
                        max: 220.0,
                        min: 80.0,
                        inactiveColor: Colors.grey,
                        onChanged: (value){
                          setState(() {
                            height = value;
                          });
                        },
                      ),
                      SizedBox(height: 0.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                        [
                          FloatingActionButton(
                            onPressed: ()
                            {
                              setState(() {
                                height--;
                              });
                            },
                            mini: true,
                            child: Icon(
                              Icons.remove,
                              color: darkgrey,
                            ),
                            backgroundColor: lightyellow,
                          ),
                          SizedBox(
                            width: 170.w,
                          ),
                          FloatingActionButton(
                            onPressed: ()
                            {
                              setState(() {
                                height++;
                              });
                            },
                            mini: true,
                            child: Icon(
                              Icons.add,
                              color: darkgrey,
                            ),
                            backgroundColor: lightyellow,
                          ),
                        ],
                      ),
                      SizedBox(height: 0.h,),
                    ],
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: darkgrey,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        color: Colors.black38,
                        offset: Offset(0, 8),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async{
                      await DataCollectionMethods().savestringdata('height',height.toInt().toString());
                      Get.off(GoalScreen());
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
          Get.off(WeightScreen());
          return false;
        });
  }
}
