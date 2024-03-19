import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flockergym/Methods/colors_methods.dart';
import 'package:flockergym/NewBackend/MainMethods.dart';
import 'package:flockergym/NewBackend/Models/TrainingModel.dart';
import 'package:flockergym/Plans/Training/exercises_screen.dart';
import 'package:flockergym/Responsive%20UI/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

FirebaseFirestore ref = FirebaseFirestore.instance;
final trainings = ref.collection("trainings").snapshots();

class TrainingPrograms extends StatefulWidget {
  const TrainingPrograms({super.key});

  @override
  State<TrainingPrograms> createState() => _TrainingProgramsState();
}

class _TrainingProgramsState extends State<TrainingPrograms> {

  Scaffold MakeStream(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.black,
      body: StreamBuilder(
        stream: trainings,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null ) {
            if (snapshot.data?.docs.length != 0) {
              final items2 = snapshot.data!.docs;
              List<TrainingModel>trs = [];
              for(var item in items2){
                TrainingModel trainingModel = new TrainingModel(
                    dateday: item["dateday"],
                    datemonth: item["datemonth"],
                    name: item["name"],
                    id: item["id"],
                    time: item["time"],
                    imgurl: item["imgurl"]
                );
                trs.add(trainingModel);
              }
              return Scaffold(
                backgroundColor: Colors.black,
                appBar: AppBar(
                  backgroundColor: Colors.black,
                  elevation: 0,
                  title: Text("Training Programs",
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
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    child: Column(
                      children: [
                        SizedBox(height: 10.h,),
                        Row(
                          children: [
                            Icon(FontAwesomeIcons.dumbbell, color: Colors.white, size: 15,),
                            SizedBox(width: 10.w,),
                            Text('Upcoming exercise', style: TextStyle(color: Colors.white, fontSize: 18.sp),),
                          ],
                        ),
                        SizedBox(height: 10.h,),
                        Card(
                          color: Color(0xFF323232),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                              padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 24.h, bottom: 24.h),
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
                                        child: AutoSizeText(trs[0].name,
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
                                          Text(trs[0].time, style: TextStyle(
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
                                      SizedBox(height: 16.h),
                                      Row(
                                        children: [
                                          Icon(Icons.edit_calendar_outlined, color: Colors.grey, size: 16,),
                                          SizedBox(width: 5.w,),
                                          Text(trs[0].dateday+" - "+trs[0].datemonth, style: TextStyle(
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
                                      SizedBox(height: 16.h),
                                      InkWell(
                                        onTap: (){
                                          Get.to(ExercisesScreen(
                                            i: trs[0].id,
                                            d: trs[0].dateday + " - "+ trs[0].datemonth,
                                            n: trs[0].name,
                                            t: trs[0].time,
                                            im: trs[0].imgurl,
                                          ));
                                        },
                                        child: Container(
                                          width: 120.w,
                                          height: 30.h,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            color: lightyellow,
                                          ),
                                          child: Center(
                                            child: Text('Start exercise',
                                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14.sp),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10.h,),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 150.w,
                                    height: 150.h,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image(
                                        image: NetworkImage(trs[0].imgurl),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                          ),
                        ),
                        SizedBox(height: 30.h,),
                        Row(
                          children: [
                            Text("Exercises",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 0,
                                letterSpacing: 0.16,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h,),
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: trs.length,
                            itemBuilder: (context, index) {
                              final tr = trs[index];
                              return Column(
                                children: [
                                  Container(
                                    width: 328.w,
                                    height: 80.h,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF323232),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8, right: 12,),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                width: 64.sp,
                                                height: 64.sp,
                                                decoration: BoxDecoration(
                                                    color: Color(0xff5C5C5C),
                                                    borderRadius: BorderRadius.circular(12)
                                                ),
                                                child: Center(
                                                  child: Text('${tr.dateday} \n${tr.datemonth}',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14.sp,
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w600,
                                                      height: 0,
                                                      letterSpacing: 0.14,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10.w,),
                                              Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: 100.w,
                                                    child: AutoSizeText(tr.name,
                                                      maxLines: 2,
                                                      textAlign: TextAlign.start,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16.sp,
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w600,
                                                        height: 0,
                                                        letterSpacing: 0.16,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 8.h,),
                                                  Row(
                                                    children: [
                                                      Icon(Icons.watch_later_outlined, color: Colors.white, size: 16,),
                                                      SizedBox(width: 5.w,),
                                                      Text(tr.time, style: TextStyle(
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
                                            ],
                                          ),
                                          InkWell(
                                            onTap: (){
                                              Get.to(ExercisesScreen(
                                                i: tr.id,
                                                t: tr.time,
                                                n: tr.name,
                                                d: tr.dateday + " - "+ tr.datemonth,
                                                im: tr.imgurl,
                                              ));
                                            },
                                            child: Text('View',
                                              style: TextStyle(
                                                color: Color(0xFFF8BE00),
                                                fontSize: 16.sp,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 15.h,),
                                ],
                              );
                            }
                        ),
                        SizedBox(height: 20.h,),
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
