import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flockergym/Methods/colors_methods.dart';
import 'package:flockergym/NewBackend/MainMethods.dart';
import 'package:flockergym/NewBackend/Models/NutritionsModel.dart';
import 'package:flockergym/Plans/Nutrition/food_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

List<String> meals = ['breakfast','brunch','elevenses','lunch','supper','dinner'];
List<String> mealssub = [
  'The first meal of the day. Usually around 6am-9am.',
  'A meal eaten in the late morning, instead of BReakfast and lUNCH. (informal)',
  'A snack (for example, biscuits and coffee). Around 11am. (BrE, informal)',
  'A meal in the middle of the day. Usually around noon or 1pm.',
  'A light or informal evening meal. Around 6pm-7pm.',
  'The main meal of the day, eaten either in the middle of the day or in the evening. Usually when people say "dinner", they mean an evening meal, around 7pm-9pm.'
];

FirebaseFirestore ref = FirebaseFirestore.instance;
final ref2 = ref.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition").doc(DateFormat('dd-MM-yyyy').format(DateTime.now())).snapshots();

class NutritionPlans extends StatefulWidget {
  NutritionPlans({required NutritionsModel nutritionsModel}){
  }

  @override
  State<NutritionPlans> createState() => _NutritionPlansState();
}

class _NutritionPlansState extends State<NutritionPlans> {

