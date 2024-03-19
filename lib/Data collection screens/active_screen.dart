import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flockergym/Data%20collection%20screens/notes_screen.dart';
import 'package:flockergym/Data%20collection%20screens/subtype_screen.dart';
import 'package:flockergym/Data%20collection%20screens/Future%20data/walk_screen.dart';
import 'package:flockergym/Methods/colors_methods.dart';
import 'package:flockergym/NewBackend/DataCollectionBack/DataCollectionMethods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ActiveScreen extends StatefulWidget {

  @override
  State<ActiveScreen> createState() => _ActiveScreenState();
}
int age = 20;
double weight = 60.0;

TextEditingController controller = TextEditingController();
String data = "";


class _ActiveScreenState extends State<ActiveScreen> {

  bool a = false;
  bool s = false;
  bool d = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: BackButton(
            color: Colors.white,
            onPressed: (){
              Get.off(SubtypeScreen());
            },
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(height: 10.h,),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      'Set your weekly goal',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 300.w,
                    child: Text(
                      'We recommend training at least 3 days weekly for a better result',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  InkWell(
                    onTap: (){
                      setState(() {
                        data = "1-2 Workouts a Week";
                        if (a == false) {
                          a = true;
                          s = false;
                          d = false;
                        } else if (a == true) {
                          a = false;
                          data = "";
                        }
                      });
                    },
                    child: Container(
                      width: 300.w,
                      height: 60.h,
                      decoration: BoxDecoration(
                          color: a ? lightyellow : Colors.black,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: silverdark)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Row(
                          children: [
                            Text('1-2 Workouts a Week',
                              textAlign: TextAlign.start,
                              style: TextStyle(fontWeight: FontWeight.bold, color: a ? Colors.black : Colors.white, fontSize: 16.sp),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h,),
                  InkWell(
                    onTap: (){
                      setState(() {
                        data = "3-5 Workouts a Week";
                        if (s == false) {
                          s = true;
                          a = false;
                          d = false;
                        } else if (s == true) {
                          s = false;
                          data = "";
                        }
                      });
                    },
                    child: Container(
                      width: 300.w,
                      height: 60.h,
                      decoration: BoxDecoration(
                          color: s ? lightyellow : Colors.black,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: silverdark)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Row(
                          children: [
                            Text('3-5 Workouts a Week',
                              textAlign: TextAlign.start,
                              style: TextStyle(fontWeight: FontWeight.bold, color: s ? Colors.black : Colors.white, fontSize: 16.sp),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h,),
                  InkWell(
                    onTap: (){
                      setState(() {
                        data = "5-7 Workouts a Week";
                        if (d == false) {
                          d = true;
                          a = false;
                          s = false;
                        } else if (d == true) {
                          d = false;
                          data = "";
                        }
                      });
                    },
                    child: Container(
                      width: 300.w,
                      height: 60.h,
                      decoration: BoxDecoration(
                          color: d ? lightyellow : Colors.black,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: silverdark)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Row(
                          children: [
                            Text('5-7 Workouts a Week',
                              textAlign: TextAlign.start,
                              style: TextStyle(fontWeight: FontWeight.bold, color: d ? Colors.black : Colors.white, fontSize: 16.sp),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: InkWell(
                  onTap: () async{
                    if (data == "") {
                      final snackBar = SnackBar(
                        duration: Duration(milliseconds: 1500,),
                        elevation: 0,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          title: 'Error',
                          message: 'Please Choose An Option.',
                          contentType: ContentType.failure,
                        ),
                      );
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackBar);
                      return;
                    }
                    await DataCollectionMethods().savestringdata('active',data);
                    Get.off(NotesScreen());
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
              ),
            ],
          ),
        ),
      ),
        onWillPop: ()async{
          Get.off(NotesScreen());
          return false;
        }
    );
  }
}
