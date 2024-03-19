import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flockergym/Booking/Coach/coachview_screen.dart';
import 'package:flockergym/Methods/AuthMethods/AuthMethods.dart';
import 'package:flockergym/Methods/colors_methods.dart';
import 'package:flockergym/NewBackend/MainMethods.dart';
import 'package:flockergym/NewBackend/Models/ClassModel.dart';
import 'package:flockergym/NewBackend/Models/ClassesDaysModel.dart';
import 'package:flockergym/NewBackend/Models/StaffModel.dart';
import 'package:flockergym/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

List<String> data = [];
late String classN;
late String clase;
late List<StaffModel> staffe;
late StaffModel current;
List<ClassesDaysModel> classe = [];

class CoachScreen extends StatefulWidget {
  CoachScreen({required String day, required String from, required String to, required String daylong,required String classname, required List<ClassesDaysModel> classes, required String clas}){
    data.add(day);
    data.add(from);
    data.add(to);
    data.add(daylong);
    classN = classname;
    staffe = [];
    classe = classes;
    clase = clas;
  }

  @override
  State<CoachScreen> createState() => _CoachScreenState();
}

class _CoachScreenState extends State<CoachScreen> {

  Scaffold MakeStream(BuildContext context){
    DatabaseReference ref2 = FirebaseDatabase.instance.ref("staff/");
    return Scaffold(
      body: StreamBuilder(
        stream: ref2.onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null && (snapshot.data! as DatabaseEvent).snapshot.value != null) {
            staffe.clear();
            final classes = Map<dynamic, dynamic>.from((snapshot.data! as DatabaseEvent).snapshot.value as Map<dynamic, dynamic>); //typecasting
            classes.forEach((key, value) {
              final classelement = Map<String, dynamic>.from(value);
              staffe.add(
                  StaffModel(
                    id: classelement['id'],
                    name: classelement['name'],
                    age: classelement['age'],
                    email: classelement['email'],
                    gender: classelement['gender'],
                    mobile: classelement['mobile'],
                    role: classelement['role'],
                    salary: classelement['salary'],
                    workfrom: classelement['workfrom'],
                    imgurl: classelement['imgurl'],
                  )
              );

              if (classelement['name'].toString().toLowerCase() == classN.toLowerCase()) {
                current = StaffModel(
                  id: classelement['id'],
                  name: classelement['name'],
                  age: classelement['age'],
                  email: classelement['email'],
                  gender: classelement['gender'],
                  mobile: classelement['mobile'],
                  role: classelement['role'],
                  salary: classelement['salary'],
                  workfrom: classelement['workfrom'],
                  imgurl: classelement['imgurl'],
                );
              }

            });
            return Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                backgroundColor: Colors.black,
                elevation: 0,
                title: Text("Find coach",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),
                leading: BackButton(color: Colors.white,),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 10.h,),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 320.w,
                            child: Text("You have scheduled with ${current.name} for your last session, would you like to meet up again?",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      color: Color(0xFF2B2F30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 60.w,
                                        height: 90.h,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: NetworkImage(current.imgurl),
                                            )
                                        ),
                                      ),
                                      SizedBox(width: 10.w,),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 120.w,
                                            child: AutoSizeText(classN,
                                              maxLines: 2,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 14.sp),
                                            ),
                                          ),
                                          SizedBox(height: 5.h,),
                                          Row(
                                            children: [
                                              SizedBox(
                                                  width: 15.w,
                                                  height: 15.h,
                                                  child: Image(image: AssetImage('assets/p19.PNG'),)
                                              ),
                                              SizedBox(
                                                  width: 15.w,
                                                  height: 15.h,
                                                  child: Image(image: AssetImage('assets/p19.PNG'),)
                                              ),
                                              SizedBox(
                                                  width: 15.w,
                                                  height: 15.h,
                                                  child: Image(image: AssetImage('assets/p19.PNG'),)
                                              ),
                                              SizedBox(
                                                  width: 15.w,
                                                  height: 15.h,
                                                  child: Image(image: AssetImage('assets/p19.PNG'),)
                                              ),
                                              SizedBox(
                                                  width: 15.w,
                                                  height: 15.h,
                                                  child: Image(image: AssetImage('assets/p20.PNG'),)
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 5.h,),
                                          Row(
                                            children: [
                                              Text('+25 Trainee', style: TextStyle(color: Colors.grey),),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h,),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("Results for coaches available for next:",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${data[0]} at ${data[1]} - ${data[2]}",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.white,
                                ),
                              ),
                              TextButton(
                                onPressed: (){
                                  context.go("/Class/Schedule",extra: classe);
                                },
                                child: Text("Edit",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp,
                                    color: lightyellow,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisExtent: 275.h,
                          ),
                          itemCount: staffe.length,
                          itemBuilder: (_,index){
                            final staff = staffe[index];
                            return Column(
                              children: [
                                Container(
                                  width: 156.w,
                                  height: 260.h,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF2B2F30),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              width: 40.w,
                                              height: 70.h,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                    image: NetworkImage(staff.imgurl),
                                                  )
                                              ),
                                            ),
                                            AutoSizeText(staff.name,
                                              maxLines: 2,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14.sp,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w500,
                                                height: 0,
                                                letterSpacing: -0.15,
                                              ),
                                            ),
                                            SizedBox(height: 5.h,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                    width: 15.w,
                                                    height: 15.h,
                                                    child: Image(image: AssetImage('assets/p19.PNG'),)
                                                ),
                                                SizedBox(
                                                    width: 15.w,
                                                    height: 15.h,
                                                    child: Image(image: AssetImage('assets/p19.PNG'),)
                                                ),
                                                SizedBox(
                                                    width: 15.w,
                                                    height: 15.h,
                                                    child: Image(image: AssetImage('assets/p19.PNG'),)
                                                ),
                                                SizedBox(
                                                    width: 15.w,
                                                    height: 15.h,
                                                    child: Image(image: AssetImage('assets/p19.PNG'),)
                                                ),
                                                SizedBox(
                                                    width: 15.w,
                                                    height: 15.h,
                                                    child: Image(image: AssetImage('assets/p20.PNG'),)
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5.h,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text('+25 Trainee', style: TextStyle(
                                                  color: Color(0xFFBCBCBC),
                                                  fontSize: 14.sp,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w500,
                                                  height: 0,
                                                  letterSpacing: -0.15,
                                                ),),
                                              ],
                                            ),
                                          ],
                                        ),
                                        TextButton(
                                          onPressed: (){
                                            context.goNamed("Coachview",extra: staff.name,pathParameters: {'clas':clase});
                                          },
                                          child: Text("View profile",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              color: Color(0xFFF8BE00),
                                              fontSize: 14.sp,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                              height: 0,
                                              letterSpacing: -0.15,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                      ),
                    ),
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: ()async{
          context.go("/Class/Schedule",extra: classe);
          return false;
        },
        child: MakeStream(context));
  }
}
