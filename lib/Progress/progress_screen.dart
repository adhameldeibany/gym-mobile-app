// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flockergym/Data%20collection%20screens/weight_screen.dart';
// import 'package:flockergym/Methods/colors_methods.dart';
// import 'package:flockergym/NewBackend/Models/MemberModel.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:gradient_widgets/gradient_widgets.dart';
// import 'package:lottie/lottie.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
//
// List<SalesData> data = [
//   SalesData('Jan', 35),
//   SalesData('Feb', 28),
//   SalesData('Mar', 34),
//   SalesData('Apr', 32),
//   SalesData('May', 40)
// ];
//
// late String MuscleMass;
// late String Fat;
// late MemberModel memberModel;
//
// DatabaseReference ref = FirebaseDatabase.instance.ref("members/${FirebaseAuth.instance.currentUser!.uid}/");
//
//
// class ProgressScreen extends StatefulWidget {
//   const ProgressScreen({super.key});
//
//   @override
//   State<ProgressScreen> createState() => _ProgressScreenState();
// }
//
// List<String> inperson = ["Weight","Muscle Mass","Fat Mass"];
// List<double> inpercent = [0.5,0.4,0.8];
//
//
// class _ProgressScreenState extends State<ProgressScreen> {
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       backgroundColor: darkgrey,
//       appBar: AppBar(
//         backgroundColor: darkgrey,
//         title: Text('Progress',
//           style: TextStyle(color: lightyellow, fontSize: 25.sp),
//         ),
//         centerTitle: true,
//       ),
//       body: StreamBuilder(
//         stream: ref.onValue,
//         builder: (context, snapshot) {
//           if (snapshot.hasData && snapshot.data != null &&
//               (snapshot.data! as DatabaseEvent).snapshot.value != null) {
//             memberModel = MemberModel(
//                 age: snapshot.data?.snapshot
//                     .child('age')
//                     .value
//                     .toString(),
//                 createdat: snapshot.data?.snapshot
//                     .child('createdat')
//                     .value
//                     .toString(),
//                 email: snapshot.data?.snapshot
//                     .child('email')
//                     .value
//                     .toString(),
//                 endsAt: snapshot.data?.snapshot
//                     .child('endsAt')
//                     .value
//                     .toString(),
//                 gender: snapshot.data?.snapshot
//                     .child('gender')
//                     .value
//                     .toString(),
//                 height: snapshot.data?.snapshot
//                     .child('height')
//                     .value
//                     .toString(),
//                 id: snapshot.data?.snapshot
//                     .child('id')
//                     .value
//                     .toString(),
//                 imgurl: snapshot.data?.snapshot
//                     .child('imgurl')
//                     .value
//                     .toString(),
//                 memberstatus: snapshot.data?.snapshot
//                     .child('memberstatus')
//                     .value
//                     .toString(),
//                 mobile: snapshot.data?.snapshot
//                     .child('mobile')
//                     .value
//                     .toString(),
//                 name: snapshot.data?.snapshot
//                     .child('name')
//                     .value
//                     .toString(),
//                 password: snapshot.data?.snapshot
//                     .child('password')
//                     .value
//                     .toString(),
//                 weight: snapshot.data?.snapshot
//                     .child('weight')
//                     .value
//                     .toString(),
//                 uniq: snapshot.data?.snapshot
//                     .child('uniq')
//                     .value
//                     .toString()
//             );
//             // For men: Lean body mass = (0.32810 × W) + (0.33929 × H) − 29.5336 => 44
//             // For women: Lean body mass = (0.29569 × W) + (0.41813 × H) − 43.2933 => 33
//             //https://gymnation.com/fitness-calculators/lean-body-mass-calculator/
//             double wp = int.parse(memberModel.weight.toString())/ int.parse(memberModel.height.toString()) + 0.2;
//             inpercent[0] = wp;
//
//             print(wp.toString());
//             if (memberModel.gender.toString().toLowerCase() == "male") {
//               MuscleMass = ((0.32810 * int.parse(memberModel.weight.toString()).toDouble()) + (0.33929 * int.parse(memberModel.height.toString()).toDouble()) - 29.5336).toStringAsFixed(2);
//               Fat = double.parse((int.parse(memberModel.weight.toString()) * 0.15).toString()).toStringAsFixed(2);
//               double mmp = double.parse(Fat)/ 88;
//               inpercent[1] = mmp;
//             }else{
//               MuscleMass = ((0.29569 * int.parse(memberModel.weight.toString()).toDouble()) + (0.41813 * int.parse(memberModel.height.toString()).toDouble()) - 43.2933).toStringAsFixed(2);
//               Fat = double.parse((int.parse(memberModel.weight.toString()) * 0.15).toString()).toStringAsFixed(2);
//               double mmp = double.parse(Fat)/ 66;
//               inpercent[1] = mmp;
//             }
//             return SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(top: 20),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           InkWell(
//                             onTap:(){
//                               Get.to(WeightScreen());
//                             },
//                             child: Container(
//                               width: 300.w,
//                               height: 40.h,
//                               decoration: BoxDecoration(
//                                 color: lightyellow,
//                                 borderRadius: BorderRadius.circular(10),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     blurRadius: 10,
//                                     color: silverdark,
//                                     offset: Offset(0, 5),
//                                   ),
//                                 ],
//                               ),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text('Start Sync',
//                                     style: TextStyle(color: darkgrey, fontSize: 18.sp, fontWeight: FontWeight.bold),),
//                                   Icon(Icons.arrow_forward_ios, color: darkgrey,)
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 25.h),
//                     Row(
//                       children: [
//                         Text('InBody Test Summary',
//                           style: TextStyle(color: lightyellow, fontSize: 15.sp, fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 10.h),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         InkWell(
//                           onTap: (){},
//                           child: Container(
//                             height: 90.h,
//                             width: 100.w,
//                             decoration: BoxDecoration(
//                                 color: darkgrey,
//                                 borderRadius: BorderRadius.circular(10),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     blurRadius: 10,
//                                     color: Colors.white24,
//                                     offset: Offset(0, 5),
//                                   )
//                                 ]
//                             ),
//                             child: Center(
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text('Weight ',
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 12.sp),
//                                   ),
//                                   SizedBox(height: 5.h,),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text(memberModel.weight.toString(),
//                                         textAlign: TextAlign.center,
//                                         style: TextStyle(fontWeight: FontWeight.bold, color: lightyellow, fontSize: 20.sp),
//                                       ),
//                                       Text('kg',
//                                         style: TextStyle(fontWeight: FontWeight.bold, color: silverdark, fontSize: 10.sp),
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(height: 5.h,),
//                                   Container(
//                                     width: 80.w,
//                                     height: 20.h,
//                                     decoration: BoxDecoration(
//                                         color: int.parse(memberModel.height.toString()) - int.parse(memberModel.weight.toString())  >= 90?Colors.green:Colors.red,
//                                         borderRadius: BorderRadius.circular(20)
//                                     ),
//                                     child: Center(
//                                       child: Text(int.parse(memberModel.height.toString()) - int.parse(memberModel.weight.toString())  >= 90?'Avg':'Above Avg.',
//                                         style: TextStyle(color: Colors.white, fontSize: 11.sp),
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: 10.w,),
//                         InkWell(
//                           onTap: (){},
//                           child: Container(
//                             height: 90.h,
//                             width: 100.w,
//                             decoration: BoxDecoration(
//                                 color: darkgrey,
//                                 borderRadius: BorderRadius.circular(10),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     blurRadius: 10,
//                                     color: Colors.white24,
//                                     offset: Offset(0, 5),
//                                   )
//                                 ]
//                             ),
//                             child: Center(
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text('Muscle Mass',
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 12.sp),
//                                   ),
//                                   SizedBox(height: 5.h,),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text(MuscleMass,
//                                         textAlign: TextAlign.center,
//                                         style: TextStyle(fontWeight: FontWeight.bold, color: lightyellow, fontSize: 20.sp),
//                                       ),
//                                       Text('kg',
//                                         style: TextStyle(fontWeight: FontWeight.bold, color: silverdark, fontSize: 10.sp),
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(height: 5.h,),
//                                   Container(
//                                     width: 80.w,
//                                     height: 20.h,
//                                     decoration: BoxDecoration(
//                                         color: memberModel.gender.toString().toLowerCase()=="male"?double.parse(MuscleMass)<=44?Colors.green:Colors.red:double.parse(MuscleMass)<=33?Colors.green:Colors.red,
//                                         borderRadius: BorderRadius.circular(20)
//                                     ),
//                                     child: Center(
//                                       child: Text( memberModel.gender.toString().toLowerCase()=="male"?double.parse(MuscleMass)<=44?"Avg":"Above Avg":double.parse(MuscleMass)<=33?"Avg":"Above Avg",
//                                         style: TextStyle(color: Colors.white, fontSize: 11.sp),
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: 10.w,),
//                         InkWell(
//                           onTap: (){},
//                           child: Container(
//                             height: 90.h,
//                             width: 100.w,
//                             decoration: BoxDecoration(
//                                 color: darkgrey,
//                                 borderRadius: BorderRadius.circular(10),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     blurRadius: 10,
//                                     color: Colors.white24,
//                                     offset: Offset(0, 5),
//                                   )
//                                 ]
//                             ),
//                             child: Center(
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text('Body Fat ',
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 12.sp),
//                                   ),
//                                   SizedBox(height: 5.h,),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text(Fat,
//                                         textAlign: TextAlign.center,
//                                         style: TextStyle(fontWeight: FontWeight.bold, color: lightyellow, fontSize: 20.sp),
//                                       ),
//                                       Text('kg',
//                                         textAlign: TextAlign.center,
//                                         style: TextStyle(fontWeight: FontWeight.bold, color: silverdark, fontSize: 10.sp),
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(height: 5.h,),
//                                   Container(
//                                     width: 80.w,
//                                     height: 20.h,
//                                     decoration: BoxDecoration(
//                                         color: double.parse(Fat) <= 19?Colors.green:Colors.red,
//                                         borderRadius: BorderRadius.circular(20)
//                                     ),
//                                     child: Center(
//                                       child: Text(double.parse(Fat) <= 19?'Avg.':'Above Avg',
//                                         style: TextStyle(color: Colors.white, fontSize: 11.sp),
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 25.h),
//                     // Expanded(
//                     //   child: ListView.builder(
//                     //       itemCount: 3,
//                     //       itemBuilder: (context, index) {
//                     //         return Column(
//                     //           children: [
//                     //             Row(
//                     //               children: [
//                     //                 SizedBox(
//                     //                   width: 54.5.w,
//                     //                   child: Text(inperson[index],
//                     //                     textAlign: TextAlign.start,
//                     //                     style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 15.sp),
//                     //                   ),
//                     //                 ),
//                     //                 LinearPercentIndicator(
//                     //                   width: 230.w,
//                     //                   animation: true,
//                     //                   animationDuration: 10000,
//                     //                   lineHeight: 12.h,
//                     //                   percent: inpercent[index],
//                     //                   progressColor: inpercent[index]>0.5?Colors.red:lightyellow,
//                     //                   backgroundColor: silverdark,
//                     //                 ),
//                     //               ],
//                     //             ),
//                     //             SizedBox(height: 10.h,),
//                     //           ],
//                     //         );
//                     //       }
//                     //   ),
//                     // ),
//                     Row(
//                       children: [
//                         Text('CID',
//                           style: TextStyle(color: lightyellow, fontSize: 20.sp, fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 15.h),
//                     SizedBox(
//                       width: double.infinity,
//                       height: 120.h,
//                       child: ListView.builder(
//                           itemCount: 3,
//                           itemBuilder: (context, index) {
//                             return Column(
//                               children: [
//                                 Row(
//                                   children: [
//                                     SizedBox(
//                                       width: 60.w,
//                                       child: Text(inperson[index],
//                                         textAlign: TextAlign.start,
//                                         style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 15.sp),
//                                       ),
//                                     ),
//                                     SizedBox(width: 10.w,),
//                                     SizedBox(
//                                       width: 240.w,
//                                       height: 12.h,
//                                       child: inpercent[index]<=0.4?GradientProgressIndicator(
//                                         gradient: LinearGradient(
//                                             colors: [Colors.grey, lightyellow], begin: Alignment.centerLeft, end: Alignment.centerRight),
//                                         value: inpercent[index],
//                                       )
//                                           :inpercent[index]>=0.6?GradientProgressIndicator(
//                                         gradient: LinearGradient(
//                                             colors: [Colors.grey, Colors.red], begin: Alignment.centerLeft, end: Alignment.centerRight),
//                                         value: inpercent[index],
//                                       )
//                                           :GradientProgressIndicator(
//                                         gradient: LinearGradient(
//                                             colors: [Colors.grey, Colors.green], begin: Alignment.centerLeft, end: Alignment.centerRight),
//                                         value: inpercent[index],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(height: 8.h,),
//                               ],
//                             );
//                           }
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         Text('History',
//                           style: TextStyle(color: lightyellow, fontSize: 20.sp, fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 10.h,),
//                     SfCartesianChart(
//                       backgroundColor: Colors.white12,
//                       title: ChartTitle(text: 'Monthly Analysis',textStyle: TextStyle(color: lightyellow)),
//                       borderColor: silverdark,
//                       series: [
//                         LineSeries<SalesData, String>(
//                           color: lightyellow,
//                           width: 3.5.w,
//                           dataSource: data,
//                           xValueMapper: (SalesData sales, _) => sales.month,
//                           yValueMapper: (SalesData sales, _) => sales.sales,
//                           name: 'Sales',
//                           dataLabelSettings: DataLabelSettings(isVisible: true,
//                               textStyle: TextStyle(color: Colors.green, fontSize: 15.sp, fontWeight: FontWeight.bold)
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }else{
//             return Scaffold(
//               backgroundColor: Colors.white,
//               body: Center(
//                 child: Lottie.asset('assets/gym.json'),
//               ),
//             );
//           }
//         }
//     ),
//     );
//   }
// }
//
// class SalesData{
//
//   final String month;
//   final double sales;
//
//   SalesData(this.month, this.sales);
//
// }
