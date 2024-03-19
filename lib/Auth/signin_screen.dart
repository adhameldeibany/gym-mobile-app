import 'package:flockergym/Auth/forgot_screen.dart';
import 'package:flockergym/Auth/signup2.dart';
import 'package:flockergym/Methods/colors_methods.dart';
import 'package:flockergym/NewBackend/SigninBack/SigninMethods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SigninScreen extends StatefulWidget
{
  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {

  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  bool passToggle = true;
  bool isRememberMe = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.3,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: darkgrey,
                image: DecorationImage(
                  image: AssetImage('assets/login.png'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Colors.black12, BlendMode.darken),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 30, left: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 45.w,
                          height: 45.h,
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            shape: BoxShape.circle,
                          ),
                          child: BackButton(
                            color: Colors.white,
                            onPressed: (){
                              Get.off(Signup2());
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(35.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Login to your account',
                          style: TextStyle(color: Colors.white, fontSize: 18.sp),
                        ),
                      ],
                    ),
                    SizedBox(height: 25.h,),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 55.h,
                            child: TextFormField(
                              style: TextStyle(color: Colors.white),
                              controller: emailcontroller,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                labelStyle: TextStyle(color: lightyellow, fontSize: 18.sp),
                                hintText: 'Email',
                                hintStyle: TextStyle(color: Colors.white54, fontSize: 15.sp),
                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey,)),
                                border: OutlineInputBorder(borderSide: BorderSide(color: lightyellow,)),
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: lightyellow,width: 2.w)),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          SizedBox(
                            height: 55.h,
                            child: TextFormField(
                              style: TextStyle(color: Colors.white),
                              controller: passwordcontroller,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: passToggle,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  labelStyle: TextStyle(color: lightyellow, fontSize: 18.sp),
                                  hintText: 'Password',
                                  hintStyle: TextStyle(color: Colors.white54, fontSize: 15.sp),
                                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey,)),
                                  border: OutlineInputBorder(borderSide: BorderSide(color: lightyellow,)),
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: lightyellow, width: 2.w)),
                                  suffix: InkWell(
                                    onTap: (){
                                      setState(() {
                                        passToggle = !passToggle;
                                      });
                                    },
                                    child: Icon(passToggle ? Icons.visibility_off : Icons.visibility, color: Colors.grey,),
                                  )
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Get.to(ForgotScreen());
                                },
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(color: lightyellow, fontSize: 12.sp),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 48.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: ()async {
                            SigninMethods().start(emailcontroller.text, passwordcontroller.text, context);
                          },
                          child: Container(
                            width: 280.w,
                            height: 45.h,
                            decoration: BoxDecoration(
                              color: lightyellow,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Login',
                                  style: TextStyle(color: darkgrey, fontSize: 15.sp,fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
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