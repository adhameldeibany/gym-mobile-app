import 'package:flockergym/Methods/colors_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class WorkoutView2 extends StatefulWidget {
  const WorkoutView2({super.key});

  @override
  State<WorkoutView2> createState() => _WorkoutView2State();
}

class _WorkoutView2State extends State<WorkoutView2> {
  List workout = [
    {
      "name": "Push-Up",
      "image": "assets/images/3.png"
    },
    {
      "name": "Leg",
      "image": "assets/images/2.png"
    },
    {
      "name": "Running",
      "image": "assets/images/5.png",
    },
    {
      "name": "Arms",
      "image": "assets/images/3.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: darkgrey,
      appBar: AppBar(
        backgroundColor: darkgrey,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Workout",
          style: TextStyle(
              color: lightyellow, fontSize: 20.sp, fontWeight: FontWeight.w700),
        ),
      ),
      body: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: workout.length,
          itemBuilder: (context, index) {
            var wObj = workout[index] as Map? ?? {};
            return Container(
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        wObj["image"].toString(),
                        width: media.width,
                        height: media.width * 0.55,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        width: media.width,
                        height: media.width * 0.55,
                        decoration:
                            BoxDecoration(color: Colors.black.withOpacity(0.5)),
                      ),
                      InkWell(
                        onTap: () {
                          // Get.to(WorkoutDetailView());
                          launchUrl(Uri.parse("https://youtu.be/iCQ2gC4DqJw?si=0D7iX5QeXLCLSGQ5"));
                        },
                        child: Image.asset(
                          "assets/images/play.png",
                          width: 60.w,
                          height: 60.h,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          wObj["name"],
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700),
                        ),
                        IconButton(
                            onPressed: () {
                              // Get.to(WorkoutDetailView());
                              launchUrl(Uri.parse("https://youtu.be/iCQ2gC4DqJw?si=0D7iX5QeXLCLSGQ5"));
                            },
                            icon: Image.asset("assets/images/more.png",
                                width: 25.w,
                                height: 25.h
                            ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          ),
    );
  }
}
