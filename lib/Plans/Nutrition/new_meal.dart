import 'package:auto_size_text/auto_size_text.dart';
import 'package:flockergym/Methods/colors_methods.dart';
import 'package:flockergym/NewBackend/Models/NutritionsModel.dart';
import 'package:flockergym/Plans/Nutrition/food_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

late String item;
late NutritionsModel nutritions;

class NewMeal extends StatefulWidget {
  NewMeal({required String type, required NutritionsModel nutritionsModel}){
    item = type;
    nutritions = nutritionsModel;
  }

  @override
  State<NewMeal> createState() => _NewMealState();
}

class _NewMealState extends State<NewMeal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text("Add new meal to ${item}",
          textAlign: TextAlign.start,
          style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
        ),
        leading: BackButton(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("Meal title",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h,),
                  Row(
                    children: [
                      Text("Meal details",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h,),
                  Container(
                    width: 328.w,
                    height: 100.h,
                    decoration: BoxDecoration(
                      color: Color(0xFF323232),
                        borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Daily intake', style: TextStyle(
                                color: Color(0xFFCDCDCD),
                                fontSize: 14.sp,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ),
                              ),
                              Row(
                                children: [
                                  Text(nutritions.calories, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Colors.white),),
                                  Text('/${nutritions.tcalories} Kcal', style: TextStyle(fontSize: 16.sp, color: Colors.grey),),
                                ],
                              ),
                            ],
                          ),
                          CircularPercentIndicator(
                            center: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AutoSizeText("${(double.parse(nutritions.calories)/double.parse(nutritions.tcalories)*100).toStringAsFixed(2)}%",
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: Color(0xFFF8BE00),
                                    fontSize: 10.sp,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                              ],
                            ),
                            animation: true,
                            animationDuration: 3000,
                            radius: 35.w,
                            lineWidth: 8,
                            percent: 0.8,
                            progressColor: lightyellow,
                            backgroundColor: Colors.grey,
                            circularStrokeCap: CircularStrokeCap.round,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 50.h,),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: silverdark,
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  children: [
                    SizedBox(height: 20.h,),
                    Row(
                      children: [
                        Text("Meal items",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 50.h,),
                    Text("No items were added yet",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Color(0xFFCDCDCD),
                        fontSize: 14.sp,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        height: 0,
                        letterSpacing: -0.15,
                      ),
                    ),
                    SizedBox(height: 30.h,),
                    InkWell(
                      onTap: (){
                        Get.to(FoodList());
                      },
                      child: Container(
                        width: 328,
                        height: 44,
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Color(0xFF232323),
                          borderRadius: BorderRadius.circular(4)
                        ),
                        child: Center(
                          child: Text("+ add new Item",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Color(0xFFF8BE00),
                              fontSize: 14.sp,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              height: 0,
                              letterSpacing: -0.15,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
