import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flockergym/Methods/colors_methods.dart';
import 'package:flockergym/NewBackend/MainMethods.dart';
import 'package:flockergym/NewBackend/Models/NutritionsModel.dart';
import 'package:flockergym/NewBackend/Models/TrainingModel.dart';
import 'package:flockergym/Plans/Inbody/body_analysis.dart';
import 'package:flockergym/Plans/Inbody/body_history.dart';
import 'package:flockergym/Plans/Inbody/inbody_screen.dart';
import 'package:flockergym/Plans/Inbody/muscle_fat.dart';
import 'package:flockergym/Plans/Inbody/obesity_analysis.dart';
import 'package:flockergym/Plans/Nutrition/nutrition_plans.dart';
import 'package:flockergym/Plans/Training/exercises_screen.dart';
import 'package:flockergym/Plans/Training/training_programs%C2%A0.dart';
import 'package:flockergym/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

FirebaseFirestore ref = FirebaseFirestore.instance;
final ref2 = ref.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("nutirition").doc(DateFormat('dd-MM-yyyy').format(DateTime.now())).snapshots();
final trainings = ref.collection("trainings").snapshots();


class PlansScreen extends StatefulWidget {
  const PlansScreen({super.key});

  @override
  State<PlansScreen> createState() => _PlansScreenState();
}

class _PlansScreenState extends State<PlansScreen> {

