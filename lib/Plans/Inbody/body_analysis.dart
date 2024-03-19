import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flockergym/Methods/colors_methods.dart';
import 'package:flockergym/NewBackend/MainMethods.dart';
import 'package:flockergym/NewBackend/Models/InBodyFModel.dart';
import 'package:flockergym/Plans/Inbody/inbody_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

late InBodyFModel inbodydata;
FirebaseFirestore ref = FirebaseFirestore.instance;
final ref3 = ref.collection("userinbody").doc(FirebaseAuth.instance.currentUser!.uid).snapshots();


class BodyAnalysis extends StatefulWidget {
  const BodyAnalysis({super.key});

  @override
  State<BodyAnalysis> createState() => _BodyAnalysisState();
}

class _BodyAnalysisState extends State<BodyAnalysis> {

  int selectedValue = 1;

  void _handleRadioValueChange(int value) {
    setState(() {
      selectedValue = value;
    });
  }

  Scaffold MakeStream(BuildContext context){
    return Scaffold(
      body:  StreamBuilder(
        stream: ref3,
        builder: (_, snapshot1) {
          if (snapshot1.hasData && snapshot1.data != null ) {
            if (snapshot1.data!.exists) {
              final items = snapshot1.data!;
              print("Exists");

              inbodydata = InBodyFModel(
                bodyfat: items.get("bodyfat"),
                bodymass: items.get("bodymass"),
                pbf1: items.get("pbf1"),
                pbf2: items.get("pbf2"),
                pbf3: items.get("pbf3"),
                pbf4: items.get("pbf4"),
                pbf5: items.get("pbf5"),
                perbodyfat: items.get("perbodyfat"),
                skel: items.get("skel"),
                smm1: items.get("smm1"),
                smm2: items.get("smm2"),
                smm3: items.get("smm3"),
                smm4: items.get("smm4"),
                smm5: items.get("smm5"),
                weight1: items.get("weight1"),
                weight2: items.get("weight2"),
                weight3: items.get("weight3"),
                weight4: items.get("weight4"),
                weight5: items.get("weight5"),
                weight: items.get("weight"),
                water: items.get("water"),
                dry: items.get("dry"),
                bmi: items.get("bmi"),
              );
              return Scaffold(
                backgroundColor: Colors.black,
                appBar: AppBar(
                  backgroundColor: Colors.black,
                  elevation: 0,
                  title: Text(
                    'Body composition analysis',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 0,
                      letterSpacing: 0.16,
                    ),
                  ),
                  leading: BackButton(
                    color: Colors.white,
                  ),
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Column(
                      children: [
                        SizedBox(height: 20.h,),
                        Container(
                          height: 380.h,
                          width: 350.w,
                          decoration: BoxDecoration(
                            color: silverdark,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text("Dry lean mass (Kg) ",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        height: 0,
                                        letterSpacing: 0.14,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.h,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 220.w,
                                      child: Text("For building muscles and strengthening bones",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.sp,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w300,
                                          height: 0,
                                          letterSpacing: 0.12,
                                        ),
                                      ),
                                    ),
                                    Text(inbodydata.dry,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                        height: 0,
                                        letterSpacing: 0.16,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 40.h,),
                                Row(
                                  children: [
                                    Text("Body fat mass (Kg)",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        height: 0,
                                        letterSpacing: 0.14,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.h,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 220.w,
                                      child: Text("For storing excess energy",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.sp,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w300,
                                          height: 0,
                                          letterSpacing: 0.12,
                                        ),
                                      ),
                                    ),
                                    Text(inbodydata.bodyfat,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                        height: 0,
                                        letterSpacing: 0.16,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 40.h,),
                                Row(
                                  children: [
                                    Text("Total body water (Kg)",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        height: 0,
                                        letterSpacing: 0.14,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.h,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 220.w,
                                      child: Text("Total amount of water in body",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.sp,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w300,
                                          height: 0,
                                          letterSpacing: 0.12,
                                        ),
                                      ),
                                    ),
                                    Text(inbodydata.water,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                        height: 0,
                                        letterSpacing: 0.16,
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
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Weight (Kg)",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.sp,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                            letterSpacing: 0.14,
                                          ),
                                        ),
                                        Text("Sum of the above",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.sp,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w300,
                                            height: 0,
                                            letterSpacing: 0.12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(inbodydata.weight,
                                      style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25.sp,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                      height: 0,
                                      letterSpacing: 0.32,
                                    ),),
                                  ],
                                ),
                                SizedBox(height: 10.h,),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );

            }
            else{
              inbodydata = InBodyFModel(
                bodyfat: "0",
                bodymass: "0",
                pbf1: "0",
                pbf2: "0",
                pbf3: "0",
                pbf4: "0",
                pbf5: "0",
                perbodyfat: "0",
                skel: "0",
                smm1: "0",
                smm2: "0",
                smm3: "0",
                smm4: "0",
                smm5: "0",
                weight1: "0",
                weight2: "0",
                weight3: "0",
                weight4: "0",
                weight5: "0",
                weight: "0",
                water: "0",
                dry: "0",
                bmi: "0",
              );
              print("Not Exists");
              return Scaffold(
                backgroundColor: Colors.black,
                appBar: AppBar(
                  backgroundColor: Colors.black,
                  elevation: 0,
                  title: Text(
                    'Body composition analysis',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 0,
                      letterSpacing: 0.16,
                    ),
                  ),
                  leading: BackButton(
                    color: Colors.white,
                  ),
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Column(
                      children: [
                        SizedBox(height: 20.h,),
                        Container(
                          height: 380.h,
                          width: 350.w,
                          decoration: BoxDecoration(
                            color: silverdark,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text("Dry lean mass (Kg) ",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        height: 0,
                                        letterSpacing: 0.14,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.h,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 220.w,
                                      child: Text("For building muscles and strengthening bones",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.sp,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w300,
                                          height: 0,
                                          letterSpacing: 0.12,
                                        ),
                                      ),
                                    ),
                                    Text(inbodydata.dry,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.sp,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                        height: 0,
                                        letterSpacing: 0.16,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 40.h,),
                                Row(
                                  children: [
                                    Text("Body fat mass (Kg)",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        height: 0,
                                        letterSpacing: 0.14,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.h,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 220.w,
                                      child: Text("For storing excess energy",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.sp,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w300,
                                          height: 0,
                                          letterSpacing: 0.12,
                                        ),
                                      ),
                                    ),
                                    Text(inbodydata.bodyfat,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.sp,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                        height: 0,
                                        letterSpacing: 0.16,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 40.h,),
                                Row(
                                  children: [
                                    Text("Total body water (Kg)",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        height: 0,
                                        letterSpacing: 0.14,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.h,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 220.w,
                                      child: Text("Total amount of water in body",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.sp,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w300,
                                          height: 0,
                                          letterSpacing: 0.12,
                                        ),
                                      ),
                                    ),
                                    Text(inbodydata.water,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.sp,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                        height: 0,
                                        letterSpacing: 0.16,
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
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Weight (Kg)",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.sp,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                            letterSpacing: 0.14,
                                          ),
                                        ),
                                        Text("Sum of the above",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.sp,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w300,
                                            height: 0,
                                            letterSpacing: 0.12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(inbodydata.weight, style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 28.sp,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                      height: 0,
                                      letterSpacing: 0.32,
                                    ),),
                                  ],
                                ),
                                SizedBox(height: 10.h,),
                              ],
                            ),
                          ),
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
  }

  @override
  Widget build(BuildContext context) {
    return MakeStream(context);
  }
  // Future _bottomSheet(BuildContext context) {
  //   return showModalBottomSheet(
  //       context: context,
  //       barrierColor: silverdark.withOpacity(0.5),
  //       backgroundColor: Colors.black,
  //       elevation: 2,
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
  //       builder: (context) => StatefulBuilder(
  //         builder: (context, setState) => Container(
  //           height: 350.h,
  //           child: Padding(
  //             padding: const EdgeInsets.only(left: 20, right: 20),
  //             child: SingleChildScrollView(
  //               child: Column(
  //                 children: [
  //                   SizedBox(height: 30.h,),
  //                   InkWell(
  //                     onTap: (){
  //                       setState(() {
  //                         selectedValue = 0 as int;
  //                       });
  //                       _handleRadioValueChange(0);
  //                       Get.off(InbodyScreen());
  //                     },
  //                     child: Container(
  //                       width: 320.w,
  //                       height: 50.h,
  //                       decoration: BoxDecoration(
  //                         color: silverdark,
  //                         borderRadius: BorderRadius.all(Radius.circular(5)),
  //                       ),
  //                       child: Padding(
  //                         padding: const EdgeInsets.only(left: 15),
  //                         child: Row(
  //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                           children: [
  //                             Text('All statistics', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.white),),
  //                             Transform.scale(
  //                               scale: 1,
  //                               child: Radio(
  //                                 activeColor: lightyellow,
  //                                 value: 0,
  //                                 groupValue: selectedValue,
  //                                 onChanged: (value) {
  //                                 },
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   SizedBox(height: 10.w,),
  //                   InkWell(
  //                     onTap: (){
  //                       setState(() {
  //                         selectedValue = 1 as int;
  //                       });
  //                       _handleRadioValueChange(1);
  //                       Navigator.pop(context);
  //                     },
  //                     child: Container(
  //                       width: 320.w,
  //                       height: 50.h,
  //                       decoration: BoxDecoration(
  //                         color: silverdark,
  //                         borderRadius: BorderRadius.all(Radius.circular(5)),
  //                       ),
  //                       child: Padding(
  //                         padding: const EdgeInsets.only(left: 15),
  //                         child: Row(
  //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                           children: [
  //                             Text('Body composition analysis', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.white),),
  //                             Transform.scale(
  //                               scale: 1,
  //                               child: Radio(
  //                                 activeColor: lightyellow,
  //                                 value: 1,
  //                                 groupValue: selectedValue,
  //                                 onChanged: (value) {
  //
  //                                 },
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   SizedBox(height: 10.w,),
  //                   InkWell(
  //                     onTap: (){
  //                       setState(() {
  //                         selectedValue = 2 as int;
  //                       });
  //                       _handleRadioValueChange(2);
  //                     },
  //                     child: Container(
  //                       width: 320.w,
  //                       height: 50.h,
  //                       decoration: BoxDecoration(
  //                         color: silverdark,
  //                         borderRadius: BorderRadius.all(Radius.circular(5)),
  //                       ),
  //                       child: Padding(
  //                         padding: const EdgeInsets.only(left: 15),
  //                         child: Row(
  //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                           children: [
  //                             Text('Muscle fat analysis', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.white),),
  //                             Transform.scale(
  //                               scale: 1,
  //                               child: Radio(
  //                                 activeColor: lightyellow,
  //                                 value: 2,
  //                                 groupValue: selectedValue,
  //                                 onChanged: (value) {
  //
  //                                 },
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   SizedBox(height: 10.w,),
  //                   InkWell(
  //                     onTap: (){
  //                       setState(() {
  //                         selectedValue = 3 as int;
  //                       });
  //                       _handleRadioValueChange(3);
  //                     },
  //                     child: Container(
  //                       width: 320.w,
  //                       height: 50.h,
  //                       decoration: BoxDecoration(
  //                         color: silverdark,
  //                         borderRadius: BorderRadius.all(Radius.circular(5)),
  //                       ),
  //                       child: Padding(
  //                         padding: const EdgeInsets.only(left: 15),
  //                         child: Row(
  //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                           children: [
  //                             Text('Obesity analysis', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.white),),
  //                             Transform.scale(
  //                               scale: 1,
  //                               child: Radio(
  //                                 activeColor: lightyellow,
  //                                 value: 3,
  //                                 groupValue: selectedValue,
  //                                 onChanged: (value) {
  //
  //                                 },
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   SizedBox(height: 10.w,),
  //                   InkWell(
  //                     onTap: (){
  //                       setState(() {
  //                         selectedValue = 4 as int;
  //                       });
  //                       _handleRadioValueChange(4);
  //                     },
  //                     child: Container(
  //                       width: 320.w,
  //                       height: 50.h,
  //                       decoration: BoxDecoration(
  //                         color: silverdark,
  //                         borderRadius: BorderRadius.all(Radius.circular(5)),
  //                       ),
  //                       child: Padding(
  //                         padding: const EdgeInsets.only(left: 15),
  //                         child: Row(
  //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                           children: [
  //                             Text('Body composition history', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.white),),
  //                             Transform.scale(
  //                               scale: 1,
  //                               child: Radio(
  //                                 activeColor: lightyellow,
  //                                 value: 4,
  //                                 groupValue: selectedValue,
  //                                 onChanged: (value) {
  //
  //                                 },
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       )
  //   );
  // }
}
