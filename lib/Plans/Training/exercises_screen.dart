import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flockergym/Methods/colors_methods.dart';
import 'package:flockergym/NewBackend/MainMethods.dart';
import 'package:flockergym/NewBackend/Models/ExercisesModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

late String id;
late String name;
late String time;
late String date;
late String img;
FirebaseFirestore ref = FirebaseFirestore.instance;
class ExercisesScreen extends StatefulWidget {
  ExercisesScreen({required String i, required String n, required String t, required String d, required String im}){
    id = i;
    name = n;
    time = t;
    date = d;
    img = im;
  }

  @override
  State<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> {

  Scaffold MakeStream(BuildContext context){
    final trainings = ref.collection("trainings").doc(id).collection("exercises").snapshots();
    return Scaffold(
      backgroundColor: Colors.black,
      body: StreamBuilder(
        stream: trainings,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null ) {
            if (snapshot.data?.docs.length != 0) {
              final items2 = snapshot.data!.docs;
              List<ExercisesModel>trs = [];
              for(var item in items2){
                ExercisesModel trainingModel = new ExercisesModel(
                  reps: item["reps"],
                    sets: item["sets"],
                    name: item["name"],
                    imgurl: item["imgurl"]
                );
                trs.add(trainingModel);
              }

              return Scaffold(
                backgroundColor: Colors.black,
                appBar: AppBar(
                  backgroundColor: Colors.black,
                  elevation: 0,
                  title: Text("Chest exercises",
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
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Column(
                      children: [
                        SizedBox(height: 10.h,),
                        Card(
                          color: silverdark,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                              padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 24.h, top: 24.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 120.w,
                                        child: AutoSizeText(name,
                                          maxLines: 2,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24.sp,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            height: 0,
                                            letterSpacing: 0.24,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 16.h),
                                      Row(
                                        children: [
                                          Icon(Icons.watch_later_outlined, color: Colors.grey, size: 16,),
                                          SizedBox(width: 5.w,),
                                          Text(time, style: TextStyle(
                                            color: Color(0xFFC8C8C8),
                                            fontSize: 12.sp,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                            letterSpacing: 0.12,
                                          ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 16.h,),
                                      Row(
                                        children: [
                                          Icon(Icons.edit_calendar_outlined, color: Colors.grey, size: 16,),
                                          SizedBox(width: 5.w,),
                                          Text(date, style: TextStyle(
                                            color: Color(0xFFC8C8C8),
                                            fontSize: 12.sp,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                            letterSpacing: 0.12,
                                          ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 120.w,
                                    height: 120.h,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image(
                                          image: NetworkImage(img),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: 280.h,
                            ),
                            itemCount: trs.length,
                            itemBuilder: (_,index){
                              final exe = trs[index];
                              return InkWell(
                                onTap: (){
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      backgroundColor: Colors.grey,
                                      content: Container(
                                        height: 400.h,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            ClipRRect(
                                                borderRadius: BorderRadius.circular(12),
                                                child: Image(
                                                  image: NetworkImage(exe.imgurl),
                                                  fit: BoxFit.fill,
                                                ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      width: 156.w,
                                      height: 260.h,
                                      decoration: BoxDecoration(
                                          color: Color(0xFF323232),
                                          borderRadius: BorderRadius.circular(12)
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SizedBox(height: 10.h,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                    width: 120.w,
                                                    child: AutoSizeText(exe.name,
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w600,
                                                        height: 0,
                                                        letterSpacing: 0.16,
                                                      ),
                                                    )),
                                              ],
                                            ),
                                            SizedBox(height: 5.h,),
                                            SizedBox(
                                                width: 128.w,
                                                height: 120.h,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(12),
                                                    child: Image(image: NetworkImage(exe.imgurl)))),
                                            SizedBox(height: 10.h,),
                                            Row(
                                              children: [
                                                Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(exe.sets + " Sets",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w500,
                                                        height: 0,
                                                        letterSpacing: 0.12,
                                                      ),
                                                    ),
                                                    SizedBox(height: 8.h,),
                                                    Text(exe.reps+' Reps',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w500,
                                                        height: 0,
                                                        letterSpacing: 0.12,
                                                      ),),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                        ),
                      ],
                    ),
                  ),
                ),
              );

            }
            else{
              return LoadingScreen();
            }
          }else{
            return LoadingScreen();
          }
        },
      ),
    );
    return LoadingScreen();
  }

  @override
  Widget build(BuildContext context) {
    return MakeStream(context);
  }
}
