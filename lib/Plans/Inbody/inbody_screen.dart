import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flockergym/Methods/colors_methods.dart';
import 'package:flockergym/NewBackend/MainMethods.dart';
import 'package:flockergym/NewBackend/Models/InBodyFModel.dart';
import 'package:flockergym/NewBackend/Models/MemberModel.dart';
import 'package:flockergym/Plans/Inbody/body_analysis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

DatabaseReference ref2 = FirebaseDatabase.instance.ref("members/${FirebaseAuth.instance.currentUser!.uid}/");
FirebaseFirestore ref = FirebaseFirestore.instance;
final ref3 = ref.collection("userinbody").doc(FirebaseAuth.instance.currentUser!.uid).snapshots();
late MemberModel memberModel;
late InBodyFModel inbodydata;
late List<SalesData> data ;
late List<SalesData> data2 ;
late List<SalesData> data3 ;
int d = 0;
class InbodyScreen extends StatefulWidget {
  const InbodyScreen({super.key});

  @override
  State<InbodyScreen> createState() => _InbodyScreenState();
}

class _InbodyScreenState extends State<InbodyScreen> {

  int selectedValue = 0;

  void _handleRadioValueChange(int value) {
    setState(() {
      selectedValue = value;
    });
  }
  DefaultTabController MakeStream5(BuildContext context){
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          title: Text("Inbody ",
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white
            ),
          ),
          leading: BackButton(
            color: Colors.white,
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: (){
                          _bottomSheet(context);
                        },
                        child: Container(
                          height: 50.h,
                          width: 330.w,
                          decoration: BoxDecoration(
                            color: silverdark,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12, right: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Body composition history',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.sp),
                                ),
                                Icon(Icons.arrow_drop_down, color: Colors.white,)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h,),
                  TabBar(
                    indicatorColor: Colors.white,
                    dividerColor: Colors.black,
                    labelColor: Colors.white,
                    tabs: [
                      SizedBox(
                        width: 150.w,
                        child: Tab(child: Text('SMM',
                          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                        ),
                        ),
                      ),
                      SizedBox(
                        width: 150.w,
                        child: Tab(child: Text('Weight',
                          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                        ),
                        ),
                      ),
                      SizedBox(
                        width: 150.w,
                        child: Tab(child: Text('PBF',
                          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                        ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.72,
              child: TabBarView(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Column(
                            children: [
                              SizedBox(height: 20.h,),
                              Row(
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("SMM (Kg)",
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
                                      SizedBox(height: 5.h,),
                                      Text("Skeletal muscle mass",
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
                                ],
                              ),
                              SizedBox(height: 30.h,),
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
                              SizedBox(height: 10.h,),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        Expanded(
                          child: ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                final dt = data[index];
                                return Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 80.h,
                                      color: silverdark,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 15, right: 15),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(dt.month,
                                              style: TextStyle(color: Colors.white, fontSize: 16.sp),),
                                            Row(
                                              children: [
                                                Text(dt.sales.toString(),
                                                  style: TextStyle(color: index==0?lightyellow:dt.sales>data[index-1].sales?Color(0xFF00FF3B):dt.sales==data[index-1].sales?lightyellow:Colors.red, fontSize: 20.sp, fontWeight: FontWeight.bold),),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10.h,),
                                  ],
                                );
                              }
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Column(
                            children: [
                              SizedBox(height: 20.h,),
                              Row(
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
                                      SizedBox(height: 5.h,),
                                      Text("Sum of the above",
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
                                ],
                              ),
                              SizedBox(height: 30.h,),
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
                              SizedBox(height: 10.h,),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        Expanded(
                          child: ListView.builder(
                              itemCount: data2.length,
                              itemBuilder: (context, index) {
                                final dt = data2[index];
                                return Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 80.h,
                                      color: silverdark,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 15, right: 15),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(dt.month,
                                              style: TextStyle(color: Colors.white, fontSize: 16.sp),),
                                            Row(
                                              children: [
                                                Text(dt.sales.toString(),
                                                  style: TextStyle(color: index==0?lightyellow:dt.sales>data2[index-1].sales?Color(0xFF00FF3B):dt.sales==data2[index-1].sales?lightyellow:Colors.red, fontSize: 20.sp, fontWeight: FontWeight.bold),),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10.h,),
                                  ],
                                );
                              }
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Column(
                            children: [
                              SizedBox(height: 20.h,),
                              Row(
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("PBF (%)",
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
                                      SizedBox(height: 5.h,),
                                      Text("Percent body fat",
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
                                ],
                              ),
                              SizedBox(height: 30.h,),
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
                              SizedBox(height: 10.h,),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        Expanded(
                          child: ListView.builder(
                              itemCount: data3.length,
                              itemBuilder: (context, index) {
                                final dt = data3[index];
                                return Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 80.h,
                                      color: silverdark,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 15, right: 15),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(dt.month,
                                              style: TextStyle(color: Colors.white, fontSize: 16.sp),),
                                            Row(
                                              children: [
                                                Text(dt.sales.toString()+' %',
                                                  style: TextStyle(color: index==0?lightyellow:dt.sales>data3[index-1].sales?Color(0xFF00FF3B):dt.sales==data3[index-1].sales?lightyellow:Colors.red, fontSize: 20.sp, fontWeight: FontWeight.bold),),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10.h,),
                                  ],
                                );
                              }
                          ),
                        ),
                      ],
                    ),
                  ]
              ),
            ),
          ],
        ),
      ),
    );

  }

  Scaffold MakeStream4(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          'Obesity analysis',
          textAlign: TextAlign.start,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
            height: 0.08,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (){
                      _bottomSheet(context);
                    },
                    child: Container(
                      height: 50.h,
                      width: 330.w,
                      decoration: BoxDecoration(
                        color: silverdark,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Obesity analysis',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.sp),
                            ),
                            Icon(Icons.arrow_drop_down, color: Colors.white,)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
                  itemCount: 2,
                  itemBuilder: (context, index) {
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
                                    Text(index==0?"BMI (kg/m2)":"PBF (%)",
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
                                    Text(index==0?"Body mass index":"Percent body fat",
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
                                Text(index==0?inbodydata.bmi:((double.parse(inbodydata.pbf1)+double.parse(inbodydata.pbf2)
                                    +double.parse(inbodydata.pbf3)+double.parse(inbodydata.pbf4)+double.parse(inbodydata.pbf5))/5).toStringAsFixed(0)+" %",
                                  style: TextStyle(
                                    color: index==0?double.parse(inbodydata.bmi)>100?Colors.red:
                                    index==0?double.parse(inbodydata.bmi)>50?Color(0xFF00FF3B):lightyellow:((double.parse(inbodydata.pbf1)+double.parse(inbodydata.pbf2)
                                        +double.parse(inbodydata.pbf3)+double.parse(inbodydata.pbf4)+double.parse(inbodydata.pbf5))/5)>33.33?Color(0xFF00FF3B):lightyellow
                                        : ((double.parse(inbodydata.pbf1)+double.parse(inbodydata.pbf2)
                                        +double.parse(inbodydata.pbf3)+double.parse(inbodydata.pbf4)+double.parse(inbodydata.pbf5))/5)>66.67?Colors.red
                                        :index==0?double.parse(inbodydata.bmi)>50?Color(0xFF00FF3B):lightyellow:((double.parse(inbodydata.pbf1)+double.parse(inbodydata.pbf2)
                                        +double.parse(inbodydata.pbf3)+double.parse(inbodydata.pbf4)+double.parse(inbodydata.pbf5))/5)>33.33?Color(0xFF00FF3B):lightyellow,
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
                                    color: index==0?double.parse(inbodydata.bmi)>25?lightyellow:Color(0xFF50524C):((double.parse(inbodydata.pbf1)+double.parse(inbodydata.pbf2)
                                        +double.parse(inbodydata.pbf3)+double.parse(inbodydata.pbf4)+double.parse(inbodydata.pbf5))/5)>16.67?lightyellow:Color(0xFF50524C),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                Container(
                                  width: 42.67.w,
                                  height: 24.h,
                                  decoration: BoxDecoration(
                                    color: index==0?double.parse(inbodydata.bmi)>50?Color(0xFF00FF3B):Color(0xFF50524C):((double.parse(inbodydata.pbf1)+double.parse(inbodydata.pbf2)
                                        +double.parse(inbodydata.pbf3)+double.parse(inbodydata.pbf4)+double.parse(inbodydata.pbf5))/5)>33.33?Color(0xFF00FF3B):Color(0xFF50524C),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                Container(
                                  width: 42.67.w,
                                  height: 24.h,
                                  decoration: BoxDecoration(
                                    color: index==0?double.parse(inbodydata.bmi)>75?Color(0xFF00FF3B):Color(0xFF50524C):((double.parse(inbodydata.pbf1)+double.parse(inbodydata.pbf2)
                                        +double.parse(inbodydata.pbf3)+double.parse(inbodydata.pbf4)+double.parse(inbodydata.pbf5))/5)>50?Color(0xFF00FF3B):Color(0xFF50524C),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                Container(
                                  width: 42.67.w,
                                  height: 24.h,
                                  decoration: BoxDecoration(
                                    color: index==0?double.parse(inbodydata.bmi)>100?Colors.red:Color(0xFF50524C):((double.parse(inbodydata.pbf1)+double.parse(inbodydata.pbf2)
                                        +double.parse(inbodydata.pbf3)+double.parse(inbodydata.pbf4)+double.parse(inbodydata.pbf5))/5)>66.67?Colors.red:Color(0xFF50524C),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                Container(
                                  width: 42.67.w,
                                  height: 24.h,
                                  decoration: BoxDecoration(
                                    color: index==0?double.parse(inbodydata.bmi)>125?Colors.red:Color(0xFF50524C):((double.parse(inbodydata.pbf1)+double.parse(inbodydata.pbf2)
                                        +double.parse(inbodydata.pbf3)+double.parse(inbodydata.pbf4)+double.parse(inbodydata.pbf5))/5)>83.33?Colors.red:Color(0xFF50524C),
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


  Scaffold MakeStream3(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text("Inbody",
          textAlign: TextAlign.start,
          style: TextStyle(
              fontSize: 18.sp,
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
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (){
                      _bottomSheet(context);
                    },
                    child: Container(
                      height: 50.h,
                      width: 330.w,
                      decoration: BoxDecoration(
                        color: silverdark,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Muscle fat analysis',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.sp),
                            ),
                            Icon(Icons.arrow_drop_down, color: Colors.white,)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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


  Scaffold MakeStream2(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text("Inbody",
          textAlign: TextAlign.start,
          style: TextStyle(
              fontSize: 18.sp,
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
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (){
                      _bottomSheet(context);
                    },
                    child: Container(
                      height: 50.h,
                      width: 330.w,
                      decoration: BoxDecoration(
                        color: silverdark,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Body composition analysis',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.sp),
                            ),
                            Icon(Icons.arrow_drop_down, color: Colors.white,)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
                              fontSize: 16.sp,
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
                              fontSize: 16.sp,
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
                              fontSize: 16.sp,
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
                            fontSize: 30.sp,
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


  Scaffold MakeStream(BuildContext context){
    return Scaffold(
      body: StreamBuilder(
          stream: ref2.onValue,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null &&
                (snapshot.data! as DatabaseEvent).snapshot.value != null) {
              memberModel = MemberModel(
                age: snapshot.data?.snapshot
                    .child('age')
                    .value
                    .toString(),
                createdat: snapshot.data?.snapshot
                    .child('createdat')
                    .value
                    .toString(),
                email: snapshot.data?.snapshot
                    .child('email')
                    .value
                    .toString(),
                endsAt: snapshot.data?.snapshot
                    .child('endsAt')
                    .value
                    .toString(),
                gender: snapshot.data?.snapshot
                    .child('gender')
                    .value
                    .toString(),
                height: snapshot.data?.snapshot
                    .child('height')
                    .value
                    .toString(),
                id: snapshot.data?.snapshot
                    .child('id')
                    .value
                    .toString(),
                imgurl: snapshot.data?.snapshot
                    .child('imgurl')
                    .value
                    .toString(),
                memberstatus: snapshot.data?.snapshot
                    .child('memberstatus')
                    .value
                    .toString(),
                mobile: snapshot.data?.snapshot
                    .child('mobile')
                    .value
                    .toString(),
                name: snapshot.data?.snapshot
                    .child('name')
                    .value
                    .toString(),
                password: snapshot.data?.snapshot
                    .child('password')
                    .value
                    .toString(),
                weight: snapshot.data?.snapshot
                    .child('weight')
                    .value
                    .toString(),
                uniq: snapshot.data?.snapshot
                    .child('uniq')
                    .value
                    .toString(),
                active: snapshot.data?.snapshot
                    .child('active')
                    .value
                    .toString(),
                goal: snapshot.data?.snapshot
                    .child('goal')
                    .value
                    .toString(),
                motivate: snapshot.data?.snapshot
                    .child('motivate')
                    .value
                    .toString(),
              );

              return Scaffold(
                body:  StreamBuilder(
                  stream: ref3,
                  builder: (_, snapshot1) {
                    if (snapshot1.hasData && snapshot1.data != null ) {
                      if (snapshot1.data!.exists) {
                        final items = snapshot1.data!;
                        print("Exists");

                        data = [];
                        data2 = [];
                        data3 = [];
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
                          dry: items.get("dry"),
                          water: items.get("water"),
                          bmi: items.get("bmi"),
                        );

                        data.add(SalesData(DateFormat("dd - MMMM").format(DateTime.now().add(Duration(days: -28))), double.parse(items.get("smm1"))));
                        data.add(SalesData(DateFormat("dd - MMMM").format(DateTime.now().add(Duration(days: -21))), double.parse(items.get("smm2"))));
                        data.add(SalesData(DateFormat("dd - MMMM").format(DateTime.now().add(Duration(days: -14))), double.parse(items.get("smm3"))));
                        data.add(SalesData(DateFormat("dd - MMMM").format(DateTime.now().add(Duration(days: -7))), double.parse(items.get("smm4"))));
                        data.add(SalesData(DateFormat("dd - MMMM").format(DateTime.now().add(Duration(days: 0))), double.parse(items.get("smm5"))));

                        data3.add(SalesData(DateFormat("dd - MMMM").format(DateTime.now().add(Duration(days: -28))), double.parse(items.get("weight1"))));
                        data3.add(SalesData(DateFormat("dd - MMMM").format(DateTime.now().add(Duration(days: -21))), double.parse(items.get("weight2"))));
                        data3.add(SalesData(DateFormat("dd - MMMM").format(DateTime.now().add(Duration(days: -14))), double.parse(items.get("weight3"))));
                        data3.add(SalesData(DateFormat("dd - MMMM").format(DateTime.now().add(Duration(days: -7))), double.parse(items.get("weight4"))));
                        data3.add(SalesData(DateFormat("dd - MMMM").format(DateTime.now().add(Duration(days: 0))), double.parse(items.get("weight5"))));

                        data2.add(SalesData(DateFormat("dd - MMMM").format(DateTime.now().add(Duration(days: -28))), double.parse(items.get("pbf1"))));
                        data2.add(SalesData(DateFormat("dd - MMMM").format(DateTime.now().add(Duration(days: -21))), double.parse(items.get("pbf2"))));
                        data2.add(SalesData(DateFormat("dd - MMMM").format(DateTime.now().add(Duration(days: -14))), double.parse(items.get("pbf3"))));
                        data2.add(SalesData(DateFormat("dd - MMMM").format(DateTime.now().add(Duration(days: -7))), double.parse(items.get("pbf4"))));
                        data2.add(SalesData(DateFormat("dd - MMMM").format(DateTime.now().add(Duration(days: 0))), double.parse(items.get("pbf5"))));

                        return Scaffold(
                          backgroundColor: Colors.black,
                          appBar: AppBar(
                            backgroundColor: Colors.black,
                            elevation: 0,
                            title: Text("Inbody",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 18.sp,
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
                              padding: EdgeInsets.only(left: 16.w, right: 16.w),
                              child: Column(
                                children: [
                                  SizedBox(height: 16.h,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: (){
                                          _bottomSheet(context);
                                        },
                                        child: Container(
                                          height: 44.h,
                                          width: 328.w,
                                          decoration: BoxDecoration(
                                            color: silverdark,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 12, right: 12),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('All statistics',
                                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.sp),
                                                ),
                                                Icon(Icons.arrow_drop_down, color: Colors.white,)
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 30.h,),
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.person, color: Colors.white,),
                                          SizedBox(width: 5.w,),
                                          SizedBox(
                                            width: 180.w,
                                            child: AutoSizeText(memberModel.name.toString(),
                                              maxLines: 1,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5.h,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          width: 104.w,
                                          height: 72.h,
                                          decoration: BoxDecoration(
                                            color: silverdark,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 10, right: 10),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text('Height', style: TextStyle(color: Colors.white),),
                                                  ],
                                                ),
                                                SizedBox(height: 5.h,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    Text('${memberModel.height} cm', style: TextStyle(color: Colors.white),),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                      ),
                                      Container(
                                          width: 104.w,
                                          height: 72.h,
                                          decoration: BoxDecoration(
                                            color: silverdark,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 10, right: 10),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text('Gender', style: TextStyle(color: Colors.white),),
                                                  ],
                                                ),
                                                SizedBox(height: 5.h,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    Text(memberModel.gender!, style: TextStyle(color: Colors.white),),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                      ),
                                      Container(
                                          width: 104.w,
                                          height: 72.h,
                                          decoration: BoxDecoration(
                                            color: silverdark,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 10, right: 10),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text('Age', style: TextStyle(color: Colors.white),),
                                                  ],
                                                ),
                                                SizedBox(height: 5.h,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    Text('${(DateTime.now().difference(DateFormat('yyyy-MM-dd').parse(memberModel.age.toString())).inDays/365.25).toStringAsFixed(0)}', style: TextStyle(color: Colors.white),),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20.h,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.circle, color: Color(0xff00D1FF), size: 20,),
                                          SizedBox(width: 3.w,),
                                          Text('SMM', style: TextStyle(color: Color(0xff00D1FF), fontWeight: FontWeight.bold),)
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.circle, color: Color(0xffBF6EFF), size: 20,),
                                          SizedBox(width: 3.w,),
                                          Text('Weight', style: TextStyle(color: Color(0xffBF6EFF), fontWeight: FontWeight.bold),)
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.circle, color: Color(0xffFFC56E), size: 20,),
                                          SizedBox(width: 3.w,),
                                          Text('PBF', style: TextStyle(color: Color(0xffFFC56E), fontWeight: FontWeight.bold),)
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10.h,),
                                  SizedBox(
                                    height: 200.h,
                                    child: SfCartesianChart(
                                      plotAreaBorderWidth: 0,
                                      primaryYAxis: NumericAxis(
                                        interval: 10,
                                      ),
                                      primaryXAxis: CategoryAxis(),
                                      backgroundColor: silverdark,
                                      series: [
                                        LineSeries<SalesData, String>(
                                          color: Color(0xff00D1FF),
                                          width: 3.5.w,
                                          dataSource: data,
                                          xValueMapper: (SalesData sales, _) => sales.month,
                                          yValueMapper: (SalesData sales, _) => sales.sales,
                                        ),
                                        LineSeries<SalesData, String>(
                                          color: Color(0xffFFC56E),
                                          width: 3.5.w,
                                          dataSource: data2,
                                          xValueMapper: (SalesData sales, _) => sales.month,
                                          yValueMapper: (SalesData sales, _) => sales.sales,
                                        ),
                                        LineSeries<SalesData, String>(
                                          color: Color(0xffBF6EFF),
                                          width: 3.5.w,
                                          dataSource: data3,
                                          xValueMapper: (SalesData sales, _) => sales.month,
                                          yValueMapper: (SalesData sales, _) => sales.sales,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 16.h,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            width: 156.w,
                                            height: 160.h,
                                            decoration: BoxDecoration(
                                                color: silverdark,
                                                borderRadius: BorderRadius.circular(20)
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(16),
                                              child: Row(
                                                children: [
                                                  Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        width: 120.w,
                                                        child: AutoSizeText('Body composition history',
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16.sp,
                                                            fontWeight: FontWeight.w500,
                                                            height: 0,
                                                            letterSpacing: 0.16,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 16.h,),
                                                      Text('SMM', style: TextStyle(
                                                        color: Color(0xFFC8C8C8),
                                                        fontSize: 12.sp,
                                                        fontWeight: FontWeight.w500,
                                                        height: 0,
                                                        letterSpacing: 0.12,
                                                      ),),
                                                      SizedBox(height: 8.h,),
                                                      Text('Weight', style: TextStyle(
                                                        color: Color(0xFFC8C8C8),
                                                        fontSize: 12.sp,
                                                        fontWeight: FontWeight.w500,
                                                        height: 0,
                                                        letterSpacing: 0.12,
                                                      ),),
                                                      SizedBox(height: 8.h,),
                                                      Text('PBF', style: TextStyle(
                                                        color: Color(0xFFC8C8C8),
                                                        fontSize: 12.sp,
                                                        fontWeight: FontWeight.w500,
                                                        height: 0,
                                                        letterSpacing: 0.12,
                                                      ),),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 16.h,),
                                          Container(
                                            width: 156.w,
                                            height: 272.h,
                                            decoration: BoxDecoration(
                                                color: silverdark,
                                                borderRadius: BorderRadius.circular(16)
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(12),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: 120.w,
                                                    child: AutoSizeText('Muscle fat analysis',
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w500,
                                                        letterSpacing: 0.16,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.h,),
                                                  Row(
                                                    children: [
                                                      Text('Skeletal muscle mass',
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          color: Color(0xFFC8C8C8),
                                                          fontSize: 10,
                                                          fontWeight: FontWeight.w400,
                                                          height: 0,
                                                          letterSpacing: 0.10,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      Text(inbodydata.skel, style: TextStyle(
                                                        color: Color(0xFFF8BE00),
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w500,
                                                        height: 0,
                                                        letterSpacing: 0.16,
                                                      ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 28.h,),
                                                  Row(
                                                    children: [
                                                      Text('Weight', style: TextStyle(
                                                        color: Color(0xFFC8C8C8),
                                                        fontSize: 10,
                                                        fontWeight: FontWeight.w400,
                                                        height: 0,
                                                        letterSpacing: 0.10,
                                                      ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      Text(inbodydata.weight, style: TextStyle(
                                                        color: Color(0xFF00FF3B),
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w500,
                                                        height: 0,
                                                        letterSpacing: 0.16,
                                                      ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 28.h,),
                                                  Row(
                                                    children: [
                                                      Text('Body fat mass',
                                                        style: TextStyle(
                                                          color: Color(0xFFC8C8C8),
                                                          fontSize: 10,
                                                          fontWeight: FontWeight.w400,
                                                          height: 0,
                                                          letterSpacing: 0.10,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      Text(inbodydata.bodyfat, style: TextStyle(
                                                        color: Color(0xFFFD6262),
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w500,
                                                        height: 0,
                                                        letterSpacing: 0.16,
                                                      ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 16.w,),
                                      Column(
                                        children: [
                                          Container(
                                            width: 156.w,
                                            height: 272.h,
                                            decoration: BoxDecoration(
                                                color: silverdark,
                                                borderRadius: BorderRadius.circular(16)
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.only(right: 16.w, left: 16.w, top: 24.h, bottom: 24.h),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          SizedBox(
                                                            width: 120.w,
                                                            child: AutoSizeText('Body composition analysis',
                                                              maxLines: 2,
                                                              style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.w500,
                                                                height: 0,
                                                                letterSpacing: 0.16,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 8.h,),
                                                      Text(
                                                        'Dry lean mass',
                                                        style: TextStyle(
                                                          color: Color(0xFFC8C8C8),
                                                          fontSize: 10,
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w400,
                                                          height: 0,
                                                          letterSpacing: 0.10,
                                                        ),
                                                      ),
                                                      SizedBox(height: 8.h,),
                                                      Text(
                                                        'Body fat mass',
                                                        style: TextStyle(
                                                          color: Color(0xFFC8C8C8),
                                                          fontSize: 10,
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w400,
                                                          height: 0,
                                                          letterSpacing: 0.10,
                                                        ),
                                                      ),
                                                      SizedBox(height: 8.h,),
                                                      Text(
                                                        'Total body water',
                                                        style: TextStyle(
                                                          color: Color(0xFFC8C8C8),
                                                          fontSize: 10,
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w400,
                                                          height: 0,
                                                          letterSpacing: 0.10,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                        children: [
                                                          Text('Weight (Kg)',
                                                            style: TextStyle(
                                                              color: Color(0xFFC8C8C8),
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.w500,
                                                              height: 0,
                                                              letterSpacing: 0.14,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 120.w,
                                                            child: AutoSizeText(inbodydata.weight,
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                color: Color(0xFF00FF3B),
                                                                fontSize: 48,
                                                                fontWeight: FontWeight.w700,
                                                                height: 0,
                                                                letterSpacing: 0.48,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 16.h,),
                                          Container(
                                            width: 156.w,
                                            height: 160.h,
                                            decoration: BoxDecoration(
                                                color: silverdark,
                                                borderRadius: BorderRadius.circular(20)
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(16),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: 120.w,
                                                    child: AutoSizeText('Obesity analysis',
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w500,
                                                        letterSpacing: 0.16,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.h,),
                                                  Row(
                                                    children: [
                                                      Text('Body mass index', style: TextStyle(
                                                        color: Color(0xFFC8C8C8),
                                                        fontSize: 10,
                                                        fontWeight: FontWeight.w400,
                                                        letterSpacing: 0.10,
                                                      ),),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      AutoSizeText(inbodydata.bodymass,
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                          color: Color(0xFFF8BE00),
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w500,
                                                          letterSpacing: 0.16,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text('Percent body fat', style: TextStyle(
                                                        color: Color(0xFFC8C8C8),
                                                        fontSize: 10,
                                                        fontWeight: FontWeight.w400,
                                                        letterSpacing: 0.10,
                                                      ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      AutoSizeText(inbodydata.perbodyfat,
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                          color: Color(0xFFF8BE00),
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w500,
                                                          letterSpacing: 0.16,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20.h,),
                                ],
                              ),
                            ),
                          ),
                        );

                      }
                      else{
                        data = [];
                        data2 = [];
                        data3 = [];
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
                            dry: "0",
                            water: "0",
                            bmi: "0"
                        );
                        print("Not Exists");
                        return Scaffold(
                          backgroundColor: Colors.black,
                          appBar: AppBar(
                            backgroundColor: Colors.black,
                            elevation: 0,
                            title: Text("Inbody",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 18.sp,
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
                              padding: EdgeInsets.only(left: 16.w, right: 16.w),
                              child: Column(
                                children: [
                                  SizedBox(height: 16.h,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: (){
                                          _bottomSheet(context);
                                        },
                                        child: Container(
                                          height: 44.h,
                                          width: 328.w,
                                          decoration: BoxDecoration(
                                            color: silverdark,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 12, right: 12),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('All statistics',
                                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.sp),
                                                ),
                                                Icon(Icons.arrow_drop_down, color: Colors.white,)
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 30.h,),
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.person, color: Colors.white,),
                                          SizedBox(width: 5.w,),
                                          SizedBox(
                                            width: 180.w,
                                            child: AutoSizeText(memberModel.name.toString(),
                                              maxLines: 1,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5.h,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          width: 104.w,
                                          height: 72.h,
                                          decoration: BoxDecoration(
                                            color: silverdark,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 10, right: 10),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text('Height', style: TextStyle(color: Colors.white),),
                                                  ],
                                                ),
                                                SizedBox(height: 5.h,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    Text('${memberModel.height} cm', style: TextStyle(color: Colors.white),),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                      ),
                                      Container(
                                          width: 104.w,
                                          height: 72.h,
                                          decoration: BoxDecoration(
                                            color: silverdark,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 10, right: 10),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text('Gender', style: TextStyle(color: Colors.white),),
                                                  ],
                                                ),
                                                SizedBox(height: 5.h,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    Text(memberModel.gender!, style: TextStyle(color: Colors.white),),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                      ),
                                      Container(
                                          width: 104.w,
                                          height: 72.h,
                                          decoration: BoxDecoration(
                                            color: silverdark,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 10, right: 10),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text('Age', style: TextStyle(color: Colors.white),),
                                                  ],
                                                ),
                                                SizedBox(height: 5.h,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    Text('${(DateTime.now().difference(DateFormat('yyyy-MM-dd').parse(memberModel.age.toString())).inDays/365.25).toStringAsFixed(0)}', style: TextStyle(color: Colors.white),),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20.h,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.circle, color: Color(0xff00D1FF), size: 20,),
                                          SizedBox(width: 3.w,),
                                          Text('SMM', style: TextStyle(color: Color(0xff00D1FF), fontWeight: FontWeight.bold),)
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.circle, color: Color(0xffBF6EFF), size: 20,),
                                          SizedBox(width: 3.w,),
                                          Text('Weight', style: TextStyle(color: Color(0xffBF6EFF), fontWeight: FontWeight.bold),)
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.circle, color: Color(0xffFFC56E), size: 20,),
                                          SizedBox(width: 3.w,),
                                          Text('PBF', style: TextStyle(color: Color(0xffFFC56E), fontWeight: FontWeight.bold),)
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10.h,),
                                  SizedBox(
                                    height: 200.h,
                                    child: SfCartesianChart(
                                      plotAreaBorderWidth: 0,
                                      primaryYAxis: NumericAxis(
                                        interval: 10,
                                      ),
                                      primaryXAxis: CategoryAxis(),
                                      backgroundColor: silverdark,
                                      series: [
                                        LineSeries<SalesData, String>(
                                          color: Color(0xff00D1FF),
                                          width: 3.5.w,
                                          dataSource: data,
                                          xValueMapper: (SalesData sales, _) => sales.month,
                                          yValueMapper: (SalesData sales, _) => sales.sales,
                                        ),
                                        LineSeries<SalesData, String>(
                                          color: Color(0xffFFC56E),
                                          width: 3.5.w,
                                          dataSource: data2,
                                          xValueMapper: (SalesData sales, _) => sales.month,
                                          yValueMapper: (SalesData sales, _) => sales.sales,
                                        ),
                                        LineSeries<SalesData, String>(
                                          color: Color(0xffBF6EFF),
                                          width: 3.5.w,
                                          dataSource: data3,
                                          xValueMapper: (SalesData sales, _) => sales.month,
                                          yValueMapper: (SalesData sales, _) => sales.sales,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 16.h,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            width: 156.w,
                                            height: 160.h,
                                            decoration: BoxDecoration(
                                                color: silverdark,
                                                borderRadius: BorderRadius.circular(20)
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(16),
                                              child: Row(
                                                children: [
                                                  Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        width: 120.w,
                                                        child: AutoSizeText('Body composition history',
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16.sp,
                                                            fontWeight: FontWeight.w500,
                                                            height: 0,
                                                            letterSpacing: 0.16,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 16.h,),
                                                      Text('SMM', style: TextStyle(
                                                        color: Color(0xFFC8C8C8),
                                                        fontSize: 12.sp,
                                                        fontWeight: FontWeight.w500,
                                                        height: 0,
                                                        letterSpacing: 0.12,
                                                      ),),
                                                      SizedBox(height: 8.h,),
                                                      Text('Weight', style: TextStyle(
                                                        color: Color(0xFFC8C8C8),
                                                        fontSize: 12.sp,
                                                        fontWeight: FontWeight.w500,
                                                        height: 0,
                                                        letterSpacing: 0.12,
                                                      ),),
                                                      SizedBox(height: 8.h,),
                                                      Text('PBF', style: TextStyle(
                                                        color: Color(0xFFC8C8C8),
                                                        fontSize: 12.sp,
                                                        fontWeight: FontWeight.w500,
                                                        height: 0,
                                                        letterSpacing: 0.12,
                                                      ),),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 16.h,),
                                          Container(
                                            width: 156.w,
                                            height: 272.h,
                                            decoration: BoxDecoration(
                                                color: silverdark,
                                                borderRadius: BorderRadius.circular(16)
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(12),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: 120.w,
                                                    child: AutoSizeText('Muscle fat analysis',
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w500,
                                                        letterSpacing: 0.16,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.h,),
                                                  Row(
                                                    children: [
                                                      Text('Skeletal muscle mass',
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          color: Color(0xFFC8C8C8),
                                                          fontSize: 10,
                                                          fontWeight: FontWeight.w400,
                                                          height: 0,
                                                          letterSpacing: 0.10,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      Text(inbodydata.skel, style: TextStyle(
                                                        color: Color(0xFFF8BE00),
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w500,
                                                        height: 0,
                                                        letterSpacing: 0.16,
                                                      ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 28.h,),
                                                  Row(
                                                    children: [
                                                      Text('Weight', style: TextStyle(
                                                        color: Color(0xFFC8C8C8),
                                                        fontSize: 10,
                                                        fontWeight: FontWeight.w400,
                                                        height: 0,
                                                        letterSpacing: 0.10,
                                                      ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      Text(inbodydata.weight, style: TextStyle(
                                                        color: Color(0xFF00FF3B),
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w500,
                                                        height: 0,
                                                        letterSpacing: 0.16,
                                                      ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 28.h,),
                                                  Row(
                                                    children: [
                                                      Text('Body fat mass',
                                                        style: TextStyle(
                                                          color: Color(0xFFC8C8C8),
                                                          fontSize: 10,
                                                          fontWeight: FontWeight.w400,
                                                          height: 0,
                                                          letterSpacing: 0.10,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      Text(inbodydata.bodyfat, style: TextStyle(
                                                        color: Color(0xFFFD6262),
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w500,
                                                        height: 0,
                                                        letterSpacing: 0.16,
                                                      ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 16.w,),
                                      Column(
                                        children: [
                                          Container(
                                            width: 156.w,
                                            height: 272.h,
                                            decoration: BoxDecoration(
                                                color: silverdark,
                                                borderRadius: BorderRadius.circular(16)
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.only(right: 16.w, left: 16.w, top: 24.h, bottom: 24.h),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          SizedBox(
                                                            width: 120.w,
                                                            child: AutoSizeText('Body composition analysis',
                                                              maxLines: 2,
                                                              style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.w500,
                                                                height: 0,
                                                                letterSpacing: 0.16,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 8.h,),
                                                      Text(
                                                        'Dry lean mass',
                                                        style: TextStyle(
                                                          color: Color(0xFFC8C8C8),
                                                          fontSize: 10,
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w400,
                                                          height: 0,
                                                          letterSpacing: 0.10,
                                                        ),
                                                      ),
                                                      SizedBox(height: 8.h,),
                                                      Text(
                                                        'Body fat mass',
                                                        style: TextStyle(
                                                          color: Color(0xFFC8C8C8),
                                                          fontSize: 10,
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w400,
                                                          height: 0,
                                                          letterSpacing: 0.10,
                                                        ),
                                                      ),
                                                      SizedBox(height: 8.h,),
                                                      Text(
                                                        'Total body water',
                                                        style: TextStyle(
                                                          color: Color(0xFFC8C8C8),
                                                          fontSize: 10,
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w400,
                                                          height: 0,
                                                          letterSpacing: 0.10,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                        children: [
                                                          Text('Weight (Kg)',
                                                            style: TextStyle(
                                                              color: Color(0xFFC8C8C8),
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.w500,
                                                              height: 0,
                                                              letterSpacing: 0.14,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 120.w,
                                                            child: AutoSizeText(inbodydata.weight,
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                color: Color(0xFF00FF3B),
                                                                fontSize: 48,
                                                                fontWeight: FontWeight.w700,
                                                                height: 0,
                                                                letterSpacing: 0.48,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 16.h,),
                                          Container(
                                            width: 156.w,
                                            height: 160.h,
                                            decoration: BoxDecoration(
                                                color: silverdark,
                                                borderRadius: BorderRadius.circular(20)
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(16),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: 120.w,
                                                    child: AutoSizeText('Obesity analysis',
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w500,
                                                        letterSpacing: 0.16,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.h,),
                                                  Row(
                                                    children: [
                                                      Text('Body mass index', style: TextStyle(
                                                        color: Color(0xFFC8C8C8),
                                                        fontSize: 10,
                                                        fontWeight: FontWeight.w400,
                                                        letterSpacing: 0.10,
                                                      ),),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      AutoSizeText(inbodydata.bodymass,
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                          color: Color(0xFFF8BE00),
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w500,
                                                          letterSpacing: 0.16,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text('Percent body fat', style: TextStyle(
                                                        color: Color(0xFFC8C8C8),
                                                        fontSize: 10,
                                                        fontWeight: FontWeight.w400,
                                                        letterSpacing: 0.10,
                                                      ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      AutoSizeText(inbodydata.perbodyfat,
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                          color: Color(0xFFF8BE00),
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w500,
                                                          letterSpacing: 0.16,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
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

            }
            else{
              return LoadingScreen();
            }
          }
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return d==0?MakeStream(context):d==1?MakeStream2(context):d==2?MakeStream3(context):d==3?MakeStream4(context):MakeStream5(context);
  }
  Future _bottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        barrierColor: silverdark.withOpacity(0.5),
        backgroundColor: Colors.black,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        builder: (context) => StatefulBuilder(
          builder: (context, setState) => Container(
            height: 350.h,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 30.h,),
                    InkWell(
                      onTap: (){
                        setState(() {
                          selectedValue = 0 as int;
                        });
                        _handleRadioValueChange(0);
                        this.setState(() {
                          d = 0;
                        });
                        Navigator.pop(context);
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
                              Text('All statistics', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.white),),
                              Transform.scale(
                                scale: 1,
                                child: Radio(
                                  activeColor: lightyellow,
                                  value: 0,
                                  groupValue: selectedValue,
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
                          selectedValue = 1 as int;
                        });
                        _handleRadioValueChange(1);
                        this.setState(() {
                          d = 1;
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
                              Text('Body composition analysis', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.white),),
                              Transform.scale(
                                scale: 1,
                                child: Radio(
                                  activeColor: lightyellow,
                                  value: 1,
                                  groupValue: selectedValue,
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
                          selectedValue = 2 as int;
                        });
                        this.setState(() {
                          d = 2;
                        });
                        _handleRadioValueChange(2);
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
                              Text('Muscle fat analysis', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.white),),
                              Transform.scale(
                                scale: 1,
                                child: Radio(
                                  activeColor: lightyellow,
                                  value: 2,
                                  groupValue: selectedValue,
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
                          selectedValue = 3 as int;
                        });
                        _handleRadioValueChange(3);
                        this.setState(() {
                          d = 3;
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
                              Text('Obesity analysis', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.white),),
                              Transform.scale(
                                scale: 1,
                                child: Radio(
                                  activeColor: lightyellow,
                                  value: 3,
                                  groupValue: selectedValue,
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
                          selectedValue = 4 as int;
                        });
                        _handleRadioValueChange(4);
                        this.setState(() {
                          d=4;
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
                              Text('Body composition history', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.white),),
                              Transform.scale(
                                scale: 1,
                                child: Radio(
                                  activeColor: lightyellow,
                                  value: 4,
                                  groupValue: selectedValue,
                                  onChanged: (value) {

                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }

}
class SalesData{

  final String month;
  final double sales;

  SalesData(this.month, this.sales);

}
