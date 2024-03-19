import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flockergym/Methods/colors_methods.dart';
import 'package:flockergym/NewBackend/Models/MemberModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class NewhomeScreen extends StatefulWidget {
  const NewhomeScreen({super.key});

  @override
  State<NewhomeScreen> createState() => _NewhomeScreenState();
}

late MemberModel memberModel;
DatabaseReference ref = FirebaseDatabase.instance.ref("members/${FirebaseAuth.instance.currentUser!.uid}/");

class _NewhomeScreenState extends State<NewhomeScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: darkgrey,
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
            return  Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: darkgrey,
                    image: DecorationImage(
                      image: AssetImage("assets/p3.png"),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text("You can subscribe to join our gym",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 20.h,),
                                  Text("Open from 8:00 AM To 12:00 AM",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                      color: lightyellow,
                                    ),
                                  ),
                                  SizedBox(height: 10.h,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Id: ', textAlign: TextAlign.start, style: TextStyle(color: lightyellow, fontSize: 16.sp, fontWeight: FontWeight.bold),),
                                      Text(memberModel.uniq!, textAlign: TextAlign.start, style: TextStyle(color: Colors.white, fontSize: 16.sp),)
                                    ],
                                  ),
                                  SizedBox(height: 20.h,),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          launchUrl(Uri.parse("https://maps.app.goo.gl/WgyxD983GraRPSPW7"));
                        },
                        child: Container(
                          width: 180.w,
                          height: 45.h,
                          decoration: BoxDecoration(
                            color: lightyellow,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Gym location',
                                style: TextStyle(color: darkgrey, fontSize: 16.sp,fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 5.w,),
                              Icon(Icons.location_on_outlined, color: darkgrey,)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }else{
            return Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: Lottie.asset('assets/gym.json'),
              ),
            );
          }
        }
      ),
    );
  }
}
