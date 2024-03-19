import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flockergym/Auth/signup2.dart';
import 'package:flockergym/Methods/colors_methods.dart';
import 'package:flockergym/NewBackend/SignupBack/SignupMethods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

bool x = false;
class SignupScreen extends StatefulWidget
{
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  var firstnamecontroller = TextEditingController();
  var lastnamecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var confirmpasswordcontroller = TextEditingController();
  bool passToggle = true;
  bool isRememberMe = false;

  @override
  Widget build(BuildContext context) {
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
                  image: AssetImage('assets/email.png'),
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
            SizedBox(height: 25.h,),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Signup with email',
                          style: TextStyle(color: Colors.white, fontSize: 18.sp),
                        ),
                      ],
                    ),
                    SizedBox(height: 40.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 145.w,
                          height: 50.h,
                          child: TextFormField(
                            controller: firstnamecontroller,
                            onChanged: Completed,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              labelStyle: TextStyle(color: lightyellow, fontSize: 15.sp),
                              hintText: 'First name',
                              hoverColor: Colors.white,
                              hintStyle: TextStyle(color: Colors.white54, fontSize: 15.sp),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey,)),
                              border: OutlineInputBorder(borderSide: BorderSide(color: lightyellow,)),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: lightyellow,width: 2.w)),
                            ),
                          ),
                        ),
                        SizedBox(width: 20.w,),
                        SizedBox(
                          width: 145.w,
                          height: 50.h,
                          child: TextFormField(
                            controller: lastnamecontroller,
                            onChanged: Completed,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              labelStyle: TextStyle(color: lightyellow, fontSize: 15.sp),
                              hintText: 'Last name',
                              hoverColor: Colors.white,
                              hintStyle: TextStyle(color: Colors.white54, fontSize: 15.sp),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey,)),
                              border: OutlineInputBorder(borderSide: BorderSide(color: lightyellow,)),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: lightyellow,width: 2.w)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(
                      height: 50.h,
                      child: TextFormField(
                        onChanged: Completed,
                        style: TextStyle(color: Colors.white),
                        controller: emailcontroller,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          labelStyle: TextStyle(color: lightyellow, fontSize: 18.sp),
                          hintText: 'Email',
                          hoverColor: Colors.white,
                          hintStyle: TextStyle(color: Colors.white54, fontSize: 15.sp),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey,)),
                          border: OutlineInputBorder(borderSide: BorderSide(color: lightyellow,)),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: lightyellow,width: 2.w)),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(
                      height: 50.h,
                      child: TextFormField(
                        onChanged: Completed,
                        style: TextStyle(color: Colors.white),
                        controller: phonecontroller,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          labelStyle: TextStyle(color: lightyellow, fontSize: 18.sp),
                          hintText: 'Phone number',
                          hoverColor: Colors.white,
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
                      height: 50.h,
                      child: TextFormField(
                        onChanged: Completed,
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
                    SizedBox(
                      height: 20.h,
                    ),
                    SizedBox(
                      height: 50.h,
                      child: TextFormField(
                        onChanged: Completed,
                        style: TextStyle(color: Colors.white),
                        controller: confirmpasswordcontroller,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: passToggle,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            labelStyle: TextStyle(color: lightyellow, fontSize: 18.sp),
                            hintText: 'Confirm password',
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
                    SizedBox(height: 40.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: ()async{
                            if (firstnamecontroller.text.length == 0) {
                              final snackBar = SnackBar(
                                duration: Duration(milliseconds: 1500,),
                                elevation: 0,
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                content: AwesomeSnackbarContent(
                                  title: 'Error',
                                  message: 'First Name Can\'t Be Empty',
                                  contentType: ContentType.failure,
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(snackBar);
                              return;
                            }else if(lastnamecontroller.text.length == 0){
                              final snackBar = SnackBar(
                                duration: Duration(milliseconds: 1500,),
                                elevation: 0,
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                content: AwesomeSnackbarContent(
                                  title: 'Error',
                                  message: 'Last Name Can\'t Be Empty',
                                  contentType: ContentType.failure,
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(snackBar);
                              return;
                            }else if(emailcontroller.text.length == 0){
                              final snackBar = SnackBar(
                                duration: Duration(milliseconds: 1500,),
                                elevation: 0,
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                content: AwesomeSnackbarContent(
                                  title: 'Error',
                                  message: 'Email Can\'t Be Empty',
                                  contentType: ContentType.failure,
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(snackBar);
                              return;
                            }
                            else if(phonecontroller.text.length == 0){
                              final snackBar = SnackBar(
                                duration: Duration(milliseconds: 1500,),
                                elevation: 0,
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                content: AwesomeSnackbarContent(
                                  title: 'Error',
                                  message: 'Phone Can\'t Be Empty',
                                  contentType: ContentType.failure,
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(snackBar);
                              return;
                            }
                            else if(passwordcontroller.text.length == 0){
                              final snackBar = SnackBar(
                                duration: Duration(milliseconds: 1500,),
                                elevation: 0,
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                content: AwesomeSnackbarContent(
                                  title: 'Error',
                                  message: 'Password Can\'t Be Empty',
                                  contentType: ContentType.failure,
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(snackBar);
                              return;
                            }else if (confirmpasswordcontroller.text != passwordcontroller.text){
                              final snackBar = SnackBar(
                                duration: Duration(milliseconds: 1500,),
                                elevation: 0,
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                content: AwesomeSnackbarContent(
                                  title: 'Error',
                                  message: 'Password isn\'t match confirm password' ,
                                  contentType: ContentType.failure,
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(snackBar);
                              return;
                            }
                            else{
                              await SignupMethods().start(1, phonecontroller.text, emailcontroller.text, passwordcontroller.text, firstnamecontroller.text +" "+lastnamecontroller.text, context);
                            }
                            },
                          child: Container(
                            width: 280.w,
                            height: 45.h,
                            decoration: BoxDecoration(
                              color: x?lightyellow:darkgrey,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Create account',
                                  style: TextStyle(color: x?Colors.black:silverdark, fontSize: 15.sp,fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Completed(String value)async {
    if (
    confirmpasswordcontroller.text.length != 0 &&
    passwordcontroller.text.length != 0 &&
    phonecontroller.text.length != 0 &&
    emailcontroller.text.length != 0 &&
    firstnamecontroller.text.length != 0 &&
    lastnamecontroller.text.length != 0) {
      setState(() {
        x = true;
      });
    }else{
      setState(() {
        x = false;
      });
    }
  }

}

