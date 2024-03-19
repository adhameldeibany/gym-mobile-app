import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flockergym/Methods/colors_methods.dart';
import 'package:flockergym/NewBackend/MainMethods.dart';
import 'package:flockergym/NewBackend/Models/MealsModels.dart';
import 'package:flockergym/NewBackend/Models/NutritionsModel.dart';
import 'package:flockergym/Plans/Nutrition/food_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

late String item;
late NutritionsModel nutritions;
late List<MealsModel> meals;

class NewmealData extends StatefulWidget {
  NewmealData({required String type, required NutritionsModel nutritionsModel}){
    item = type;
    nutritions = nutritionsModel;
  }

  @override
  State<NewmealData> createState() => _NewmealDataState();
}

class _NewmealDataState extends State<NewmealData> {

  Scaffold MakeStream(BuildContext Screencontext){
    FirebaseFirestore ref = FirebaseFirestore.instance;
    final ref2 = ref.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition").doc(DateFormat('dd-MM-yyyy').format(DateTime.now())).snapshots();
    final ref3 = ref.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition").doc(DateFormat('dd-MM-yyyy').format(DateTime.now())).collection("meals").snapshots();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 64.h,
        elevation: 0,
        title: Text("Add new meal to $item",
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
      body: StreamBuilder(
        stream: ref2,
        builder: (_, snapshot0) {
          if (snapshot0.hasData && snapshot0.data != null ) {
            if (snapshot0.data!.exists) {
              final items2 = snapshot0.data!;
              print("Exists");
              NutritionsModel nutrition = new NutritionsModel(
                calories: items2.get("calories").toString(),
                tcalories: items2.get("tcalories").toString(),
                carbs: items2.get("carbs").toString(),
                tcarbs: items2.get("tcarbs").toString(),
                fat: items2.get("fat").toString(),
                tfat: items2.get("tfat").toString(),
                protien: items2.get("protien").toString(),
                tprotien: items2.get("tprotien").toString(),
                m1: items2.get("m1"),
                m2: items2.get("m2"),
                m3: items2.get("m3"),
                m4: items2.get("m4"),
                m5: items2.get("m5"),
                m6: items2.get("m6"),
              );
              return StreamBuilder(
                stream: ref3,
                builder: (context, snapshot1) {
                  if (snapshot1.hasData && snapshot1.data != null ) {
                    if (snapshot1.data?.docs.length == 0) {
                      int t = 0;
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 270.h,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10, right: 10),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Center(
                                          child: Text("Meal title",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 50.h,),
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
                                    SizedBox(height: 12.h,),
                                    Container(
                                      width: 328.w,
                                      height: 100.h,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF323232),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 32, right: 32),
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
                                                    Text(t.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Colors.white),),
                                                    Text('/${(double.parse(nutrition.tcalories)/6).toStringAsFixed(0)} Kcal', style: TextStyle(fontSize: 16.sp, color: Colors.grey),),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            CircularPercentIndicator(
                                              center: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  AutoSizeText("${((double.parse(t.toString())/(double.parse(nutrition.tcalories)/6))*100).toStringAsFixed(1)} %",
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
                                              percent: ((double.parse(t.toString())/(double.parse(nutrition.tcalories)/6))),
                                              progressColor: lightyellow,
                                              backgroundColor: Colors.grey,
                                              circularStrokeCap: CircularStrokeCap.round,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 40.h,),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 456.h,
                              color: silverdark,
                              child: Padding(
                                padding: EdgeInsets.only(left: 10.w, right: 10.w),
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
                                    SizedBox(height: 10.h,),
                                    SizedBox(
                                      height: 267.h,
                                      child: Text("No items were added yet",
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
                                    ),
                                    SizedBox(height: 20.h,),
                                    InkWell(
                                      onTap: (){
                                        Get.to(FoodList());
                                      },
                                      child: Container(
                                        width: 328.w,
                                        height: 44.h,
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
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }else{
                      final items = snapshot1.data!.docs;
                      meals = [];
                      meals.clear();
                      int t = 0;
                      for(var item in items){
                        MealsModel meal = new MealsModel(
                            calories: item["calories"],
                            carbs: item["carbs"],
                            fat: item["fat"],
                            name: item["name"],
                            protien: item["protien"],
                            fiber: item["fiber"],
                            sugar: item["sugar"],
                            saturatedfat: item["saturatedfat"],
                            unsaturatedfat: item["unsaturatedfat"],
                            other: item["other"],
                            cholesterol: item["cholesterol"],
                            sodium: item["sodium"],
                            potassium: item["potassium"]
                        );
                        meals.add(meal);
                        t += int.parse(item["calories"]);
                      }
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 270.h,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10, right: 10),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Center(
                                          child: Text("Meal title",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 50.h,),
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
                                    SizedBox(height: 12.h,),
                                    Container(
                                      width: 328.w,
                                      height: 100.h,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF323232),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 32, right: 32),
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
                                                    Text(t.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Colors.white),),
                                                    Text('/${(double.parse(nutrition.tcalories)/6).toStringAsFixed(0)} Kcal', style: TextStyle(fontSize: 16.sp, color: Colors.grey),),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            CircularPercentIndicator(
                                              center: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  AutoSizeText("${((double.parse(t.toString())/(double.parse(nutrition.tcalories)/6))*100).toStringAsFixed(1)} %",
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
                                              percent: ((double.parse(t.toString())/(double.parse(nutrition.tcalories)/6))),
                                              progressColor: lightyellow,
                                              backgroundColor: Colors.grey,
                                              circularStrokeCap: CircularStrokeCap.round,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 40.h,),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 456.h,
                              color: silverdark,
                              child: Padding(
                                padding: EdgeInsets.only(left: 10.w, right: 10.w),
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
                                    SizedBox(height: 10.h,),
                                    SizedBox(
                                      height: 267.h,
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: meals.length,
                                          itemBuilder: (context, index) {
                                            final meal = meals[index];
                                            return Column(
                                              children: [
                                                Container(
                                                  width: 328.w,
                                                  height: 81.h,
                                                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                                                  decoration: ShapeDecoration(
                                                    color: Color(0xFF232323),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(12),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Container(
                                                        height: double.infinity,
                                                        child: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              meal.name,
                                                              style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 14.sp,
                                                                fontFamily: 'Inter',
                                                                fontWeight: FontWeight.w500,
                                                                height: 0,
                                                              ),
                                                            ),
                                                            SizedBox(height: 8.h),
                                                            Text(
                                                              '${meal.calories} Kcal',
                                                              style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 14.sp,
                                                                fontFamily: 'Inter',
                                                                fontWeight: FontWeight.w400,
                                                                height: 0,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 172.w,
                                                        height: double.infinity,
                                                        child: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          crossAxisAlignment: CrossAxisAlignment.end,
                                                          children: [
                                                            InkWell(
                                                                onTap: () async {
                                                                  await ref.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition").doc(DateFormat('dd-MM-yyyy').format(DateTime.now())).collection("meals")
                                                                      .doc(meal.name).delete().then(
                                                                        (doc) => print("Document deleted"),
                                                                    onError: (e) => print("Error updating document $e"),
                                                                  );
                                                                },
                                                                child: Icon(Icons.delete_forever_outlined, size: 24, color: Colors.white,)),
                                                            SizedBox(height: 8.h),
                                                            InkWell(
                                                              onTap: (){
                                                                showDialog(
                                                                  context: context,
                                                                  builder: (context) => AlertDialog(
                                                                    backgroundColor: Colors.black,
                                                                    content: Container(
                                                                      width: 350.w,
                                                                      height: 600.h,
                                                                      child: Column(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                            children: [
                                                                              Column(
                                                                                children: [
                                                                                  Text(meal.name,
                                                                                    textAlign: TextAlign.start,
                                                                                    style: TextStyle(
                                                                                      color: Colors.white,
                                                                                      fontSize: 14.sp,
                                                                                      fontFamily: 'Inter',
                                                                                      fontWeight: FontWeight.w600,
                                                                                      letterSpacing: 0.14,
                                                                                    ),
                                                                                  ),
                                                                                  Text('Nutrition fact',
                                                                                    style: TextStyle(
                                                                                      color: Colors.white,
                                                                                      fontSize: 12.sp,
                                                                                      fontFamily: 'Roboto',
                                                                                      fontWeight: FontWeight.w500,
                                                                                      letterSpacing: 0.12,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(height: 20.h,),
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Text("Kcal",
                                                                                textAlign: TextAlign.start,
                                                                                style: TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 14.sp,
                                                                                  fontFamily: 'Inter',
                                                                                  fontWeight: FontWeight.w600,
                                                                                  letterSpacing: 0.14,
                                                                                ),
                                                                              ),
                                                                              Text(meal.calories,
                                                                                style: TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 12.sp,
                                                                                  fontFamily: 'Roboto',
                                                                                  fontWeight: FontWeight.w500,
                                                                                  letterSpacing: 0.12,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(height: 10.h,),
                                                                          Divider(color: Colors.grey,),
                                                                          SizedBox(height: 10.h,),
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Text("Protein",
                                                                                textAlign: TextAlign.start,
                                                                                style: TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 14.sp,
                                                                                  fontFamily: 'Inter',
                                                                                  fontWeight: FontWeight.w600,
                                                                                  letterSpacing: 0.14,
                                                                                ),
                                                                              ),
                                                                              Text(meal.protien, style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 12.sp,
                                                                                fontFamily: 'Roboto',
                                                                                fontWeight: FontWeight.w500,
                                                                                letterSpacing: 0.12,
                                                                              ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(height: 10.h,),
                                                                          Divider(color: Colors.grey,),
                                                                          SizedBox(height: 10.h,),
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Text("Carbs",
                                                                                textAlign: TextAlign.start,
                                                                                style: TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 14.sp,
                                                                                  fontFamily: 'Inter',
                                                                                  fontWeight: FontWeight.w600,
                                                                                  letterSpacing: 0.14,
                                                                                ),
                                                                              ),
                                                                              Text(meal.carbs, style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 12.sp,
                                                                                fontFamily: 'Roboto',
                                                                                fontWeight: FontWeight.w500,
                                                                                letterSpacing: 0.12,
                                                                              ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(height: 8.h,),
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Text("Fiber",
                                                                                textAlign: TextAlign.start,
                                                                                style: TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 12.sp,
                                                                                  fontFamily: 'Roboto',
                                                                                  fontWeight: FontWeight.w400,
                                                                                  letterSpacing: 0.12,
                                                                                ),
                                                                              ),
                                                                              Text(meal.fiber, style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 12.sp,
                                                                                fontFamily: 'Roboto',
                                                                                fontWeight: FontWeight.w500,
                                                                                letterSpacing: 0.12,
                                                                              ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(height: 8.h,),
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Text("Sugar",
                                                                                textAlign: TextAlign.start,
                                                                                style: TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 12.sp,
                                                                                  fontFamily: 'Roboto',
                                                                                  fontWeight: FontWeight.w400,
                                                                                  letterSpacing: 0.12,
                                                                                ),
                                                                              ),
                                                                              Text(meal.sugar, style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 12.sp,
                                                                                fontFamily: 'Roboto',
                                                                                fontWeight: FontWeight.w500,
                                                                                letterSpacing: 0.12,
                                                                              ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(height: 10.h,),
                                                                          Divider(color: Colors.grey,),
                                                                          SizedBox(height: 10.h,),
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Text("Fat",
                                                                                textAlign: TextAlign.start,
                                                                                style: TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 14.sp,
                                                                                  fontFamily: 'Inter',
                                                                                  fontWeight: FontWeight.w600,
                                                                                  letterSpacing: 0.14,
                                                                                ),
                                                                              ),
                                                                              Text(meal.fat, style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 12.sp,
                                                                                fontFamily: 'Roboto',
                                                                                fontWeight: FontWeight.w500,
                                                                                letterSpacing: 0.12,
                                                                              ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(height: 8.h,),
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Text("Saturated fat",
                                                                                textAlign: TextAlign.start,
                                                                                style: TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 12.sp,
                                                                                  fontFamily: 'Roboto',
                                                                                  fontWeight: FontWeight.w400,
                                                                                  letterSpacing: 0.12,
                                                                                ),
                                                                              ),
                                                                              Text(meal.saturatedfat, style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 12.sp,
                                                                                fontFamily: 'Roboto',
                                                                                fontWeight: FontWeight.w500,
                                                                                letterSpacing: 0.12,
                                                                              ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(height: 8.h,),
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Text("Unsaturated fat",
                                                                                textAlign: TextAlign.start,
                                                                                style: TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 12.sp,
                                                                                  fontFamily: 'Roboto',
                                                                                  fontWeight: FontWeight.w400,
                                                                                  letterSpacing: 0.12,
                                                                                ),
                                                                              ),
                                                                              Text(meal.unsaturatedfat, style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 12.sp,
                                                                                fontFamily: 'Roboto',
                                                                                fontWeight: FontWeight.w500,
                                                                                letterSpacing: 0.12,
                                                                              ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(height: 10.h,),
                                                                          Divider(color: Colors.grey,),
                                                                          SizedBox(height: 10.h,),
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Text("Other",
                                                                                textAlign: TextAlign.start,
                                                                                style: TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 14.sp,
                                                                                  fontFamily: 'Inter',
                                                                                  fontWeight: FontWeight.w600,
                                                                                  letterSpacing: 0.14,
                                                                                ),
                                                                              ),
                                                                              Text(meal.other, style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 12.sp,
                                                                                fontFamily: 'Roboto',
                                                                                fontWeight: FontWeight.w500,
                                                                                letterSpacing: 0.12,
                                                                              ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(height: 8.h,),
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Text("Cholesterol",
                                                                                textAlign: TextAlign.start,
                                                                                style: TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 12.sp,
                                                                                  fontFamily: 'Roboto',
                                                                                  fontWeight: FontWeight.w400,
                                                                                  letterSpacing: 0.12,
                                                                                ),
                                                                              ),
                                                                              Text(meal.cholesterol, style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 12.sp,
                                                                                fontFamily: 'Roboto',
                                                                                fontWeight: FontWeight.w500,
                                                                                letterSpacing: 0.12,
                                                                              ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(height: 8.h,),
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Text("Sodium",
                                                                                textAlign: TextAlign.start,
                                                                                style: TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 12.sp,
                                                                                  fontFamily: 'Roboto',
                                                                                  fontWeight: FontWeight.w400,
                                                                                  letterSpacing: 0.12,
                                                                                ),
                                                                              ),
                                                                              Text(meal.sodium, style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 12.sp,
                                                                                fontFamily: 'Roboto',
                                                                                fontWeight: FontWeight.w500,
                                                                                letterSpacing: 0.12,
                                                                              ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(height: 8.h,),
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Text("Potassium",
                                                                                textAlign: TextAlign.start,
                                                                                style: TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 12.sp,
                                                                                  fontFamily: 'Roboto',
                                                                                  fontWeight: FontWeight.w400,
                                                                                  letterSpacing: 0.12,
                                                                                ),
                                                                              ),
                                                                              Text(meal.potassium, style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 12.sp,
                                                                                fontFamily: 'Roboto',
                                                                                fontWeight: FontWeight.w500,
                                                                                letterSpacing: 0.12,
                                                                              ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(height: 10.h,),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                              child: Text('view details',
                                                                style: TextStyle(
                                                                  color: Colors.white,
                                                                  fontSize: 12.sp,
                                                                  fontFamily: 'Inter',
                                                                  fontWeight: FontWeight.w400,
                                                                  height: 0,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 8.h,),
                                              ],
                                            );
                                          }
                                      ),
                                    ),
                                    SizedBox(height: 20.h,),
                                    InkWell(
                                      onTap: (){
                                        Get.to(FoodList());
                                      },
                                      child: Container(
                                        width: 328.w,
                                        height: 44.h,
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
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }
                  }else{
                    return LoadingScreen();
                  }
                },
              );
            }
            else{
              int t = 0;
              print("Not Exists");
              NutritionsModel nutrition= new NutritionsModel(calories: "0", tcalories: "1", carbs: "0", tcarbs: "1", fat: "0", tfat: "1", protien: "0", tprotien: "1",m1:false,m2:false,m3: false,m4: false,m5: false,m6: false);
              return StreamBuilder(
                stream: ref3,
                builder: (context, snapshot1) {
                  if (snapshot1.hasData && snapshot1.data != null ) {
                    if (snapshot1.data?.docs.length == 0) {
                      int t = 0;
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 270.h,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10, right: 10),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Center(
                                          child: Text("Meal title",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 50.h,),
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
                                    SizedBox(height: 12.h,),
                                    Container(
                                      width: 328.w,
                                      height: 100.h,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF323232),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 32, right: 32),
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
                                                    Text(t.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Colors.white),),
                                                    Text('/${(double.parse(nutrition.tcalories)/6).toStringAsFixed(0)} Kcal', style: TextStyle(fontSize: 16.sp, color: Colors.grey),),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            CircularPercentIndicator(
                                              center: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  AutoSizeText("${((double.parse(t.toString())/(double.parse(nutrition.tcalories)/6))*100).toStringAsFixed(1)} %",
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
                                              percent: ((double.parse(t.toString())/(double.parse(nutrition.tcalories)/6))),
                                              progressColor: lightyellow,
                                              backgroundColor: Colors.grey,
                                              circularStrokeCap: CircularStrokeCap.round,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 40.h,),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 456.h,
                              color: silverdark,
                              child: Padding(
                                padding: EdgeInsets.only(left: 10.w, right: 10.w),
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
                                    SizedBox(height: 10.h,),
                                    SizedBox(
                                      height: 267.h,
                                      child: Text("No items were added yet",
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
                                    ),
                                    SizedBox(height: 20.h,),
                                    InkWell(
                                      onTap: (){
                                        Get.to(FoodList());
                                      },
                                      child: Container(
                                        width: 328.w,
                                        height: 44.h,
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
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }else{
                      final items = snapshot1.data!.docs;
                      meals = [];
                      meals.clear();
                      int t = 0;
                      for(var item in items){

                        MealsModel meal = new MealsModel(
                            calories: item["calories"],
                            carbs: item["carbs"],
                            fat: item["fat"],
                            name: item["name"],
                            protien: item["protien"],
                            fiber: item["fiber"],
                            sugar: item["sugar"],
                            saturatedfat: item["saturatedfat"],
                            unsaturatedfat: item["unsaturatedfat"],
                            other: item["other"],
                            cholesterol: item["cholesterol"],
                            sodium: item["sodium"],
                            potassium: item["potassium"]
                        );
                        meals.add(meal);
                        t+= int.parse(item["calories"]);
                      }
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 270.h,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10, right: 10),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Center(
                                          child: Text("Meal title",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 50.h,),
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
                                    SizedBox(height: 12.h,),
                                    Container(
                                      width: 328.w,
                                      height: 100.h,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF323232),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 32, right: 32),
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
                                                    Text(t.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Colors.white),),
                                                    Text('/${(double.parse(nutrition.tcalories)/6).toStringAsFixed(0)} Kcal', style: TextStyle(fontSize: 16.sp, color: Colors.grey),),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            CircularPercentIndicator(
                                              center: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  AutoSizeText("${((double.parse(t.toString())/(double.parse(nutrition.tcalories)/6))*100).toStringAsFixed(1)} %",
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
                                              percent: ((double.parse(t.toString())/(double.parse(nutrition.tcalories)/6))),
                                              progressColor: lightyellow,
                                              backgroundColor: Colors.grey,
                                              circularStrokeCap: CircularStrokeCap.round,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 40.h,),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 456.h,
                              color: silverdark,
                              child: Padding(
                                padding: EdgeInsets.only(left: 10.w, right: 10.w),
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
                                    SizedBox(height: 10.h,),
                                    SizedBox(
                                      height: 267.h,
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: meals.length,
                                          itemBuilder: (context, index) {
                                            final meal = meals[index];
                                            return Column(
                                              children: [
                                                Container(
                                                  width: 328.w,
                                                  height: 81.h,
                                                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                                                  decoration: ShapeDecoration(
                                                    color: Color(0xFF232323),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(12),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Container(
                                                        height: double.infinity,
                                                        child: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              meal.name,
                                                              style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 14.sp,
                                                                fontFamily: 'Inter',
                                                                fontWeight: FontWeight.w500,
                                                                height: 0,
                                                              ),
                                                            ),
                                                            SizedBox(height: 8.h),
                                                            Text(
                                                              '${meal.calories} Kcal',
                                                              style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 14.sp,
                                                                fontFamily: 'Inter',
                                                                fontWeight: FontWeight.w400,
                                                                height: 0,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 172.w,
                                                        height: double.infinity,
                                                        child: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          crossAxisAlignment: CrossAxisAlignment.end,
                                                          children: [
                                                            InkWell(
                                                                onTap: () async {
                                                                  await ref.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition").doc(DateFormat('dd-MM-yyyy').format(DateTime.now())).collection("meals")
                                                                      .doc(meal.name).delete().then(
                                                                        (doc) => print("Document deleted"),
                                                                    onError: (e) => print("Error updating document $e"),
                                                                  );
                                                                },
                                                                child: Icon(Icons.delete_forever_outlined, size: 24, color: Colors.white,)),
                                                            SizedBox(height: 8.h),
                                                            InkWell(
                                                              onTap: (){
                                                                showDialog(
                                                                  context: context,
                                                                  builder: (context) => AlertDialog(
                                                                    backgroundColor: Colors.black,
                                                                    content: Container(
                                                                      width: 350.w,
                                                                      height: 600.h,
                                                                      child: Column(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                            children: [
                                                                              Column(
                                                                                children: [
                                                                                  Text(meal.name,
                                                                                    textAlign: TextAlign.start,
                                                                                    style: TextStyle(
                                                                                      color: Colors.white,
                                                                                      fontSize: 14.sp,
                                                                                      fontFamily: 'Inter',
                                                                                      fontWeight: FontWeight.w600,
                                                                                      letterSpacing: 0.14,
                                                                                    ),
                                                                                  ),
                                                                                  Text('Nutrition fact',
                                                                                    style: TextStyle(
                                                                                      color: Colors.white,
                                                                                      fontSize: 12.sp,
                                                                                      fontFamily: 'Roboto',
                                                                                      fontWeight: FontWeight.w500,
                                                                                      letterSpacing: 0.12,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(height: 20.h,),
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Text("Kcal",
                                                                                textAlign: TextAlign.start,
                                                                                style: TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 14.sp,
                                                                                  fontFamily: 'Inter',
                                                                                  fontWeight: FontWeight.w600,
                                                                                  letterSpacing: 0.14,
                                                                                ),
                                                                              ),
                                                                              Text(meal.calories,
                                                                                style: TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 12.sp,
                                                                                  fontFamily: 'Roboto',
                                                                                  fontWeight: FontWeight.w500,
                                                                                  letterSpacing: 0.12,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(height: 10.h,),
                                                                          Divider(color: Colors.grey,),
                                                                          SizedBox(height: 10.h,),
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Text("Protein",
                                                                                textAlign: TextAlign.start,
                                                                                style: TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 14.sp,
                                                                                  fontFamily: 'Inter',
                                                                                  fontWeight: FontWeight.w600,
                                                                                  letterSpacing: 0.14,
                                                                                ),
                                                                              ),
                                                                              Text(meal.protien, style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 12.sp,
                                                                                fontFamily: 'Roboto',
                                                                                fontWeight: FontWeight.w500,
                                                                                letterSpacing: 0.12,
                                                                              ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(height: 10.h,),
                                                                          Divider(color: Colors.grey,),
                                                                          SizedBox(height: 10.h,),
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Text("Carbs",
                                                                                textAlign: TextAlign.start,
                                                                                style: TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 14.sp,
                                                                                  fontFamily: 'Inter',
                                                                                  fontWeight: FontWeight.w600,
                                                                                  letterSpacing: 0.14,
                                                                                ),
                                                                              ),
                                                                              Text(meal.carbs, style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 12.sp,
                                                                                fontFamily: 'Roboto',
                                                                                fontWeight: FontWeight.w500,
                                                                                letterSpacing: 0.12,
                                                                              ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(height: 8.h,),
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Text("Fiber",
                                                                                textAlign: TextAlign.start,
                                                                                style: TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 12.sp,
                                                                                  fontFamily: 'Roboto',
                                                                                  fontWeight: FontWeight.w400,
                                                                                  letterSpacing: 0.12,
                                                                                ),
                                                                              ),
                                                                              Text(meal.fiber, style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 12.sp,
                                                                                fontFamily: 'Roboto',
                                                                                fontWeight: FontWeight.w500,
                                                                                letterSpacing: 0.12,
                                                                              ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(height: 8.h,),
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Text("Sugar",
                                                                                textAlign: TextAlign.start,
                                                                                style: TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 12.sp,
                                                                                  fontFamily: 'Roboto',
                                                                                  fontWeight: FontWeight.w400,
                                                                                  letterSpacing: 0.12,
                                                                                ),
                                                                              ),
                                                                              Text(meal.sugar, style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 12.sp,
                                                                                fontFamily: 'Roboto',
                                                                                fontWeight: FontWeight.w500,
                                                                                letterSpacing: 0.12,
                                                                              ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(height: 10.h,),
                                                                          Divider(color: Colors.grey,),
                                                                          SizedBox(height: 10.h,),
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Text("Fat",
                                                                                textAlign: TextAlign.start,
                                                                                style: TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 14.sp,
                                                                                  fontFamily: 'Inter',
                                                                                  fontWeight: FontWeight.w600,
                                                                                  letterSpacing: 0.14,
                                                                                ),
                                                                              ),
                                                                              Text(meal.fat, style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 12.sp,
                                                                                fontFamily: 'Roboto',
                                                                                fontWeight: FontWeight.w500,
                                                                                letterSpacing: 0.12,
                                                                              ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(height: 8.h,),
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Text("Saturated fat",
                                                                                textAlign: TextAlign.start,
                                                                                style: TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 12.sp,
                                                                                  fontFamily: 'Roboto',
                                                                                  fontWeight: FontWeight.w400,
                                                                                  letterSpacing: 0.12,
                                                                                ),
                                                                              ),
                                                                              Text(meal.saturatedfat, style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 12.sp,
                                                                                fontFamily: 'Roboto',
                                                                                fontWeight: FontWeight.w500,
                                                                                letterSpacing: 0.12,
                                                                              ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(height: 8.h,),
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Text("Unsaturated fat",
                                                                                textAlign: TextAlign.start,
                                                                                style: TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 12.sp,
                                                                                  fontFamily: 'Roboto',
                                                                                  fontWeight: FontWeight.w400,
                                                                                  letterSpacing: 0.12,
                                                                                ),
                                                                              ),
                                                                              Text(meal.unsaturatedfat, style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 12.sp,
                                                                                fontFamily: 'Roboto',
                                                                                fontWeight: FontWeight.w500,
                                                                                letterSpacing: 0.12,
                                                                              ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(height: 10.h,),
                                                                          Divider(color: Colors.grey,),
                                                                          SizedBox(height: 10.h,),
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Text("Other",
                                                                                textAlign: TextAlign.start,
                                                                                style: TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 14.sp,
                                                                                  fontFamily: 'Inter',
                                                                                  fontWeight: FontWeight.w600,
                                                                                  letterSpacing: 0.14,
                                                                                ),
                                                                              ),
                                                                              Text(meal.other, style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 12.sp,
                                                                                fontFamily: 'Roboto',
                                                                                fontWeight: FontWeight.w500,
                                                                                letterSpacing: 0.12,
                                                                              ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(height: 8.h,),
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Text("Cholesterol",
                                                                                textAlign: TextAlign.start,
                                                                                style: TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 12.sp,
                                                                                  fontFamily: 'Roboto',
                                                                                  fontWeight: FontWeight.w400,
                                                                                  letterSpacing: 0.12,
                                                                                ),
                                                                              ),
                                                                              Text(meal.cholesterol, style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 12.sp,
                                                                                fontFamily: 'Roboto',
                                                                                fontWeight: FontWeight.w500,
                                                                                letterSpacing: 0.12,
                                                                              ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(height: 8.h,),
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Text("Sodium",
                                                                                textAlign: TextAlign.start,
                                                                                style: TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 12.sp,
                                                                                  fontFamily: 'Roboto',
                                                                                  fontWeight: FontWeight.w400,
                                                                                  letterSpacing: 0.12,
                                                                                ),
                                                                              ),
                                                                              Text(meal.sodium, style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 12.sp,
                                                                                fontFamily: 'Roboto',
                                                                                fontWeight: FontWeight.w500,
                                                                                letterSpacing: 0.12,
                                                                              ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(height: 8.h,),
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Text("Potassium",
                                                                                textAlign: TextAlign.start,
                                                                                style: TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 12.sp,
                                                                                  fontFamily: 'Roboto',
                                                                                  fontWeight: FontWeight.w400,
                                                                                  letterSpacing: 0.12,
                                                                                ),
                                                                              ),
                                                                              Text(meal.potassium, style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 12.sp,
                                                                                fontFamily: 'Roboto',
                                                                                fontWeight: FontWeight.w500,
                                                                                letterSpacing: 0.12,
                                                                              ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(height: 10.h,),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                              child: Text('view details',
                                                                style: TextStyle(
                                                                  color: Colors.white,
                                                                  fontSize: 12.sp,
                                                                  fontFamily: 'Inter',
                                                                  fontWeight: FontWeight.w400,
                                                                  height: 0,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 8.h,),
                                              ],
                                            );
                                          }
                                      ),
                                    ),
                                    SizedBox(height: 20.h,),
                                    InkWell(
                                      onTap: (){
                                        Get.to(FoodList());
                                      },
                                      child: Container(
                                        width: 328.w,
                                        height: 44.h,
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
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }
                  }else{
                    return LoadingScreen();
                  }
                },
              );
            }
          } else {
            return LoadingScreen();
          }
        },
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MakeStream(context),
    );
  }
}
