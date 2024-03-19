import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flockergym/Data%20collection%20screens/active_screen.dart';
import 'package:flockergym/Data%20collection%20screens/Future%20data/form_screen.dart';
import 'package:flockergym/Data%20collection%20screens/notes_screen.dart';
import 'package:flockergym/Data%20collection%20screens/pushup_screen.dart';
import 'package:flockergym/Methods/colors_methods.dart';
import 'package:flockergym/NewBackend/DataCollectionBack/DataCollectionMethods.dart';
import 'package:flockergym/NewBackend/MainMethods.dart';
import 'package:flockergym/NewBackend/Models/StaffModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

List<String> List55 = ['Private'];
String List5 = 'Private';
DatabaseReference ref2 = FirebaseDatabase.instance.ref("staff/");
String data = "";

class SubtypeScreen extends StatefulWidget {
  const SubtypeScreen({super.key});

  @override
  State<SubtypeScreen> createState() => _SubtypeScreenState();
}
int age = 20;
double weight = 60.0;

TextEditingController controller = TextEditingController();
late List<StaffModel> staffe;
bool x = false;

class _SubtypeScreenState extends State<SubtypeScreen> {

  @override
  void initState() {
    controller.text = age.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool y = false;
    bool z = false;

    return WillPopScope(
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.black,
            leading: BackButton(
              color: Colors.white,
              onPressed: (){
                Get.off(PushupScreen());
              },
            ),
          ),
          body: StreamBuilder(
          stream: ref2.onValue,
          builder: (context, snapshot) {
            staffe = [];
            if (snapshot.hasData && snapshot.data != null && (snapshot.data! as DatabaseEvent).snapshot.value != null) {
              staffe.clear();
              List55.clear();
              List55.add("Private");

              final classes = Map<dynamic, dynamic>.from((snapshot.data! as DatabaseEvent).snapshot.value as Map<dynamic, dynamic>); //typecasting
              classes.forEach((key, value) {
                final classelement = Map<String, dynamic>.from(value);
                List55.add(classelement['name'].toString());
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
              return Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(height: 10.h,),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'What is your subtype ?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 25.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 15.h,),
                            Text(
                              'This helps us create your personalized plan',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap:(){
                                setState(() {
                                  x = false;
                                });
                              },
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                  height: 60.h,
                                  width: 250.w,
                                  decoration: BoxDecoration(
                                    color: x?darkgrey:lightyellow,
                                    border: Border.all(color: Colors.grey, width: 1.w, ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 12, right: 12),
                                    child: x?Center(
                                      child: Container(),
                                    ):Center(
                                      child: DropdownButton<String>(
                                        underline: Container(color: Colors.white,),
                                        isExpanded: true,
                                        items: List55.map<DropdownMenuItem<String>>(
                                                (String value)
                                            {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: SingleChildScrollView(
                                                    scrollDirection: Axis.horizontal,
                                                    child: Center(
                                                        child: Text(value,
                                                          style: TextStyle(color: darkgrey, fontSize: 18.sp, fontWeight: FontWeight.bold,),))),
                                              );
                                            }

                                        ).toList(),
                                        icon: Icon(Icons.arrow_drop_down, size: 35, color: darkgrey,),

                                        value: List5,
                                        onChanged:(alinanVeri) {
                                          if (alinanVeri! == "Private") {
                                            data = "";
                                          }else{
                                            data = "${FirebaseAuth.instance.currentUser!.uid.toString()}>${staffe[List55.indexOf(alinanVeri!)-1].name}";
                                          }
                                          setState(() {
                                            List5 = alinanVeri!;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
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
                          },
                          child: Container(
                            width: 250.w,
                            height: 60.h,
                            decoration: BoxDecoration(
                                color: x ? lightyellow : darkgrey,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: silverdark)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Public',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(fontWeight: FontWeight.bold, color: x ? darkgrey : Colors.grey, fontSize: 18.sp),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: ()async{
                            await DataCollectionMethods().savestringdata('subtype',data.toString());
                            Get.off(ActiveScreen());
                          },
                          child: Container(
                            width: 280.w,
                            height: 45.h,
                            decoration: BoxDecoration(
                              color: lightyellow,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Next',
                                  style: TextStyle(color: darkgrey, fontSize: 18.sp,fontWeight: FontWeight.bold),
                                ),
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
              return LoadingScreen();
            }
            },
          ),
        ),
        onWillPop: ()async{
          Get.off(PushupScreen());
          return false;
        });
  }
}
