import 'package:flockergym/Auth/signup2.dart';
import 'package:flockergym/Methods/colors_methods.dart';
import 'package:flockergym/NewBackend/OnBoardingBack/OnBoardingMethods.dart';
import 'package:flockergym/Onboarding/Pages/page1.dart';
import 'package:flockergym/Onboarding/Pages/page2.dart';
import 'package:flockergym/Onboarding/Pages/page3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

bool onLastPage = false;
PageController controller = PageController();

class _OnboardingScreenState extends State<OnboardingScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children:
        [
          PageView(
            controller: controller,
            onPageChanged: (index){
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: [
              Page1(),
              Page2(),
              Page3(),
            ],
          ),
          SizedBox(height: 20.h,),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              onLastPage?InkWell(
                onTap: ()async{
                  await OnBoardingMethods().savebooldata('show', true);
                  Get.off(Signup2());
                },
                child: Container(
                  width: 180.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: lightyellow,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Continue',
                        style: TextStyle(color: darkgrey, fontSize: 18.sp,fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.arrow_forward_ios, color: darkgrey,),
                    ],
                  ),
                ),
              ):SizedBox(height: 0,width: 0,),
              Container(
                alignment: Alignment(0,0.9),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    onLastPage?SizedBox(height: 0,width: 0,):SmoothPageIndicator(
                      controller: controller,
                      count: 3,
                      effect: WormEffect(
                        activeDotColor: lightyellow,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.h,),
              onLastPage?SizedBox(width: 0,height: 0,):TextButton(
                  onPressed: ()async{
                    await OnBoardingMethods().savebooldata('show', true);
                    Get.off(Signup2());
                  },
                  child: Text('Skip',
                    style: TextStyle(color: Colors.white, fontSize: 15.sp),
                  )
              ),
              SizedBox(height: 30.h,),
            ],
          ),
        ],
      ),
    );
  }
}