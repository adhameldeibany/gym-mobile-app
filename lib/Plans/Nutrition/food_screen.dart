import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flockergym/Methods/colors_methods.dart';
import 'package:flockergym/NewBackend/MainMethods.dart';
import 'package:flockergym/NewBackend/Models/MealsModels.dart';
import 'package:flockergym/NewBackend/Models/NutritionsModel.dart';
import 'package:flockergym/Plans/Nutrition/newmeal_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

late String type;

class FoodScreen extends StatefulWidget {
  FoodScreen({required String data}){
    type = data;
  }

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {

  Scaffold MakeStream(BuildContext context){
    DatabaseReference ref3 = FirebaseDatabase.instance.ref("meals/");
    FirebaseFirestore ref = FirebaseFirestore.instance;
    final ref2 = ref.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition").doc(DateFormat('dd-MM-yyyy').format(DateTime.now())).snapshots();

    return Scaffold(
      backgroundColor: Colors.black,
      body: StreamBuilder(
        stream: ref3.onValue,
        builder: (context, snapshot) {
          List<MealsModel>staffe = [];
          if (snapshot.hasData && snapshot.data != null && (snapshot.data! as DatabaseEvent).snapshot.value != null) {
            staffe.clear();
            final classes = Map<dynamic, dynamic>.from((snapshot.data! as DatabaseEvent).snapshot.value as Map<dynamic, dynamic>); //typecasting
            classes.forEach((key, value) {
              final classelement = Map<String, dynamic>.from(value);
              staffe.add(
                  MealsModel(
                      calories: classelement["calories"],
                      carbs: classelement["carbs"],
                      fat: classelement["fat"],
                      name: classelement["name"],
                      protien: classelement["protien"],
                    cholesterol: classelement["cholesterol"],
                    fiber: classelement["fiber"],
                    other: classelement["other"],
                    potassium: classelement["potassium"],
                    saturatedfat: classelement["saturatedfat"],
                    sodium: classelement["sodium"],
                    sugar: classelement["sugar"],
                    unsaturatedfat: classelement["unsaturatedfat"],
                  )
              );
            });

            return Scaffold(
              backgroundColor: Colors.black,
              body: StreamBuilder(
              stream: ref2,
              builder: (_, snapshot1) {
                if (snapshot1.hasData && snapshot1.data != null ) {
                  if (snapshot1.data!.exists) {
                    final items = snapshot1.data!;
                    print("Exists");
                    NutritionsModel nutrition = new NutritionsModel(
                      calories: items.get("calories").toString(),
                      tcalories: items.get("tcalories").toString(),
                      carbs: items.get("carbs").toString(),
                      tcarbs: items.get("tcarbs").toString(),
                      fat: items.get("fat").toString(),
                      tfat: items.get("tfat").toString(),
                      protien: items.get("protien").toString(),
                      tprotien: items.get("tprotien").toString(),
                      m1: items.get("m1"),
                      m2: items.get("m2"),
                      m3: items.get("m3"),
                      m4: items.get("m4"),
                      m5: items.get("m5"),
                      m6: items.get("m6"),
                    );
                    return Scaffold(
                      backgroundColor: Colors.black,
                      body: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Column(
                            children: [
                              Container(
                                width: 350.w,
                                height: 100.h,
                                decoration: BoxDecoration(
                                  color: lightyellow,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('Daily intake', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),),
                                          Row(
                                            children: [
                                              Text(nutrition.calories, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                                              Text('/${nutrition.tcalories} Kcal', style: TextStyle(fontSize: 16.sp),),
                                            ],
                                          ),
                                        ],
                                      ),
                                      CircularPercentIndicator(
                                        center: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            AutoSizeText("${(double.parse(nutrition.calories)/double.parse(nutrition.tcalories)*100).toStringAsFixed(2)}%",
                                              maxLines: 1,
                                              style: TextStyle(
                                                color: Color(0xFF232323),
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
                                        percent: double.parse(nutrition.calories)/double.parse(nutrition.tcalories),
                                        progressColor: Color(0xff232323),
                                        backgroundColor: Colors.grey,
                                        circularStrokeCap: CircularStrokeCap.round,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.h,),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Container(
                                        width: 100.w,
                                        height: 80.h,
                                        decoration: BoxDecoration(
                                          color: silverdark,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 10),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                children: [
                                                  Text('Carbs', style: TextStyle(color: Colors.white),),
                                                ],
                                              ),
                                              SizedBox(height: 5.h,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(nutrition.carbs+" g", style: TextStyle(color: Colors.white),),
                                                  Text('/${nutrition.tcarbs} g', style: TextStyle(color: Colors.grey),),
                                                ],
                                              ),
                                              SizedBox(height: 5.h,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  LinearPercentIndicator(
                                                    center: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [

                                                        ]
                                                    ),
                                                    animation: true,
                                                    animationDuration: 3000,
                                                    barRadius: Radius.circular(20),
                                                    width: 80.w,
                                                    lineHeight: 8.h,
                                                    percent: double.parse(nutrition.carbs)/double.parse(nutrition.tcarbs),
                                                    progressColor: lightyellow,
                                                    backgroundColor: Colors.grey,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Container(
                                        width: 100.w,
                                        height: 80.h,
                                        decoration: BoxDecoration(
                                          color: silverdark,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 10),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                children: [
                                                  Text('fats', style: TextStyle(color: Colors.white),),
                                                ],
                                              ),
                                              SizedBox(height: 5.h,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(nutrition.fat+" g", style: TextStyle(color: Colors.white),),
                                                  Text('/${nutrition.tfat} g', style: TextStyle(color: Colors.grey),),
                                                ],
                                              ),
                                              SizedBox(height: 5.h,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  LinearPercentIndicator(
                                                    center: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [

                                                        ]
                                                    ),
                                                    animation: true,
                                                    animationDuration: 3000,
                                                    barRadius: Radius.circular(20),
                                                    width: 80.w,
                                                    lineHeight: 8.h,
                                                    percent: double.parse(nutrition.fat)/double.parse(nutrition.tfat),
                                                    progressColor: lightyellow,
                                                    backgroundColor: Colors.grey,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Container(
                                        width: 100.w,
                                        height: 80.h,
                                        decoration: BoxDecoration(
                                          color: silverdark,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 10),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                children: [
                                                  Text('protien', style: TextStyle(color: Colors.white),),
                                                ],
                                              ),
                                              SizedBox(height: 5.h,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(nutrition.protien, style: TextStyle(color: Colors.white),),
                                                  Text('/${nutrition.tprotien} g', style: TextStyle(color: Colors.grey),),
                                                ],
                                              ),
                                              SizedBox(height: 5.h,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  LinearPercentIndicator(
                                                    center: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [

                                                        ]
                                                    ),
                                                    animation: true,
                                                    animationDuration: 3000,
                                                    barRadius: Radius.circular(20),
                                                    width: 80.w,
                                                    lineHeight: 8.h,
                                                    percent: double.parse(nutrition.protien)/double.parse(nutrition.tprotien),
                                                    progressColor: lightyellow,
                                                    backgroundColor: Colors.grey,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Recent meals",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  TextButton(
                                      onPressed: (){
                                        Get.to(NewmealData(type: type, nutritionsModel: nutrition,));
                                      },
                                      child: Text('New meal', style: TextStyle(color: lightyellow, fontSize: 15.sp),)
                                  ),
                                ],
                              ),
                              ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: staffe.length,
                                  itemBuilder: (context, index) {
                                    final meal = staffe[index];
                                    return Column(
                                      children: [
                                        Container(
                                          width: 328.w,
                                          height: 80.h,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF323232),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(meal.name,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16.sp,
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w600,
                                                        height: 0,
                                                        letterSpacing: 0.16,
                                                      ),
                                                    ),
                                                    SizedBox(height: 8.h,),
                                                    Text('${meal.calories} Kcal ', style: TextStyle(
                                                      color: Color(0xFFDADADA),
                                                      fontSize: 12.sp,
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      height: 0,
                                                      letterSpacing: 0.12,
                                                    ),
                                                    ),
                                                  ],
                                                ),
                                                InkWell(
                                                  onTap: (){
                                                    if (nutrition.tfat==1) {
                                                      final snackBar = SnackBar(
                                                        duration: Duration(milliseconds: 1500,),
                                                        elevation: 0,
                                                        behavior: SnackBarBehavior.floating,
                                                        backgroundColor: Colors.transparent,
                                                        content: AwesomeSnackbarContent(
                                                          title: 'Wrong',
                                                          message: 'You Don\'t Have A Nutrition Plan' ,
                                                          contentType: ContentType.failure,
                                                        ),
                                                      );
                                                      ScaffoldMessenger.of(context)
                                                        ..hideCurrentSnackBar()
                                                        ..showSnackBar(snackBar);
                                                      return;
                                                    }
                                                    else{
                                                      if (int.parse(nutrition.tcalories) - int.parse(nutrition.calories)  >= int.parse(meal.calories)) {
                                                        FirebaseFirestore.instance
                                                            .collection("usersclasses")
                                                            .doc(FirebaseAuth.instance.currentUser!.uid)
                                                            .collection("nutirition")
                                                            .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                            .update({
                                                          "calories": (double.parse(nutrition.calories) + double.parse(meal.calories)).toStringAsFixed(0),
                                                        });
                                                      }else{
                                                        FirebaseFirestore.instance
                                                            .collection("usersclasses")
                                                            .doc(FirebaseAuth.instance.currentUser!.uid)
                                                            .collection("nutirition")
                                                            .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                            .update({
                                                          "calories": nutrition.tcalories,
                                                        });
                                                      }

                                                      if (int.parse(nutrition.tcarbs) - int.parse(nutrition.carbs)  >= int.parse(meal.carbs)) {
                                                        FirebaseFirestore.instance
                                                            .collection("usersclasses")
                                                            .doc(FirebaseAuth.instance.currentUser!.uid)
                                                            .collection("nutirition")
                                                            .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                            .update({
                                                          "carbs": (double.parse(nutrition.carbs) + double.parse(meal.carbs)).toStringAsFixed(0),
                                                        });
                                                      }else{
                                                        FirebaseFirestore.instance
                                                            .collection("usersclasses")
                                                            .doc(FirebaseAuth.instance.currentUser!.uid)
                                                            .collection("nutirition")
                                                            .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                            .update({
                                                          "carbs": nutrition.tcarbs,
                                                        });
                                                      }

                                                      if (int.parse(nutrition.tprotien) - int.parse(nutrition.protien)  >= int.parse((double.parse(meal.protien)).toStringAsFixed(0))) {
                                                        FirebaseFirestore.instance
                                                            .collection("usersclasses")
                                                            .doc(FirebaseAuth.instance.currentUser!.uid)
                                                            .collection("nutirition")
                                                            .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                            .update({
                                                          "protien": (double.parse(nutrition.protien) + double.parse(meal.protien)).toStringAsFixed(0),
                                                        });
                                                      }else{
                                                        FirebaseFirestore.instance
                                                            .collection("usersclasses")
                                                            .doc(FirebaseAuth.instance.currentUser!.uid)
                                                            .collection("nutirition")
                                                            .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                            .update({
                                                          "protien": nutrition.tprotien,
                                                        });
                                                      }
                                                      if (int.parse(nutrition.tfat) - int.parse(nutrition.fat)  >= int.parse((double.parse(meal.fat)).toStringAsFixed(0))) {
                                                        FirebaseFirestore.instance
                                                            .collection("usersclasses")
                                                            .doc(FirebaseAuth.instance.currentUser!.uid)
                                                            .collection("nutirition")
                                                            .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                            .update({
                                                          "fat": (double.parse(nutrition.fat) + double.parse(meal.fat)).toStringAsFixed(0),
                                                        });
                                                      }else{
                                                        FirebaseFirestore.instance
                                                            .collection("usersclasses")
                                                            .doc(FirebaseAuth.instance.currentUser!.uid)
                                                            .collection("nutirition")
                                                            .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                            .update({
                                                          "fat": nutrition.tfat,
                                                        });
                                                      }
                                                    }
                                                  },
                                                  child: Container(
                                                    width: 42.w,
                                                    height: 42.h,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      color: greylight,
                                                    ),
                                                    child: Center(child: Icon(Icons.add, color: lightyellow, size: 20,)),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 16.h,),
                                      ],
                                    );
                                  }
                              ),
                              SizedBox(height: 20.h,),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  else{
                    print("Not Exists");
                    NutritionsModel nutrition= new NutritionsModel(calories: "0", tcalories: "1", carbs: "0", tcarbs: "1", fat: "0", tfat: "1", protien: "0", tprotien: "1",m1:false,m2:false,m3: false,m4: false,m5: false,m6: false);
                    return Scaffold(
                      backgroundColor: Colors.black,
                      body: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Column(
                            children: [
                              Container(
                                width: 350.w,
                                height: 100.h,
                                decoration: BoxDecoration(
                                  color: lightyellow,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('Daily intake', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),),
                                          Row(
                                            children: [
                                              Text(nutrition.calories, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                                              Text('/${nutrition.tcalories} Kcal', style: TextStyle(fontSize: 16.sp),),
                                            ],
                                          ),
                                        ],
                                      ),
                                      CircularPercentIndicator(
                                        center: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text("${(double.parse(nutrition.calories)/double.parse(nutrition.tcalories)*100).toStringAsFixed(2)}%",
                                              style: TextStyle(
                                                color: Color(0xFF232323),
                                                fontSize: 12.sp,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                                height: 0,
                                              ),
                                            ),
                                          ],
                                        ),
                                        animation: true,
                                        animationDuration: 3000,
                                        radius: 30.w,
                                        lineWidth: 8,
                                        percent: double.parse(nutrition.calories)/double.parse(nutrition.tcalories),
                                        progressColor: Color(0xff232323),
                                        backgroundColor: Colors.grey,
                                        circularStrokeCap: CircularStrokeCap.round,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.h,),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Container(
                                        width: 100.w,
                                        height: 80.h,
                                        decoration: BoxDecoration(
                                          color: silverdark,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 10),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                children: [
                                                  Text('Carbs', style: TextStyle(color: Colors.white),),
                                                ],
                                              ),
                                              SizedBox(height: 5.h,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(nutrition.carbs+" g", style: TextStyle(color: Colors.white),),
                                                  Text('/${nutrition.tcarbs} g', style: TextStyle(color: Colors.grey),),
                                                ],
                                              ),
                                              SizedBox(height: 5.h,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  LinearPercentIndicator(
                                                    center: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [

                                                        ]
                                                    ),
                                                    animation: true,
                                                    animationDuration: 3000,
                                                    barRadius: Radius.circular(20),
                                                    width: 80.w,
                                                    lineHeight: 8.h,
                                                    percent: double.parse(nutrition.carbs)/double.parse(nutrition.tcarbs),
                                                    progressColor: lightyellow,
                                                    backgroundColor: Colors.grey,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Container(
                                        width: 100.w,
                                        height: 80.h,
                                        decoration: BoxDecoration(
                                          color: silverdark,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 10),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                children: [
                                                  Text('fats', style: TextStyle(color: Colors.white),),
                                                ],
                                              ),
                                              SizedBox(height: 5.h,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(nutrition.fat+" g", style: TextStyle(color: Colors.white),),
                                                  Text('/${nutrition.tfat} g', style: TextStyle(color: Colors.grey),),
                                                ],
                                              ),
                                              SizedBox(height: 5.h,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  LinearPercentIndicator(
                                                    center: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [

                                                        ]
                                                    ),
                                                    animation: true,
                                                    animationDuration: 3000,
                                                    barRadius: Radius.circular(20),
                                                    width: 80.w,
                                                    lineHeight: 8.h,
                                                    percent: double.parse(nutrition.fat)/double.parse(nutrition.tfat),
                                                    progressColor: lightyellow,
                                                    backgroundColor: Colors.grey,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Container(
                                        width: 100.w,
                                        height: 80.h,
                                        decoration: BoxDecoration(
                                          color: silverdark,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 10),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                children: [
                                                  Text('protien', style: TextStyle(color: Colors.white),),
                                                ],
                                              ),
                                              SizedBox(height: 5.h,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(nutrition.protien, style: TextStyle(color: Colors.white),),
                                                  Text('/${nutrition.tprotien} g', style: TextStyle(color: Colors.grey),),
                                                ],
                                              ),
                                              SizedBox(height: 5.h,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  LinearPercentIndicator(
                                                    center: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [

                                                        ]
                                                    ),
                                                    animation: true,
                                                    animationDuration: 3000,
                                                    barRadius: Radius.circular(20),
                                                    width: 80.w,
                                                    lineHeight: 8.h,
                                                    percent: double.parse(nutrition.protien)/double.parse(nutrition.tprotien),
                                                    progressColor: lightyellow,
                                                    backgroundColor: Colors.grey,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Recent meals",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  TextButton(
                                      onPressed: (){
                                        Get.to(NewmealData(type: type,nutritionsModel: nutrition,));
                                      },
                                      child: Text('New meal', style: TextStyle(color: lightyellow, fontSize: 15.sp),)
                                  ),
                                ],
                              ),
                              ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: staffe.length,
                                  itemBuilder: (context, index) {
                                    final meal = staffe[index];
                                    return Column(
                                      children: [
                                        Container(
                                          width: 328.w,
                                          height: 80.h,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF323232),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(meal.name,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16.sp,
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w600,
                                                        height: 0,
                                                        letterSpacing: 0.16,
                                                      ),
                                                    ),
                                                    SizedBox(height: 8.h,),
                                                    Text('${meal.calories} Kcal ', style: TextStyle(
                                                      color: Color(0xFFDADADA),
                                                      fontSize: 12.sp,
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      height: 0,
                                                      letterSpacing: 0.12,
                                                    ),
                                                    ),
                                                  ],
                                                ),
                                                InkWell(
                                                  onTap: (){
                                                    if (nutrition.tfat==1) {
                                                      final snackBar = SnackBar(
                                                        duration: Duration(milliseconds: 1500,),
                                                        elevation: 0,
                                                        behavior: SnackBarBehavior.floating,
                                                        backgroundColor: Colors.transparent,
                                                        content: AwesomeSnackbarContent(
                                                          title: 'Wrong',
                                                          message: 'You Don\'t Have A Nutrition Plan' ,
                                                          contentType: ContentType.failure,
                                                        ),
                                                      );
                                                      ScaffoldMessenger.of(context)
                                                        ..hideCurrentSnackBar()
                                                        ..showSnackBar(snackBar);
                                                      return;
                                                    }
                                                    else{
                                                      if (int.parse(nutrition.tcalories) - int.parse(nutrition.calories)  >= int.parse(meal.calories)) {
                                                        FirebaseFirestore.instance
                                                            .collection("usersclasses")
                                                            .doc(FirebaseAuth.instance.currentUser!.uid)
                                                            .collection("nutirition")
                                                            .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                            .update({
                                                          "calories": (double.parse(nutrition.calories) + double.parse(meal.calories)).toStringAsFixed(0),
                                                        });
                                                      }else{
                                                        FirebaseFirestore.instance
                                                            .collection("usersclasses")
                                                            .doc(FirebaseAuth.instance.currentUser!.uid)
                                                            .collection("nutirition")
                                                            .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                            .update({
                                                          "calories": nutrition.tcalories,
                                                        });
                                                      }

                                                      if (int.parse(nutrition.tcarbs) - int.parse(nutrition.carbs)  >= int.parse(meal.carbs)) {
                                                        FirebaseFirestore.instance
                                                            .collection("usersclasses")
                                                            .doc(FirebaseAuth.instance.currentUser!.uid)
                                                            .collection("nutirition")
                                                            .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                            .update({
                                                          "carbs": (double.parse(nutrition.carbs) + double.parse(meal.carbs)).toStringAsFixed(0),
                                                        });
                                                      }else{
                                                        FirebaseFirestore.instance
                                                            .collection("usersclasses")
                                                            .doc(FirebaseAuth.instance.currentUser!.uid)
                                                            .collection("nutirition")
                                                            .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                            .update({
                                                          "carbs": nutrition.tcarbs,
                                                        });
                                                      }

                                                      if (int.parse(nutrition.tprotien) - int.parse(nutrition.protien)  >= int.parse((double.parse(meal.protien)).toStringAsFixed(0))) {
                                                        FirebaseFirestore.instance
                                                            .collection("usersclasses")
                                                            .doc(FirebaseAuth.instance.currentUser!.uid)
                                                            .collection("nutirition")
                                                            .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                            .update({
                                                          "protien": (double.parse(nutrition.protien) + double.parse(meal.protien)).toStringAsFixed(0),
                                                        });
                                                      }else{
                                                        FirebaseFirestore.instance
                                                            .collection("usersclasses")
                                                            .doc(FirebaseAuth.instance.currentUser!.uid)
                                                            .collection("nutirition")
                                                            .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                            .update({
                                                          "protien": nutrition.tprotien,
                                                        });
                                                      }
                                                      if (int.parse(nutrition.tfat) - int.parse(nutrition.fat)  >= int.parse((double.parse(meal.fat)).toStringAsFixed(0))) {
                                                        FirebaseFirestore.instance
                                                            .collection("usersclasses")
                                                            .doc(FirebaseAuth.instance.currentUser!.uid)
                                                            .collection("nutirition")
                                                            .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                            .update({
                                                          "fat": (double.parse(nutrition.fat) + double.parse(meal.fat)).toStringAsFixed(0),
                                                        });
                                                      }else{
                                                        FirebaseFirestore.instance
                                                            .collection("usersclasses")
                                                            .doc(FirebaseAuth.instance.currentUser!.uid)
                                                            .collection("nutirition")
                                                            .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                            .update({
                                                          "fat": nutrition.tfat,
                                                        });
                                                      }
                                                    }
                                                  },
                                                  child: Container(
                                                    width: 42.w,
                                                    height: 42.h,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      color: greylight,
                                                    ),
                                                    child: Center(child: Icon(Icons.add, color: lightyellow, size: 20,)),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 16.h,),
                                      ],
                                    );
                                  }
                              ),
                              SizedBox(height: 20.h,),
                            ],
                          ),
                        ),
                      ),
                    );

                  }
                } else {
                  return LoadingScreen();
                }
              },
            ),
            );

          }else{
            return LoadingScreen();
          }
        },
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(type,
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
      body: MakeStream(context),
    );
  }
}