  Scaffold MakeStream(BuildContext context){
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
                appBar: AppBar(
                  backgroundColor: Colors.black,
                  elevation: 0,
                  title: Text("Nutrition Plans",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),
                  ),
                  leading: BackButton(
                    color: Colors.white,
                  ),
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      children: [
                        SizedBox(height: 10.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(FontAwesomeIcons.fire, color: Colors.white, size: 20,),
                                SizedBox(width: 10.w,),
                                Text("Calories",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h,),
                        Row(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width*0.53,
                                  height: MediaQuery.of(context).size.width*0.56,
                                  decoration: BoxDecoration(
                                    color: lightyellow,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircularPercentIndicator(
                                        center: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text("Kcal",
                                              style: TextStyle(color: silverdark, fontWeight: FontWeight.bold, fontSize: 15.sp),),
                                            Text(nutrition.calories,
                                              style: TextStyle(color: silverdark, fontWeight: FontWeight.bold, fontSize: 15.sp),),
                                            Text("of ${nutrition.tcalories}",
                                              style: TextStyle(color: Colors.black38, fontWeight: FontWeight.bold, fontSize: 13.sp),),
                                          ],
                                        ),
                                        animation: true,
                                        animationDuration: 3000,
                                        radius: 70.w,
                                        lineWidth: 14,
                                        percent: double.parse(nutrition.calories)/double.parse(nutrition.tcalories),
                                        progressColor: Color(0xff232323),
                                        backgroundColor: Colors.grey,
                                        circularStrokeCap: CircularStrokeCap.round,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 10.w,),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width*0.36,
                                      height: MediaQuery.of(context).size.width*0.16,
                                      decoration: BoxDecoration(
                                        color: silverdark,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 10, right: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('Carbs', style: TextStyle(color: Colors.white),),
                                                Text(nutrition.carbs, style: TextStyle(color: lightyellow),),
                                              ],
                                            ),
                                            CircularPercentIndicator(
                                              center: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(nutrition.tcarbs,
                                                    style: TextStyle(
                                                      color: Color(0xFFB9B9B9),
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
                                              radius: 20.w,
                                              lineWidth: 3.5,
                                              percent: double.parse(nutrition.carbs)/double.parse(nutrition.tcarbs),
                                              progressColor: lightyellow,
                                              backgroundColor: Colors.grey,
                                              circularStrokeCap: CircularStrokeCap.round,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15.h,),
                                Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width*0.36,
                                      height: MediaQuery.of(context).size.width*0.16,
                                      decoration: BoxDecoration(
                                        color: silverdark,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 10, right: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('Protein', style: TextStyle(color: Colors.white),),
                                                Text(nutrition.protien, style: TextStyle(color: lightyellow),),
                                              ],
                                            ),
                                            CircularPercentIndicator(
                                              center: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(nutrition.tprotien,
                                                    style: TextStyle(
                                                      color: Color(0xFFB9B9B9),
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
                                              radius: 20.w,
                                              lineWidth: 3.5,
                                              percent: double.parse(nutrition.protien)/double.parse(nutrition.tprotien),
                                              progressColor: lightyellow,
                                              backgroundColor: Colors.grey,
                                              circularStrokeCap: CircularStrokeCap.round,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15.h,),
                                Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width*0.36,
                                      height: MediaQuery.of(context).size.width*0.16,
                                      decoration: BoxDecoration(
                                        color: silverdark,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 10, right: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('Fat', style: TextStyle(color: Colors.white),),
                                                Text(nutrition.fat, style: TextStyle(color: lightyellow),),
                                              ],
                                            ),
                                            CircularPercentIndicator(
                                              center: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(nutrition.tfat,
                                                    style: TextStyle(
                                                      color: Color(0xFFB9B9B9),
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
                                              radius: 20.w,
                                              lineWidth: 3.5,
                                              percent: double.parse(nutrition.fat)/double.parse(nutrition.tfat),
                                              progressColor: lightyellow,
                                              backgroundColor: Colors.grey,
                                              circularStrokeCap: CircularStrokeCap.round,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h,),
                        Row(
                          children: [
                            Icon(FontAwesomeIcons.utensils, color: Colors.white, size: 20,),
                            SizedBox(width: 10.w,),
                            Text("Meals",
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
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: meals.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: (){
                                  Get.to(FoodScreen(data:meals[index]));
                                },
                                child: Card(
                                    color: silverdark,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    margin: EdgeInsets.only(top: 10, bottom: 10),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          index ==0?
                                          nutrition.m1?
                                          Container(
                                            foregroundDecoration: BoxDecoration(
                                              color: Colors.grey,
                                              backgroundBlendMode: BlendMode.saturation,
                                            ),
                                            child: Image(
                                              image: Image.asset('assets/food.png').image
                                            )
                                          ):
                                          Image(
                                              image: Image.asset('assets/food.png').image
                                          )
                                          :
                                          index ==1?
                                          nutrition.m2?
                                          Container(
                                              foregroundDecoration: BoxDecoration(
                                                color: Colors.grey,
                                                backgroundBlendMode: BlendMode.saturation,
                                              ),
                                              child: Image(
                                                  image: Image.asset('assets/food.png').image
                                              )
                                          ):
                                          Image(
                                              image: Image.asset('assets/food.png').image
                                          ):
                                          index ==2?
                                          nutrition.m3?
                                          Container(
                                              foregroundDecoration: BoxDecoration(
                                                color: Colors.grey,
                                                backgroundBlendMode: BlendMode.saturation,
                                              ),
                                              child: Image(
                                                  image: Image.asset('assets/food.png').image
                                              )
                                          ):
                                          Image(
                                              image: Image.asset('assets/food.png').image
                                          ):
                                          index ==3?
                                          nutrition.m4?
                                          Container(
                                              foregroundDecoration: BoxDecoration(
                                                color: Colors.grey,
                                                backgroundBlendMode: BlendMode.saturation,
                                              ),
                                              child: Image(
                                                  image: Image.asset('assets/food.png').image
                                              )
                                          ):
                                          Image(
                                              image: Image.asset('assets/food.png').image
                                          ):
                                          index ==4?
                                          nutrition.m5?
                                          Container(
                                              foregroundDecoration: BoxDecoration(
                                                color: Colors.grey,
                                                backgroundBlendMode: BlendMode.saturation,
                                              ),
                                              child: Image(
                                                  image: Image.asset('assets/food.png').image
                                              )
                                          ):
                                          Image(
                                              image: Image.asset('assets/food.png').image
                                          ): nutrition.m1?
                                          Container(
                                              foregroundDecoration: BoxDecoration(
                                                color: Colors.grey,
                                                backgroundBlendMode: BlendMode.saturation,
                                              ),
                                              child: Image(
                                                  image: Image.asset('assets/food.png').image
                                              )
                                          ):
                                          Image(
                                              image: Image.asset('assets/food.png').image
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(meals[index],
                                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15.sp),),
                                              SizedBox(
                                                  width: 200.w,
                                                  child: Text(mealssub[index], style: TextStyle(color: Colors.grey),)),
                                              Text(nutrition.tfat!=1?'${(double.parse(nutrition.tcalories)/6).toStringAsFixed(0)} Kcal':'0 Kcal ', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),),
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
                                              else {
                                                final itemcalories = int.parse((double.parse(nutrition.tcalories) / 6).toStringAsFixed(0));
                                                final itemcarbs = int.parse((double.parse(nutrition.tcarbs) / 6).toStringAsFixed(0));
                                                final itemfat = int.parse((double.parse(nutrition.tfat) / 6).toStringAsFixed(0));
                                                final itemprotien = int.parse((double.parse(nutrition.tprotien) / 6).toStringAsFixed(0));

                                                final totalcalories = int.parse(nutrition.tcalories);
                                                final totalcarbs = int.parse(nutrition.tcarbs);
                                                final totalfat = int.parse(nutrition.tfat);
                                                final totalprotien = int.parse(nutrition.tprotien);

                                                final calories = int.parse(nutrition.calories);
                                                final carbs = int.parse(nutrition.carbs);
                                                final fat = int.parse(nutrition.fat);
                                                final protien = int.parse(nutrition.protien);

                                                if (index == 0) {
                                                  if (nutrition.m1) {
                                                    FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                        .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                        .update({"calories": (calories - itemcalories).toStringAsFixed(0),
                                                    });
                                                    FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                        .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                        .update({"carbs": (carbs - itemcarbs).toStringAsFixed(0),
                                                    });
                                                    FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                        .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                        .update({"fat": (fat - itemfat).toStringAsFixed(0),
                                                    });
                                                    FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                        .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                        .update({"protien": (protien - itemprotien).toStringAsFixed(0),
                                                    });
                                                  }
                                                  else {
                                                    if (totalcalories - calories >= itemcalories) {
                                                      FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({"calories": (calories + itemcalories).toStringAsFixed(0),
                                                      });
                                                    }else{
                                                      FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({"calories": totalcalories.toStringAsFixed(0),
                                                      });
                                                    }
                                                    if (totalprotien - protien >= itemprotien) {
                                                      FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({"protien": (protien + itemprotien).toStringAsFixed(0),
                                                      });
                                                    }else{
                                                      FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({"protien": totalprotien.toStringAsFixed(0),
                                                      });
                                                    }
                                                    if (totalfat - fat >= itemfat) {
                                                      FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({"fat": (fat + itemfat).toStringAsFixed(0),
                                                      });
                                                    }else{
                                                      FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({"fat": totalfat.toStringAsFixed(0),
                                                      });
                                                    }
                                                    if (totalcarbs - carbs >= itemcarbs) {
                                                      FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({"carbs": (carbs + itemcarbs).toStringAsFixed(0),
                                                      });
                                                    }else{
                                                      FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({"carbs": totalcarbs.toStringAsFixed(0),
                                                      });
                                                    }
                                                  }
                                                  FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                      .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                      .update({"m1": !nutrition.m1,
                                                  });
                                                }
                                                if (index == 1) {
                                                  if (nutrition.m2) {
                                                    FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                        .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                        .update({"calories": (calories - itemcalories).toStringAsFixed(0),
                                                    });
                                                    FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                        .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                        .update({"carbs": (carbs - itemcarbs).toStringAsFixed(0),
                                                    });
                                                    FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                        .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                        .update({"fat": (fat - itemfat).toStringAsFixed(0),
                                                    });
                                                    FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                        .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                        .update({"protien": (protien - itemprotien).toStringAsFixed(0),
                                                    });
                                                  }
                                                  else {
                                                    if (totalcalories - calories >= itemcalories) {
                                                      FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({"calories": (calories + itemcalories).toStringAsFixed(0),
                                                      });
                                                    }else{
                                                      FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({"calories": totalcalories.toStringAsFixed(0),
                                                      });
                                                    }
                                                    if (totalprotien - protien >= itemprotien) {
                                                      FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({"protien": (protien + itemprotien).toStringAsFixed(0),
                                                      });
                                                    }else{
                                                      FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({"protien": totalprotien.toStringAsFixed(0),
                                                      });
                                                    }
                                                    if (totalfat - fat >= itemfat) {
                                                      FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({"fat": (fat + itemfat).toStringAsFixed(0),
                                                      });
                                                    }else{
                                                      FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({"fat": totalfat.toStringAsFixed(0),
                                                      });
                                                    }
                                                    if (totalcarbs - carbs >= itemcarbs) {
                                                      FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({"carbs": (carbs + itemcarbs).toStringAsFixed(0),
                                                      });
                                                    }else{
                                                      FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({"carbs": totalcarbs.toStringAsFixed(0),
                                                      });
                                                    }
                                                  }
                                                  FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                      .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                      .update({"m2": !nutrition.m2,
                                                  });
                                                }
                                                if (index == 2) {
                                                  if (nutrition.m3) {
                                                    FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                        .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                        .update({"calories": (calories - itemcalories).toStringAsFixed(0),
                                                    });
                                                    FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                        .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                        .update({"carbs": (carbs - itemcarbs).toStringAsFixed(0),
                                                    });
                                                    FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                        .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                        .update({"fat": (fat - itemfat).toStringAsFixed(0),
                                                    });
                                                    FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                        .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                        .update({"protien": (protien - itemprotien).toStringAsFixed(0),
                                                    });
                                                  }
                                                  else {
                                                    if (totalcalories - calories >= itemcalories) {
                                                      FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({"calories": (calories + itemcalories).toStringAsFixed(0),
                                                      });
                                                    }else{
                                                      FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({"calories": totalcalories.toStringAsFixed(0),
                                                      });
                                                    }
                                                    if (totalprotien - protien >= itemprotien) {
                                                      FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({"protien": (protien + itemprotien).toStringAsFixed(0),
                                                      });
                                                    }else{
                                                      FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({"protien": totalprotien.toStringAsFixed(0),
                                                      });
                                                    }
                                                    if (totalfat - fat >= itemfat) {
                                                      FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({"fat": (fat + itemfat).toStringAsFixed(0),
                                                      });
                                                    }else{
                                                      FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({"fat": totalfat.toStringAsFixed(0),
                                                      });
                                                    }
                                                    if (totalcarbs - carbs >= itemcarbs) {
                                                      FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({"carbs": (carbs + itemcarbs).toStringAsFixed(0),
                                                      });
                                                    }else{
                                                      FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({"carbs": totalcarbs.toStringAsFixed(0),
                                                      });
                                                    }
                                                  }
                                                  FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                      .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                      .update({"m3": !nutrition.m3,
                                                  });
                                                }
                                                if (index == 3) {
                                                  if (nutrition.m4) {
                                                    FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                        .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                        .update({"calories": (calories - itemcalories).toStringAsFixed(0),
                                                    });
                                                    FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                        .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                        .update({"carbs": (carbs - itemcarbs).toStringAsFixed(0),
                                                    });
                                                    FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                        .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                        .update({"fat": (fat - itemfat).toStringAsFixed(0),
                                                    });
                                                    FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                        .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                        .update({"protien": (protien - itemprotien).toStringAsFixed(0),
                                                    });
                                                  }
                                                  else {
                                                    if (totalcalories - calories >= itemcalories) {
                                                      FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({"calories": (calories + itemcalories).toStringAsFixed(0),
                                                      });
                                                    }else{
                                                      FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({"calories": totalcalories.toStringAsFixed(0),
                                                      });
                                                    }
                                                    if (totalprotien - protien >= itemprotien) {
                                                      FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({"protien": (protien + itemprotien).toStringAsFixed(0),
                                                      });
                                                    }else{
                                                      FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({"protien": totalprotien.toStringAsFixed(0),
                                                      });
                                                    }
                                                    if (totalfat - fat >= itemfat) {
                                                      FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({"fat": (fat + itemfat).toStringAsFixed(0),
                                                      });
                                                    }else{
                                                      FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({"fat": totalfat.toStringAsFixed(0),
                                                      });
                                                    }
                                                    if (totalcarbs - carbs >= itemcarbs) {
                                                      FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({"carbs": (carbs + itemcarbs).toStringAsFixed(0),
                                                      });
                                                    }else{
                                                      FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({"carbs": totalcarbs.toStringAsFixed(0),
                                                      });
                                                    }
                                                  }
                                                  FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                      .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                      .update({"m4": !nutrition.m4,
                                                  });
                                                }
                                                if (index == 4) {
                                                  if (nutrition.m5) {
                                                    FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                        .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                        .update({"calories": (calories - itemcalories).toStringAsFixed(0),
                                                    });
                                                    FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                        .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                        .update({"carbs": (carbs - itemcarbs).toStringAsFixed(0),
                                                    });
                                                    FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                        .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                        .update({"fat": (fat - itemfat).toStringAsFixed(0),
                                                    });
                                                    FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                        .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                        .update({"protien": (protien - itemprotien).toStringAsFixed(0),
                                                    });
                                                  }
                                                  else {
                                                    if (totalcalories - calories >= itemcalories) {
                                                      FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({"calories": (calories + itemcalories).toStringAsFixed(0),
                                                      });
                                                    }else{
                                                      FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({"calories": totalcalories.toStringAsFixed(0),
                                                      });
                                                    }
                                                    if (totalprotien - protien >= itemprotien) {
                                                      FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({"protien": (protien + itemprotien).toStringAsFixed(0),
                                                      });
                                                    }else{
                                                      FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({"protien": totalprotien.toStringAsFixed(0),
                                                      });
                                                    }
                                                    if (totalfat - fat >= itemfat) {
                                                      FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({"fat": (fat + itemfat).toStringAsFixed(0),
                                                      });
                                                    }else{
                                                      FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({"fat": totalfat.toStringAsFixed(0),
                                                      });
                                                    }
                                                    if (totalcarbs - carbs >= itemcarbs) {
                                                      FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({"carbs": (carbs + itemcarbs).toStringAsFixed(0),
                                                      });
                                                    }else{
                                                      FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({"carbs": totalcarbs.toStringAsFixed(0),
                                                      });
                                                    }
                                                  }
                                                  FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                      .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                      .update({"m5": !nutrition.m5,
                                                  });
                                                }
                                                if (index == 5) {
                                                  if (nutrition.m6) {
                                                    FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                        .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                        .update({"calories": (calories - itemcalories).toStringAsFixed(0),
                                                    });
                                                    FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                        .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                        .update({"carbs": (carbs - itemcarbs).toStringAsFixed(0),
                                                    });
                                                    FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                        .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                        .update({"fat": (fat - itemfat).toStringAsFixed(0),
                                                    });
                                                    FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                        .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                        .update({"protien": (protien - itemprotien).toStringAsFixed(0),
                                                    });
                                                  }
                                                  else {
                                                    if (totalcalories - calories >= itemcalories) {
                                                      FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({"calories": (calories + itemcalories).toStringAsFixed(0),
                                                      });
                                                    }else{
                                                      FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({"calories": totalcalories.toStringAsFixed(0),
                                                      });
                                                    }
                                                    if (totalprotien - protien >= itemprotien) {
                                                      FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({"protien": (protien + itemprotien).toStringAsFixed(0),
                                                      });
                                                    }else{
                                                      FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({"protien": totalprotien.toStringAsFixed(0),
                                                      });
                                                    }
                                                    if (totalfat - fat >= itemfat) {
                                                      FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({"fat": (fat + itemfat).toStringAsFixed(0),
                                                      });
                                                    }else{
                                                      FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({"fat": totalfat.toStringAsFixed(0),
                                                      });
                                                    }
                                                    if (totalcarbs - carbs >= itemcarbs) {
                                                      FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({"carbs": (carbs + itemcarbs).toStringAsFixed(0),
                                                      });
                                                    }else{
                                                      FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({"carbs": totalcarbs.toStringAsFixed(0),
                                                      });
                                                    }
                                                  }
                                                  FirebaseFirestore.instance.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition")
                                                      .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                      .update({"m6": !nutrition.m6,
                                                  });
                                                }
                                              }
                                            },
                                            child: Container(
                                              width: 45.w,
                                              height: 45.h,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: greylight,
                                              ),
                                              child: Center(child: Icon(
                                                index == 0?
                                                nutrition.m1?Icons.remove:Icons.add:
                                                    index == 1?
                                                nutrition.m2?Icons.remove:Icons.add:
                                                    index == 2?
                                                nutrition.m3?Icons.remove:Icons.add:
                                                    index == 3?
                                                nutrition.m4?Icons.remove:Icons.add:
                                                    index == 4?
                                                nutrition.m5?Icons.remove:Icons.add:
                                                nutrition.m6?Icons.remove:Icons.add,
                                                color: lightyellow, size: 25,)),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                ),
                              );
                            }
                        ),
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
                appBar: AppBar(
                  backgroundColor: Colors.black,
                  elevation: 0,
                  title: Text("Nutrition Plans",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),
                  ),
                  leading: BackButton(
                    color: Colors.white,
                  ),
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      children: [
                        SizedBox(height: 10.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(FontAwesomeIcons.fire, color: Colors.white, size: 20,),
                                SizedBox(width: 10.w,),
                                Text("Calories",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h,),
                        Row(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width*0.53,
                                  height: MediaQuery.of(context).size.width*0.56,
                                  decoration: BoxDecoration(
                                    color: lightyellow,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircularPercentIndicator(
                                        center: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text("Kcal",
                                              style: TextStyle(color: silverdark, fontWeight: FontWeight.bold, fontSize: 15.sp),),
                                            Text(nutrition.calories,
                                              style: TextStyle(color: silverdark, fontWeight: FontWeight.bold, fontSize: 15.sp),),
                                            Text("of ${nutrition.tcalories}",
                                              style: TextStyle(color: Colors.black38, fontWeight: FontWeight.bold, fontSize: 13.sp),),
                                          ],
                                        ),
                                        animation: true,
                                        animationDuration: 3000,
                                        radius: 70.w,
                                        lineWidth: 14,
                                        percent: double.parse(nutrition.calories)/double.parse(nutrition.tcalories),
                                        progressColor: Color(0xff232323),
                                        backgroundColor: Colors.grey,
                                        circularStrokeCap: CircularStrokeCap.round,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 10.w,),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width*0.36,
                                      height: MediaQuery.of(context).size.width*0.16,
                                      decoration: BoxDecoration(
                                        color: silverdark,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 10, right: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('Carbs', style: TextStyle(color: Colors.white),),
                                                Text(nutrition.carbs, style: TextStyle(color: lightyellow),),
                                              ],
                                            ),
                                            CircularPercentIndicator(
                                              center: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(nutrition.tcarbs,
                                                    style: TextStyle(
                                                      color: Color(0xFFB9B9B9),
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
                                              radius: 20.w,
                                              lineWidth: 3.5,
                                              percent: double.parse(nutrition.carbs)/double.parse(nutrition.tcarbs),
                                              progressColor: lightyellow,
                                              backgroundColor: Colors.grey,
                                              circularStrokeCap: CircularStrokeCap.round,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15.h,),
                                Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width*0.36,
                                      height: MediaQuery.of(context).size.width*0.16,
                                      decoration: BoxDecoration(
                                        color: silverdark,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 10, right: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('Protein', style: TextStyle(color: Colors.white),),
                                                Text(nutrition.protien, style: TextStyle(color: lightyellow),),
                                              ],
                                            ),
                                            CircularPercentIndicator(
                                              center: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(nutrition.tprotien,
                                                    style: TextStyle(
                                                      color: Color(0xFFB9B9B9),
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
                                              radius: 20.w,
                                              lineWidth: 3.5,
                                              percent: double.parse(nutrition.protien)/double.parse(nutrition.tprotien),
                                              progressColor: lightyellow,
                                              backgroundColor: Colors.grey,
                                              circularStrokeCap: CircularStrokeCap.round,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15.h,),
                                Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width*0.36,
                                      height: MediaQuery.of(context).size.width*0.16,
                                      decoration: BoxDecoration(
                                        color: silverdark,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 10, right: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('Fat', style: TextStyle(color: Colors.white),),
                                                Text(nutrition.fat, style: TextStyle(color: lightyellow),),
                                              ],
                                            ),
                                            CircularPercentIndicator(
                                              center: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(nutrition.tfat,
                                                    style: TextStyle(
                                                      color: Color(0xFFB9B9B9),
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
                                              radius: 20.w,
                                              lineWidth: 3.5,
                                              percent: double.parse(nutrition.fat)/double.parse(nutrition.tfat),
                                              progressColor: lightyellow,
                                              backgroundColor: Colors.grey,
                                              circularStrokeCap: CircularStrokeCap.round,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h,),
                        Row(
                          children: [
                            Icon(FontAwesomeIcons.utensils, color: Colors.white, size: 20,),
                            SizedBox(width: 10.w,),
                            Text("Meals",
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
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: meals.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: (){
                                  Get.to(FoodScreen(data:meals[index]));
                                },
                                child: Card(
                                    color: silverdark,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    margin: EdgeInsets.only(top: 10, bottom: 10),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          index ==0?
                                          nutrition.m1?
                                          Container(
                                              foregroundDecoration: BoxDecoration(
                                                color: Colors.grey,
                                                backgroundBlendMode: BlendMode.saturation,
                                              ),
                                              child: Image(
                                                  image: Image.asset('assets/food.png').image
                                              )
                                          ):
                                          Image(
                                              image: Image.asset('assets/food.png').image
                                          )
                                              :
                                          index ==1?
                                          nutrition.m2?
                                          Container(
                                              foregroundDecoration: BoxDecoration(
                                                color: Colors.grey,
                                                backgroundBlendMode: BlendMode.saturation,
                                              ),
                                              child: Image(
                                                  image: Image.asset('assets/food.png').image
                                              )
                                          ):
                                          Image(
                                              image: Image.asset('assets/food.png').image
                                          ):
                                          index ==2?
                                          nutrition.m3?
                                          Container(
                                              foregroundDecoration: BoxDecoration(
                                                color: Colors.grey,
                                                backgroundBlendMode: BlendMode.saturation,
                                              ),
                                              child: Image(
                                                  image: Image.asset('assets/food.png').image
                                              )
                                          ):
                                          Image(
                                              image: Image.asset('assets/food.png').image
                                          ):
                                          index ==3?
                                          nutrition.m4?
                                          Container(
                                              foregroundDecoration: BoxDecoration(
                                                color: Colors.grey,
                                                backgroundBlendMode: BlendMode.saturation,
                                              ),
                                              child: Image(
                                                  image: Image.asset('assets/food.png').image
                                              )
                                          ):
                                          Image(
                                              image: Image.asset('assets/food.png').image
                                          ):
                                          index ==4?
                                          nutrition.m5?
                                          Container(
                                              foregroundDecoration: BoxDecoration(
                                                color: Colors.grey,
                                                backgroundBlendMode: BlendMode.saturation,
                                              ),
                                              child: Image(
                                                  image: Image.asset('assets/food.png').image
                                              )
                                          ):
                                          Image(
                                              image: Image.asset('assets/food.png').image
                                          ): nutrition.m1?
                                          Container(
                                              foregroundDecoration: BoxDecoration(
                                                color: Colors.grey,
                                                backgroundBlendMode: BlendMode.saturation,
                                              ),
                                              child: Image(
                                                  image: Image.asset('assets/food.png').image
                                              )
                                          ):
                                          Image(
                                              image: Image.asset('assets/food.png').image
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(meals[index],
                                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15.sp),),
                                              SizedBox(
                                                  width: 200.w,
                                                  child: Text(mealssub[index], style: TextStyle(color: Colors.grey),)),
                                              Text(nutrition.tfat!=1?'${(double.parse(nutrition.tcalories)/6).toStringAsFixed(0)} Kcal':'0 Kcal ', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),),
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
                                                if (index == 0) {
                                                  if (nutrition.m1) {
                                                    if (int.parse(nutrition.calories) - int.parse((double.parse(nutrition.tcalories)/6).toStringAsFixed(0))  >= int.parse((double.parse(nutrition.tcalories)/6).toStringAsFixed(0))) {
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "calories": (double.parse(nutrition.calories) - double.parse(nutrition.tcalories)/6).toStringAsFixed(0),
                                                      });
                                                    }else{
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "calories": "0",
                                                      });
                                                    }

                                                    if (int.parse(nutrition.carbs) - int.parse((double.parse(nutrition.tcarbs)/6).toStringAsFixed(0))  >= int.parse((double.parse(nutrition.tcarbs)/6).toStringAsFixed(0))) {
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "carbs": (double.parse(nutrition.carbs) - double.parse(nutrition.tcarbs)/6).toStringAsFixed(0),
                                                      });
                                                    }else{
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "carbs": "0",
                                                      });
                                                    }

                                                    if (int.parse(nutrition.protien) - int.parse((double.parse(nutrition.tprotien)/6).toStringAsFixed(0))  >= int.parse((double.parse(nutrition.tprotien)/6).toStringAsFixed(0))) {
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "protien": (double.parse(nutrition.protien) - double.parse(nutrition.tprotien)/6).toStringAsFixed(0),
                                                      });
                                                    }else{
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "protien": "0",
                                                      });
                                                    }
                                                    if (int.parse(nutrition.fat) - int.parse((double.parse(nutrition.tfat)/6).toStringAsFixed(0))  >= int.parse((double.parse(nutrition.tfat)/6).toStringAsFixed(0))) {
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "fat": (double.parse(nutrition.fat) - double.parse(nutrition.tfat)/6).toStringAsFixed(0),
                                                      });
                                                    }else{
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "fat": "0",
                                                      });
                                                    }
                                                  }
                                                  else{
                                                    if (int.parse(nutrition.calories) - int.parse((double.parse(nutrition.tcalories)/6).toStringAsFixed(0))  >= int.parse((double.parse(nutrition.tcalories)/6).toStringAsFixed(0))) {
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "calories": (double.parse(nutrition.calories) + double.parse(nutrition.tcalories)/6).toStringAsFixed(0),
                                                      });
                                                    }
                                                    else{
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "calories": nutrition.tcalories,
                                                      });
                                                    }

                                                    if (int.parse(nutrition.carbs) - int.parse((double.parse(nutrition.tcarbs)/6).toStringAsFixed(0))  >= int.parse((double.parse(nutrition.tcarbs)/6).toStringAsFixed(0))) {
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "carbs": (double.parse(nutrition.carbs) + double.parse(nutrition.tcarbs)/6).toStringAsFixed(0),
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

                                                    if (int.parse(nutrition.protien) - int.parse((double.parse(nutrition.tprotien)/6).toStringAsFixed(0))  >= int.parse((double.parse(nutrition.tprotien)/6).toStringAsFixed(0))) {
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "protien": (double.parse(nutrition.protien) + double.parse(nutrition.tprotien)/6).toStringAsFixed(0),
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
                                                    if (int.parse(nutrition.fat) - int.parse((double.parse(nutrition.tfat)/6).toStringAsFixed(0))  >= int.parse((double.parse(nutrition.tfat)/6).toStringAsFixed(0))) {
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "fat": (double.parse(nutrition.fat) + double.parse(nutrition.tfat)/6).toStringAsFixed(0),
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
                                                  FirebaseFirestore.instance
                                                      .collection("usersclasses")
                                                      .doc(FirebaseAuth.instance.currentUser!.uid)
                                                      .collection("nutirition")
                                                      .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                      .update({
                                                    "m1": !nutrition.m1,
                                                  });
                                                  return;
                                                }
                                                else if (index == 1) {
                                                  if (nutrition.m2) {
                                                    if (int.parse(nutrition.calories) - int.parse((double.parse(nutrition.tcalories)/6).toStringAsFixed(0))  >= int.parse((double.parse(nutrition.tcalories)/6).toStringAsFixed(0))) {
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "calories": (double.parse(nutrition.calories) - double.parse(nutrition.tcalories)/6).toStringAsFixed(0),
                                                      });
                                                    }else{
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "calories": "0",
                                                      });
                                                    }

                                                    if (int.parse(nutrition.carbs) - int.parse((double.parse(nutrition.tcarbs)/6).toStringAsFixed(0))  >= int.parse((double.parse(nutrition.tcarbs)/6).toStringAsFixed(0))) {
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "carbs": (double.parse(nutrition.carbs) - double.parse(nutrition.tcarbs)/6).toStringAsFixed(0),
                                                      });
                                                    }else{
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "carbs": "0",
                                                      });
                                                    }

                                                    if (int.parse(nutrition.protien) - int.parse((double.parse(nutrition.tprotien)/6).toStringAsFixed(0))  >= int.parse((double.parse(nutrition.tprotien)/6).toStringAsFixed(0))) {
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "protien": (double.parse(nutrition.protien) - double.parse(nutrition.tprotien)/6).toStringAsFixed(0),
                                                      });
                                                    }else{
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "protien": "0",
                                                      });
                                                    }
                                                    if (int.parse(nutrition.fat) - int.parse((double.parse(nutrition.tfat)/6).toStringAsFixed(0))  >= int.parse((double.parse(nutrition.tfat)/6).toStringAsFixed(0))) {
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "fat": (double.parse(nutrition.fat) - double.parse(nutrition.tfat)/6).toStringAsFixed(0),
                                                      });
                                                    }else{
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "fat": "0",
                                                      });
                                                    }
                                                  }
                                                  else{
                                                    if (int.parse(nutrition.calories) - int.parse((double.parse(nutrition.tcalories)/6).toStringAsFixed(0))  >= int.parse((double.parse(nutrition.tcalories)/6).toStringAsFixed(0))) {
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "calories": (double.parse(nutrition.calories) + double.parse(nutrition.tcalories)/6).toStringAsFixed(0),
                                                      });
                                                    }
                                                    else{
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "calories": nutrition.tcalories,
                                                      });
                                                    }

                                                    if (int.parse(nutrition.carbs) - int.parse((double.parse(nutrition.tcarbs)/6).toStringAsFixed(0))  >= int.parse((double.parse(nutrition.tcarbs)/6).toStringAsFixed(0))) {
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "carbs": (double.parse(nutrition.carbs) + double.parse(nutrition.tcarbs)/6).toStringAsFixed(0),
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

                                                    if (int.parse(nutrition.protien) - int.parse((double.parse(nutrition.tprotien)/6).toStringAsFixed(0))  >= int.parse((double.parse(nutrition.tprotien)/6).toStringAsFixed(0))) {
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "protien": (double.parse(nutrition.protien) + double.parse(nutrition.tprotien)/6).toStringAsFixed(0),
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
                                                    if (int.parse(nutrition.fat) - int.parse((double.parse(nutrition.tfat)/6).toStringAsFixed(0))  >= int.parse((double.parse(nutrition.tfat)/6).toStringAsFixed(0))) {
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "fat": (double.parse(nutrition.fat) + double.parse(nutrition.tfat)/6).toStringAsFixed(0),
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
                                                  FirebaseFirestore.instance
                                                      .collection("usersclasses")
                                                      .doc(FirebaseAuth.instance.currentUser!.uid)
                                                      .collection("nutirition")
                                                      .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                      .update({
                                                    "m2": !nutrition.m2,
                                                  });
                                                  return;
                                                }
                                                else if (index == 2) {
                                                  if (nutrition.m3) {
                                                    if (int.parse(nutrition.calories) - int.parse((double.parse(nutrition.tcalories)/6).toStringAsFixed(0))  >= int.parse((double.parse(nutrition.tcalories)/6).toStringAsFixed(0))) {
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "calories": (double.parse(nutrition.calories) - double.parse(nutrition.tcalories)/6).toStringAsFixed(0),
                                                      });
                                                    }else{
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "calories": "0",
                                                      });
                                                    }

                                                    if (int.parse(nutrition.carbs) - int.parse((double.parse(nutrition.tcarbs)/6).toStringAsFixed(0))  >= int.parse((double.parse(nutrition.tcarbs)/6).toStringAsFixed(0))) {
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "carbs": (double.parse(nutrition.carbs) - double.parse(nutrition.tcarbs)/6).toStringAsFixed(0),
                                                      });
                                                    }else{
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "carbs": "0",
                                                      });
                                                    }

                                                    if (int.parse(nutrition.protien) - int.parse((double.parse(nutrition.tprotien)/6).toStringAsFixed(0))  >= int.parse((double.parse(nutrition.tprotien)/6).toStringAsFixed(0))) {
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "protien": (double.parse(nutrition.protien) - double.parse(nutrition.tprotien)/6).toStringAsFixed(0),
                                                      });
                                                    }else{
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "protien": "0",
                                                      });
                                                    }
                                                    if (int.parse(nutrition.fat) - int.parse((double.parse(nutrition.tfat)/6).toStringAsFixed(0))  >= int.parse((double.parse(nutrition.tfat)/6).toStringAsFixed(0))) {
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "fat": (double.parse(nutrition.fat) - double.parse(nutrition.tfat)/6).toStringAsFixed(0),
                                                      });
                                                    }else{
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "fat": "0",
                                                      });
                                                    }
                                                  }
                                                  else{
                                                    if (int.parse(nutrition.calories) - int.parse((double.parse(nutrition.tcalories)/6).toStringAsFixed(0))  >= int.parse((double.parse(nutrition.tcalories)/6).toStringAsFixed(0))) {
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "calories": (double.parse(nutrition.calories) + double.parse(nutrition.tcalories)/6).toStringAsFixed(0),
                                                      });
                                                    }
                                                    else{
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "calories": nutrition.tcalories,
                                                      });
                                                    }

                                                    if (int.parse(nutrition.carbs) - int.parse((double.parse(nutrition.tcarbs)/6).toStringAsFixed(0))  >= int.parse((double.parse(nutrition.tcarbs)/6).toStringAsFixed(0))) {
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "carbs": (double.parse(nutrition.carbs) + double.parse(nutrition.tcarbs)/6).toStringAsFixed(0),
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

                                                    if (int.parse(nutrition.protien) - int.parse((double.parse(nutrition.tprotien)/6).toStringAsFixed(0))  >= int.parse((double.parse(nutrition.tprotien)/6).toStringAsFixed(0))) {
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "protien": (double.parse(nutrition.protien) + double.parse(nutrition.tprotien)/6).toStringAsFixed(0),
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
                                                    if (int.parse(nutrition.fat) - int.parse((double.parse(nutrition.tfat)/6).toStringAsFixed(0))  >= int.parse((double.parse(nutrition.tfat)/6).toStringAsFixed(0))) {
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "fat": (double.parse(nutrition.fat) + double.parse(nutrition.tfat)/6).toStringAsFixed(0),
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
                                                  FirebaseFirestore.instance
                                                      .collection("usersclasses")
                                                      .doc(FirebaseAuth.instance.currentUser!.uid)
                                                      .collection("nutirition")
                                                      .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                      .update({
                                                    "m3": !nutrition.m3,
                                                  });
                                                  return;
                                                }
                                                else if (index == 3) {
                                                  if (nutrition.m4) {
                                                    if (int.parse(nutrition.calories) - int.parse((double.parse(nutrition.tcalories)/6).toStringAsFixed(0))  >= int.parse((double.parse(nutrition.tcalories)/6).toStringAsFixed(0))) {
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "calories": (double.parse(nutrition.calories) - double.parse(nutrition.tcalories)/6).toStringAsFixed(0),
                                                      });
                                                    }else{
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "calories": "0",
                                                      });
                                                    }

                                                    if (int.parse(nutrition.carbs) - int.parse((double.parse(nutrition.tcarbs)/6).toStringAsFixed(0))  >= int.parse((double.parse(nutrition.tcarbs)/6).toStringAsFixed(0))) {
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "carbs": (double.parse(nutrition.carbs) - double.parse(nutrition.tcarbs)/6).toStringAsFixed(0),
                                                      });
                                                    }else{
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "carbs": "0",
                                                      });
                                                    }

                                                    if (int.parse(nutrition.protien) - int.parse((double.parse(nutrition.tprotien)/6).toStringAsFixed(0))  >= int.parse((double.parse(nutrition.tprotien)/6).toStringAsFixed(0))) {
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "protien": (double.parse(nutrition.protien) - double.parse(nutrition.tprotien)/6).toStringAsFixed(0),
                                                      });
                                                    }else{
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "protien": "0",
                                                      });
                                                    }
                                                    if (int.parse(nutrition.fat) - int.parse((double.parse(nutrition.tfat)/6).toStringAsFixed(0))  >= int.parse((double.parse(nutrition.tfat)/6).toStringAsFixed(0))) {
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "fat": (double.parse(nutrition.fat) - double.parse(nutrition.tfat)/6).toStringAsFixed(0),
                                                      });
                                                    }else{
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "fat": "0",
                                                      });
                                                    }
                                                  }
                                                  else{
                                                    if (int.parse(nutrition.calories) - int.parse((double.parse(nutrition.tcalories)/6).toStringAsFixed(0))  >= int.parse((double.parse(nutrition.tcalories)/6).toStringAsFixed(0))) {
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "calories": (double.parse(nutrition.calories) + double.parse(nutrition.tcalories)/6).toStringAsFixed(0),
                                                      });
                                                    }
                                                    else{
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "calories": nutrition.tcalories,
                                                      });
                                                    }

                                                    if (int.parse(nutrition.carbs) - int.parse((double.parse(nutrition.tcarbs)/6).toStringAsFixed(0))  >= int.parse((double.parse(nutrition.tcarbs)/6).toStringAsFixed(0))) {
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "carbs": (double.parse(nutrition.carbs) + double.parse(nutrition.tcarbs)/6).toStringAsFixed(0),
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

                                                    if (int.parse(nutrition.protien) - int.parse((double.parse(nutrition.tprotien)/6).toStringAsFixed(0))  >= int.parse((double.parse(nutrition.tprotien)/6).toStringAsFixed(0))) {
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "protien": (double.parse(nutrition.protien) + double.parse(nutrition.tprotien)/6).toStringAsFixed(0),
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
                                                    if (int.parse(nutrition.fat) - int.parse((double.parse(nutrition.tfat)/6).toStringAsFixed(0))  >= int.parse((double.parse(nutrition.tfat)/6).toStringAsFixed(0))) {
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "fat": (double.parse(nutrition.fat) + double.parse(nutrition.tfat)/6).toStringAsFixed(0),
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
                                                  FirebaseFirestore.instance
                                                      .collection("usersclasses")
                                                      .doc(FirebaseAuth.instance.currentUser!.uid)
                                                      .collection("nutirition")
                                                      .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                      .update({
                                                    "m4": !nutrition.m4,
                                                  });
                                                  return;
                                                }
                                                else if (index == 4) {
                                                  if (nutrition.m5) {
                                                    if (int.parse(nutrition.calories) - int.parse((double.parse(nutrition.tcalories)/6).toStringAsFixed(0))  >= int.parse((double.parse(nutrition.tcalories)/6).toStringAsFixed(0))) {
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "calories": (double.parse(nutrition.calories) - double.parse(nutrition.tcalories)/6).toStringAsFixed(0),
                                                      });
                                                    }else{
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "calories": "0",
                                                      });
                                                    }

                                                    if (int.parse(nutrition.carbs) - int.parse((double.parse(nutrition.tcarbs)/6).toStringAsFixed(0))  >= int.parse((double.parse(nutrition.tcarbs)/6).toStringAsFixed(0))) {
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "carbs": (double.parse(nutrition.carbs) - double.parse(nutrition.tcarbs)/6).toStringAsFixed(0),
                                                      });
                                                    }else{
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "carbs": "0",
                                                      });
                                                    }

                                                    if (int.parse(nutrition.protien) - int.parse((double.parse(nutrition.tprotien)/6).toStringAsFixed(0))  >= int.parse((double.parse(nutrition.tprotien)/6).toStringAsFixed(0))) {
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "protien": (double.parse(nutrition.protien) - double.parse(nutrition.tprotien)/6).toStringAsFixed(0),
                                                      });
                                                    }else{
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "protien": "0",
                                                      });
                                                    }
                                                    if (int.parse(nutrition.fat) - int.parse((double.parse(nutrition.tfat)/6).toStringAsFixed(0))  >= int.parse((double.parse(nutrition.tfat)/6).toStringAsFixed(0))) {
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "fat": (double.parse(nutrition.fat) - double.parse(nutrition.tfat)/6).toStringAsFixed(0),
                                                      });
                                                    }else{
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "fat": "0",
                                                      });
                                                    }
                                                  }
                                                  else{
                                                    if (int.parse(nutrition.calories) - int.parse((double.parse(nutrition.tcalories)/6).toStringAsFixed(0))  >= int.parse((double.parse(nutrition.tcalories)/6).toStringAsFixed(0))) {
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "calories": (double.parse(nutrition.calories) + double.parse(nutrition.tcalories)/6).toStringAsFixed(0),
                                                      });
                                                    }
                                                    else{
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "calories": nutrition.tcalories,
                                                      });
                                                    }

                                                    if (int.parse(nutrition.carbs) - int.parse((double.parse(nutrition.tcarbs)/6).toStringAsFixed(0))  >= int.parse((double.parse(nutrition.tcarbs)/6).toStringAsFixed(0))) {
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "carbs": (double.parse(nutrition.carbs) + double.parse(nutrition.tcarbs)/6).toStringAsFixed(0),
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

                                                    if (int.parse(nutrition.protien) - int.parse((double.parse(nutrition.tprotien)/6).toStringAsFixed(0))  >= int.parse((double.parse(nutrition.tprotien)/6).toStringAsFixed(0))) {
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "protien": (double.parse(nutrition.protien) + double.parse(nutrition.tprotien)/6).toStringAsFixed(0),
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
                                                    if (int.parse(nutrition.fat) - int.parse((double.parse(nutrition.tfat)/6).toStringAsFixed(0))  >= int.parse((double.parse(nutrition.tfat)/6).toStringAsFixed(0))) {
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "fat": (double.parse(nutrition.fat) + double.parse(nutrition.tfat)/6).toStringAsFixed(0),
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
                                                  FirebaseFirestore.instance
                                                      .collection("usersclasses")
                                                      .doc(FirebaseAuth.instance.currentUser!.uid)
                                                      .collection("nutirition")
                                                      .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                      .update({
                                                    "m5": !nutrition.m5,
                                                  });
                                                  return;
                                                }
                                                else if (index == 5) {
                                                  if (nutrition.m6) {
                                                    if (int.parse(nutrition.calories) - int.parse((double.parse(nutrition.tcalories)/6).toStringAsFixed(0))  >= int.parse((double.parse(nutrition.tcalories)/6).toStringAsFixed(0))) {
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "calories": (double.parse(nutrition.calories) - double.parse(nutrition.tcalories)/6).toStringAsFixed(0),
                                                      });
                                                    }else{
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "calories": "0",
                                                      });
                                                    }

                                                    if (int.parse(nutrition.carbs) - int.parse((double.parse(nutrition.tcarbs)/6).toStringAsFixed(0))  >= int.parse((double.parse(nutrition.tcarbs)/6).toStringAsFixed(0))) {
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "carbs": (double.parse(nutrition.carbs) - double.parse(nutrition.tcarbs)/6).toStringAsFixed(0),
                                                      });
                                                    }else{
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "carbs": "0",
                                                      });
                                                    }

                                                    if (int.parse(nutrition.protien) - int.parse((double.parse(nutrition.tprotien)/6).toStringAsFixed(0))  >= int.parse((double.parse(nutrition.tprotien)/6).toStringAsFixed(0))) {
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "protien": (double.parse(nutrition.protien) - double.parse(nutrition.tprotien)/6).toStringAsFixed(0),
                                                      });
                                                    }else{
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "protien": "0",
                                                      });
                                                    }
                                                    if (int.parse(nutrition.fat) - int.parse((double.parse(nutrition.tfat)/6).toStringAsFixed(0))  >= int.parse((double.parse(nutrition.tfat)/6).toStringAsFixed(0))) {
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "fat": (double.parse(nutrition.fat) - double.parse(nutrition.tfat)/6).toStringAsFixed(0),
                                                      });
                                                    }else{
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "fat": "0",
                                                      });
                                                    }
                                                  }
                                                  else{
                                                    if (int.parse(nutrition.calories) - int.parse((double.parse(nutrition.tcalories)/6).toStringAsFixed(0))  >= int.parse((double.parse(nutrition.tcalories)/6).toStringAsFixed(0))) {
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "calories": (double.parse(nutrition.calories) + double.parse(nutrition.tcalories)/6).toStringAsFixed(0),
                                                      });
                                                    }
                                                    else{
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "calories": nutrition.tcalories,
                                                      });
                                                    }

                                                    if (int.parse(nutrition.carbs) - int.parse((double.parse(nutrition.tcarbs)/6).toStringAsFixed(0))  >= int.parse((double.parse(nutrition.tcarbs)/6).toStringAsFixed(0))) {
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "carbs": (double.parse(nutrition.carbs) + double.parse(nutrition.tcarbs)/6).toStringAsFixed(0),
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

                                                    if (int.parse(nutrition.protien) - int.parse((double.parse(nutrition.tprotien)/6).toStringAsFixed(0))  >= int.parse((double.parse(nutrition.tprotien)/6).toStringAsFixed(0))) {
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "protien": (double.parse(nutrition.protien) + double.parse(nutrition.tprotien)/6).toStringAsFixed(0),
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
                                                    if (int.parse(nutrition.fat) - int.parse((double.parse(nutrition.tfat)/6).toStringAsFixed(0))  >= int.parse((double.parse(nutrition.tfat)/6).toStringAsFixed(0))) {
                                                      FirebaseFirestore.instance
                                                          .collection("usersclasses")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection("nutirition")
                                                          .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                          .update({
                                                        "fat": (double.parse(nutrition.fat) + double.parse(nutrition.tfat)/6).toStringAsFixed(0),
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
                                                  FirebaseFirestore.instance
                                                      .collection("usersclasses")
                                                      .doc(FirebaseAuth.instance.currentUser!.uid)
                                                      .collection("nutirition")
                                                      .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                                                      .update({
                                                    "m6": !nutrition.m6,
                                                  });
                                                  return;
                                                }
                                              }
                                            },
                                            child: Container(
                                              width: 45.w,
                                              height: 45.h,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: greylight,
                                              ),
                                              child: Center(child: Icon(
                                                index == 0?
                                                nutrition.m1?Icons.remove:Icons.add:
                                                index == 1?
                                                nutrition.m2?Icons.remove:Icons.add:
                                                index == 2?
                                                nutrition.m3?Icons.remove:Icons.add:
                                                index == 3?
                                                nutrition.m4?Icons.remove:Icons.add:
                                                index == 4?
                                                nutrition.m5?Icons.remove:Icons.add:
                                                nutrition.m6?Icons.remove:Icons.add,
                                                color: lightyellow, size: 25,)),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                ),
                              );
                            }
                        ),
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
    return LoadingScreen();
  }

  @override
  Widget build(BuildContext context) {
    return MakeStream(context);
  }
}
