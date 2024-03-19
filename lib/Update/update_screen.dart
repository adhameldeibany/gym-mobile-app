import 'package:flockergym/Methods/colors_methods.dart';
import 'package:flockergym/NewBackend/Models/UpdateModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

late UpdateModel updatemodel;

class UpdateScreen extends StatefulWidget {

  UpdateScreen({required UpdateModel update}){
    updatemodel = update;
  }

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text("Time To Update To Version "+updatemodel.version!,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold, color: lightyellow,),
                              ),
                              SizedBox(height: 15.h,),
                              Text("We added lots of new features and fix some bugs to make your experience as smooth as possible.",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.white,),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      launchUrl(Uri.parse(updatemodel.url!));
                    },
                    child: Container(
                      width: 160.w,
                      height: 55.h,
                      decoration: BoxDecoration(
                        color: lightyellow,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Update Now',
                            style: TextStyle(color: darkgrey, fontSize: 18.sp,fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
