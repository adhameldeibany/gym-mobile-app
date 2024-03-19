import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flockergym/Methods/colors_methods.dart';
import 'package:flockergym/NewBackend/MainMethods.dart';
import 'package:flockergym/NewBackend/Models/MemberModel.dart';
import 'package:flockergym/NewBackend/Models/SubscriptionModel.dart';
import 'package:flockergym/NewBackend/SigninBack/SigninMethods.dart';
import 'package:flockergym/Responsive%20UI/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

late StatefulNavigationShell navigationshell;

class SubscriptionScreen extends StatefulWidget {
  SubscriptionScreen({required StatefulNavigationShell navi}){
    navigationshell = navi;
  }

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

late MemberModel memberModel;

DatabaseReference ref = FirebaseDatabase.instance.ref("members/${FirebaseAuth.instance.currentUser!.uid}/");
DatabaseReference ref2 = FirebaseDatabase.instance.ref("subscriptions/${FirebaseAuth.instance.currentUser!.uid}/");
late List<SubscriptionModel> subscriptions;

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  @override
  Widget build(BuildContext context) {

    return RefreshIndicator(
        child: Scaffold(
          backgroundColor: darkgrey,
          body: StreamBuilder(
            stream: ref.onValue,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null &&
                  (snapshot.data! as DatabaseEvent).snapshot.value != null) {
                memberModel = MemberModel(
                  age: snapshot.data!.snapshot.child('age').value.toString(),
                  createdat: snapshot.data!.snapshot.child('createdat').value.toString(),
                  email: snapshot.data!.snapshot.child('email').value.toString(),
                  endsAt: snapshot.data!.snapshot.child('endsAt').value.toString(),
                  gender: snapshot.data!.snapshot.child('gender').value.toString(),
                  height: snapshot.data!.snapshot.child('height').value.toString(),
                  id: snapshot.data!.snapshot.child('id').value.toString(),
                  imgurl: snapshot.data!.snapshot.child('imgurl').value.toString(),
                  memberstatus: snapshot.data!.snapshot.child('memberstatus').value.toString(),
                  mobile: snapshot.data!.snapshot.child('mobile').value.toString(),
                  name: snapshot.data!.snapshot.child('name').value.toString(),
                  password: snapshot.data!.snapshot.child('password').value.toString(),
                  weight: snapshot.data!.snapshot.child('weight').value.toString(),
                  uniq: snapshot.data!.snapshot.child('uniq').value.toString(),
                  active: snapshot.data!.snapshot.child('active').value.toString(),
                  goal: snapshot.data!.snapshot.child('goal').value.toString(),
                  motivate: snapshot.data!.snapshot.child('motivate').value.toString(),
                );
                return Scaffold(
                    backgroundColor: darkgrey,
                    body: StreamBuilder(
                        stream: ref2.onValue,
                        builder: (context, snapshot1) {
                          if (snapshot1.hasData && snapshot1.data != null &&
                              (snapshot1.data! as DatabaseEvent).snapshot.value != null) {
                            final classes = Map<dynamic, dynamic>.from((snapshot1.data! as DatabaseEvent).snapshot.value as Map<dynamic, dynamic>); //typecasting
                            subscriptions = [];
                            classes.forEach((key, value) {
                              final classelement = Map<String, dynamic>.from(value);
                              subscriptions.add(SubscriptionModel(
                                  id: classelement["id"].toString(),
                                  uid: classelement["uid"].toString(),
                                  classname: classelement["classname"].toString(),
                                  classid: classelement["classid"].toString(),
                                  numofsessions: classelement["numofsessions"].toString())
                              );
                            });

                            late DateTime parsedDate;
                            try{
                              parsedDate = DateTime.parse(memberModel.endsAt!);
                            }catch(e){
                              parsedDate = new DateTime(
                                int.parse(memberModel.endsAt!.replaceAll('-', '/').substring(0,4)),
                                int.parse(memberModel.endsAt!.replaceAll('-', '/').substring(5,7)),
                                int.parse(memberModel.endsAt!.replaceAll('-', '/').substring(8,10)),
                              );
                            }
                            final currentTime = DateTime.now();

                            String remain = "0";

                            if (parsedDate.isAfter(currentTime)) {
                              remain = parsedDate.difference(currentTime).inDays.toString();
                            }else{
                              remain = "Expired";
                            }
                            return Scaffold(
                              backgroundColor: Colors.black,
                              appBar: AppBar(
                                backgroundColor: Colors.black,
                                toolbarHeight: 45.h,
                                elevation: 0,
                                title: Text("Subscription",
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
                                child: Column(
                                  children: [
                                    Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: MediaQuery.of(context).size.height*0.38,
                                        child: Image(image: AssetImage('assets/login.png'))),
                                    SizedBox(height: 40.h,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 328.w,
                                          height: 120.h,
                                          decoration: BoxDecoration(
                                              color: Color(0xFF323232),
                                              borderRadius: BorderRadius.circular(16)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(24),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Started',
                                                  style: TextStyle(
                                                    color: Color(0xFFC8C8C8),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    height: 0,
                                                    letterSpacing: 0.16,
                                                  ),
                                                ),
                                                SizedBox(height: 5.h,),
                                                Text(
                                                  memberModel.createdat!.replaceAll('/', ':').substring(0,10),
                                                  style: TextStyle(
                                                    color: lightyellow, fontWeight: FontWeight.bold,
                                                    fontSize: 17.sp,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 16.w,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 156.w,
                                          height: 120.h,
                                          decoration: BoxDecoration(
                                              color: Color(0xFF323232),
                                              borderRadius: BorderRadius.circular(16)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  memberModel.memberstatus! == '1 Month'?'1':
                                                  memberModel.memberstatus! == '3 Months'?'3':
                                                  memberModel.memberstatus! == '6 Months'?'6':
                                                  memberModel.memberstatus! == '9 Months'?'9':'12',
                                                  style: TextStyle(
                                                    color: Color(0xFFF8BE00),
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.w600,
                                                    height: 0,
                                                    letterSpacing: 0.24,
                                                  ),
                                                ),
                                                SizedBox(height: 4.h,),
                                                Text(
                                                  'Months',
                                                  style: TextStyle(
                                                    color: Color(0xFFC8C8C8),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    height: 0,
                                                    letterSpacing: 0.16,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 16.w,),
                                        Container(
                                          width: 156.w,
                                          height: 120.h,
                                          decoration: BoxDecoration(
                                              color: Color(0xFF323232),
                                              borderRadius: BorderRadius.circular(16)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  remain,
                                                  style: TextStyle(
                                                    color: Color(0xFFF8BE00),
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.w600,
                                                    height: 0,
                                                    letterSpacing: 0.24,
                                                  ),
                                                ),
                                                SizedBox(height: 4.h,),
                                                Text(
                                                  'Days Left',
                                                  style: TextStyle(
                                                    color: Color(0xFFC8C8C8),
                                                    fontSize: 16,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w400,
                                                    height: 0,
                                                    letterSpacing: 0.16,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                          else if(!snapshot1.hasData && snapshot1.data == null){
                            late DateTime parsedDate;
                            try{
                              parsedDate = DateTime.parse(memberModel.endsAt!);
                            }catch(e){
                              parsedDate = new DateTime(
                                int.parse(memberModel.endsAt!.replaceAll('-', '/').substring(0,4)),
                                int.parse(memberModel.endsAt!.replaceAll('-', '/').substring(5,7)),
                                int.parse(memberModel.endsAt!.replaceAll('-', '/').substring(8,10)),
                              );
                            }
                            final currentTime = DateTime.now();

                            String remain = "0";

                            if (parsedDate.isAfter(currentTime)) {
                              remain = parsedDate.difference(currentTime).inDays.toString();
                            }else{
                              remain = "Expired";
                            }
                            return Scaffold(
                              backgroundColor: Colors.black,
                              appBar: AppBar(
                                backgroundColor: Colors.black,
                                toolbarHeight: 45.h,
                                elevation: 0,
                                title: Text("Subscription",
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
                                child: Column(
                                  children: [
                                    Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: MediaQuery.of(context).size.height*0.38,
                                        child: Image(image: AssetImage('assets/login.png'))),
                                    SizedBox(height: 40.h,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 328.w,
                                          height: 120.h,
                                          decoration: BoxDecoration(
                                              color: Color(0xFF323232),
                                              borderRadius: BorderRadius.circular(16)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(24),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Started',
                                                  style: TextStyle(
                                                    color: Color(0xFFC8C8C8),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    height: 0,
                                                    letterSpacing: 0.16,
                                                  ),
                                                ),
                                                SizedBox(height: 5.h,),
                                                Text(
                                                  memberModel.createdat!.replaceAll('/', ':').substring(0,10),
                                                  style: TextStyle(
                                                    color: lightyellow, fontWeight: FontWeight.bold,
                                                    fontSize: 17.sp,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 16.w,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 156.w,
                                          height: 120.h,
                                          decoration: BoxDecoration(
                                              color: Color(0xFF323232),
                                              borderRadius: BorderRadius.circular(16)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  memberModel.memberstatus! == '1 Month'?'1':
                                                  memberModel.memberstatus! == '3 Months'?'3':
                                                  memberModel.memberstatus! == '6 Months'?'6':
                                                  memberModel.memberstatus! == '9 Months'?'9':'12',
                                                  style: TextStyle(
                                                    color: Color(0xFFF8BE00),
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.w600,
                                                    height: 0,
                                                    letterSpacing: 0.24,
                                                  ),
                                                ),
                                                SizedBox(height: 4.h,),
                                                Text(
                                                  'Months',
                                                  style: TextStyle(
                                                    color: Color(0xFFC8C8C8),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    height: 0,
                                                    letterSpacing: 0.16,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 16.w,),
                                        Container(
                                          width: 156.w,
                                          height: 120.h,
                                          decoration: BoxDecoration(
                                              color: Color(0xFF323232),
                                              borderRadius: BorderRadius.circular(16)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  remain,
                                                  style: TextStyle(
                                                    color: Color(0xFFF8BE00),
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.w600,
                                                    height: 0,
                                                    letterSpacing: 0.24,
                                                  ),
                                                ),
                                                SizedBox(height: 4.h,),
                                                Text(
                                                  'Days Left',
                                                  style: TextStyle(
                                                    color: Color(0xFFC8C8C8),
                                                    fontSize: 16,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w400,
                                                    height: 0,
                                                    letterSpacing: 0.16,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                          else
                            return FutureBuilder(
                              future: SigninMethods().isExists(ref2),
                              builder: (context, snapshot0) {
                                if (snapshot0.hasData && snapshot0.data != null) {
                                  print(snapshot0.data.toString());
                                  if (bool.parse(snapshot0.data.toString())) {

                                  }else{
                                    subscriptions = [];
                                    late DateTime parsedDate;
                                    try{
                                      parsedDate = DateTime.parse(memberModel.endsAt!);
                                    }catch(e){
                                      parsedDate = new DateTime(
                                        int.parse(memberModel.endsAt!.replaceAll('-', '/').substring(0,4)),
                                        int.parse(memberModel.endsAt!.replaceAll('-', '/').substring(5,7)),
                                        int.parse(memberModel.endsAt!.replaceAll('-', '/').substring(8,10)),
                                      );
                                    }
                                    final currentTime = DateTime.now();

                                    String remain = "0";

                                    if (parsedDate.isAfter(currentTime)) {
                                      remain = parsedDate.difference(currentTime).inDays.toString();
                                    }else{
                                      remain = "Expired";
                                    }
                                    return Scaffold(
                                      backgroundColor: Colors.black,
                                      appBar: AppBar(
                                        backgroundColor: Colors.black,
                                        toolbarHeight: 45.h,
                                        elevation: 0,
                                        title: Text("Subscription",
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
                                        child: Column(
                                          children: [
                                            Container(
                                                width: Width(context, 360),
                                                height: Height(context, 303),
                                                child: Image(image: AssetImage('assets/login.png'),
                                                  fit: BoxFit.cover,
                                                )),
                                            SizedBox(height: 40.h,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 328.w,
                                                  height: 120.h,
                                                  decoration: BoxDecoration(
                                                      color: Color(0xFF323232),
                                                      borderRadius: BorderRadius.circular(16)
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(24),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(
                                                          width: Width(context, 200),
                                                          child: AutoSizeText(
                                                            maxLines: 1,
                                                            'Started',
                                                            style: TextStyle(
                                                              color: Color(0xFFC8C8C8),
                                                              fontSize: 16.sp,
                                                              fontWeight: FontWeight.w400,
                                                              height: 0,
                                                              letterSpacing: 0.16,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(height: 5.h,),
                                                        SizedBox(
                                                          width: Width(context, 200),
                                                          child: AutoSizeText(
                                                            maxLines: 1,
                                                            memberModel.createdat!.replaceAll('/', ':').substring(0,10),
                                                            style: TextStyle(
                                                              color: lightyellow, fontWeight: FontWeight.bold,
                                                              fontSize: 16.sp,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 16.w,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 156.w,
                                                  height: 120.h,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFF323232),
                                                    borderRadius: BorderRadius.circular(16)
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(
                                                          width: Width(context, 150),
                                                          child: AutoSizeText(
                                                            maxLines: 1,
                                                            memberModel.memberstatus! == '1 Month'?'1':
                                                            memberModel.memberstatus! == '3 Months'?'3':
                                                            memberModel.memberstatus! == '6 Months'?'6':
                                                            memberModel.memberstatus! == '9 Months'?'9':'12',
                                                            style: TextStyle(
                                                              color: Color(0xFFF8BE00),
                                                              fontSize: 20.sp,
                                                              fontWeight: FontWeight.w600,
                                                              height: 0,
                                                              letterSpacing: 0.24,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(height: 4.h,),
                                                        SizedBox(
                                                          width: Width(context, 150),
                                                          height: Height(context, 14.sp),
                                                          child: AutoSizeText(
                                                            maxLines: 1,
                                                            'Months',
                                                            style: TextStyle(
                                                              color: Color(0xFFC8C8C8),
                                                              fontSize: 14.sp,
                                                              fontWeight: FontWeight.w400,
                                                              height: 0,
                                                              letterSpacing: 0.16,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 16.w,),
                                                Container(
                                                  width: Width(context, 156),
                                                  height: Height(context, 120),
                                                  decoration: BoxDecoration(
                                                      color: Color(0xFF323232),
                                                      borderRadius: BorderRadius.circular(16)
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        AutoSizeText(
                                                          maxLines: 1,
                                                          remain,
                                                          style: TextStyle(
                                                            color: Color(0xFFF8BE00),
                                                            fontSize: 20.sp,
                                                            fontWeight: FontWeight.w600,
                                                            height: 0,
                                                            letterSpacing: 0.24,
                                                          ),
                                                        ),
                                                        SizedBox(height: 4.h,),
                                                        SizedBox(
                                                          width: Width(context, 150),
                                                          height: Height(context, 14.sp),
                                                          child: AutoSizeText(
                                                            maxLines: 1,
                                                            'Days Left',
                                                            style: TextStyle(
                                                              color: Color(0xFFC8C8C8),
                                                              fontSize: 14.sp,
                                                              fontWeight: FontWeight.w400,
                                                              height: 0,
                                                              letterSpacing: 0.16,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                                  return LoadingScreen();
                                }
                                else {
                                  return LoadingScreen();

                                }
                              }
                            );
                          }
                    )
                );
              }else{
                return LoadingScreen();
              }
            },
          ),
        ),
        onRefresh: ()async{
          setState(() {
            print(FirebaseAuth.instance.currentUser!.uid);
            State<SubscriptionScreen> createState() => _SubscriptionScreenState();
          });
        }
    );

    return RefreshIndicator(
        onRefresh: ()async{
          setState(() {
            print(FirebaseAuth.instance.currentUser!.uid);
            State<SubscriptionScreen> createState() => _SubscriptionScreenState();
          });
        },
      child: Scaffold(
        backgroundColor: darkgrey,
        body: StreamBuilder(
          stream: ref2.onValue,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null &&
                (snapshot.data! as DatabaseEvent).snapshot.value != null) {
              final classes = Map<dynamic, dynamic>.from((snapshot.data! as DatabaseEvent).snapshot.value as Map<dynamic, dynamic>); //typecasting
                subscriptions = [];
              classes.forEach((key, value) {
                final classelement = Map<String, dynamic>.from(value);
                subscriptions.add(SubscriptionModel(
                    id: classelement["id"].toString(),
                    uid: classelement["uid"].toString(),
                    classname: classelement["classname"].toString(),
                    classid: classelement["classid"].toString(),
                    numofsessions: classelement["numofsessions"].toString())
                );
              });

              late DateTime parsedDate;
              try{
                parsedDate = DateTime.parse(memberModel.endsAt!);
              }catch(e){
                parsedDate = new DateTime(
                    int.parse(memberModel.endsAt!.replaceAll('-', '/').substring(0,4)),
                    int.parse(memberModel.endsAt!.replaceAll('-', '/').substring(5,7)),
                    int.parse(memberModel.endsAt!.replaceAll('-', '/').substring(8,10)),
                );
              }
              final currentTime = DateTime.now();

              String remain = "0";

              if (parsedDate.isAfter(currentTime)) {
                remain = parsedDate.difference(currentTime).inDays.toString();
              }else{
                remain = "Expired";
              }
              return Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: darkgrey,
                          image: DecorationImage(
                            image: AssetImage('assets/p3.png'),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 40.h,),
                              Column(
                                children: [
                                  Container(
                                    width: 90.w,
                                    height: 130.h,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: NetworkImage(memberModel.imgurl!),
                                      ),
                                    ),
                                  ),
                                  Text(memberModel.name!,
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 16.sp),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10, right: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          SizedBox(height: 30.h,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                    memberModel.createdat!.replaceAll('/', ':').substring(0,10),
                                                    style: TextStyle(
                                                      color: lightyellow, fontWeight: FontWeight.bold,
                                                      fontSize: 17.sp,
                                                    ),
                                                  ),
                                                  SizedBox(height: 5.h,),
                                                  Text(
                                                    'Started',
                                                    style: TextStyle(
                                                        fontSize: 16.sp,
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(width: 20.w,),
                                              Column(
                                                children: [
                                                  Text(
                                                    memberModel.memberstatus! == '1 Month'?'1':
                                                    memberModel.memberstatus! == '3 Months'?'3':
                                                    memberModel.memberstatus! == '6 Months'?'6':
                                                    memberModel.memberstatus! == '9 Months'?'9':'12',
                                                    style: TextStyle(
                                                      color: lightyellow, fontWeight: FontWeight.bold,
                                                      fontSize: 18.sp,
                                                    ),
                                                  ),
                                                  SizedBox(height: 5.h,),
                                                  Text(
                                                    'Months',
                                                    style: TextStyle(
                                                      fontSize: 16.sp,
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(width: 20.w,),
                                              Column(
                                                children: [
                                                  Text(
                                                    remain,
                                                    style: TextStyle(
                                                      color: lightyellow,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18.sp,
                                                    ),
                                                  ),
                                                  SizedBox(height: 5.h,),
                                                  Text(
                                                    'Days Left',
                                                    style: TextStyle(
                                                      fontSize: 16.sp,
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  )
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
                              SizedBox(height: 30.h,),
                              Text('Remaining Sessions',
                                style: TextStyle(color: lightyellow, fontSize: 18.sp, fontWeight: FontWeight.bold),
                              ),
                              GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 0,
                                    mainAxisSpacing: 12,
                                    mainAxisExtent: 120.h
                                  ),
                                  itemCount: subscriptions.length,
                                  itemBuilder: (_,index){
                                    final subscription = subscriptions[index];
                                    return Card(
                                      color: lightyellow,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      elevation: 7,
                                      margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 10.h),
                                      child: Center(
                                        child: SingleChildScrollView(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsets.only(left: 10.w, right: 10.w),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text(subscription.classname!,
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(color: darkgrey, fontSize: 18.sp, fontWeight: FontWeight.bold),
                                                      ),
                                                      SizedBox(height: 5.h,),
                                                      Text(subscription.numofsessions!+' Sessions',
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(color: darkgrey, fontSize: 15.sp),
                                                      ),
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
                                  ),
                              SizedBox(height: 100.h,),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            else if(!snapshot.hasData && snapshot.data == null){
              ref.onValue.listen((DatabaseEvent event) {
                memberModel = MemberModel(
                  age: event.snapshot.child('age').value.toString(),
                  createdat: event.snapshot.child('createdat').value.toString(),
                  email: event.snapshot.child('email').value.toString(),
                  endsAt: event.snapshot.child('endsAt').value.toString(),
                  gender: event.snapshot.child('gender').value.toString(),
                  height: event.snapshot.child('height').value.toString(),
                  id: event.snapshot.child('id').value.toString(),
                  imgurl: event.snapshot.child('imgurl').value.toString(),
                  memberstatus: event.snapshot.child('memberstatus').value.toString(),
                  mobile: event.snapshot.child('mobile').value.toString(),
                  name: event.snapshot.child('name').value.toString(),
                  password: event.snapshot.child('password').value.toString(),
                  weight: event.snapshot.child('weight').value.toString(),
                  uniq: event.snapshot.child('uniq').value.toString(),
                  active: event.snapshot.child('active').value.toString(),
                  goal: event.snapshot.child('goal').value.toString(),
                  motivate: event.snapshot.child('motivate').value.toString(),
                );
                setState(() {
                  subscriptions =[];
                });
              });
              late DateTime parsedDate;
              try{
                parsedDate = DateTime.parse(memberModel.endsAt!);
              }catch(e){
                  parsedDate = new DateTime(
                    int.parse(memberModel.endsAt!.replaceAll('-', '/').substring(0,4)),
                    int.parse(memberModel.endsAt!.replaceAll('-', '/').substring(5,7)),
                    int.parse(memberModel.endsAt!.replaceAll('-', '/').substring(8,10)),
                  );
              }
              final currentTime = DateTime.now();

              String remain = "0";

              if (parsedDate.isAfter(currentTime)) {
                remain = parsedDate.difference(currentTime).inDays.toString();
              }else{
                remain = "Expired";
              }
              return Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: darkgrey,
                          image: DecorationImage(
                            image: AssetImage('assets/p3.png'),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(height: 150.h,),
                              Column(
                                children: [
                                  Container(
                                    width: 90.w,
                                    height: 130.h,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: NetworkImage(memberModel.imgurl!),
                                      ),
                                    ),
                                  ),
                                  Text(memberModel.name!,
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 16.sp),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10, right: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          SizedBox(height: 30.h,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                    memberModel.createdat!.replaceAll('/', ':').substring(0,10),
                                                    style: TextStyle(
                                                      color: lightyellow, fontWeight: FontWeight.bold,
                                                      fontSize: 17.sp,
                                                    ),
                                                  ),
                                                  SizedBox(height: 5.h,),
                                                  Text(
                                                    'Started',
                                                    style: TextStyle(
                                                        fontSize: 16.sp,
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(width: 20.w,),
                                              Column(
                                                children: [
                                                  Text(
                                                    memberModel.memberstatus! == '1 Month'?'1':
                                                    memberModel.memberstatus! == '3 Months'?'3':
                                                    memberModel.memberstatus! == '6 Months'?'6':
                                                    memberModel.memberstatus! == '9 Months'?'9':'12',
                                                    style: TextStyle(
                                                      color: lightyellow, fontWeight: FontWeight.bold,
                                                      fontSize: 18.sp,
                                                    ),
                                                  ),
                                                  SizedBox(height: 5.h,),
                                                  Text(
                                                    'Months',
                                                    style: TextStyle(
                                                      fontSize: 16.sp,
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(width: 20.w,),
                                              Column(
                                                children: [
                                                  Text(
                                                    remain,
                                                    style: TextStyle(
                                                      color: lightyellow,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18.sp,
                                                    ),
                                                  ),
                                                  SizedBox(height: 5.h,),
                                                  Text(
                                                    'Days Left',
                                                    style: TextStyle(
                                                      fontSize: 16.sp,
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  )
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
                              // SizedBox(height: 30.h,),
                              // Text('Remaining Sessions',
                              //   style: TextStyle(color: lightyellow, fontSize: 18.sp, fontWeight: FontWeight.bold),
                              // ),
                              // GridView.builder(
                              //     shrinkWrap: true,
                              //     physics: const NeverScrollableScrollPhysics(),
                              //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              //         crossAxisCount: 2,
                              //         crossAxisSpacing: 0,
                              //         mainAxisSpacing: 12,
                              //         mainAxisExtent: 120.h
                              //     ),
                              //     itemCount: subscriptions.length,
                              //     itemBuilder: (_,index){
                              //       final subscription = subscriptions[index];
                              //       return Card(
                              //         color: lightyellow,
                              //         shape: RoundedRectangleBorder(
                              //           borderRadius: BorderRadius.circular(10),
                              //         ),
                              //         elevation: 7,
                              //         margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 10.h),
                              //         child: Center(
                              //           child: SingleChildScrollView(
                              //             child: Row(
                              //               mainAxisAlignment: MainAxisAlignment.center,
                              //               children: [
                              //                 Expanded(
                              //                   child: Padding(
                              //                     padding: EdgeInsets.only(left: 10.w, right: 10.w),
                              //                     child: Column(
                              //                       mainAxisAlignment: MainAxisAlignment.center,
                              //                       children: [
                              //                         Text(subscription.classname!,
                              //                           textAlign: TextAlign.center,
                              //                           style: TextStyle(color: darkgrey, fontSize: 18.sp, fontWeight: FontWeight.bold),
                              //                         ),
                              //                         SizedBox(height: 5.h,),
                              //                         Text(subscription.numofsessions!+' Sessions',
                              //                           textAlign: TextAlign.center,
                              //                           style: TextStyle(color: darkgrey, fontSize: 15.sp),
                              //                         ),
                              //                       ],
                              //                     ),
                              //                   ),
                              //                 ),
                              //               ],
                              //             ),
                              //           ),
                              //         ),
                              //       );
                              //     }
                              // ),
                              // SizedBox(height: 100.h,),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            else {
              return Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                  child: Lottie.asset('assets/gym.json'),
                ),
              );
            }

          }
        )
      ),
    );
  }
}
