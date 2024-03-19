import 'package:flockergym/Data%20collection%20screens/age_screen.dart';
import 'package:flockergym/Data%20collection%20screens/height_screen.dart';
import 'package:flockergym/Methods/colors_methods.dart';
import 'package:flockergym/NewBackend/DataCollectionBack/DataCollectionMethods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class WeightScreen extends StatefulWidget {
  const WeightScreen({super.key});

  @override
  State<WeightScreen> createState() => _WeightScreenState();
}
int weight = 60;

class _WeightScreenState extends State<WeightScreen> {
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
              Get.off(AgeScreen());
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
              child:Padding(
                padding: const EdgeInsets.only(top: 100, bottom: 100, right: 50, left: 50),
                child: Row(
                  children:
                  [
                    Expanded(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          [
                            Text(
                              'Weight',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 15.h,),
                            Text(
                              '$weight',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 28.sp,
                              ),
                            ),
                            SizedBox(height: 30.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:
                              [
                                FloatingActionButton(
                                  onPressed: ()
                                  {
                                    setState(() {
                                      weight--;
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
                                  width: 40.w,
                                ),
                                FloatingActionButton(
                                  onPressed: ()
                                  {
                                    setState(() {
                                      weight++;
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
                            )
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
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: ()async{
                      await DataCollectionMethods().savestringdata('weight',weight.toInt().toString());
                      Get.off(HeightScreen());
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
          Get.off(AgeScreen());
          return false;
        });
  }
}
