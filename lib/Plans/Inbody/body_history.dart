import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flockergym/Methods/colors_methods.dart';
import 'package:flockergym/NewBackend/MainMethods.dart';
import 'package:flockergym/NewBackend/Models/InBodyFModel.dart';
import 'package:flockergym/Plans/Inbody/inbody_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

late InBodyFModel inbodydata;
FirebaseFirestore ref = FirebaseFirestore.instance;
final ref3 = ref.collection("userinbody").doc(FirebaseAuth.instance.currentUser!.uid).snapshots();
late List<SalesData> data ;
late List<SalesData> data2 ;
late List<SalesData> data3 ;

class BodyHistory extends StatefulWidget {
  const BodyHistory({super.key});

  @override
  State<BodyHistory> createState() => _BodyHistoryState();
}

class _BodyHistoryState extends State<BodyHistory> {

  Scaffold MakeStream(BuildContext context){
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
                water: items.get("water"),
                dry: items.get("dry"),
                bmi: items.get("bmi"),
              );

              data.add(SalesData(DateFormat("dd - MMMM").format(DateTime.now().add(Duration(days: -28))), double.parse(items.get("smm1"))));
              data.add(SalesData(DateFormat("dd - MMMM").format(DateTime.now().add(Duration(days: -21))), double.parse(items.get("smm2"))));
              data.add(SalesData(DateFormat("dd - MMMM").format(DateTime.now().add(Duration(days: -14))), double.parse(items.get("smm3"))));
              data.add(SalesData(DateFormat("dd - MMMM").format(DateTime.now().add(Duration(days: -7))), double.parse(items.get("smm4"))));
              data.add(SalesData(DateFormat("dd - MMMM").format(DateTime.now().add(Duration(days: 0))), double.parse(items.get("smm5"))));

              data2.add(SalesData(DateFormat("dd - MMMM").format(DateTime.now().add(Duration(days: -28))), double.parse(items.get("weight1"))));
              data2.add(SalesData(DateFormat("dd - MMMM").format(DateTime.now().add(Duration(days: -21))), double.parse(items.get("weight2"))));
              data2.add(SalesData(DateFormat("dd - MMMM").format(DateTime.now().add(Duration(days: -14))), double.parse(items.get("weight3"))));
              data2.add(SalesData(DateFormat("dd - MMMM").format(DateTime.now().add(Duration(days: -7))), double.parse(items.get("weight4"))));
              data2.add(SalesData(DateFormat("dd - MMMM").format(DateTime.now().add(Duration(days: 0))), double.parse(items.get("weight5"))));

              data3.add(SalesData(DateFormat("dd - MMMM").format(DateTime.now().add(Duration(days: -28))), double.parse(items.get("pbf1"))));
              data3.add(SalesData(DateFormat("dd - MMMM").format(DateTime.now().add(Duration(days: -21))), double.parse(items.get("pbf2"))));
              data3.add(SalesData(DateFormat("dd - MMMM").format(DateTime.now().add(Duration(days: -14))), double.parse(items.get("pbf3"))));
              data3.add(SalesData(DateFormat("dd - MMMM").format(DateTime.now().add(Duration(days: -7))), double.parse(items.get("pbf4"))));
              data3.add(SalesData(DateFormat("dd - MMMM").format(DateTime.now().add(Duration(days: 0))), double.parse(items.get("smm5"))));


              return Scaffold(
                backgroundColor: Colors.black,
                appBar: AppBar(
                  backgroundColor: Colors.black,
                  elevation: 0,
                  title: Text(
                    'Body composition history',
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
                body: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Column(
                        children: [
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
              data = [];
              data2 = [];
              data3 = [];
              print("Not Exists");
              return Scaffold(
                backgroundColor: Colors.black,
                appBar: AppBar(
                  backgroundColor: Colors.black,
                  elevation: 0,
                  title: Text(
                    'Body composition history',
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
                body: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Column(
                        children: [
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
              );
            }
          } else {
            return LoadingScreen();
          }
        },
      ),
    );

  }

  int selectedValue = 4;

  void _handleRadioValueChange(int value) {
    setState(() {
      selectedValue = value;
    });
  }

  int valueSelected = 0;

  void _handleRadioValueChange2(int value) {
    setState(() {
      valueSelected = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: MakeStream(context),
    );
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
// Future _displayBottomSheet(BuildContext context) {
//   return showModalBottomSheet(
//       context: context,
//       barrierColor: silverdark.withOpacity(0.5),
//       backgroundColor: Colors.black,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
//       builder: (context) => StatefulBuilder(
//         builder: (context, setState) => Container(
//           height: 180.h,
//           child: Padding(
//             padding: const EdgeInsets.only(left: 20, right: 20),
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   SizedBox(height: 30.h,),
//                   InkWell(
//                     onTap: (){
//                       setState(() {
//                         valueSelected = 0 as int;
//                       });
//                       _handleRadioValueChange2(0);
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
//                             Text('Recent', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.white),),
//                             Transform.scale(
//                               scale: 1,
//                               child: Radio(
//                                 activeColor: lightyellow,
//                                 value: 0,
//                                 groupValue: valueSelected,
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
//                         valueSelected = 1 as int;
//                       });
//                       _handleRadioValueChange2(1);
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
//                             Text('Total', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.white),),
//                             Transform.scale(
//                               scale: 1,
//                               child: Radio(
//                                 activeColor: lightyellow,
//                                 value: 1,
//                                 groupValue: valueSelected,
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
//                   SizedBox(height: 30.w,),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       )
//   );
// }
}
