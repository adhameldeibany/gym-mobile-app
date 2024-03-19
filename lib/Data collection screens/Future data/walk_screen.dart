// import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
// import 'package:flockergym/Data%20collection%20screens/Future%20data/form_screen.dart';
// import 'package:flockergym/Data%20collection%20screens/pushup_screen.dart';
// import 'package:flockergym/Methods/colors_methods.dart';
// import 'package:flockergym/NewBackend/DataCollectionBack/DataCollectionMethods.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// class WalkScreen extends StatefulWidget {
//
//   @override
//   State<WalkScreen> createState() => _WalkScreenState();
// }
//
// TextEditingController controller = TextEditingController();
//
//
// class _WalkScreenState extends State<WalkScreen> {
//
//   bool a = false;
//   bool s = false;
//   bool d = false;
//   String walk = "";
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       child: Scaffold(
//         backgroundColor: Colors.black,
//         appBar: AppBar(
//           elevation: 0,
//           backgroundColor: Colors.black,
//           leading: BackButton(
//             color: Colors.white,
//             onPressed: (){
//               Get.off(PushupScreen());
//             },
//           ),
//         ),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 SizedBox(height: 10.h,),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 20, right: 20),
//                   child: Text(
//                     'How much do you walk daily ?',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 25.sp,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Column(
//               children: [
//                 InkWell(
//                   onTap: (){
//                     setState(() {
//                       if (a == false) {
//                         a = true;
//                         s = false;
//                         d = false;
//                         walk = "Less Than 1 Hour";
//                       } else if (a == true) {
//                         a = false;
//                       }
//                     });
//                   },
//                   child: Container(
//                     width: 300.w,
//                     height: 60.h,
//                     decoration: BoxDecoration(
//                         color: a ? lightyellow : darkgrey,
//                         borderRadius: BorderRadius.circular(5),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 15),
//                       child: Row(
//                         children: [
//                           Text('Less Than 1 Hour',
//                             textAlign: TextAlign.start,
//                             style: TextStyle(fontWeight: FontWeight.bold, color: a ? darkgrey : lightyellow, fontSize: 16.sp),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 15.h,),
//                 InkWell(
//                   onTap: (){
//                     setState(() {
//                       if (s == false) {
//                         s = true;
//                         a = false;
//                         d = false;
//                         walk = "1-2 Hours";
//                       } else if (s == true) {
//                         s = false;
//                       }
//                     });
//                   },
//                   child: Container(
//                     width: 300.w,
//                     height: 60.h,
//                     decoration: BoxDecoration(
//                         color: s ? lightyellow : darkgrey,
//                         borderRadius: BorderRadius.circular(5),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 15),
//                       child: Row(
//                         children: [
//                           Text('1-2 Hours',
//                             textAlign: TextAlign.start,
//                             style: TextStyle(fontWeight: FontWeight.bold, color: s ? darkgrey : lightyellow, fontSize: 16.sp),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 15.h,),
//                 InkWell(
//                   onTap: (){
//                     setState(() {
//                       if (d == false) {
//                         d = true;
//                         a = false;
//                         s = false;
//                         walk = "More Than 2 Hours";
//                       } else if (d == true) {
//                         d = false;
//                       }
//                     });
//                   },
//                   child: Container(
//                     width: 300.w,
//                     height: 60.h,
//                     decoration: BoxDecoration(
//                         color: d ? lightyellow : darkgrey,
//                         borderRadius: BorderRadius.circular(5),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 15),
//                       child: Row(
//                         children: [
//                           Text('More Than 2 Hours',
//                             textAlign: TextAlign.start,
//                             style: TextStyle(fontWeight: FontWeight.bold, color: d ? darkgrey : lightyellow, fontSize: 16.sp),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.all(25),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   InkWell(
//                     onTap: () async {
//                       if(walk == ""){
//                         final snackBar = SnackBar(
//                           duration: Duration(milliseconds: 1500,),
//                           elevation: 0,
//                           behavior: SnackBarBehavior.floating,
//                           backgroundColor: Colors.transparent,
//                           content: AwesomeSnackbarContent(
//                             title: 'Wrong',
//                             message: 'Please Choose An Option',
//                             contentType: ContentType.failure,
//                           ),
//                         );
//                         ScaffoldMessenger.of(context)
//                           ..hideCurrentSnackBar()
//                           ..showSnackBar(snackBar);
//                         return;
//                       }
//                       await DataCollectionMethods().savestringdata('walk',walk);
//                       Get.to(FormScreen());
//                     },
//                     child: Container(
//                       width: 280.w,
//                       height: 45.h,
//                       decoration: BoxDecoration(
//                         color: lightyellow,
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text('Next',
//                             style: TextStyle(color: darkgrey, fontSize: 18.sp,fontWeight: FontWeight.bold),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//         onWillPop: ()async{
//           Get.off(PushupScreen());
//           return false;
//         });
//   }
// }
