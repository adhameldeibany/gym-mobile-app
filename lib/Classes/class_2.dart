import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flockergym/Methods/colors_methods.dart';
import 'package:flockergym/NewBackend/ClassesBack/ClassesMethods.dart';
import 'package:flockergym/NewBackend/MainMethods.dart';
import 'package:flockergym/NewBackend/Models/ClassesDaysModel.dart';
import 'package:flockergym/NewBackend/Models/FireClassModel.dart';
import 'package:flockergym/NewBackend/Models/StaffModel.dart';
import 'package:flockergym/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

String selected = "All Classes";
bool x = false;
bool y = false;
bool z = false;
List<FireClassModel> fireclass = [];
List<ClassesDaysModel> filteredfireclass = [];
FirebaseFirestore ref = FirebaseFirestore.instance;
String filterby = "";
class ClassesScreen2 extends StatefulWidget {
  ClassesScreen2({String? filter}){
    print(filter);
    if (filter == null) {
      filterby = "";
    }  else{
      filterby = filter;
      filteredfireclass = [];
    }
  }

  @override
  State<ClassesScreen2> createState() => _ClassesScreen2State();
}

class _ClassesScreen2State extends State<ClassesScreen2> {
  int valueSelected = 0;


  void _handleRadioValueChange(int value) {
    setState(() {
      valueSelected = value;
    });
  }

