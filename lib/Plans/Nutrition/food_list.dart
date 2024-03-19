import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flockergym/Methods/colors_methods.dart';
import 'package:flockergym/NewBackend/MainMethods.dart';
import 'package:flockergym/NewBackend/Models/MealsModels.dart';
import 'package:flockergym/NewBackend/Models/NutritionsModel.dart';
import 'package:flockergym/Plans/Nutrition/nutrition_plans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

late List<MealsModel> meals;
String t = "High to Low";
List<MealsModel> meals2 = [];
late int sum = 0;
List checkListItems = [];
bool isactive = false;

class FoodList extends StatefulWidget {
  const FoodList({super.key});

  @override
  State<FoodList> createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {

  bool isChecked = false;

  int valueSelected = 0;

  void _handleRadioValueChange2(int value) {
    setState(() {
      valueSelected = value;
    });
  }

  Scaffold MakeStream(BuildContext context){
    FirebaseFirestore ref = FirebaseFirestore.instance;
    final ref2 = ref.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition").doc(DateFormat('dd-MM-yyyy').format(DateTime.now())).snapshots();
    DatabaseReference ref3 = FirebaseDatabase.instance.ref("meals/");

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
                body: StreamBuilder(
                  stream: ref3.onValue,
                  builder: (context, snapshot) {
                    meals = [];
                    if (snapshot.hasData && snapshot.data != null && (snapshot.data! as DatabaseEvent).snapshot.value != null) {

                      meals.clear();
                      if (checkListItems.isEmpty) {
                        checkListItems.clear();
                        isChecked =true;
                      }

                      final classes = Map<dynamic, dynamic>.from((snapshot.data! as DatabaseEvent).snapshot.value as Map<dynamic, dynamic>); //typecasting
                      int init = 0;
                      classes.forEach((key, value) {
                        final classelement = Map<String, dynamic>.from(value);
                        meals.add(
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

                        if (isChecked) {
                          checkListItems.add(
                            {
                              "id":init,
                              "value":false,
                              "title":classelement["name"],
                              "calories": int.parse(classelement["calories"])
                            }
                          );
                        }
                        init += 1;
                      });

                      isChecked = false;

                      return Scaffold(
                        backgroundColor: Colors.black,
                        appBar: AppBar(
                          backgroundColor: Colors.black,
                          elevation: 0,
                          title: Text("Food list",
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
                                    SizedBox(height: 10.h,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Daily intake",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(sum.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Colors.white),),
                                            Text('/${(double.parse(nutrition.tcalories)/6).toStringAsFixed(0)} Kcal', style: TextStyle(fontSize: 16.sp, color: Colors.grey),),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10.h,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        LinearPercentIndicator(
                                          center: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [

                                              ]
                                          ),
                                          animation: true,
                                          barRadius: Radius.circular(20),
                                          animationDuration: 3000,
                                          width: 330.w,
                                          lineHeight: 15.h,
                                          percent: sum/(double.parse(nutrition.tcalories)/6),
                                          progressColor: lightyellow,
                                          backgroundColor: Colors.grey,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10.h,),
                                    Row(
                                      children: [
                                        Text("add more food to reach the Kcal amount",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20.h,),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50.h,
                                color: silverdark,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15, right: 15),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Items",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  InkWell(
                                                    onTap: (){
                                                      _displayBottomSheet(context);
                                                    },
                                                    child: Container(
                                                      width: 120.w,
                                                      height: 40.h,
                                                      decoration: BoxDecoration(
                                                        color: darkgrey,
                                                        borderRadius: BorderRadius.circular(4),
                                                      ),
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(left: 10, right: 10),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Text(t,
                                                              style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 12.sp,
                                                                fontFamily: 'Inter',
                                                                fontWeight: FontWeight.w400,
                                                                height: 0,
                                                              ),
                                                            ),
                                                            Icon(Icons.arrow_drop_down, color: Colors.white, size: 16,)
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.h,),
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: meals.length,
                                  itemBuilder: (context, index) {
                                    final meal = meals2.length==0?meals[index]:meals2[index];
                                    return Card(
                                        color: Color(0xFF232323),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        margin: EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h, bottom: 5.h),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(meal.name,
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      fontSize: 16.sp,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Checkbox(
                                                      value: checkListItems[index]["value"],
                                                      activeColor: lightyellow,
                                                      side: BorderSide(color: Colors.grey, width: 2),
                                                      onChanged: (newBool) {
                                                        setState(() {
                                                          if (newBool!) {
                                                            sum += int.parse(checkListItems[index]["calories"].toString());
                                                            if (sum==(double.parse(nutrition.tcalories)/6).toInt()) {
                                                              isactive = true;
                                                            }else{
                                                              isactive = false;
                                                            }
                                                          }else{
                                                            sum -= int.parse(checkListItems[index]["calories"].toString());
                                                            if (sum==(double.parse(nutrition.tcalories)/6).toInt()) {
                                                              isactive = true;
                                                            }else{
                                                              isactive = false;
                                                            }
                                                          }
                                                          checkListItems[index]["value"] = !checkListItems[index]["value"];
                                                        });
                                                      }
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("${meal.calories} Kcal",
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      fontSize: 16.sp,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: (){
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
                                                    child: Text('view details', style: TextStyle(
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
                                            ],
                                          ),
                                        )
                                    );
                                  }
                              ),
                              SizedBox(height: 20.h,),
                              InkWell(
                                onTap: () async {
                                  if (isactive) {
                                    final mealsref = ref.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition").doc(DateFormat('dd-MM-yyyy').format(DateTime.now())).collection("meals");
                                    for(var checkli in checkListItems){
                                      if (checkli["value"]) {

                                        final meal = {
                                          "calories": meals[checkli["id"]].calories,
                                          "carbs": meals[checkli["id"]].carbs,
                                          "fat": meals[checkli["id"]].fat,
                                          "name": meals[checkli["id"]].name,
                                          "protien" : meals[checkli["id"]].protien,
                                          "fiber":meals[checkli["id"]].fiber,
                                          "sugar":meals[checkli["id"]].sugar,
                                          "saturatedfat":meals[checkli["id"]].saturatedfat,
                                          "unsaturatedfat":meals[checkli["id"]].unsaturatedfat,
                                          "other": meals[checkli["id"]].other,
                                          "cholesterol": meals[checkli["id"]].cholesterol,
                                          "sodium": meals[checkli["id"]].sodium,
                                          "potassium": meals[checkli["id"]].potassium,
                                        };

                                        await mealsref.doc(meals[checkli["id"]].name).set(meal).onError((error, stackTrace) => print("Error"));;
                                      }
                                    }
                                    setState(() {
                                      sum=0;
                                      isactive = false;
                                      checkListItems = [];
                                      Navigator.pop(context);
                                    });
                                  }
                                },
                                child: Container(
                                  width: 328.w,
                                  height: 44.h,
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: ShapeDecoration(
                                    color: isactive?lightyellow: Color(0xFF3C3C3C),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                  ),
                                  child: Center(
                                    child: Text("Confirm",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: Colors.black,
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
                              SizedBox(height: 10.h,),
                            ],
                          ),
                        ),
                      );
                    }else{
                      return LoadingScreen();
                    }
                  },
                ),
              );
            }
            else{
              print("Not Exists");
              NutritionsModel nutrition= new NutritionsModel(calories: "0", tcalories: "1", carbs: "0", tcarbs: "1", fat: "0", tfat: "1", protien: "0", tprotien: "1",m1:false,m2:false,m3: false,m4: false,m5: false,m6: false);
              return Scaffold(
                backgroundColor: Colors.black,
                body: StreamBuilder(
                  stream: ref3.onValue,
                  builder: (context, snapshot) {
                    meals = [];
                    if (snapshot.hasData && snapshot.data != null && (snapshot.data! as DatabaseEvent).snapshot.value != null) {

                      meals.clear();
                      if (checkListItems.isEmpty) {
                        checkListItems.clear();
                        isChecked =true;
                      }

                      final classes = Map<dynamic, dynamic>.from((snapshot.data! as DatabaseEvent).snapshot.value as Map<dynamic, dynamic>); //typecasting
                      int init = 0;
                      classes.forEach((key, value) {
                        final classelement = Map<String, dynamic>.from(value);
                        meals.add(
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

                        if (isChecked) {
                          checkListItems.add(
                              {
                                "id":init,
                                "value":false,
                                "title":classelement["name"],
                                "calories": int.parse(classelement["calories"])
                              }
                          );
                        }
                        init += 1;
                      });

                      isChecked = false;

                      return Scaffold(
                        backgroundColor: Colors.black,
                        appBar: AppBar(
                          backgroundColor: Colors.black,
                          elevation: 0,
                          title: Text("Food list",
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
                                    SizedBox(height: 10.h,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Daily intake",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(sum.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Colors.white),),
                                            Text('/${(double.parse(nutrition.tcalories)/6).toStringAsFixed(0)} Kcal', style: TextStyle(fontSize: 16.sp, color: Colors.grey),),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10.h,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        LinearPercentIndicator(
                                          center: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [

                                              ]
                                          ),
                                          animation: true,
                                          barRadius: Radius.circular(20),
                                          animationDuration: 3000,
                                          width: 330.w,
                                          lineHeight: 15.h,
                                          percent: sum/(double.parse(nutrition.tcalories)/6),
                                          progressColor: lightyellow,
                                          backgroundColor: Colors.grey,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10.h,),
                                    Row(
                                      children: [
                                        Text("add more food to reach the Kcal amount",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20.h,),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50.h,
                                color: silverdark,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15, right: 15),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Items",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  InkWell(
                                                    onTap: (){
                                                      _displayBottomSheet(context);
                                                    },
                                                    child: Container(
                                                      width: 120.w,
                                                      height: 40.h,
                                                      decoration: BoxDecoration(
                                                        color: darkgrey,
                                                        borderRadius: BorderRadius.circular(4),
                                                      ),
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(left: 10, right: 10),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Text(t,
                                                              style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 12.sp,
                                                                fontFamily: 'Inter',
                                                                fontWeight: FontWeight.w400,
                                                                height: 0,
                                                              ),
                                                            ),
                                                            Icon(Icons.arrow_drop_down, color: Colors.white, size: 16,)
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.h,),
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: meals.length,
                                  itemBuilder: (context, index) {
                                    final meal = meals2.length==0?meals[index]:meals2[index];
                                    return Card(
                                        color: Color(0xFF232323),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        margin: EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h, bottom: 5.h),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(meal.name,
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      fontSize: 16.sp,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Checkbox(
                                                      value: checkListItems[index]["value"],
                                                      activeColor: lightyellow,
                                                      side: BorderSide(color: Colors.grey, width: 2),
                                                      onChanged: (newBool) {
                                                        setState(() {
                                                          if (newBool!) {
                                                            sum += int.parse(checkListItems[index]["calories"].toString());
                                                            if (sum==(double.parse(nutrition.tcalories)/6).toInt()) {
                                                              isactive = true;
                                                            }else{
                                                              isactive = false;
                                                            }
                                                          }else{
                                                            sum -= int.parse(checkListItems[index]["calories"].toString());
                                                            if (sum==(double.parse(nutrition.tcalories)/6).toInt()) {
                                                              isactive = true;
                                                            }else{
                                                              isactive = false;
                                                            }
                                                          }
                                                          checkListItems[index]["value"] = !checkListItems[index]["value"];
                                                        });
                                                      }
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("${meal.calories} Kcal",
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      fontSize: 16.sp,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: (){
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
                                                    child: Text('view details', style: TextStyle(
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
                                            ],
                                          ),
                                        )
                                    );
                                  }
                              ),
                              SizedBox(height: 20.h,),
                              InkWell(
                                onTap: () async {
                                  if (isactive) {
                                    final mealsref = ref.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition").doc(DateFormat('dd-MM-yyyy').format(DateTime.now())).collection("meals");
                                    for(var checkli in checkListItems){
                                      if (checkli["value"]) {

                                        final meal = {
                                          "calories": meals[checkli["id"]].calories,
                                          "carbs": meals[checkli["id"]].carbs,
                                          "fat": meals[checkli["id"]].fat,
                                          "name": meals[checkli["id"]].name,
                                          "protien" : meals[checkli["id"]].protien,
                                          "fiber":meals[checkli["id"]].fiber,
                                          "sugar":meals[checkli["id"]].sugar,
                                          "saturatedfat":meals[checkli["id"]].saturatedfat,
                                          "unsaturatedfat":meals[checkli["id"]].unsaturatedfat,
                                          "other": meals[checkli["id"]].other,
                                          "cholesterol": meals[checkli["id"]].cholesterol,
                                          "sodium": meals[checkli["id"]].sodium,
                                          "potassium": meals[checkli["id"]].potassium,
                                        };

                                        await mealsref.doc(meals[checkli["id"]].name).set(meal).onError((error, stackTrace) => print("Error"));;
                                      }
                                    }
                                    setState(() {
                                      sum=0;
                                      isactive = false;
                                      checkListItems = [];
                                      Navigator.pop(context);
                                    });
                                  }
                                },
                                child: Container(
                                  width: 328.w,
                                  height: 44.h,
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: ShapeDecoration(
                                    color: isactive?lightyellow: Color(0xFF3C3C3C),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                  ),
                                  child: Center(
                                    child: Text("Confirm",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: Colors.black,
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
                              SizedBox(height: 10.h,),
                            ],
                          ),
                        ),
                      );
                    }else{
                      return LoadingScreen();
                    }
                  },
                ),
              );
            }
          } else {
            return LoadingScreen();
          }
        },
      ),
    );

    return LoadingScreen();
  }

  @override
  Widget build(BuildContext context) {
    return MakeStream(context);
  }
  Future _displayBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        barrierColor: silverdark.withOpacity(0.5),
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        builder: (context) => StatefulBuilder(
          builder: (context, setState) => Container(
            height: 180.h,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 30.h,),
                    InkWell(
                      onTap: (){
                        setState(() {
                          valueSelected = 0 as int;
                        });
                        _handleRadioValueChange2(0);
                        this.setState(() {
                          meals.sort((b, a) => double.parse(a.calories).compareTo(double.parse(b.calories)));
                          meals2 = meals;
                          t = "High to low";
                        });
                      },
                      child: Container(
                        width: 320.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: silverdark,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('High to low', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.white),),
                              Transform.scale(
                                scale: 1,
                                child: Radio(
                                  activeColor: lightyellow,
                                  value: 0,
                                  groupValue: valueSelected,
                                  onChanged: (value) {

                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.w,),
                    InkWell(
                      onTap: (){
                        setState(() {
                          valueSelected = 1 as int;
                        });
                        _handleRadioValueChange2(1);
                        this.setState(() {
                          meals.sort((a, b) => double.parse(a.calories).compareTo(double.parse(b.calories)));
                          meals2 = meals;
                          t = "Low to High";
                        });
                      },
                      child: Container(
                        width: 320.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: silverdark,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Low to high', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.white),),
                              Transform.scale(
                                scale: 1,
                                child: Radio(
                                  activeColor: lightyellow,
                                  value: 1,
                                  groupValue: valueSelected,
                                  onChanged: (value) {

                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.w,),
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}
