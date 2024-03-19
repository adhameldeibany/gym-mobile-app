import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flockergym/Methods/colors_methods.dart';
import 'package:flockergym/NewBackend/MainMethods.dart';
import 'package:flockergym/NewBackend/Models/ClassModel.dart';
import 'package:flockergym/NewBackend/Models/ProfileModel.dart';
import 'package:flockergym/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';

String data = FirebaseAuth.instance.currentUser!.uid.toString();

List<String> List11 = ["Choose Class"];
late List<ClassModel> classe;

String List1 = 'Choose Class';
late ProfileModel profileModel;
DatabaseReference ref = FirebaseDatabase.instance.ref("members/${FirebaseAuth.instance.currentUser!.uid}/");
DatabaseReference ref2 = FirebaseDatabase.instance.ref("classes/");

class CheckinScreen extends StatefulWidget {
  const CheckinScreen({super.key});

  @override
  State<CheckinScreen> createState() => _CheckinScreenState();
}

class _CheckinScreenState extends State<CheckinScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text("Check-in",
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
      body: StreamBuilder(
        stream: ref2.onValue,
        builder: (context, snapshot) {
          classe = [];
          ref.onValue.listen((DatabaseEvent event) {
            profileModel = new ProfileModel(
                id: event.snapshot.child('id').value.toString(),
                imgurl: event.snapshot.child('imgurl').value.toString(),
                name: event.snapshot.child('name').value.toString(),
                uniq: event.snapshot.child('uniq').value.toString(),
                invitations: event.snapshot.child('invitations').value.toString(),
            );

          });
          if (snapshot.hasData && snapshot.data != null && (snapshot.data! as DatabaseEvent).snapshot.value != null) {
            classe.clear();
            List11.clear();
            List11.add("Choose Class");
            final classes = Map<dynamic, dynamic>.from((snapshot.data! as DatabaseEvent).snapshot.value as Map<dynamic, dynamic>); //typecasting
            classes.forEach((key, value) {
              final classelement = Map<String, dynamic>.from(value);
              List11.add(classelement['name'].toString());
              classe.add(
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
            });
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: lightyellow, width: 8.w),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: QrImageView(
                          padding: EdgeInsets.all(25),
                          foregroundColor: Colors.white,
                          data: profileModel.uniq.toString(),
                          version: QrVersions.auto,
                          size: MediaQuery.of(context).size.width/1.15,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h,),
                  Text('Scan to enter Olympic Gym',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                  )
                  // SizedBox(height: 25.h,),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     InkWell(
                  //       onTap: () {
                  //         setState(() {
                  //           List1 = List11[0];
                  //           data = FirebaseAuth.instance.currentUser!.uid.toString();
                  //         });
                  //       },
                  //       child: Container(
                  //         width: 130.w,
                  //         height: 40.h,
                  //         decoration: BoxDecoration(
                  //           color: lightyellow,
                  //           borderRadius: BorderRadius.circular(30),
                  //         ),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: [
                  //             Text('GYM Check-In',
                  //               style: TextStyle(color: darkgrey, fontSize: 12.sp,fontWeight: FontWeight.bold),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(width: 35.w,),
                  //     SingleChildScrollView(
                  //       scrollDirection: Axis.horizontal,
                  //       child: Container(
                  //         height: 40.h,
                  //         width: 130.w,
                  //         decoration: BoxDecoration(
                  //           border: Border.all(color: Colors.grey, width: 1.w, ),
                  //           borderRadius: BorderRadius.circular(10),
                  //         ),
                  //         child: Padding(
                  //           padding: const EdgeInsets.only(left: 12, right: 12),
                  //           child: DropdownButton<String>(
                  //               underline: Container(color: Colors.white,),
                  //               isExpanded: true,
                  //               items: List11.map<DropdownMenuItem<String>>(
                  //                       (String value)
                  //                   {
                  //                     return DropdownMenuItem<String>(
                  //                       value: value,
                  //                       child: SingleChildScrollView(
                  //                           scrollDirection: Axis.horizontal,
                  //                           child: Center(
                  //                               child: Text(value,
                  //                                 style: TextStyle(color: lightyellow, fontSize: 15.sp),))),
                  //                     );
                  //                   }
                  //
                  //               ).toList(),
                  //               icon: Icon(Icons.arrow_drop_down),
                  //               value: List1,
                  //               onChanged:(alinanVeri) {
                  //                 if (alinanVeri! == "Choose Class") {
                  //                   data = FirebaseAuth.instance.currentUser!.uid.toString();
                  //                 }else{
                  //                   data = "${FirebaseAuth.instance.currentUser!.uid.toString()}>${classe[List11.indexOf(alinanVeri!)-1].id}";
                  //                 }
                  //                 setState(() {
                  //                   List1 = alinanVeri!;
                  //                 });
                  //               }
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            );
          }
          else{
            return LoadingScreen();
          }
        },
      ),
    );

    return Scaffold(
      backgroundColor: darkgrey,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Container(
                  width: 110.w,
                  height: 150.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/pic.png'),
                    ),
                  ),
                ),
                Text('Adham Eldeibany',
                  style: TextStyle(color: lightyellow, fontWeight: FontWeight.bold,fontSize: 18.sp),
                ),
              ],
            ),
            SizedBox(height: 40.h,),
            Center(
              child: QrImageView(
                data: data,
                backgroundColor: Colors.white,
                version: QrVersions.auto,
                size: MediaQuery.of(context).size.width/1.25,
              ),
            ),
            SizedBox(height: 40.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: 130.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: lightyellow,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('GYM Check-In',
                          style: TextStyle(color: darkgrey, fontSize: 12.sp,fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 35.w,),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    height: 40.h,
                    width: 130.w,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.w, ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: DropdownButton<String>(
                          underline: Container(color: Colors.white,),
                          isExpanded: true,
                          items: List11.map<DropdownMenuItem<String>>(
                                  (String value)
                              {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Center(
                                          child: Text(value,
                                            style: TextStyle(color: lightyellow, fontSize: 15.sp),))),
                                );
                              }

                          ).toList(),
                          icon: Icon(Icons.arrow_drop_down),
                          value: List1,
                          onChanged:(alinanVeri) {}
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
