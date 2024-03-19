import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flockergym/Methods/colors_methods.dart';
import 'package:flockergym/NewBackend/MainMethods.dart';
import 'package:flockergym/NewBackend/Models/InBodyFModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

late InBodyFModel inbodydata;
FirebaseFirestore ref = FirebaseFirestore.instance;
final ref3 = ref.collection("userinbody").doc(FirebaseAuth.instance.currentUser!.uid).snapshots();

class MuscleFat extends StatefulWidget {
  const MuscleFat({super.key});

  @override
  State<MuscleFat> createState() => _MuscleFatState();
}

class _MuscleFatState extends State<MuscleFat> {

  int selectedValue = 2;

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
                    'Muscle fat analysis',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.circle, color: lightyellow, size: 20,),
                                SizedBox(width: 5.w,),
                                Text('Below Avg', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.circle, color: Color(0xFF00FF3B), size: 20,),
                                SizedBox(width: 5.w,),
                                Text('Avg', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.circle, color: Colors.red, size: 20,),
                                SizedBox(width: 5.w,),
                                Text('Above Avg', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h,),
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              double t = index==0?double.parse(inbodydata.skel):index==1?double.parse(inbodydata.weight):double.parse(inbodydata.bodymass);
                              return Card(
                                color: silverdark,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                margin: EdgeInsets.only(top: 8, bottom: 8),
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 20.h,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(index==0?"SMM":index==1?"Weight (Kg)":"Body Fat mass (Kg)",
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
                                              SizedBox(height: 8.h,),
                                              Text(index==0?"Skeletal muscle mass":index==1?"sum of the above":"For Store excess energy",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12.sp,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w400,
                                                  height: 0,
                                                  letterSpacing: 0.12,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(t.toString(),
                                            style: TextStyle(
                                              color: t>33.33?t>66.67?Colors.red:Color(0xFF00FF3B):Color(0xFFF8BE00),
                                              fontSize: 25.sp,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                              height: 0,
                                              letterSpacing: 0.32,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10.h,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            width: 42.67.w,
                                            height: 24.h,
                                            decoration: BoxDecoration(
                                              color: lightyellow,
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                          ),
                                          Container(
                                            width: 42.67.w,
                                            height: 24.h,
                                            decoration: BoxDecoration(
                                              color: t>16.67?lightyellow:Color(0xff50524C),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                          ),
                                          Container(
                                            width: 42.67.w,
                                            height: 24.h,
                                            decoration: BoxDecoration(
                                              color: t>33.33?Color(0xFF00FF3B):Color(0xff50524C),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                          ),
                                          Container(
                                            width: 42.67.w,
                                            height: 24.h,
                                            decoration: BoxDecoration(
                                              color: t>50?Color(0xFF00FF3B):Color(0xff50524C),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                          ),
                                          Container(
                                            width: 42.67.w,
                                            height: 24.h,
                                            decoration: BoxDecoration(
                                              color: t>66.67?Colors.red:Color(0xff50524C),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                          ),
                                          Container(
                                            width: 42.67.w,
                                            height: 24.h,
                                            decoration: BoxDecoration(
                                              color: t>83.33?Colors.red:Color(0xff50524C),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20.h,),
                                    ],
                                  ),
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
                    'Muscle fat analysis',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.circle, color: lightyellow, size: 20,),
                                SizedBox(width: 5.w,),
                                Text('Below Avg', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.circle, color: Color(0xFF00FF3B), size: 20,),
                                SizedBox(width: 5.w,),
                                Text('Avg', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.circle, color: Colors.red, size: 20,),
                                SizedBox(width: 5.w,),
                                Text('Above Avg', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h,),
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              double t = index==0?double.parse(inbodydata.skel):index==1?double.parse(inbodydata.weight):double.parse(inbodydata.bodymass);
                              return Card(
                                color: silverdark,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                margin: EdgeInsets.only(top: 8, bottom: 8),
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 20.h,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(index==0?"SMM":index==1?"Weight (Kg)":"Body Fat mass (Kg)",
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
                                              SizedBox(height: 8.h,),
                                              Text(index==0?"Skeletal muscle mass":index==1?"sum of the above":"For Store excess energy",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12.sp,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w400,
                                                  height: 0,
                                                  letterSpacing: 0.12,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(t.toString(),
                                            style: TextStyle(
                                              color: t>33.33?t>66.67?Colors.red:Color(0xFF00FF3B):Color(0xFFF8BE00),
                                              fontSize: 25.sp,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                              height: 0,
                                              letterSpacing: 0.32,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10.h,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            width: 42.67.w,
                                            height: 24.h,
                                            decoration: BoxDecoration(
                                              color: lightyellow,
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                          ),
                                          Container(
                                            width: 42.67.w,
                                            height: 24.h,
                                            decoration: BoxDecoration(
                                              color: t>16.67?lightyellow:Color(0xff50524C),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                          ),
                                          Container(
                                            width: 42.67.w,
                                            height: 24.h,
                                            decoration: BoxDecoration(
                                              color: t>33.33?Color(0xFF00FF3B):Color(0xff50524C),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                          ),
                                          Container(
                                            width: 42.67.w,
                                            height: 24.h,
                                            decoration: BoxDecoration(
                                              color: t>50?Color(0xFF00FF3B):Color(0xff50524C),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                          ),
                                          Container(
                                            width: 42.67.w,
                                            height: 24.h,
                                            decoration: BoxDecoration(
                                              color: t>66.67?Colors.red:Color(0xff50524C),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                          ),
                                          Container(
                                            width: 42.67.w,
                                            height: 24.h,
                                            decoration: BoxDecoration(
                                              color: t>83.33?Colors.red:Color(0xff50524C),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20.h,),
                                    ],
                                  ),
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