  Scaffold MakeStream(BuildContext context){
    return Scaffold(
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
                  stream: trainings,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null ) {
                      if (snapshot.data?.docs.length != 0) {
                        final items2 = snapshot.data!.docs;
                        List<TrainingModel>trs = [];
                        for(var item in items2){
                          TrainingModel trainingModel = new TrainingModel(
                              dateday: item["dateday"],
                              datemonth: item["datemonth"],
                              name: item["name"],
                              id: item["id"],
                              time: item["time"],
                              imgurl: item["imgurl"]
                          );
                          trs.add(trainingModel);
                        }
                        return Scaffold(
                          backgroundColor: Colors.black,
                          body: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10, right: 10),
                              child: Column(
                                children: [
                                  SizedBox(height: 10.h,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Nutrition Plans",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: (){
                                          Get.to(NutritionPlans(nutritionsModel: nutrition,));
                                        },
                                        child: Text('View more',
                                          style: TextStyle(
                                            color: Color(0xFFF8BE00),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text("Calories",
                                                          textAlign: TextAlign.start,
                                                          style: TextStyle(
                                                            fontSize: 16.sp,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        SizedBox(width: 60.w,),
                                                        Icon(FontAwesomeIcons.fire, color: Colors.black, size: 20,),
                                                      ],
                                                    ),
                                                    SizedBox(height: 10.h,),
                                                    CircularPercentIndicator(
                                                      center: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text("Kcal",
                                                            style: TextStyle(color: silverdark, fontWeight: FontWeight.bold, fontSize: 15.sp),),
                                                          Text(items.get("calories"),
                                                            style: TextStyle(color: silverdark, fontWeight: FontWeight.bold, fontSize: 15.sp),),
                                                          Text("of ${items.get("tcalories")}",
                                                            style: TextStyle(color: Colors.black38, fontWeight: FontWeight.bold, fontSize: 13.sp),),
                                                        ],
                                                      ),
                                                      animation: true,
                                                      animationDuration: 3000,
                                                      radius: 70.w,
                                                      lineWidth: 14,
                                                      percent: double.parse(items.get("calories"))/double.parse(items.get("tcalories")),
                                                      progressColor: Color(0xff232323),
                                                      backgroundColor: Colors.grey,
                                                      circularStrokeCap: CircularStrokeCap.round,
                                                    ),
                                                  ],
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
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 12, right: 12, bottom: 8, top: 8),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text('Carbs', style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w400,
                                                            height: 0,
                                                          ),
                                                          ),
                                                          SizedBox(
                                                            width: 40.w,
                                                            child: AutoSizeText(items.get("carbs"),
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                color: Color(0xFFF8BE00),
                                                                fontSize: 14.sp,
                                                                fontWeight: FontWeight.w500,
                                                                height: 0,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      CircularPercentIndicator(
                                                        center: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Text(items.get("tcarbs"),
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
                                                        percent: double.parse(items.get("carbs"))/double.parse(items.get("tcarbs")),
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
                                          SizedBox(height: 16.h,),
                                          Row(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context).size.width*0.36,
                                                height: MediaQuery.of(context).size.width*0.16,
                                                decoration: BoxDecoration(
                                                  color: silverdark,
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 12, right: 12, bottom: 8, top: 8),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text('Protein', style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w400,
                                                            height: 0,
                                                          ),
                                                          ),
                                                          SizedBox(
                                                            width: 40.w,
                                                            child: AutoSizeText(items.get("protien"),
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                color: Color(0xFFF8BE00),
                                                                fontSize: 14.sp,
                                                                fontWeight: FontWeight.w500,
                                                                height: 0,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      CircularPercentIndicator(
                                                        center: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Text(items.get("tprotien"),
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
                                                        percent: double.parse(items.get("protien"))/double.parse(items.get("tprotien")),
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
                                          SizedBox(height: 16.h,),
                                          Row(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context).size.width*0.36,
                                                height: MediaQuery.of(context).size.width*0.16,
                                                decoration: BoxDecoration(
                                                  color: silverdark,
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 12, right: 12, bottom: 8, top: 8),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text('Fat', style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w400,
                                                            height: 0,
                                                          ),
                                                          ),
                                                          SizedBox(
                                                            width: 40.w,
                                                            child: AutoSizeText(items.get("fat"),
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                color: Color(0xFFF8BE00),
                                                                fontSize: 14.sp,
                                                                fontWeight: FontWeight.w500,
                                                                height: 0,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      CircularPercentIndicator(
                                                        center: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Text(items.get("tfat"),
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
                                                        percent: double.parse(items.get("fat"))/double.parse(items.get("tfat")),
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
                                  SizedBox(height: 10.h,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Inbody data",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: (){
                                          Get.to(InbodyScreen());
                                        },
                                        child: Text('View more',
                                          style: TextStyle(
                                            color: Color(0xFFF8BE00),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: (){
                                          Get.to(BodyAnalysis());
                                        },
                                        child: Row(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context).size.width*0.43,
                                              height: MediaQuery.of(context).size.width*0.20,
                                              decoration: BoxDecoration(
                                                color: silverdark,
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 10, right: 10),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 80.w,
                                                      child: AutoSizeText('Body composition analysis',
                                                        maxLines: 3,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w500,
                                                          height: 0,
                                                          letterSpacing: 0.12,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 16.w,),
                                      InkWell(
                                        onTap: (){
                                          Get.to(ObesityAnalysis());
                                        },
                                        child: Row(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context).size.width*0.43,
                                              height: MediaQuery.of(context).size.width*0.20,
                                              decoration: BoxDecoration(
                                                color: silverdark,
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 10, right: 10),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                        width: 80.w,
                                                        child: AutoSizeText('Obesity analysis',
                                                          maxLines: 3,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w500,
                                                            height: 0,
                                                            letterSpacing: 0.12,
                                                          ),
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 16.h,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: (){
                                          Get.to(BodyHistory());
                                        },
                                        child: Row(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context).size.width*0.43,
                                              height: MediaQuery.of(context).size.width*0.20,
                                              decoration: BoxDecoration(
                                                color: silverdark,
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 10, right: 10),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                        width: 80.w,
                                                        child: AutoSizeText('Body composition history',
                                                          maxLines: 3,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w500,
                                                            height: 0,
                                                            letterSpacing: 0.12,
                                                          ),
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 16.w,),
                                      InkWell(
                                        onTap: (){
                                          Get.to(MuscleFat());
                                        },
                                        child: Row(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context).size.width*0.43,
                                              height: MediaQuery.of(context).size.width*0.20,
                                              decoration: BoxDecoration(
                                                color: silverdark,
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 10, right: 10),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                        width: 80.w,
                                                        child: AutoSizeText('Muscle fat analysis',
                                                          maxLines: 3,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w500,
                                                            height: 0,
                                                            letterSpacing: 0.12,
                                                          ),
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10.h,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Training Programs",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: (){
                                          Get.to(TrainingPrograms());
                                        },
                                        child: Text('View more',
                                          style: TextStyle(
                                            color: Color(0xFFF8BE00),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Card(
                                    color: Color(0xFF323232),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Padding(
                                        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 24.h, bottom: 24.h),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(FontAwesomeIcons.dumbbell, color: Colors.white, size: 15,),
                                                    SizedBox(width: 10.w,),
                                                    Text('Upcoming exercise', style: TextStyle(color: Colors.white),)
                                                  ],
                                                ),
                                                SizedBox(height: 16.h,),
                                                SizedBox(
                                                  width: 120.w,
                                                  child: AutoSizeText(trs[0].name,
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 24.sp,
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w600,
                                                      height: 0,
                                                      letterSpacing: 0.24,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 16.h),
                                                Row(
                                                  children: [
                                                    Icon(Icons.watch_later_outlined, color: Colors.grey, size: 16,),
                                                    SizedBox(width: 5.w,),
                                                    Text(trs[0].time, style: TextStyle(
                                                      color: Color(0xFFC8C8C8),
                                                      fontSize: 12.sp,
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w500,
                                                      height: 0,
                                                      letterSpacing: 0.12,
                                                    ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 16.h),
                                                Row(
                                                  children: [
                                                    Icon(Icons.edit_calendar_outlined, color: Colors.grey, size: 16,),
                                                    SizedBox(width: 5.w,),
                                                    Text(trs[0].dateday+" - "+trs[0].datemonth, style: TextStyle(
                                                      color: Color(0xFFC8C8C8),
                                                      fontSize: 12.sp,
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w500,
                                                      height: 0,
                                                      letterSpacing: 0.12,
                                                    ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 30.h),
                                                InkWell(
                                                  onTap: (){
                                                    Get.to(ExercisesScreen(
                                                      i: trs[0].id,
                                                      d: trs[0].dateday + " - "+ trs[0].datemonth,
                                                      n: trs[0].name,
                                                      t: trs[0].time,
                                                      im: trs[0].imgurl,
                                                    ));
                                                  },
                                                  child: Container(
                                                    width: 120.w,
                                                    height: 30.h,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(5),
                                                      color: lightyellow,
                                                    ),
                                                    child: Center(
                                                      child: Text('Start exercise',
                                                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14.sp),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 10.h,),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 120.sp,
                                              height: 140.sp,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(12),
                                                child: Image(
                                                  image: NetworkImage(trs[0].imgurl),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                    ),
                                  ),
                                  SizedBox(height: 20.h,),
                                ],
                              ),
                            ),
                          ),
                        );
                      }else{
                        return LoadingScreen();
                      }
                    }else{
                      return LoadingScreen();
                    }
                  },
                ),
              );
            }
            else{
              print("Not Exists");
              NutritionsModel nutritionsModel= new NutritionsModel(calories: "0", tcalories: "1", carbs: "0", tcarbs: "1", fat: "0", tfat: "1", protien: "0", tprotien: "1",m1:false,m2:false,m3: false,m4: false,m5: false,m6: false);
              return Scaffold(
                backgroundColor: Colors.black,
                body: StreamBuilder(
                  stream: trainings,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null ) {
                      if (snapshot.data?.docs.length != 0) {
                        final items2 = snapshot.data!.docs;
                        List<TrainingModel>trs = [];
                        for(var item in items2){
                          TrainingModel trainingModel = new TrainingModel(
                              dateday: item["dateday"],
                              datemonth: item["datemonth"],
                              name: item["name"],
                              id: item["id"],
                              time: item["time"],
                              imgurl: item["imgurl"]
                          );
                          trs.add(trainingModel);
                        }
                        return Scaffold(
                          backgroundColor: Colors.black,
                          body: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10, right: 10),
                              child: Column(
                                children: [
                                  SizedBox(height: 10.h,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Nutrition Plans",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: (){
                                          Get.to(NutritionPlans(nutritionsModel: nutritionsModel,));
                                        },
                                        child: Text('View more',
                                          style: TextStyle(
                                            color: Color(0xFFF8BE00),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text("Calories",
                                                          textAlign: TextAlign.start,
                                                          style: TextStyle(
                                                            fontSize: 16.sp,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        SizedBox(width: 60.w,),
                                                        Icon(FontAwesomeIcons.fire, color: Colors.black, size: 20,),
                                                      ],
                                                    ),
                                                    SizedBox(height: 10.h,),
                                                    CircularPercentIndicator(
                                                      center: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text("Kcal",
                                                            style: TextStyle(color: silverdark, fontWeight: FontWeight.bold, fontSize: 15.sp),),
                                                          Text(nutritionsModel.calories,
                                                            style: TextStyle(color: silverdark, fontWeight: FontWeight.bold, fontSize: 15.sp),),
                                                          Text("of ${nutritionsModel.tcalories}",
                                                            style: TextStyle(color: Colors.black38, fontWeight: FontWeight.bold, fontSize: 13.sp),),
                                                        ],
                                                      ),
                                                      animation: true,
                                                      animationDuration: 3000,
                                                      radius: 70.w,
                                                      lineWidth: 14,
                                                      percent: 0,
                                                      progressColor: Color(0xff232323),
                                                      backgroundColor: Colors.grey,
                                                      circularStrokeCap: CircularStrokeCap.round,
                                                    ),
                                                  ],
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
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 12, right: 12, bottom: 8, top: 8),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text('Carbs', style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w400,
                                                            height: 0,
                                                          ),
                                                          ),
                                                          SizedBox(
                                                            width: 40.w,
                                                            child: AutoSizeText(nutritionsModel.carbs,
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                color: Color(0xFFF8BE00),
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.w500,
                                                                height: 0,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      CircularPercentIndicator(
                                                        center: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Text(nutritionsModel.tcarbs,
                                                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12.sp),),
                                                          ],
                                                        ),
                                                        animation: true,
                                                        animationDuration: 3000,
                                                        radius: 20.w,
                                                        lineWidth: 5,
                                                        percent: 0,
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
                                          SizedBox(height: 16.h,),
                                          Row(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context).size.width*0.36,
                                                height: MediaQuery.of(context).size.width*0.16,
                                                decoration: BoxDecoration(
                                                  color: silverdark,
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 12, right: 12, bottom: 8, top: 8),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text('Protein', style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w400,
                                                            height: 0,
                                                          ),
                                                          ),
                                                          SizedBox(
                                                            width: 40.w,
                                                            child: AutoSizeText(nutritionsModel.protien,
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                color: Color(0xFFF8BE00),
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.w500,
                                                                height: 0,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      CircularPercentIndicator(
                                                        center: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Text(nutritionsModel.tprotien,
                                                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12.sp),),
                                                          ],
                                                        ),
                                                        animation: true,
                                                        animationDuration: 3000,
                                                        radius: 20.w,
                                                        lineWidth: 5,
                                                        percent: 0,
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
                                          SizedBox(height: 16.h,),
                                          Row(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context).size.width*0.36,
                                                height: MediaQuery.of(context).size.width*0.16,
                                                decoration: BoxDecoration(
                                                  color: silverdark,
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 12, right: 12, bottom: 8, top: 8),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text('Fat', style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w400,
                                                            height: 0,
                                                          ),
                                                          ),
                                                          SizedBox(
                                                            width: 40.w,
                                                            child: AutoSizeText(nutritionsModel.fat,
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                color: Color(0xFFF8BE00),
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.w500,
                                                                height: 0,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      CircularPercentIndicator(
                                                        center: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Text(nutritionsModel.tfat,
                                                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12.sp),),
                                                          ],
                                                        ),
                                                        animation: true,
                                                        animationDuration: 3000,
                                                        radius: 20.w,
                                                        lineWidth: 5,
                                                        percent: 0,
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
                                  SizedBox(height: 10.h,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Inbody data",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: (){
                                          Get.to(InbodyScreen());
                                        },
                                        child: Text('View more',
                                          style: TextStyle(
                                            color: Color(0xFFF8BE00),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: (){
                                          Get.to(BodyAnalysis());
                                        },
                                        child: Row(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context).size.width*0.43,
                                              height: MediaQuery.of(context).size.width*0.20,
                                              decoration: BoxDecoration(
                                                color: silverdark,
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 10, right: 10),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 80.w,
                                                      child: AutoSizeText('Body composition analysis',
                                                        maxLines: 3,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w500,
                                                          height: 0,
                                                          letterSpacing: 0.12,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 16.w,),
                                      InkWell(
                                        onTap: (){
                                          Get.to(ObesityAnalysis());
                                        },
                                        child: Row(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context).size.width*0.43,
                                              height: MediaQuery.of(context).size.width*0.20,
                                              decoration: BoxDecoration(
                                                color: silverdark,
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 10, right: 10),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                        width: 80.w,
                                                        child: AutoSizeText('Obesity analysis',
                                                          maxLines: 3,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w500,
                                                            height: 0,
                                                            letterSpacing: 0.12,
                                                          ),
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 16.h,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: (){
                                          Get.to(BodyHistory());
                                        },
                                        child: Row(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context).size.width*0.43,
                                              height: MediaQuery.of(context).size.width*0.20,
                                              decoration: BoxDecoration(
                                                color: silverdark,
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 10, right: 10),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                        width: 80.w,
                                                        child: AutoSizeText('Body composition history',
                                                          maxLines: 3,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w500,
                                                            height: 0,
                                                            letterSpacing: 0.12,
                                                          ),
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 16.w,),
                                      InkWell(
                                        onTap: (){
                                          Get.to(MuscleFat());
                                        },
                                        child: Row(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context).size.width*0.43,
                                              height: MediaQuery.of(context).size.width*0.20,
                                              decoration: BoxDecoration(
                                                color: silverdark,
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 10, right: 10),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                        width: 80.w,
                                                        child: AutoSizeText('Muscle fat analysis',
                                                          maxLines: 3,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w500,
                                                            height: 0,
                                                            letterSpacing: 0.12,
                                                          ),
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10.h,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Training Programs",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: (){
                                          Get.to(TrainingPrograms());
                                        },
                                        child: Text('View more',
                                          style: TextStyle(
                                            color: Color(0xFFF8BE00),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Card(
                                    color: Color(0xFF323232),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Padding(
                                        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 24.h, bottom: 24.h),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(FontAwesomeIcons.dumbbell, color: Colors.white, size: 15,),
                                                    SizedBox(width: 10.w,),
                                                    Text('Upcoming exercise', style: TextStyle(color: Colors.white),)
                                                  ],
                                                ),
                                                SizedBox(height: 16.h,),
                                                SizedBox(
                                                  width: 120.w,
                                                  child: AutoSizeText(trs[0].name,
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 24.sp,
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w600,
                                                      height: 0,
                                                      letterSpacing: 0.24,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 16.h),
                                                Row(
                                                  children: [
                                                    Icon(Icons.watch_later_outlined, color: Colors.grey, size: 16,),
                                                    SizedBox(width: 5.w,),
                                                    Text(trs[0].time, style: TextStyle(
                                                      color: Color(0xFFC8C8C8),
                                                      fontSize: 12.sp,
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w500,
                                                      height: 0,
                                                      letterSpacing: 0.12,
                                                    ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 16.h),
                                                Row(
                                                  children: [
                                                    Icon(Icons.edit_calendar_outlined, color: Colors.grey, size: 16,),
                                                    SizedBox(width: 5.w,),
                                                    Text(trs[0].dateday+" - "+trs[0].datemonth, style: TextStyle(
                                                      color: Color(0xFFC8C8C8),
                                                      fontSize: 12.sp,
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w500,
                                                      height: 0,
                                                      letterSpacing: 0.12,
                                                    ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 30.h),
                                                InkWell(
                                                  onTap: (){
                                                    Get.to(ExercisesScreen(
                                                      i: trs[0].id,
                                                      d: trs[0].dateday + " - "+ trs[0].datemonth,
                                                      n: trs[0].name,
                                                      t: trs[0].time,
                                                      im: trs[0].imgurl,
                                                    ));
                                                  },
                                                  child: Container(
                                                    width: 120.w,
                                                    height: 30.h,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(5),
                                                      color: lightyellow,
                                                    ),
                                                    child: Center(
                                                      child: Text('Start exercise',
                                                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14.sp),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 10.h,),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 130.w,
                                              height: 140.h,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(12),
                                                child: Image(
                                                  image: NetworkImage(trs[0].imgurl),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                    ),
                                  ),
                                  SizedBox(height: 20.h,),
                                ],
                              ),
                            ),
                          ),
                        );
                      }else{
                        return LoadingScreen();
                      }
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
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text("Plans",
          textAlign: TextAlign.start,
          style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: (){
            context.go("/home/notifications");
          },
          icon: Icon(Icons.notifications_none, color: Colors.white, size: 30,),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: InkWell(
              onTap: (){
                context.go('/home/Profile');
              },
              child: Container(
                width: 40.w,
                height: 60.h,
                decoration: BoxDecoration(
                  color: darkgrey,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(prefs.getString('imgurl').toString()),
                  ),
                ),
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(right: 12),
          //   child: IconButton(
          //       onPressed: (){
          //         context.go('/home/Profile');
          //       },
          //       icon: Icon(Icons.notifications_active_outlined, color: darkgrey, size: 35,),
          //   ),
          // )
        ],
      ),
      body: MakeStream(context),
    );
  }
}
