import 'package:flockergym/Methods/colors_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkoutDetailView extends StatefulWidget {
  const WorkoutDetailView({super.key});

  @override
  State<WorkoutDetailView> createState() => _WorkoutDetailViewState();
}

class _WorkoutDetailViewState extends State<WorkoutDetailView> {
  List workout = [
    {
      "name": "Running",
      "image": "assets/images/3.png"
    },
    {
      "name": "Jumping",
      "image": "assets/images/2.png"
    },
    {
      "name": "Boxing",
      "image": "assets/images/5.png",
    },
    {
      "name": "Crossfit",
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              "assets/images/3.png",
              width: media.width,
              height: media.width * 0.55,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 30.h,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: Text(
                "Recommended",
                style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  color: lightyellow,
                ),
              ),
            ),
            SizedBox(
              height: media.width * 0.26,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  itemCount: workout.length,
                  itemBuilder: (context, index) {
                    var wObj = workout[index] as Map? ?? {};
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      width: media.width * 0.28,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                wObj["image"].toString(),
                                width: media.width,
                                height: media.width * 0.15,
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 0),
                            child: Text(
                              wObj["name"],
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                color: lightyellow,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
