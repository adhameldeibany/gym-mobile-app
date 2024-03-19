// import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flockergym/Data%20collection%20screens/pushup_screen.dart';
// import 'package:flockergym/Data%20collection%20screens/subtype_screen.dart';
// import 'package:flockergym/Data%20collection%20screens/Future%20data/walk_screen.dart';
// import 'package:flockergym/Methods/colors_methods.dart';
// import 'package:flockergym/NewBackend/DataCollectionBack/DataCollectionMethods.dart';
// import 'package:flockergym/NewBackend/MainMethods.dart';
// import 'package:flockergym/NewBackend/Models/ClassModel.dart';
// import 'package:flockergym/main.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
//
//
// class FormScreen extends StatefulWidget {
//   const FormScreen({super.key});
//
//   @override
//   State<FormScreen> createState() => _FormScreenState();
// }
// int age = 20;
// double weight = 60.0;
//
// TextEditingController controller = TextEditingController();
//
// List<String> List33 = ["Choose Class"];
// late List<ClassModel> classe;
// String List3 = 'Choose Class';
// DatabaseReference ref2 = FirebaseDatabase.instance.ref("classes/");
// List<String> List44 = ["Choose Class"];
// String List4 = 'Choose Class';
// String data = "";
// String data2 = "";
// class _FormScreenState extends State<FormScreen> {
//
//   @override
//   void initState() {
//     controller.text = age.toString();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return RefreshIndicator(
//       onRefresh: ()async{
//         setState(() {
//           print(FirebaseAuth.instance.currentUser!.uid);
//           State<FormScreen> createState() => _FormScreenState();
//         });
//       },
//       child: WillPopScope(
//           child: StreamBuilder(
//             stream: ref2.onValue,
//             builder: (context, snapshot) {
//               classe = [];
//               if (snapshot.hasData && snapshot.data != null && (snapshot.data! as DatabaseEvent).snapshot.value != null) {
//                 classe.clear();
//                 List33.clear();
//                 List33.add("Choose Class");
//                 List44.clear();
//                 List44.add("Choose Class");
//                 if (prefs.getString('gender') == "Female") {
//                   List44.add("Ladies only");
//                 }
//                 final classes = Map<dynamic, dynamic>.from((snapshot.data! as DatabaseEvent).snapshot.value as Map<dynamic, dynamic>); //typecasting
//                 classes.forEach((key, value) {
//                   final classelement = Map<String, dynamic>.from(value);
//                   List33.add(classelement['name'].toString());
//                   List44.add(classelement['name'].toString());
//                   classe.add(
//                       ClassModel(
//                         id: classelement['id'],
//                         name: classelement['name'],
//                         startsat: classelement['startsat'],
//                         timesaweek: classelement['timesaweek'],
//                         coachid: classelement['coachid'],
//                         coachname: classelement['coachname'],
//                         daysandtimeandlength: classelement['daysandtimeandlength'],
//                         imgurl: classelement['imgurl'],
//                       )
//                   );
//                 });
//                 return Scaffold(
//                   backgroundColor: Colors.black,
//                   appBar: AppBar(
//                     elevation: 0,
//                     backgroundColor: Colors.black,
//                     leading: BackButton(
//                       color: Colors.white,
//                       onPressed: (){
//                         Get.off(PushupScreen());
//                       },
//                     ),
//                   ),
//                   body: Column(
//                     children: [
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           SizedBox(height: 10.h,),
//                           Padding(
//                             padding: const EdgeInsets.only(left: 20, right: 20),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   'What is your subscription form ?',
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                     fontSize: 25.sp,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       Expanded(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 SingleChildScrollView(
//                                   scrollDirection: Axis.horizontal,
//                                   child: Container(
//                                     height: 60.h,
//                                     width: 250.w,
//                                     decoration: BoxDecoration(
//                                       color: lightyellow,
//                                       border: Border.all(color: Colors.grey, width: 1.w, ),
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                     child: Padding(
//                                       padding: const EdgeInsets.only(left: 12, right: 12),
//                                       child: Center(
//                                         child: DropdownButton<String>(
//                                           underline: Container(color: Colors.white,),
//                                           isExpanded: true,
//                                           items: List44.map<DropdownMenuItem<String>>(
//                                                   (String value)
//                                               {
//                                                 return DropdownMenuItem<String>(
//                                                   value: value,
//                                                   child: SingleChildScrollView(
//                                                       scrollDirection: Axis.horizontal,
//                                                       child: Center(
//                                                           child: Text(value,
//                                                             style: TextStyle(color: darkgrey, fontSize: 18.sp, fontWeight: FontWeight.bold,),))),
//                                                 );
//                                               }
//
//                                           ).toList(),
//                                           icon: Icon(Icons.arrow_drop_down, size: 35, color: darkgrey,),
//
//                                           value: List4,
//                                           onChanged:(alinanVeri) {
//                                             if (alinanVeri! == "Choose Class") {
//                                               data = "";
//                                             }else{
//                                               data = "${FirebaseAuth.instance.currentUser!.uid.toString()}>${classe[List44.indexOf(alinanVeri!)-1].name}";
//                                             }
//                                             setState(() {
//                                               List4 = alinanVeri!;
//                                             });
//                                           },
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 SingleChildScrollView(
//                                   scrollDirection: Axis.horizontal,
//                                   child: Container(
//                                     height: 60.h,
//                                     width: 250.w,
//                                     decoration: BoxDecoration(
//                                       color: lightyellow,
//                                       border: Border.all(color: Colors.grey, width: 1.w, ),
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                     child: Padding(
//                                       padding: const EdgeInsets.only(left: 12, right: 12),
//                                       child: Center(
//                                         child: DropdownButton<String>(
//                                             underline: Container(color: Colors.white,),
//                                             isExpanded: true,
//                                             items: List33.map<DropdownMenuItem<String>>(
//                                                     (String value)
//                                                 {
//                                                   return DropdownMenuItem<String>(
//                                                     value: value,
//                                                     child: SingleChildScrollView(
//                                                         scrollDirection: Axis.horizontal,
//                                                         child: Center(
//                                                             child: Text(value,
//                                                               style: TextStyle(color: darkgrey, fontSize: 18.sp, fontWeight: FontWeight.bold,),))),
//                                                   );
//                                                 }
//
//                                             ).toList(),
//                                             icon: Icon(Icons.arrow_drop_down, size: 35, color: darkgrey,),
//
//                                             value: List3,
//                                             onChanged:(alinanVeri) {
//                                               if (alinanVeri! == "Choose Class") {
//                                                 data = "";
//                                               }else{
//                                                 data = "${FirebaseAuth.instance.currentUser!.uid.toString()}>${classe[List33.indexOf(alinanVeri!)-1].name}";
//                                               }
//                                               setState(() {
//                                                 List3 = alinanVeri!;
//                                               });
//                                             }
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(25),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             InkWell(
//                               onTap: ()async{
//                                 if (data == "" && data2 == "") {
//                                   final snackBar = SnackBar(
//                                     duration: Duration(milliseconds: 1500,),
//                                     elevation: 0,
//                                     behavior: SnackBarBehavior.floating,
//                                     backgroundColor: Colors.transparent,
//                                     content: AwesomeSnackbarContent(
//                                       title: 'Error',
//                                       message: 'Please Choose Class.',
//                                       contentType: ContentType.failure,
//                                     ),
//                                   );
//                                   ScaffoldMessenger.of(context)
//                                     ..hideCurrentSnackBar()
//                                     ..showSnackBar(snackBar);
//                                   return;
//                                 }
//                                 await DataCollectionMethods().savestringdata('form1',data);
//                                 await DataCollectionMethods().savestringdata('form2',data2);
//                                 Get.off(SubtypeScreen());
//                               },
//                               child: Container(
//                                 width: 280.w,
//                                 height: 45.h,
//                                 decoration: BoxDecoration(
//                                   color: lightyellow,
//                                   borderRadius: BorderRadius.circular(5),
//                                 ),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Text('Next',
//                                       style: TextStyle(color: darkgrey, fontSize: 18.sp,fontWeight: FontWeight.bold),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               }else{
//                 return LoadingScreen();
//               }
//               },
//           ),
//           onWillPop: ()async{
//             Get.off(PushupScreen());
//             return false;
//           }),
//     );
//
//
//   }
// }
