import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flockergym/Data%20collection%20screens/Button%20widget/button_widget.dart';
import 'package:flockergym/Data%20collection%20screens/Button%20widget/util.dart';
import 'package:flockergym/Data%20collection%20screens/gender_screen.dart';
import 'package:flockergym/Data%20collection%20screens/weight_screen.dart';
import 'package:flockergym/Methods/colors_methods.dart';
import 'package:flockergym/NewBackend/DataCollectionBack/DataCollectionMethods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AgeScreen extends StatefulWidget {
  const AgeScreen({super.key});

  @override
  State<AgeScreen> createState() => _AgeScreenState();
}
int age = 20;
double weight = 60.0;
bool istapped = false;
TextEditingController controller = TextEditingController();


class _AgeScreenState extends State<AgeScreen> {

  DateTime dateTime = DateTime.now();
  String List2 = 'Calendar';
  var List22 = ['Calendar'];

  @override
  void initState() {
    controller.text = age.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black,
          leading: BackButton(
            color: Colors.white,
            onPressed: (){
              Get.off(GenderScreen());
            },
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: 20.h,),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Enter your age',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonWidget(
                  onClicked: () => Utils.showSheet(
                    context,
                    child: buildDatePicker(),
                    onClicked: () {
                      final value = DateFormat('yyyy/MM/dd').format(dateTime);
                      Utils.showSnackBar(context, 'Selected "$value"');
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: ()async{
                      if (!istapped) {
                        final snackBar = SnackBar(
                          duration: Duration(milliseconds: 1500,),
                          elevation: 0,
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          content: AwesomeSnackbarContent(
                            title: 'Error',
                            message: 'Please Choose Date.',
                            contentType: ContentType.failure,
                          ),
                        );
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(snackBar);
                        return;
                      }
                      String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
                      await DataCollectionMethods().savestringdata('age', formattedDate.toString());
                      Get.off(WeightScreen());
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
                          Text('Next',
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
      onWillPop: ()async{
        Get.off(GenderScreen());
        return false;
      });
  }
  Widget buildDatePicker() => SizedBox(
    height: 180.h,
    child: CupertinoDatePicker(
      minimumYear: 1950,
      maximumYear: DateTime.now().year,
      initialDateTime: dateTime,
      mode: CupertinoDatePickerMode.date,
      onDateTimeChanged: (dateTime) =>
          setState(() {
            this.dateTime = dateTime;
            istapped = true;
          }),
    ),
  );
}
