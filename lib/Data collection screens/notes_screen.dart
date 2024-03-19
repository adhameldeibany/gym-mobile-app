import 'package:flockergym/Data%20collection%20screens/active_screen.dart';
import 'package:flockergym/Data%20collection%20screens/policy_screen.dart';
import 'package:flockergym/Methods/colors_methods.dart';
import 'package:flockergym/NewBackend/DataCollectionBack/DataCollectionMethods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}
int age = 20;
double weight = 60.0;
String notes = "";
TextEditingController controller = TextEditingController();


class _NotesScreenState extends State<NotesScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: BackButton(
              color: Colors.white,
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 10.h,),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Write your notes...',
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
                SizedBox(height: 20.h,),
                Padding(
                  padding: const EdgeInsets.only(right: 30, left: 30),
                  child: TextFormField(
                    minLines: 10,
                    maxLines: 10,
                    keyboardType: TextInputType.multiline,
                    controller: controller,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Your notes',
                      hintStyle: TextStyle(color: Colors.white54, fontSize: 17.sp),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: lightyellow,)),
                      border: OutlineInputBorder(borderSide: BorderSide(color: lightyellow,)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: lightyellow, width: 2.w)),
                    ),
                  ),
                ),
                SizedBox(height: 70.h,),
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () async {
                          await DataCollectionMethods().savestringdata('notes',controller.text);
                          Get.off(PolicyScreen());
                        },
                        child: Container(
                          width: 300.w,
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
            ),
          ),
        ),
        onWillPop: ()async{
          Get.off(ActiveScreen());
          return false;
        });
  }
}
