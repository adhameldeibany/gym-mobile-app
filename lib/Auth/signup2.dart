import 'package:flockergym/Auth/signin_screen.dart';
import 'package:flockergym/Auth/signup_screen.dart';
import 'package:flockergym/HomePolicyScreen/HomePivacyScreen.dart';
import 'package:flockergym/Methods/colors_methods.dart';
import 'package:flockergym/NewBackend/SignupBack/SignupMethods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class Signup2 extends StatefulWidget
{
  @override
  State<Signup2> createState() => _Signup2State();
}

class _Signup2State extends State<Signup2> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: darkgrey,
                image: DecorationImage(
                  image: AssetImage('assets/signup2.png',),
                  fit: BoxFit.fill,
                  colorFilter: ColorFilter.mode(Colors.black12, BlendMode.darken),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xff0A0A0A00), Color(0xff0A0A0A)],
                    begin: Alignment(0.0, -0.3),
                    end: Alignment(0, 0.2),
                  )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: 10.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Signup',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 25.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: ()async{
                                await SignupMethods().start(2,null,null,null,null,null);
                              },
                              child: Container(
                                height: 45.h,
                                width: 320.w,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.black),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(FontAwesomeIcons.google,color: darkgrey,),
                                    SizedBox(width: 8.w,),
                                    Text(
                                      'Continue with Google',
                                      style: TextStyle(
                                        color: darkgrey,
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 12.h,),
                            InkWell(
                              onTap: () {
                                Get.to(SignupScreen());
                              },
                              child: Container(
                                height: 45.h,
                                width: 320.w,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.black),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.email,color: darkgrey,),
                                    SizedBox(width: 8.w,),
                                    Text(
                                      'Continue with Email',
                                      style: TextStyle(
                                        color: darkgrey,
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h,),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account ?',
                              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                            TextButton(
                                onPressed: () {
                                  Get.off(SigninScreen());
                                },
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: 16.sp, fontWeight: FontWeight.bold, color: lightyellow),
                                )
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 260.w,
                                  child: Text(
                                    'By signing up, you are creating a Geminus account and agree to Geminus',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: (){
                                    Get.to(HomePolicyScreen());
                                  },
                                  child: Text('Privacy Policy',
                                    style: TextStyle(fontSize: 12.sp, color: lightyellow),
                                  ),
                                ),
                              ],
                            ),
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
      ),
    );
  }
}