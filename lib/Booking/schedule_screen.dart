import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flockergym/Booking/Coach/coach_screen.dart';
import 'package:flockergym/Methods/colors_methods.dart';
import 'package:flockergym/Methods/colors_methods.dart';
import 'package:flockergym/NewBackend/MainMethods.dart';
import 'package:flockergym/NewBackend/Models/ClassModel.dart';
import 'package:flockergym/NewBackend/Models/ClassesDaysModel.dart';
import 'package:flockergym/NewBackend/Models/StaffModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

List<String> List55 = ['Date', 'Coach'];
String List5 = 'Date';

late List<String> List66;
late String List6;
late List<ClassesDaysModel> clss;
List<ClassModel> Classes = [];
List<ClassModel> filterClasses = [];
late List<String> Days;
late List<String> from;
late List<String> to;
bool x1 = true;
bool x2 = false;
bool x3 = false;
bool x4 = false;
bool x5 = false;
bool x6 = false;
bool x7 = false;
bool asd = false;
String Sec = "Date";

class ScheduleScreen extends StatefulWidget {
  ScheduleScreen({required List<ClassesDaysModel> classes}){
    clss = classes;
    List<ClassesDaysModel> temp = classes;
    final ids = temp.map((e) => e.classname).toSet();
    temp.retainWhere((x) => ids.remove(x.classname));
    List66 = [];
    for(var cls in temp){
      List66.add(cls.classname);
    }
    List6 = List66[0];
  }

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {

  int selectedValue = 0;
  int valueSelected = 0;
  List<String> days = ['Sat',"Sun","Mon","Tue","Wed","Thu","Fri"];
  List<String> dayslong = ['Saturday',"Sunday","Monday","Tuesday","Wednesday","Thursday","Friday"];
  String Selectedday = 'Saturday';
  late List<StaffModel> staffe;

  void _handleRadioValueChange(int value) {
    setState(() {
      selectedValue = value;
    });
  }

  void _handleRadioValueChange2(int value) {
    setState(() {
      valueSelected = value;
    });
  }

  Scaffold MakeStream(BuildContext context){
    DatabaseReference ref = FirebaseDatabase.instance.ref("classes/");
    return Scaffold(
      backgroundColor: Colors.black,
      body: StreamBuilder(
        stream: ref.onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null && (snapshot.data! as DatabaseEvent).snapshot.value != null) {
            final classes = Map<dynamic, dynamic>.from((snapshot.data! as DatabaseEvent).snapshot.value as Map<dynamic, dynamic>); //typecasting
            Classes.clear();
            Days = [];
            classes.forEach((key, value) {
              final classelement = Map<String, dynamic>.from(value);
              if (classelement["name"].toString().toLowerCase() == List6.toString().toLowerCase()) {
                Classes.add(
                    ClassModel(
                      id: classelement['id'],
                      name: classelement['name'],
                      startsat: classelement['startsat'],
                      timesaweek: classelement['timesaweek'],
                      coachid: classelement['coachid'],
                      coachname: classelement['coachname'],
                      daysandtimeandlength: classelement['daysandtimeandlength'],
                      imgurl: classelement['imgurl'],
                    )
                );
                Days = [];
                List<String>daysonly = [];
                from = [];
                to = [];
                int i = 0;
                if(classelement['daysandtimeandlength'].split("|")[1].length == 0){
                  daysonly.add(classelement['daysandtimeandlength'].daysandtimeandlength.split("|")[0]);
                }else{
                  daysonly.addAll(classelement['daysandtimeandlength'].split("|"));
                }
                for(int j = i;j<daysonly.length;j++){
                  if (daysonly[i].split("-")[0].toLowerCase() == Selectedday.toLowerCase()) {
                    Days.add(daysonly[i].split("-")[0]);
                    from.add(daysonly[i].split("-")[1].substring(0,7));
                    to.add(daysonly[i].split("-")[1].substring(14,21));
                  }
                  i ++;
                }
              }
            });
            return Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                backgroundColor: Colors.black,
                elevation: 0,
                title: Text("Book a session",
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
                                  Text(List6,
                                    style: TextStyle(color: lightyellow, fontWeight: FontWeight.bold, fontSize: 16.sp),
                                  ),
                                  Icon(Icons.arrow_drop_down, color: Colors.white,)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Card(
                      color: greylight,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Column(
                                      children: [
                                        Text('Started',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                                        ),
                                        Text(clss[clss.indexWhere((element) => element.classname == List6)].started,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.white, fontSize: 14.sp),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20.w,),
                                    Column(
                                      children: [
                                        Text('Last session',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                                        ),
                                        Text(clss[clss.indexWhere((element) => element.classname == List6)].finished,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.white, fontSize: 14.sp),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    CircularPercentIndicator(
                                      center: Text("${clss[clss.indexWhere((element) => element.classname == List6)].remain}/${clss[clss.indexWhere((element) => element.classname == List6)].total}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600,
                                          height: 0,
                                          letterSpacing: -0.18,
                                        ),
                                      ),
                                      animation: true,
                                      animationDuration: 3000,
                                      radius: 40.w,
                                      lineWidth: 10,
                                      percent: double.parse(clss[clss.indexWhere((element) => element.classname == List6)].remain)/double.parse(clss[clss.indexWhere((element) => element.classname == List6)].total),
                                      progressColor: lightyellow,
                                      backgroundColor: Colors.grey,
                                      circularStrokeCap: CircularStrokeCap.round,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h,),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Book session by:",
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
                                    width: 120.w,
                                    decoration: BoxDecoration(
                                      color: silverdark,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 12, right: 12),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(Sec,
                                            style: TextStyle(color: lightyellow, fontWeight: FontWeight.bold, fontSize: 16.sp),
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
                    SizedBox(
                      height: 90.h,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: days.length,
                            itemBuilder: (context, index) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: (){
                                      setState(() {
                                        if (index ==0) {
                                          x1 = true;
                                          x2 = false;
                                          x3 = false;
                                          x4 = false;
                                          x5 = false;
                                          x6 = false;
                                          x7 = false;
                                          Selectedday = dayslong[index];
                                        }else if (index ==1) {
                                          x2 = true;
                                          x1 = false;
                                          x3 = false;
                                          x4 = false;
                                          x5 = false;
                                          x6 = false;
                                          x7 = false;
                                          Selectedday = dayslong[index];
                                        }else if (index ==2) {
                                          x3 = true;
                                          x2 = false;
                                          x1 = false;
                                          x4 = false;
                                          x5 = false;
                                          x6 = false;
                                          x7 = false;
                                          Selectedday = dayslong[index];
                                        }else if (index ==3) {
                                          x4 = true;
                                          x2 = false;
                                          x3 = false;
                                          x1 = false;
                                          x5 = false;
                                          x6 = false;
                                          x7 = false;
                                          Selectedday = dayslong[index];
                                        }else if (index ==4) {
                                          x5 = true;
                                          x2 = false;
                                          x3 = false;
                                          x4 = false;
                                          x1 = false;
                                          x6 = false;
                                          x7 = false;
                                          Selectedday = dayslong[index];
                                        }else if (index ==5) {
                                          x1 = false;
                                          x2 = false;
                                          x3 = false;
                                          x4 = false;
                                          x5 = false;
                                          x6 = true;
                                          x7 = false;
                                          Selectedday = dayslong[index];
                                        }else if (index ==6) {
                                          x1 = false;
                                          x2 = false;
                                          x3 = false;
                                          x4 = false;
                                          x5 = false;
                                          x6 = false;
                                          x7 = true;
                                          Selectedday = dayslong[index];
                                        }
                                      });
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 45.w,
                                          height: 55.h,
                                          decoration: BoxDecoration(
                                              color: index==0?x1 ? Colors.white : Colors.black
                                                  :index==1?x2 ? Colors.white : Colors.black
                                                  :index==2?x3 ? Colors.white : Colors.black
                                                  :index==3?x4 ? Colors.white : Colors.black
                                                  :index==4?x5 ? Colors.white : Colors.black
                                                  :index==5?x6 ? Colors.white : Colors.black
                                                  :x7 ? Colors.white : Colors.black,
                                              borderRadius: BorderRadius.circular(20),
                                              border: Border.all(color: Colors.white)
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(days[index], style: TextStyle(
                                                color: index==0?x1 ? Colors.black : Colors.white
                                                    :index==1?x2 ? Colors.black : Colors.white
                                                    :index==2?x3 ? Colors.black : Colors.white
                                                    :index==3?x4 ? Colors.black : Colors.white
                                                    :index==4?x5 ? Colors.black : Colors.white
                                                    :index==5?x6 ? Colors.black : Colors.white
                                                    :x7 ? Colors.black : Colors.white,
                                              ),),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 15.w,),
                                ],
                              );
                            }
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisExtent: 150.h,
                          ),
                          itemCount: Days.length,
                          itemBuilder: (_,index){
                            return Column(
                              children: [
                                InkWell(
                                  onTap: (){
                                    context.goNamed("Coach",pathParameters: {'day':Days[index],'from':from[index],'to':to[index],'daylong':Selectedday,'classname':Classes[0].coachname,'clas':Classes[0].name},extra: clss);
                                  },
                                  child: Container(
                                    width: 98.67.w,
                                    height: 141.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: Color(0xFF2B2F30),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            children: [
                                              Text('From', style: TextStyle(
                                                color: Color(0xFFCCC5BD),
                                                fontSize: 12.sp,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w300,
                                                height: 0,
                                                letterSpacing: -0.13,
                                              ),),
                                              Text(from[index], style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14.sp,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w500,
                                                height: 0,
                                                letterSpacing: -0.15,
                                              ),),
                                            ],
                                          ),
                                          SizedBox(height: 24.h,),
                                          Column(
                                            children: [
                                              Text('To', style: TextStyle(
                                                color: Color(0xFFCCC5BD),
                                                fontSize: 12.sp,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w300,
                                                height: 0,
                                                letterSpacing: -0.13,
                                              ),),
                                              Text(to[index], style: TextStyle(
                                                color: Colors.white,
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
  Scaffold MakeStream2(BuildContext context){
    DatabaseReference ref = FirebaseDatabase.instance.ref("classes/");
    DatabaseReference ref2 = FirebaseDatabase.instance.ref("staff/");

    return Scaffold(
      backgroundColor: Colors.black,
      body: StreamBuilder(
        stream: ref.onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null && (snapshot.data! as DatabaseEvent).snapshot.value != null) {
            final classes = Map<dynamic, dynamic>.from((snapshot.data! as DatabaseEvent).snapshot.value as Map<dynamic, dynamic>); //typecasting
            Classes.clear();
            Days = [];
            classes.forEach((key, value) {
              final classelement = Map<String, dynamic>.from(value);
              if (classelement["name"].toString().toLowerCase() == List6.toString().toLowerCase()) {
                Classes.add(
                    ClassModel(
                      id: classelement['id'],
                      name: classelement['name'],
                      startsat: classelement['startsat'],
                      timesaweek: classelement['timesaweek'],
                      coachid: classelement['coachid'],
                      coachname: classelement['coachname'],
                      daysandtimeandlength: classelement['daysandtimeandlength'],
                      imgurl: classelement['imgurl'],
                    )
                );
                Days = [];
                List<String>daysonly = [];
                from = [];
                to = [];
                int i = 0;
                if(classelement['daysandtimeandlength'].split("|")[1].length == 0){
                  daysonly.add(classelement['daysandtimeandlength'].daysandtimeandlength.split("|")[0]);
                }else{
                  daysonly.addAll(classelement['daysandtimeandlength'].split("|"));
                }
                for(int j = i;j<daysonly.length;j++){
                  if (daysonly[i].split("-")[0].toLowerCase() == Selectedday.toLowerCase()) {
                    Days.add(daysonly[i].split("-")[0]);
                    from.add(daysonly[i].split("-")[1].substring(0,7));
                    to.add(daysonly[i].split("-")[1].substring(14,21));
                  }
                  i ++;
                }
              }
            });
            return Scaffold(
              body: StreamBuilder(
                stream: ref2.onValue,
                builder: (context, snapshot1) {
                  if (snapshot1.hasData && snapshot1.data != null && (snapshot1.data! as DatabaseEvent).snapshot.value != null) {
                    staffe = [];
                    final classes2 = Map<dynamic, dynamic>.from((snapshot1.data! as DatabaseEvent).snapshot.value as Map<dynamic, dynamic>); //typecasting
                    classes2.forEach((key, value) {
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
                          });
                      return Scaffold(
                        backgroundColor: Colors.black,
                        appBar: AppBar(
                          backgroundColor: Colors.black,
                          elevation: 0,
                          title: Text("Book a session",
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
                                            Text(List6,
                                              style: TextStyle(color: lightyellow, fontWeight: FontWeight.bold, fontSize: 16.sp),
                                            ),
                                            Icon(Icons.arrow_drop_down, color: Colors.white,)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Card(
                                color: greylight,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              Column(
                                                children: [
                                                  Text('Started',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                                                  ),
                                                  Text(clss[clss.indexWhere((element) => element.classname == List6)].started,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(color: Colors.white, fontSize: 14.sp),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 20.w,),
                                              Column(
                                                children: [
                                                  Text('Last session',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                                                  ),
                                                  Text(clss[clss.indexWhere((element) => element.classname == List6)].finished,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(color: Colors.white, fontSize: 14.sp),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              CircularPercentIndicator(
                                                center: Text("${clss[clss.indexWhere((element) => element.classname == List6)].remain}/${clss[clss.indexWhere((element) => element.classname == List6)].total}",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14.sp,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w600,
                                                    height: 0,
                                                    letterSpacing: -0.18,
                                                  ),
                                                ),
                                                animation: true,
                                                animationDuration: 3000,
                                                radius: 40.w,
                                                lineWidth: 10,
                                                percent: double.parse(clss[clss.indexWhere((element) => element.classname == List6)].remain)/double.parse(clss[clss.indexWhere((element) => element.classname == List6)].total),
                                                progressColor: lightyellow,
                                                backgroundColor: Colors.grey,
                                                circularStrokeCap: CircularStrokeCap.round,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.h,),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Book session by:",
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
                                              width: 120.w,
                                              decoration: BoxDecoration(
                                                color: silverdark,
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 12, right: 12),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(Sec,
                                                      style: TextStyle(color: lightyellow, fontWeight: FontWeight.bold, fontSize: 16.sp),
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
          }else{
            return LoadingScreen();
          }
        },
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return asd?MakeStream2(context):MakeStream(context);
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
                          asd = false;
                          Sec = "Date";
                        });
                        _handleRadioValueChange2(0);
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
                              Text('Date', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.white),),
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
                          asd = true;
                          Sec = "Coach";
                        });
                        _handleRadioValueChange2(1);
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
                              Text('Coach', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.white),),
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
                    SizedBox(height: 30.w,),
                    InkWell(
                      onTap: (){
                        if (valueSelected == 1) {
                          Navigator.pop(context);
                        }
                        else{
                          Navigator.pop(context);
                        }
                      },
                      child: Container(
                        height: 50.h,
                        width: 320.w,
                        decoration: BoxDecoration(
                          color: lightyellow,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12, right: 12),
                          child: Center(
                            child: Text('Confirm',
                              style: TextStyle(color: darkgrey, fontWeight: FontWeight.bold, fontSize: 16.sp),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.w,),
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
  Future _bottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        barrierColor: silverdark.withOpacity(0.5),
        backgroundColor: Colors.black,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        builder: (context) => StatefulBuilder(
          builder: (context, setState) => SingleChildScrollView(
            child: Container(
              height: 480.h,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    SizedBox(height: 10.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Choose your Class',
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
                    SizedBox(
                      height: 250.h,
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: List66.length,
                        itemBuilder: (context, index) {
                          return
                            index==0? Column(
                              children: [
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      selectedValue = 0 as int;
                                    });
                                    this.setState(() {
                                      List6 = List66[index];
                                    });
                                    _handleRadioValueChange(0);
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
                                          Text(List66[index], style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.white),),
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
                                SizedBox(height: 20.w,),
                              ],
                            ):index==List66.length-1?
                            Column(
                              children: [
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      selectedValue = 3 as int;
                                    });
                                    this.setState(() {
                                      List6 = List66[index];
                                    });
                                    _handleRadioValueChange(3);
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
                                          Text(List66[index], style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.white),),
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
                                SizedBox(height: 20.w,),
                              ],
                            ):
                            Column(
                              children: [
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      selectedValue = 2 as int;
                                    });
                                    this.setState(() {
                                      List6 = List66[index];
                                    });
                                    _handleRadioValueChange(2);
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
                                          Text(List66[index], style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.white),),
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
                                SizedBox(height: 30.w,),
                              ],
                            );
                        },
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 50.h,
                        width: 320.w,
                        decoration: BoxDecoration(
                          color: lightyellow,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12, right: 12),
                          child: Center(
                            child: Text('Confirm',
                              style: TextStyle(color: darkgrey, fontWeight: FontWeight.bold, fontSize: 16.sp),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.w,),
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}
