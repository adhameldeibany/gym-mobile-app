import 'package:flockergym/Methods/colors_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkgrey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: darkgrey,
              image: DecorationImage(
                image: AssetImage('assets/3.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
              ),
            ),
            child: Row(
              children: [
                Column(
                  children: [
                    SizedBox(height: 100.h,),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Start \nyour \njourney \nnow",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: "Aquire",
                              fontSize: 50.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 35.h,),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}