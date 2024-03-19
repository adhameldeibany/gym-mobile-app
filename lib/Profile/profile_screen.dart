import 'dart:typed_data';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flockergym/Methods/BackendMethods/Backend.dart';
import 'package:flockergym/Methods/colors_methods.dart';
import 'package:flockergym/NewBackend/MainMethods.dart';
import 'package:flockergym/NewBackend/Models/FireClassModel.dart';
import 'package:flockergym/NewBackend/Models/MemberModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

late MemberModel memberModel;
FirebaseFirestore refr = FirebaseFirestore.instance;
DatabaseReference ref = FirebaseDatabase.instance.ref("members/${FirebaseAuth.instance.currentUser!.uid}/");
final classes = refr.collection("usersclasses")
    .doc(FirebaseAuth.instance.currentUser!.uid)
    .collection("classes").snapshots();

Uint8List? image;
bool edit = false;
TextEditingController controller = new TextEditingController();
FocusNode myFocusNode = new FocusNode();
class _ProfileScreenState extends State<ProfileScreen> {
  bool IsSwitched = false;
  bool GoSwitched = false;

  @override
  Widget build(BuildContext context) {

    myFocusNode.addListener(() {setState(() {

    });});

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: greylight,
          toolbarHeight: 48.h,
          elevation: 0,
          leading: BackButton(
            color: Colors.white,
          ),
          title: Text('Profile',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.sp,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              letterSpacing: -0.26,
            ),
          ),
        ),
        body: StreamBuilder(
            stream: ref.onValue,
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

                late DateTime parsedDate;
                late DateTime parseDate;
                try{
                  parsedDate = DateTime.parse(memberModel.endsAt!);
                }catch(e){
                  parsedDate = new DateTime(
                      int.parse(memberModel.endsAt!.replaceAll('-', '/').substring(0,4)),
                      int.parse(memberModel.endsAt!.replaceAll('-', '/').substring(5,7)),
                      int.parse(memberModel.endsAt!.replaceAll('-', '/').substring(8,10))
                  );
                }

                final currentTime = DateTime.now();

                String remain = "0";

                if (parsedDate.isAfter(currentTime)) {
                  remain = parsedDate.difference(currentTime).inDays.toString();
                }else{
                  remain = "Expired";
                }

                DateTime dateTime = new DateTime(
                    int.parse(memberModel.createdat!.replaceAll('-', '/').substring(0,4)),
                    int.parse(memberModel.createdat!.replaceAll('-', '/').substring(5,7)),
                    int.parse(memberModel.createdat!.replaceAll('-', '/').substring(8,10))
                );
                String rem = currentTime.difference(dateTime).inDays.toString();
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height*0.24,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: greylight,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          InkWell(
                                            onTap:() async {
                                              await BackendService().pickimage(ImageSource.gallery);
                                            },
                                            child: Container(
                                              width: 80.w,
                                              height: 80.h,
                                              decoration: image != null?
                                              BoxDecoration(
                                                  border: Border.all(color: lightyellow, width: 2.w),
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                    image: MemoryImage(image!),
                                                  )
                                              ):BoxDecoration(
                                                border: Border.all(color: lightyellow, width: 2.w),
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: NetworkImage(memberModel.imgurl!),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10.h,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 110.w,
                                                child: AutoSizeText(memberModel.name!,
                                                  maxLines: 2,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w700,
                                                    letterSpacing: -0.13,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10.h,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text('${(DateTime.now().difference(DateFormat('yyyy-MM-dd').parse(memberModel.age.toString())).inDays/365.25).toStringAsFixed(0)} Years',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: Color(0xFFCCC5BD),
                                                  fontSize: 12.sp,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w400,
                                                  letterSpacing: -0.13,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      TabBar(
                        indicatorColor: Colors.white,
                        dividerColor: Colors.black,
                        labelColor: Colors.white,
                        tabs: [
                          SizedBox(
                              width: 150.w,
                              child: Tab(text: 'Overview')),
                          SizedBox(
                              width: 150.w,
                              child: Tab(text: 'Sessions')),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.72,
                        child: TabBarView(
                            children: [
                              Column(
                                children: [
                                  SizedBox(height: 20.h,),
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 156.w,
                                            height: 94.h,
                                            decoration: BoxDecoration(
                                              color: greylight,
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding: EdgeInsets.all(16),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Image(image: AssetImage('assets/weight.png')),
                                                        SizedBox(width: 5.w,),
                                                        Text('Weight', style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14.sp,
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w500,
                                                          height: 0.12,
                                                          letterSpacing: -0.13,
                                                        ),)
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        Text('${memberModel.weight} kg', style: TextStyle(
                                                          color: Color(0xFFF8BE00),
                                                          fontSize: 14.sp,
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w500,
                                                          height: 0,
                                                          letterSpacing: -0.18,
                                                        ),)
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 15.w,),
                                          Container(
                                            width: 156.w,
                                            height: 94.h,
                                            decoration: BoxDecoration(
                                              color: greylight,
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding: EdgeInsets.all(16),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Image(image: AssetImage('assets/height.png')),
                                                        SizedBox(width: 5.w,),
                                                        Text('Height', style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14.sp,
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w500,
                                                          height: 0.12,
                                                          letterSpacing: -0.13,
                                                        ),)
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        Text('${memberModel.height} cm', style: TextStyle(
                                                          color: Color(0xFFF8BE00),
                                                          fontSize: 14.sp,
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w500,
                                                          height: 0,
                                                          letterSpacing: -0.18,
                                                        ),)
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 24.h,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 156.w,
                                            height: 94.h,
                                            decoration: BoxDecoration(
                                              color: greylight,
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding: EdgeInsets.all(16),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Image(image: AssetImage('assets/weekly.png')),
                                                        SizedBox(width: 5.w,),
                                                        Text('Weekly goal', style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12.sp,
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w500,
                                                          height: 0.12,
                                                          letterSpacing: -0.13,
                                                        ),)
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        Text(memberModel.active.toString().split('Workout')[0]+'days', style: TextStyle(
                                                          color: Color(0xFFF8BE00),
                                                          fontSize: 14.sp,
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w500,
                                                          height: 0,
                                                          letterSpacing: -0.18,
                                                        ),)
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 15.w,),
                                          Container(
                                            width: 156.w,
                                            height: 94.h,
                                            decoration: BoxDecoration(
                                              color: greylight,
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding: EdgeInsets.all(16),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Image(image: AssetImage('assets/motivation.png')),
                                                        SizedBox(width: 5.w,),
                                                        Text('Motivation', style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12.sp,
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w500,
                                                          height: 0.12,
                                                          letterSpacing: -0.13,
                                                        ),)
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        Text(memberModel.motivate.toString(), style: TextStyle(
                                                          color: Color(0xFFF8BE00),
                                                          fontSize: 12.sp,
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w500,
                                                          height: 0,
                                                          letterSpacing: -0.18,
                                                        ),)
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 24.h,),
                                  Container(
                                    width: 328.w,
                                    height: 94.h,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF191919),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              Image(image: AssetImage('assets/goal.png')),
                                              SizedBox(height: 10.h,),
                                              Text('Goal',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12.sp,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w600,
                                                  height: 0.12,
                                                  letterSpacing: -0.13,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Text(memberModel.goal.toString(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Color(0xFFF8BE00),
                                                  fontSize: 14.sp,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w600,
                                                  height: 0.09,
                                                  letterSpacing: -0.18,
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
                              StreamBuilder(
                                stream: classes,
                                builder: (context, snapshot1) {
                                  if (snapshot1.hasData && snapshot1.data != null ) {
                                    List<FireClassModel> fires = [];
                                    if (snapshot1.data?.docs.length == 0) {
                                      return Column(
                                        children: [
                                          SizedBox(height: 20.h,),
                                          Expanded(
                                            child: ListView.builder(
                                                itemCount: fires.length,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                                                    child: Container(
                                                      width: 328.w,
                                                      height: 128.h,
                                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                                      decoration: BoxDecoration(
                                                        color: Color(0xFF232627),
                                                        borderRadius: BorderRadius.circular(16),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text('Boxing',
                                                                style: TextStyle(
                                                                  color: Colors.white,
                                                                  fontSize: 20.sp,
                                                                  fontFamily: 'Inter',
                                                                  fontWeight: FontWeight.w600,
                                                                  height: 0,
                                                                ),
                                                              ),
                                                              SizedBox(height: 10.h,),
                                                              Row(
                                                                children: [
                                                                  Column(
                                                                    mainAxisSize: MainAxisSize.min,
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Text('Started',
                                                                        textAlign: TextAlign.center,
                                                                        style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                                                                      ),
                                                                      Text('11 Oct 2023',
                                                                        textAlign: TextAlign.center,
                                                                        style: TextStyle(color: Colors.white, fontSize: 12.sp),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(width: 20.w,),
                                                                  Column(
                                                                    mainAxisSize: MainAxisSize.min,
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Text('Last session',
                                                                        textAlign: TextAlign.center,
                                                                        style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                                                                      ),
                                                                      Text('16 Oct 2023',
                                                                        textAlign: TextAlign.center,
                                                                        style: TextStyle(color: Colors.white, fontSize: 12.sp),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                            children: [
                                                              CircularPercentIndicator(
                                                                center: Text("8/12",
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
                                                                lineWidth: 8,
                                                                percent: 0.8,
                                                                progressColor: lightyellow,
                                                                backgroundColor: Colors.grey,
                                                                circularStrokeCap: CircularStrokeCap.round,
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                }
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                    else{
                                      final items = snapshot1.data!.docs;
                                      for(var item in items){
                                        FireClassModel certificatesModel = new FireClassModel(
                                            started: item["started"],
                                            finished: item["finished"],
                                            classname: item["classname"],
                                            total: item["total"],
                                            status: item["status"],
                                            remain: item["remain"],
                                            coachname: item["coachname"],
                                            name: item["name"],
                                            id: item["id"]
                                        );
                                        fires.add(certificatesModel);
                                      }
                                      return Column(
                                        children: [
                                          SizedBox(height: 20.h,),
                                          Expanded(
                                            child: ListView.builder(
                                                itemCount: fires.length,
                                                itemBuilder: (context, index) {
                                                  final fire = fires[index];
                                                  return Padding(
                                                    padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                                                    child: Container(
                                                      width: 328.w,
                                                      height: 128.h,
                                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                                      decoration: BoxDecoration(
                                                        color: Color(0xFF232627),
                                                        borderRadius: BorderRadius.circular(16),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(fire.classname,
                                                                style: TextStyle(
                                                                  color: Colors.white,
                                                                  fontSize: 20.sp,
                                                                  fontFamily: 'Inter',
                                                                  fontWeight: FontWeight.w600,
                                                                  height: 0,
                                                                ),
                                                              ),
                                                              SizedBox(height: 10.h,),
                                                              Row(
                                                                children: [
                                                                  Column(
                                                                    mainAxisSize: MainAxisSize.min,
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Text('Started',
                                                                        textAlign: TextAlign.center,
                                                                        style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                                                                      ),
                                                                      Text(fire.started,
                                                                        textAlign: TextAlign.center,
                                                                        style: TextStyle(color: Colors.white, fontSize: 12.sp),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(width: 20.w,),
                                                                  Column(
                                                                    mainAxisSize: MainAxisSize.min,
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Text('Last session',
                                                                        textAlign: TextAlign.center,
                                                                        style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                                                                      ),
                                                                      Text(fire.finished,
                                                                        textAlign: TextAlign.center,
                                                                        style: TextStyle(color: Colors.white, fontSize: 12.sp),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                            children: [
                                                              CircularPercentIndicator(
                                                                center: Text("${fire.remain}/${fire.total}",
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
                                                                lineWidth: 8,
                                                                percent: double.parse(fire.remain)/double.parse(fire.total),
                                                                progressColor: lightyellow,
                                                                backgroundColor: Colors.grey,
                                                                circularStrokeCap: CircularStrokeCap.round,
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                }
                                            ),
                                          ),
                                        ],
                                      );

                                    }
                                  } else {
                                    return LoadingScreen();
                                  }

                                },
                              ),
                            ]
                        ),
                      ),
                    ],
                  ),
                );
              }
              else{
                return LoadingScreen();
              }
            }
        ),
      ),
    );
  }
}