  Scaffold MakeStream(BuildContext context){
    print(filterby);
    final UsersClasses = ref.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("classes").snapshots();
    final FireClasses = ref.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid).collection("days").snapshots();
    return Scaffold(
      backgroundColor: Colors.black,
      body: StreamBuilder(
        stream: UsersClasses,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null ) {
            if (snapshot.data?.docs.length == 0) {
              return ClassesMethods().start("Main", context);
            }else{
              fireclass.clear();
              final items = snapshot.data!.docs;
              for(var item in items) {
                fireclass.add(
                    FireClassModel(
                        id: item["id"],
                        name: item["name"],
                        remain: item["remain"],
                        status: item["status"],
                        total: item["total"],
                        coachname: item["coachname"],
                        classname: item["classname"],
                        finished: item["finished"],
                        started: item["started"]
                    )
                );
              }
              return StreamBuilder(
                stream: FireClasses,
                builder: (context, snapshot1) {
                  if (snapshot1.hasData && snapshot1.data != null ) {
                    List<ClassesDaysModel> classesdays = [];
                    final items1 = snapshot1.data!.docs;
                    bool istoday = false;
                    late ClassesDaysModel classesDaysModel;
                    filteredfireclass.clear();
                    for(var itm in items1){
                      classesdays.add(
                          ClassesDaysModel(
                            classid: itm["classid"],
                            day: itm["day"],
                            from: itm["from"],
                            id: itm["id"],
                            to: itm["to"],
                            classname: fireclass[fireclass.indexWhere((element) => element.id == itm["classid"])].classname,
                            coach: fireclass[fireclass.indexWhere((element) => element.id == itm["classid"])].coachname,
                            remain: fireclass[fireclass.indexWhere((element) => element.id == itm["classid"])].remain,
                            status: fireclass[fireclass.indexWhere((element) => element.id == itm["classid"])].status,
                            total: fireclass[fireclass.indexWhere((element) => element.id == itm["classid"])].total,
                            started: fireclass[fireclass.indexWhere((element) => element.id == itm["classid"])].started,
                            finished: fireclass[fireclass.indexWhere((element) => element.id == itm["classid"])].finished,
                          )
                      );
                      if (itm["day"].toString().toLowerCase() ==DateFormat('EEEE').format(DateTime.now()).toLowerCase() ) {
                        if (DateFormat('hh:mm').parse(itm["from"]).isBefore(DateTime.now())) {
                          classesDaysModel = ClassesDaysModel(
                            classid: itm["classid"],
                            day: itm["day"],
                            from: itm["from"],
                            id: itm["id"],
                            to: itm["to"],
                            classname: fireclass[fireclass.indexWhere((element) => element.id == itm["classid"])].classname,
                            coach: fireclass[fireclass.indexWhere((element) => element.id == itm["classid"])].coachname,
                            remain: fireclass[fireclass.indexWhere((element) => element.id == itm["classid"])].remain,
                            status: fireclass[fireclass.indexWhere((element) => element.id == itm["classid"])].status,
                            total: fireclass[fireclass.indexWhere((element) => element.id == itm["classid"])].total,
                            started: fireclass[fireclass.indexWhere((element) => element.id == itm["classid"])].started,
                            finished: fireclass[fireclass.indexWhere((element) => element.id == itm["classid"])].finished,
                          );
                          istoday = true;
                        }else{
                        }
                      }

                      if (filterby != "") {
                        if (fireclass[fireclass.indexWhere((element) => element.id == itm["classid"])].status.toLowerCase() == filterby) {
                          filteredfireclass.add(ClassesDaysModel(
                            classid: itm["classid"],
                            day: itm["day"],
                            from: itm["from"],
                            id: itm["id"],
                            to: itm["to"],
                            classname: fireclass[fireclass.indexWhere((element) => element.id == itm["classid"])].classname,
                            coach: fireclass[fireclass.indexWhere((element) => element.id == itm["classid"])].coachname,
                            remain: fireclass[fireclass.indexWhere((element) => element.id == itm["classid"])].remain,
                            status: fireclass[fireclass.indexWhere((element) => element.id == itm["classid"])].status,
                            total: fireclass[fireclass.indexWhere((element) => element.id == itm["classid"])].total,
                            started: fireclass[fireclass.indexWhere((element) => element.id == itm["classid"])].started,
                            finished: fireclass[fireclass.indexWhere((element) => element.id == itm["classid"])].finished,
                          ));
                          print(filteredfireclass.length);
                          print(filterby);
                        }
                      }

                    }
                    if (istoday) {
                      return DataScreen(context,classesDaysModel,classesdays);
                    }else{
                      return DataScreen(context,null,classesdays);
                    }
                  }
                  else{
                    return LoadingScreen();
                  }
                },
              );
            }
          }else{
            return LoadingScreen();
          }
        },
      ),
    );
  }

  Scaffold DataScreen(BuildContext context, ClassesDaysModel? classesDaysModel, List<ClassesDaysModel> classeslist){
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text("Classes",
          textAlign: TextAlign.start,
          style: TextStyle(
              fontSize: 25.sp,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text("Upcoming",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            classesDaysModel == null?Card(
              color: silverdark,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              margin: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width - 40.w,
                        child: Text("No Classes Today",textAlign: TextAlign.center,style: TextStyle(color: lightyellow),))
                  ],
                ),
              ),
            ):
            Card(
              color: silverdark,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              margin: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    SizedBox(height: 5.h,),
                    Row(
                      children: [
                        Text('Today',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Color(0xFFCCC5BD),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.18,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h,),
                    Row(
                      children: [
                        Row(
                          children: [
                            Container(
                                width: 30.w,
                                height: 30.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xffF4E0BB),
                                ),
                                child: Icon(FontAwesomeIcons.dumbbell, size: 15,)
                            ),
                            SizedBox(
                              width: 120.w,
                              child: AutoSizeText(classesDaysModel!.classname,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 20.w,),
                        Row(
                          children: [
                            Container(
                                width: 30.w,
                                height: 30.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xffF4E0BB),
                                ),
                                child: Icon(Icons.person, size: 20,)
                            ),
                            SizedBox(width: 5.w,),
                            SizedBox(
                              width: 85.w,
                              child: AutoSizeText(classesDaysModel.coach,
                                maxLines: 2,
                                textAlign: TextAlign.start,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 20.h,),
                    Row(
                      children: [
                        Row(
                          children: [
                            Container(
                                width: 30.w,
                                height: 30.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xffF4E0BB),
                                ),
                                child: Icon(Icons.date_range, size: 20,)
                            ),
                            SizedBox(width: 5.w,),
                            SizedBox(
                              width: 100.w,
                              child: AutoSizeText('${classesDaysModel.remain} out of ${classesDaysModel.total}',
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 20.w,),
                        Row(
                          children: [
                            Container(
                                width: 30.w,
                                height: 30.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xffF4E0BB),
                                ),
                                child: Icon(Icons.access_time, size: 20,)
                            ),
                            SizedBox(
                              width: 80.w,
                              child: AutoSizeText('${classesDaysModel.from} - ${classesDaysModel.to}',
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h,),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){
                    setState(() {
                      if (x == false) {
                        x = true;
                        y = false;
                        z = false;
                      } else if (x == true) {
                        x = false;
                      }
                    });
                    context.go("/Class/BookSession",extra: classeslist);
                  },
                  child: Container(
                    width: 156.w,
                    height: 44.h,
                    decoration: BoxDecoration(
                        color: x ? lightyellow : Colors.black,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: lightyellow, width: 1.w)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text('Book a session',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: x ? Colors.black : lightyellow,
                              fontSize: 14.sp,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 20.w,),
                InkWell(
                  onTap: (){
                    setState(() {
                      if (y == false) {
                        y = true;
                        x = false;
                        z = false;
                      } else if (y == true) {
                        y = false;
                      }
                    });
                    context.go("/Class/Detailsclass");
                  },
                  child: Container(
                    width: 156.w,
                    height: 44.h,
                    decoration: BoxDecoration(
                        color: y ? lightyellow : Colors.black,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: lightyellow, width: 1.w)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text('New Class',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: y ? Colors.black : lightyellow,
                              fontSize: 14.sp,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h,),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("My classes",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: (){
                            _displayBottomSheet(context);
                          },
                          child: Container(
                            height: 40.h,
                            width: 190.w,
                            decoration: BoxDecoration(
                              color: silverdark,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12, right: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 135.w,
                                    child: Text(selected,
                                      style: TextStyle(color: lightyellow, fontWeight: FontWeight.bold, fontSize: 14.sp),
                                    ),
                                  ),
                                  Icon(Icons.arrow_drop_down, color: Colors.white,)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h,),
            filterby != ""?ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: filteredfireclass.length,
                itemBuilder: (context, index) {
                  final cls = filteredfireclass[index];
                  return Card(
                    color: silverdark,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    margin: EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.w, top: 10.h, bottom: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                  width: 40.w,
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: cls.status.toLowerCase() == "pending"?Colors.grey:cls.status.toLowerCase()=="approved"?lightyellow:Colors.red,
                                  ),
                                  child: Icon(FontAwesomeIcons.dumbbell, size: 20,)
                              ),
                              SizedBox(width: 5.w,),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 150.w,
                                    child: Text(cls.classname,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 150.w,
                                    child: Text(cls.coach,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(width: 10.h,),
                          SizedBox(
                            width: 100.w,
                            child: Text('${cls.day}\n${cls.from} - ${cls.to}',
                              style: TextStyle(color: Colors.white, fontSize: 12.sp),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
            ):
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: classeslist.length,
                itemBuilder: (context, index) {
                  final cls = classeslist[index];
                  return Card(
                    color: silverdark,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    margin: EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.w, top: 10.h, bottom: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                  width: 40.w,
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: cls.status.toLowerCase() == "pending"?Colors.grey:cls.status.toLowerCase()=="approved"?lightyellow:Colors.red,
                                  ),
                                  child: Icon(FontAwesomeIcons.dumbbell, size: 20,)
                              ),
                              SizedBox(width: 5.w,),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 150.w,
                                    child: Text(cls.classname,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 150.w,
                                    child: Text(cls.coach,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 100.w,
                            child: Text('${cls.day}\n${cls.from} - ${cls.to}',
                              style: TextStyle(color: Colors.white, fontSize: 12.sp),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: MakeStream(context),
    );
  }
  Future _displayBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        barrierColor: silverdark.withOpacity(0.5),
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        builder: (context) => StatefulBuilder(
          builder: (context, setState) => Container(
            height: 480.h,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 10.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Book session by:',
                          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Icon(FontAwesomeIcons.xmark, color: Colors.white, size: 28,))
                      ],
                    ),
                    SizedBox(height: 30.h,),
                    InkWell(
                      onTap: (){
                        setState(() {
                          valueSelected = 0 as int;
                        });
                        _handleRadioValueChange(0);
                        this.setState(() {
                          filterby = "";
                          selected = "All Classes";
                        });
                      },
                      child: Container(
                        width: 320.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: silverdark,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('All classes', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.white),),
                              Transform.scale(
                                scale: 1,
                                child: Radio(
                                  activeColor: lightyellow,
                                  value: 0,
                                  groupValue: valueSelected,
                                  onChanged: (value) {

                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.w,),
                    InkWell(
                      onTap: (){
                        setState(() {
                          valueSelected = 1 as int;
                        });
                        _handleRadioValueChange(1);
                        this.setState(() {
                          filterby = "approved";
                          selected = "Approved Classes";
                        });
                      },
                      child: Container(
                        width: 320.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: silverdark,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Approved classes', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.white),),
                              Transform.scale(
                                scale: 1,
                                child: Radio(
                                  activeColor: lightyellow,
                                  value: 1,
                                  groupValue: valueSelected,
                                  onChanged: (value) {

                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.w,),
                    InkWell(
                      onTap: (){
                        setState(() {
                          valueSelected = 2 as int;
                        });
                        _handleRadioValueChange(2);
                        this.setState(() {
                          selected = "Pending Classes";
                          filterby = "pending";
                        });
                      },
                      child: Container(
                        width: 320.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: silverdark,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Pending classes', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.white),),
                              Transform.scale(
                                scale: 1,
                                child: Radio(
                                  activeColor: lightyellow,
                                  value: 2,
                                  groupValue: valueSelected,
                                  onChanged: (value) {

                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.w,),
                    InkWell(
                      onTap: (){
                        setState(() {
                          valueSelected = 3 as int;
                        });
                        _handleRadioValueChange(3);
                        this.setState(() {
                          selected = "Declined Classes";
                          filterby = "declined";
                        });
                      },
                      child: Container(
                        width: 320.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: silverdark,
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Declined classes', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.white),),
                              Transform.scale(
                                scale: 1,
                                child: Radio(
                                  activeColor: lightyellow,
                                  value: 3,
                                  groupValue: valueSelected,
                                  onChanged: (value) {

                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.w,),
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}