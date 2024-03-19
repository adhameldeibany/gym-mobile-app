import 'package:flockergym/Methods/colors_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TrainingplanScreen extends StatefulWidget {
  const TrainingplanScreen({super.key});

  @override
  State<TrainingplanScreen> createState() => _TrainingplanScreenState();
}

class _TrainingplanScreenState extends State<TrainingplanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkgrey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: darkgrey,
                image: DecorationImage(
                  image: AssetImage('assets/p3.png'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text("Not Available",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 25.sp,
                                  fontWeight: FontWeight.bold,
                                  color: lightyellow,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 35.h,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
