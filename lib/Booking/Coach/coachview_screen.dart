import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flockergym/Methods/AuthMethods/AuthMethods.dart';
import 'package:flockergym/Methods/colors_methods.dart';
import 'package:flockergym/NewBackend/MainMethods.dart';
import 'package:flockergym/NewBackend/Models/ClassModel.dart';
import 'package:flockergym/NewBackend/Models/ClassesDaysModel.dart';
import 'package:flockergym/NewBackend/Models/StaffModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

bool x = false;
bool y = false;
bool z = false;
late String coach;
late StaffModel current;
late String classe;
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

class CoachviewScreen extends StatefulWidget {
  CoachviewScreen({required String coachname, required String clas}){
    coach = coachname;
    classe = clas;
  }

  @override
  State<CoachviewScreen> createState() => _CoachviewScreenState();
}

class _CoachviewScreenState extends State<CoachviewScreen> {
  List<String> days = ['Sat',"Sun","Mon","Tue","Wed","Thu","Fri"];
  List<String> dayslong = ['Saturday',"Sunday","Monday","Tuesday","Wednesday","Thursday","Friday"];
  String Selectedday = 'Saturday';

  int valueSelected = 0;

  void _handleRadioValueChange(int value) {
    setState(() {
      valueSelected = value;
    });
  }

