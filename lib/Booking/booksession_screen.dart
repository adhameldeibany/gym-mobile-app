import 'package:flockergym/Methods/colors_methods.dart';
import 'package:flockergym/NewBackend/Models/ClassesDaysModel.dart';
import 'package:flockergym/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

late List<ClassesDaysModel> classes;
late List<ClassesDaysModel> strs;
class BookSessionScreen extends StatefulWidget {
  BookSessionScreen({required List<ClassesDaysModel> classe}){
    classes = classe;
    strs = classe;
    final ids = classes.map((e) => e.classname).toSet();
    classes.retainWhere((x) => ids.remove(x.classname));
  }

  @override
  State<BookSessionScreen> createState() => _BookSessionScreenState();
}

class _BookSessionScreenState extends State<BookSessionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text("Classes",
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
                    image: NetworkImage(prefs.getString("imgurl").toString()),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 10.h,),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                Text("Book a session of your classes",
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
          Expanded(
            child: ListView.builder(
                itemCount: classes.length,
                itemBuilder: (context, index) {
                  final cls = classes[index];
                  return Card(
                    color: Color(0xFF232627),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 25.h, bottom: 25.h),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    width: 165.w,
                                    child: Text(cls.classname,
                                      style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(height: 10.h,),
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          Text('Started',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                                          ),
                                          Text(cls.started,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(color: Colors.white, fontSize: 12.sp),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 20.w,),
                                      Column(
                                        children: [
                                          Text('Last Session',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                                          ),
                                          Text(cls.finished,
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
                                    center: Text("${cls.remain}/${cls.total}",
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
                                    lineWidth: 10,
                                    percent: double.parse(cls.remain)/double.parse(cls.total),
                                    progressColor: lightyellow,
                                    backgroundColor: Colors.grey,
                                    circularStrokeCap: CircularStrokeCap.round,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 15.h,),
                          InkWell(
                            onTap: (){
                              context.go("/Class/Schedule",extra: strs);
                            },
                            child: Container(
                              width: 310.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: lightyellow, width: 1.w),
                              ),
                              child: Center(child: Text('Schedule', style: TextStyle(fontSize: 16.sp, color: lightyellow),)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
            ),
          ),
        ],
      ),
    );
  }
}
