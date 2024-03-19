import 'package:flockergym/Home/Features/Workout/workout_view_2.dart';
import 'package:flockergym/Methods/colors_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class WorkoutView extends StatefulWidget {
  const WorkoutView({super.key});

  @override
  State<WorkoutView> createState() => _WorkoutViewState();
}

class _WorkoutViewState extends State<WorkoutView> {
  List workout = [
    {
      "name": "Chest",
      "image": "assets/images/3.png",
      "title": "workout",
      "description": "Personalized workouts will help\nyou gain strength"
    },
    {
      "name": "Arms",
      "image": "assets/images/2.png",
      "title": "workout",
      "description": "Personalized workouts will help\nyou gain strength"
    },
    {
      "name": "Running",
      "image": "assets/images/5.png",
      "title": "workout",
      "description": "Personalized workouts will help\nyou gain strength"
    },
    {
      "name": "Legs",
      "image": "assets/images/1.png",
      "title": "workout",
      "description": "Personalized workouts will help\nyou gain strength"
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
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          itemCount: workout.length,
          itemBuilder: (context, index) {
            var wObj = workout[index] as Map? ?? {};
            return Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: media.width * 0.52,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        color: Colors.white24,
                        offset: Offset(0, 5),
                      )
                    ]
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  children: [
                    Image.asset(
                      wObj["image"].toString(),
                      width: media.width,
                      height: media.width * 0.52,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      width: media.width,
                      height: media.width * 0.52,
                      decoration: BoxDecoration(
                        color: Colors.black45
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 25, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            wObj["title"],
                            style: TextStyle(
                                color: lightyellow,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            wObj["name"],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            wObj["description"],
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                child: TextButton(
                                  onPressed:() {
                                    Get.to(WorkoutView2());
                                  },
                                  child: Text('See more', style: TextStyle(color: lightyellow),),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          ),
    );
  }
}