  Scaffold MakeStream(BuildContext context){
    DatabaseReference ref2 = FirebaseDatabase.instance.ref("staff/");
    DatabaseReference ref = FirebaseDatabase.instance.ref("classes/");
    return Scaffold(
      body: StreamBuilder(
        stream: ref2.onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null && (snapshot.data! as DatabaseEvent).snapshot.value != null) {
            final classes = Map<dynamic, dynamic>.from((snapshot.data! as DatabaseEvent).snapshot.value as Map<dynamic, dynamic>); //typecasting
            classes.forEach((key, value) {
              final classelement = Map<String, dynamic>.from(value);
              if (classelement['name'].toString().toLowerCase() == coach.toLowerCase()) {
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
              body: StreamBuilder(
                stream: ref.onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null && (snapshot.data! as DatabaseEvent).snapshot.value != null) {
                    final classes = Map<dynamic, dynamic>.from((snapshot.data! as DatabaseEvent).snapshot.value as Map<dynamic, dynamic>); //typecasting
                    Classes.clear();
                    Days = [];
                    classes.forEach((key, value) {
                      final classelement = Map<String, dynamic>.from(value);
                      if (classelement["name"].toString().toLowerCase() == classe.toLowerCase()) {
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
                        backgroundColor: Color(0xff2B2F30),
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
                            Container(
                              height: MediaQuery.of(context).size.height*0.40,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Color(0xff2B2F30),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                              width: 100.w,
                                              height: 130.h,
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: lightyellow, width: 2.w),
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                    image: NetworkImage(current.imgurl),
                                                  )
                                              )
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(current.name,
                                                textAlign: TextAlign.start,
                                                style: TextStyle(color: lightyellow, fontWeight: FontWeight.bold,fontSize: 15.sp),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 5.h,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(current.role,
                                                textAlign: TextAlign.start,
                                                style: TextStyle(color: Colors.white, fontSize: 15.sp),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10.h,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                  width: 20.w,
                                                  height: 20.h,
                                                  child: Image(image: AssetImage('assets/p19.PNG'),)
                                              ),
                                              SizedBox(width: 5.w,),
                                              SizedBox(
                                                  width: 20.w,
                                                  height: 20.h,
                                                  child: Image(image: AssetImage('assets/p19.PNG'),)
                                              ),
                                              SizedBox(width: 5.w,),
                                              SizedBox(
                                                  width: 20.w,
                                                  height: 20.h,
                                                  child: Image(image: AssetImage('assets/p19.PNG'),)
                                              ),
                                              SizedBox(width: 5.w,),
                                              SizedBox(
                                                  width: 20.w,
                                                  height: 20.h,
                                                  child: Image(image: AssetImage('assets/p19.PNG'),)
                                              ),
                                              SizedBox(width: 5.w,),
                                              SizedBox(
                                                  width: 20.w,
                                                  height: 20.h,
                                                  child: Image(image: AssetImage('assets/p20.PNG'),)
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10.h,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text('+25 Trainee', style: TextStyle(color: Colors.white),),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 20.h,),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Row(
                                children: [
                                  Text("Choose date",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.h,),
                            SizedBox(
                              height: 80.h,
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
                              padding: const EdgeInsets.only(left: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Choose session",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.h,),
                            Padding(
                              padding: const EdgeInsets.only(left: 12, right: 12),
                              child: GridView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisExtent: 155.h,
                                  ),
                                  itemCount: Days.length,
                                  itemBuilder: (_,index){
                                    return Column(
                                      children: [
                                        InkWell(
                                          onTap: (){
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return Theme(
                                                    data: Theme.of(context).copyWith(dialogBackgroundColor: Color(0xFF232627),),
                                                    child: AlertDialog(
                                                      content: Container(
                                                        height: 450.h,
                                                        width: 328.w,
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Image(image: AssetImage('assets/dialog.png')),
                                                              ],
                                                            ),
                                                            SizedBox(height: 10.h,),
                                                            Row(
                                                              children: [
                                                                Text('Confirm request',
                                                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20.sp),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(height: 30.h,),
                                                            Row(
                                                              children: [
                                                                SizedBox(
                                                                  width: 220.w,
                                                                  child: Text('Confirm request to schedule a ${classe} session \nwith ${coach} \nat $Selectedday - From ${from[index]} To ${to[index]}',
                                                                    style: TextStyle(fontSize: 12.sp, color: Colors.white, fontWeight: FontWeight.bold),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(height: 20.h,),
                                                            Row(
                                                              children: [
                                                                SizedBox(
                                                                  width: 220.w,
                                                                  child: Text('By confirming this request we will send you the last updates, Please keep checking the updates.',
                                                                    style: TextStyle(fontSize: 12.sp, color: Colors.white),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(height: 30.h,),
                                                            InkWell(
                                                              child: Container(
                                                                width: 292.w,
                                                                height: 32.h,
                                                                decoration: BoxDecoration(
                                                                  color: lightyellow,
                                                                  border: Border.all(color: lightyellow),
                                                                  borderRadius: BorderRadius.circular(4),
                                                                ),
                                                                child: Center(child: Text('Confirm scheduling',
                                                                  style: TextStyle(
                                                                    color: Color(0xFF0A0A0A),
                                                                    fontSize: 14.sp,
                                                                    fontFamily: 'Inter',
                                                                    fontWeight: FontWeight.w400,
                                                                    height: 0,
                                                                    letterSpacing: -0.15,
                                                                  ),
                                                                )),
                                                              ),
                                                              onTap: () async {
                                                                FirebaseFirestore db = FirebaseFirestore.instance;
                                                                if(await AuthService().checkIfDocExists(Classes[0].id,
                                                                    FirebaseAuth.instance.currentUser!.uid.toString())){
                                                                  final docRef = db.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid.toString())
                                                                      .collection("classes").doc(Classes[0].id);
                                                                  docRef.get().then(
                                                                        (DocumentSnapshot doc) async {
                                                                      final userclasses = {
                                                                        "uid": FirebaseAuth.instance.currentUser!.uid.toString(),
                                                                      };
                                                                      final data = doc.data() as Map<String, dynamic>;
                                                                      int r = int.parse(data["remain"].toString());
                                                                      int t = int.parse(data["total"].toString());
                                                                      final classes = {
                                                                        "id": Classes[0].id,
                                                                        "name": "newsession",
                                                                        "coachname": Classes[0].coachname,
                                                                        "remain": (r + 1).toString(),
                                                                        "total" : (t + 1).toString(),
                                                                        "status":"pending",
                                                                        "classname":Classes[0].name,
                                                                        "started":DateFormat('dd-MM-yyyy').format(DateTime.now()),
                                                                        "finished": DateFormat('dd-MM-yyyy').format(DateTime.now().add(Duration(days: 30)))
                                                                      };

                                                                      await db.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid.toString())
                                                                          .set(userclasses).onError((error, stackTrace) => print("Error"));

                                                                      await db.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid.toString())
                                                                          .collection("classes").doc(Classes[0].id).set(classes).onError((error, stackTrace) => print("Error"));

                                                                      final day = {
                                                                        "id":"n"+Classes[0].id+"day"+(index).toString(),
                                                                        "day":Days[index],
                                                                        "from":from[index],
                                                                        "to":to[index],
                                                                        "classid":Classes[0].id
                                                                      };
                                                                      await db.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid.toString())
                                                                          .collection("days").doc("n"+Classes[0].id+"day"+(index).toString()).set(day)
                                                                          .onError((error, stackTrace) => print("Error"));


                                                                      final snackBar = SnackBar(
                                                                        duration: Duration(milliseconds: 1500,),
                                                                        elevation: 0,
                                                                        behavior: SnackBarBehavior.floating,
                                                                        backgroundColor: Colors.transparent,
                                                                        content: AwesomeSnackbarContent(
                                                                          title: 'Success',
                                                                          message: 'Session Booked Waiting For Approve',
                                                                          contentType: ContentType.success,
                                                                        ),
                                                                      );
                                                                      ScaffoldMessenger.of(context)
                                                                        ..hideCurrentSnackBar()
                                                                        ..showSnackBar(snackBar);
                                                                      Navigator.pop(context);
                                                                    },
                                                                    onError: (e) => print("Error getting document: $e"),
                                                                  );
                                                                }
                                                                else{
                                                                  final userclasses = {
                                                                    "uid": FirebaseAuth.instance.currentUser!.uid.toString(),
                                                                  };
                                                                  final classes = {
                                                                    "id": Classes[0].id,
                                                                    "name": "new session",
                                                                    "coachname": Classes[0].coachname,
                                                                    "remain": "1",
                                                                    "total" : "1",
                                                                    "status":"pending",
                                                                    "classname":Classes[0].name,
                                                                    "started":DateFormat('dd-MM-yyyy').format(DateTime.now()),
                                                                    "finished": DateFormat('dd-MM-yyyy').format(DateTime.now().add(Duration(days: 30)))
                                                                  };
                                                                  await db.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid.toString())
                                                                      .set(userclasses).onError((error, stackTrace) => print("Error"));

                                                                  await db.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid.toString())
                                                                      .collection("classes").doc(Classes[0].id).set(classes).onError((error, stackTrace) => print("Error"));

                                                                  final day = {
                                                                    "id":"n"+Classes[0].id+"day"+(index).toString(),
                                                                    "day":Days[index],
                                                                    "from":from[index],
                                                                    "to":to[index],
                                                                    "classid":Classes[0].id
                                                                  };
                                                                  await db.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid.toString())
                                                                      .collection("days").doc("n"+Classes[0].id+"day"+(index).toString()).set(day)
                                                                      .onError((error, stackTrace) => print("Error"));


                                                                  final snackBar = SnackBar(
                                                                    duration: Duration(milliseconds: 1500,),
                                                                    elevation: 0,
                                                                    behavior: SnackBarBehavior.floating,
                                                                    backgroundColor: Colors.transparent,
                                                                    content: AwesomeSnackbarContent(
                                                                      title: 'Success',
                                                                      message: 'Session Booked Waiting For Approve',
                                                                      contentType: ContentType.success,
                                                                    ),
                                                                  );
                                                                  ScaffoldMessenger.of(context)
                                                                    ..hideCurrentSnackBar()
                                                                    ..showSnackBar(snackBar);
                                                                  Navigator.pop(context);
                                                                }
                                                              },
                                                            ),
                                                            SizedBox(height: 15.h,),
                                                            InkWell(
                                                              child: Container(
                                                                height: 32.h,
                                                                width: 292.w,
                                                                decoration: BoxDecoration(
                                                                  border: Border.all(color: lightyellow),
                                                                  borderRadius: BorderRadius.circular(4),
                                                                ),
                                                                child: Center(child: Text('Re-scheduling',
                                                                  style: TextStyle(
                                                                    color: Color(0xFFF8BE00),
                                                                    fontSize: 14.sp,
                                                                    fontFamily: 'Inter',
                                                                    fontWeight: FontWeight.w400,
                                                                    height: 0,
                                                                    letterSpacing: -0.15,
                                                                  ),
                                                                )),
                                                              ),
                                                              onTap: () {
                                                                Navigator.pop(context);
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }
                                            );
                                          },
                                          child: Container(
                                            width: 98.67.w,
                                            height: 141.h,
                                            decoration: BoxDecoration(
                                                color: Color(0xFF2B2F30),
                                                borderRadius: BorderRadius.circular(4)
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

          }else{
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
                    Row(
                      children: [
                        Text('Gender:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.sp),),
                      ],
                    ),
                    SizedBox(height: 10.w,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: (){
                            setState(() {
                              valueSelected = 0 as int;
                            });
                            _handleRadioValueChange(0);
                          },
                          child: Container(
                            width: 150.w,
                            height: 50.h,
                            decoration: BoxDecoration(
                              color: silverdark,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('All', style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.white),),
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
                        InkWell(
                          onTap: (){
                            setState(() {
                              valueSelected = 1 as int;
                            });
                            _handleRadioValueChange(1);
                          },
                          child: Container(
                            width: 150.w,
                            height: 50.h,
                            decoration: BoxDecoration(
                              color: silverdark,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Male', style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.white),),
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
                      ],
                    ),
                    SizedBox(height: 20.w,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: (){
                            setState(() {
                              valueSelected = 2 as int;
                            });
                            _handleRadioValueChange(2);
                          },
                          child: Container(
                            width: 150.w,
                            height: 50.h,
                            decoration: BoxDecoration(
                              color: silverdark,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Female', style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.white),),
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
                        InkWell(
                          onTap: (){
                            setState(() {
                              valueSelected = 3 as int;
                            });
                            _handleRadioValueChange(3);
                          },
                          child: Container(
                            width: 150.w,
                            height: 50.h,
                            decoration: BoxDecoration(
                              color: silverdark,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Mixed', style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.white),),
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
                      ],
                    ),
                    SizedBox(height: 20.w,),
                    Row(
                      children: [
                        Text('Maturity:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.sp),),
                      ],
                    ),
                    SizedBox(height: 10.w,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: (){
                            setState(() {
                              valueSelected = 4 as int;
                            });
                            _handleRadioValueChange(4);
                          },
                          child: Container(
                            width: 150.w,
                            height: 50.h,
                            decoration: BoxDecoration(
                              color: silverdark,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('All', style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.white),),
                                  Transform.scale(
                                    scale: 1,
                                    child: Radio(
                                      activeColor: lightyellow,
                                      value: 4,
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
                        InkWell(
                          onTap: (){
                            setState(() {
                              valueSelected = 5 as int;
                            });
                            _handleRadioValueChange(5);
                          },
                          child: Container(
                            width: 150.w,
                            height: 50.h,
                            decoration: BoxDecoration(
                              color: silverdark,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Adults', style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.white),),
                                  Transform.scale(
                                    scale: 1,
                                    child: Radio(
                                      activeColor: lightyellow,
                                      value: 5,
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
                      ],
                    ),
                    SizedBox(height: 20.w,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: (){
                            setState(() {
                              valueSelected = 6 as int;
                            });
                            _handleRadioValueChange(6);
                          },
                          child: Container(
                            width: 150.w,
                            height: 50.h,
                            decoration: BoxDecoration(
                              color: silverdark,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Kids', style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.white),),
                                  Transform.scale(
                                    scale: 1,
                                    child: Radio(
                                      activeColor: lightyellow,
                                      value: 6,
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
                        InkWell(
                          onTap: (){
                            setState(() {
                              valueSelected = 7 as int;
                            });
                            _handleRadioValueChange(7);
                          },
                          child: Container(
                            width: 150.w,
                            height: 50.h,
                            decoration: BoxDecoration(
                              color: silverdark,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Mixed', style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.white),),
                                  Transform.scale(
                                    scale: 1,
                                    child: Radio(
                                      activeColor: lightyellow,
                                      value: 7,
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
                      ],
                    ),
                    SizedBox(height: 20.w,),
                    Row(
                      children: [
                        Text('Age:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.sp),),
                      ],
                    ),
                    SizedBox(height: 10.w,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: (){
                            setState(() {
                              valueSelected = 8 as int;
                            });
                            _handleRadioValueChange(8);
                          },
                          child: Container(
                            width: 150.w,
                            height: 50.h,
                            decoration: BoxDecoration(
                              color: silverdark,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('All', style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.white),),
                                  Transform.scale(
                                    scale: 1,
                                    child: Radio(
                                      activeColor: lightyellow,
                                      value: 8,
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
                        InkWell(
                          onTap: (){
                            setState(() {
                              valueSelected = 9 as int;
                            });
                            _handleRadioValueChange(9);
                          },
                          child: Container(
                            width: 150.w,
                            height: 50.h,
                            decoration: BoxDecoration(
                              color: silverdark,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Beginner', style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.white),),
                                  Transform.scale(
                                    scale: 1,
                                    child: Radio(
                                      activeColor: lightyellow,
                                      value: 9,
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
                      ],
                    ),
                    SizedBox(height: 20.w,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: (){
                            setState(() {
                              valueSelected = 10 as int;
                            });
                            _handleRadioValueChange(10);
                          },
                          child: Container(
                            width: 150.w,
                            height: 50.h,
                            decoration: BoxDecoration(
                              color: silverdark,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Intermediate', style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.white),),
                                  Transform.scale(
                                    scale: 1,
                                    child: Radio(
                                      activeColor: lightyellow,
                                      value: 10,
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
                        InkWell(
                          onTap: (){
                            setState(() {
                              valueSelected = 11 as int;
                            });
                            _handleRadioValueChange(11);
                          },
                          child: Container(
                            width: 150.w,
                            height: 50.h,
                            decoration: BoxDecoration(
                              color: silverdark,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Advanced', style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.white),),
                                  Transform.scale(
                                    scale: 1,
                                    child: Radio(
                                      activeColor: lightyellow,
                                      value: 11,
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
                      ],
                    ),
                    SizedBox(height: 20.w,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: (){},
                          child: Center(
                            child: Text('Reset all',
                              style: TextStyle(
                                color: Color(0xFFF8BE00),
                                fontSize: 14.sp,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 0,
                                letterSpacing: -0.15,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 30.w,),
                        InkWell(
                          onTap: (){},
                          child: Container(
                            width: 220.w,
                            height: 44.h,
                            decoration: BoxDecoration(
                              color: lightyellow,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12, right: 12),
                              child: Center(
                                child: Text('Apply',
                                  style: TextStyle(
                                    color: Color(0xFF0A0A0A),
                                    fontSize: 14.sp,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    height: 0,
                                    letterSpacing: -0.15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
