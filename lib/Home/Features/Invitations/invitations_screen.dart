import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flockergym/Methods/colors_methods.dart';
import 'package:flockergym/NewBackend/Models/ProfileModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

String data = FirebaseAuth.instance.currentUser!.uid.toString();
late ProfileModel profileModel;
DatabaseReference ref = FirebaseDatabase.instance.ref("members/${FirebaseAuth.instance.currentUser!.uid}/");

class InvitationsScreen extends StatefulWidget {
  const InvitationsScreen({super.key});

  @override
  State<InvitationsScreen> createState() => _InvitationsScreenState();
}

class _InvitationsScreenState extends State<InvitationsScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text("Invitations",
          textAlign: TextAlign.start,
          style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
        ),
        leading: BackButton(
          color: Colors.white,
        ),
      ),
      body: StreamBuilder(
        stream:ref.onValue,
        builder: (context, snapshot) {
      if (snapshot.hasData && snapshot.data != null &&
          (snapshot.data! as DatabaseEvent).snapshot.value != null) {
            profileModel = new ProfileModel(
              id: snapshot.data?.snapshot.child('id').value.toString(),
              imgurl: snapshot.data?.snapshot.child('imgurl').value.toString(),
              name: snapshot.data?.snapshot.child('name').value.toString(),
              uniq: snapshot.data?.snapshot.child('uniq').value.toString(),
              invitations: snapshot.data?.snapshot.child('invitations').value.toString(),
            );
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 328.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                        color: Color(0xFF404040),
                      borderRadius: BorderRadius.circular(4)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Number of invitations: ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                          Text(profileModel.invitations!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 40.h,),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.91,
                      height: MediaQuery.of(context).size.width*0.91,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(39),
                        border: Border.all(color: lightyellow, width: 8.w),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          QrImageView(
                            data: profileModel.uniq.toString(),
                            foregroundColor: Colors.white,
                            version: QrVersions.auto,
                            size: 285.w,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 40.h,),
                  InkWell(
                    onTap: () async {
                      await Clipboard.setData(ClipboardData(text: "OG"+profileModel.uniq!));
                      final snackBar = SnackBar(
                        duration: Duration(milliseconds: 1500,),
                        elevation: 0,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          title: 'Success',
                          message: 'Copied To Clipboard',
                          contentType: ContentType.warning,
                        ),
                      );
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackBar);
                      // copied successfully
                    },
                    child: Container(
                      width: 328.w,
                      height: 44.h,
                      decoration: BoxDecoration(
                        color: Color(0xFF404040),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.copy, color: Color(0xFFF8BE00),),
                          SizedBox(width: 10.w,),
                          Text('Copy To Clipboard',
                            style: TextStyle(
                              color: Color(0xFFF8BE00),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              height: 0,
                              letterSpacing: -0.15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  InkWell(
                    onTap: () async{
                      String msg = "Hello, This Is An Invitation Link To Use In Gym Desk From App\nname: Olympic Gym\nCode : ${profileModel.uniq!}";
                      final url = "whatsapp://send?text=${msg}";
                      var androidUrl = "whatsapp://send?text=${msg}";
                      var iosUrl = "https://wa.me/?text=${Uri.parse("Hi")}";

                      try{
                        if(Platform.isIOS){
                          await launchUrl(Uri.parse(iosUrl));
                        }
                        else{
                          await launchUrl(Uri.parse(androidUrl));
                        }
                      } on Exception{
                      }
                    },
                    child: Container(
                      width: 328.w,
                      height: 44.h,
                      decoration: BoxDecoration(
                        color: Color(0xFF404040),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.share, color: Color(0xFFF8BE00),),
                          SizedBox(width: 10.w,),
                          Text('Share',
                            style: TextStyle(
                              color: Color(0xFFF8BE00),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              height: 0,
                              letterSpacing: -0.15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );

      }else{
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Lottie.asset('assets/gym.json'),
          ),
        );
      }
        },
      ),
    );

    return Scaffold(
      backgroundColor: darkgrey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Number of invitations: ', style: TextStyle(color: lightyellow, fontSize: 20.sp, fontWeight: FontWeight.bold),),
              Text('10', style: TextStyle(color: Colors.white, fontSize: 18.sp),)
            ],
          ),
          SizedBox(height: 25.h,),
          Center(
            child: QrImageView(
              data: data,
              backgroundColor: Colors.white,
              version: QrVersions.auto,
              size: 280,
            ),
          ),
          SizedBox(height: 40.h,),
          InkWell(
            onTap: () async {
              await Clipboard.setData(ClipboardData(text: FirebaseAuth.instance.currentUser!.uid));
              final snackBar = SnackBar(
                duration: Duration(milliseconds: 1500,),
                elevation: 0,
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                content: AwesomeSnackbarContent(
                  title: 'Success',
                  message: 'Copied To Clipboard',
                  contentType: ContentType.warning,
                ),
              );
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(snackBar);
              // copied successfully
            },
            child: Container(
              width: 200.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: lightyellow,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Copy To Clipboard',
                    style: TextStyle(color: darkgrey, fontSize: 16.sp,fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20.h,),
          InkWell(
            onTap: () async{
              String msg = "Hello this invitation for you";
              final url = "whatsapp://send?text=${msg}";
              var androidUrl = "whatsapp://send?text=${msg}";
              var iosUrl = "https://wa.me/?text=${Uri.parse("Hi")}";

              try{
                if(Platform.isIOS){
                  await launchUrl(Uri.parse(iosUrl));
                }
                else{
                  await launchUrl(Uri.parse(androidUrl));
                }
              } on Exception{
              }

            },
            child: Container(
              width: 150.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: lightyellow,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Share',
                    style: TextStyle(color: darkgrey, fontSize: 16.sp,fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 5.w,),
                  Icon(Icons.share, color: darkgrey,)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
