import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flockergym/Methods/BackendMethods/Backend.dart';
import 'package:flockergym/Methods/colors_methods.dart';
import 'package:flockergym/NewBackend/Models/ClassModel.dart';
import 'package:flockergym/NewBackend/Models/ExtendedClassModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';

List<String> selectedItems = [];

List<String> List11 = ["Choose Class"];
List<String> List22 = ["Days","Sunday","Monday","Tuesday","Wednesday","Thursday","Friday"];
late List<ClassModel> classe;

String List1 = 'Choose Class';
String List2 = 'Days';
DatabaseReference ref = FirebaseDatabase.instance.ref("classes/");

DateTime dateTime = DateTime.now();
List<ExtendedClassModel> shortcutslist = [];
List<ExtendedClassModel> _searchval = [];
List<ExtendedClassModel> allprods = [];
List<String> days = [];
List<String> classs = [];
List<String> daysonly = [];
List<String> dayofweekonly = [];
List<String> dayofweekonly2 = [];
List<String> clsonly = [];
List<String> lenonly = [];

List<String> fldays = [];
List<String> flclasss = [];
List<String> fldaysonly = [];
List<String> fldayofweekonly = [];
List<String> fldayofweekonly2 = [];
List<String> flclsonly = [];
List<String> fllenonly = [];

class BookclassScreen extends StatefulWidget {
  const BookclassScreen({super.key});

  @override
  State<BookclassScreen> createState() => _BookclassScreenState();
}

class _BookclassScreenState extends State<BookclassScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: StreamBuilder(
        stream: ref.onValue,
        builder: (context, snapshot) {
          classe = [];
          if (snapshot.hasData && snapshot.data != null && (snapshot.data! as DatabaseEvent).snapshot.value != null) {
            classe.clear();
            List11.clear();
            daysonly.clear();
            dayofweekonly.clear();
            clsonly.clear();
            classs.clear();
            days.clear();
            shortcutslist.clear();
            List11.add("Choose Class");
            final classes = Map<dynamic, dynamic>.from((snapshot.data! as DatabaseEvent).snapshot.value as Map<dynamic, dynamic>); //typecasting
            classes.forEach((key, value) {
              final classelement = Map<String, dynamic>.from(value);
              List11.add(classelement['name'].toString());
              classe.add(
                  ClassModel(
                    id: classelement['id'],
                    name: classelement['name'],
                    startsat: classelement['startsat'],
                    timesaweek: classelement['timesaweek'],
                    coachid: classelement['coachid'],
                    coachname: classelement['coachname'],
                    daysandtimeandlength: classelement['daysandtimeandlength'],
                    imgurl: classelement['imgurl'],
                  )
              );
              days.add(classelement['daysandtimeandlength']);
              classs.add(classelement['name']);
            });
            int id = 0;
            int i = 0;
            days.forEach((day){
              if(day.split("|")[1].length == 0){
                daysonly.add(day.split("|")[0]);
              }else{
                daysonly.addAll(day.split("|"));
              }
              for(int j = i;j<daysonly.length;j++){
                shortcutslist.add(new ExtendedClassModel(
                    id: classe[id].id,
                    name: classe[id].name,
                    startsat: classe[id].startsat,
                    timesaweek: classe[id].timesaweek,
                    coachid: classe[id].coachid,
                    coachname: classe[id].coachname,
                    daysandtimeandlength: classe[id].daysandtimeandlength,
                    dayofweek: daysonly[i].split("-")[0],
                    from: daysonly[i].split("-")[1].substring(0,7),
                    to: daysonly[i].split("-")[1].substring(14,21)
                )
                );
                clsonly.add(classs[id]);
                dayofweekonly.add(daysonly[i].split("-")[0]);
                dayofweekonly2.add(daysonly[i].split("-")[1].substring(0,7));
                lenonly.add(daysonly[i].split("-")[1].substring(14,21));
                i ++;
              }
              id ++;
            });

            //int i = 0;
            // classe.forEach((element) {
            //   clas.add((i,element.name,element.timesaweek));
            //   days = element.daysandtimeandlength.split('|');
            //   i++;
            // });
            //
            // days.forEach((element) {
            //   daysofweek.add(element.split('-')[0]);
            // });

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        height: 45.h,
                        width: 160.w,
                        decoration: BoxDecoration(
                          color: lightyellow,
                          border: Border.all(color: Colors.grey, width: 1.w, ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12, right: 12),
                          child: DropdownButton<String>(
                              underline: Container(color: Colors.white,),
                              isExpanded: true,
                              items: List11.map<DropdownMenuItem<String>>(
                                      (String value)
                                  {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Center(
                                              child: Text(value,
                                                style: TextStyle(color: darkgrey, fontSize: 15.sp, fontWeight: FontWeight.bold),))),
                                    );
                                  }

                              ).toList(),
                              icon: Icon(Icons.arrow_drop_down, color: darkgrey,),

                              value: List1,
                              onChanged:(alinanVeri) {
                                if (alinanVeri! == "Choose Class") {
                                  _searchval.clear();
                                  allprods.clear();
                                  fldays.clear();
                                  flclasss.clear();
                                  fldaysonly.clear();
                                  fldayofweekonly.clear();
                                  fldayofweekonly2.clear();
                                  flclsonly.clear();
                                  fllenonly.clear();
                                  List2 = "Days";
                                }else{
                                  List2 = "Days";
                                  _searchval.clear();
                                  allprods.clear();
                                  fldays.clear();
                                  flclasss.clear();
                                  fldaysonly.clear();
                                  fldayofweekonly.clear();
                                  fldayofweekonly2.clear();
                                  flclsonly.clear();
                                  fllenonly.clear();
                                  shortcutslist.forEach((service) {
                                    if (service.name.toLowerCase().contains(alinanVeri!.toLowerCase())){
                                      allprods.add(service);
                                      _searchval.add(service);
                                      fldays.add(service.daysandtimeandlength);
                                      flclasss.add(service.name);
                                    }
                                  });
                                  int i = 0;
                                  int id = 0;
                                  fldays.forEach((day){
                                    if(day.split("|")[1].length == 0){
                                      fldaysonly.add(day.split("|")[0]);
                                    }else{
                                      fldaysonly.addAll(day.split("|"));
                                    }
                                    for(int j = i;j<fldaysonly.length;j++){
                                      flclsonly.add(flclasss[id]);
                                      fldayofweekonly.add(fldaysonly[i].split("-")[0]);
                                      fldayofweekonly2.add(fldaysonly[i].split("-")[1].substring(0,7));
                                      fllenonly.add(fldaysonly[i].split("-")[1].substring(14,21));
                                      i ++;
                                    }
                                    id ++;
                                  });
                                }
                                setState(() {
                                  List1 = alinanVeri!;
                                });
                              }
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        height: 45.h,
                        width: 160.w,
                        decoration: BoxDecoration(
                          color: lightyellow,
                          border: Border.all(color: Colors.grey, width: 1.w, ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12, right: 12),
                          child: Center(
                            child: DropdownButton<String>(
                                underline: Container(color: Colors.white,),
                                isExpanded: true,
                                items: List22.map<DropdownMenuItem<String>>(
                                        (String value)
                                    {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Center(
                                                child: Text(value,
                                                  style: TextStyle(color: darkgrey, fontSize: 15.sp, fontWeight: FontWeight.bold),))),
                                      );
                                    }

                                ).toList(),
                                icon: Icon(Icons.arrow_drop_down, color: darkgrey,),

                                value: List2,
                                onChanged:(alinanVeri) {
                                  if (alinanVeri! == "Days") {
                                    List1 = "Choose Class";
                                    _searchval.clear();
                                    allprods.clear();
                                  }else{
                                    List1 = "Choose Class";
                                    _searchval.clear();
                                    allprods.clear();
                                    shortcutslist.forEach((service) {
                                      if (service.dayofweek.toLowerCase().contains(alinanVeri.toLowerCase())){
                                        allprods.add(service);
                                        _searchval.add(service);
                                      }
                                    });

                                  }
                                  setState(() {
                                    List2 = alinanVeri!;
                                  });
                                }
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40.h,),
                Text('Schedule',
                  style: TextStyle(color: lightyellow, fontSize: 25.sp, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: _searchval.length != 0?
                  ListView.builder(
                      itemCount: _searchval.length,
                      itemBuilder: (context, index) {
                        final cls = allprods[index];
                        return Card(
                          color: Color(0xFF333333),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 7,
                          margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Text(
                                  cls.dayofweek,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15.sp),
                                ),
                                SizedBox(height: 5.h,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      cls.from,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 14.sp),
                                    ),
                                    SizedBox(width: 2.h,),
                                    Icon(Icons.arrow_forward_ios, color: lightyellow, size: 18,),
                                    SizedBox(width: 2.h,),
                                    Text(
                                      cls.to,
                                      style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 14.sp),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 25.h,),
                                Row(
                                  children: [
                                    Text('Coach: ',
                                      style: TextStyle(color: lightyellow, fontWeight: FontWeight.bold,fontSize: 16.sp),
                                    ),
                                    Text(cls.coachname,
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 14.sp),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.h,),
                                Row(
                                  children: [
                                    Text('Class: ',
                                      style: TextStyle(color: lightyellow, fontWeight: FontWeight.bold,fontSize: 16.sp),
                                    ),
                                    Text(cls.name,
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 14.sp),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.h,),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: (){
                                          showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                content: Container(
                                                  height: 150.h,
                                                  width: 350.w,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text('You want to book with this Coach ?',
                                                        style: TextStyle(fontWeight: FontWeight.bold, color: darkgrey),
                                                      ),
                                                      SizedBox(height: 30.h,),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          InkWell(
                                                            child: Container(
                                                              height: 30.h,
                                                              width: 100.w,
                                                              decoration: BoxDecoration(
                                                                border: Border.all(color: lightyellow),
                                                                borderRadius: BorderRadius.circular(25),
                                                              ),
                                                              child: Center(child: Text('Cancel', style: TextStyle(color: darkgrey, fontWeight: FontWeight.bold),)),
                                                            ),
                                                            onTap: () {
                                                              Navigator.pop(context);
                                                            },
                                                          ),
                                                          InkWell(
                                                            child: Container(
                                                              height: 30.h,
                                                              width: 100.w,
                                                              decoration: BoxDecoration(
                                                                color: lightyellow,
                                                                border: Border.all(color: lightyellow),
                                                                borderRadius: BorderRadius.circular(25),
                                                              ),
                                                              child: Center(child: Text('Book', style: TextStyle(color: darkgrey, fontWeight: FontWeight.bold),)),
                                                            ),
                                                            onTap: () async{
                                                              await BackendService().bookitem(cls);
                                                              final snackBar = SnackBar(
                                                                duration: Duration(milliseconds: 1500,),
                                                                elevation: 0,
                                                                behavior: SnackBarBehavior.floating,
                                                                backgroundColor: Colors.transparent,
                                                                content: AwesomeSnackbarContent(
                                                                  title: 'Success',
                                                                  message: 'Booked Successfully',
                                                                  contentType: ContentType.success,
                                                                ),
                                                              );
                                                              ScaffoldMessenger.of(context)
                                                                ..hideCurrentSnackBar()
                                                                ..showSnackBar(snackBar);
                                                              Navigator.pop(context);
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                          );
                                        },
                                        child: Container(
                                          width: 100.w,
                                          height: 30.h,
                                          decoration: BoxDecoration(
                                            color: lightyellow,
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text('Book',
                                                style: TextStyle(color: darkgrey, fontSize: 15.sp,fontWeight: FontWeight.bold),
                                              ),
                                              SizedBox(width: 5.w,),
                                              Icon(Icons.calendar_month_outlined, color: darkgrey, size: 22,),
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
                  ):
                  ListView.builder(
                      itemCount: daysonly.length,
                      itemBuilder: (context, index) {
                        final cls = shortcutslist[index];
                        return Card(
                          color: Color(0xFF333333),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 7,
                          margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Text(
                                  dayofweekonly[index],
                                  textAlign: TextAlign.start,
                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15.sp),
                                ),
                                SizedBox(height: 5.h,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      dayofweekonly2[index],
                                      textAlign: TextAlign.start,
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 14.sp),
                                    ),
                                    SizedBox(width: 2.h,),
                                    Icon(Icons.arrow_forward_ios, color: lightyellow, size: 18,),
                                    SizedBox(width: 2.h,),
                                    Text(
                                      lenonly[index],
                                      style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 14.sp),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 25.h,),
                                Row(
                                  children: [
                                    Text('Coach: ',
                                      style: TextStyle(color: lightyellow, fontWeight: FontWeight.bold,fontSize: 16.sp),
                                    ),
                                    Text(cls.coachname,
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 14.sp),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.h,),
                                Row(
                                  children: [
                                    Text('Class: ',
                                      style: TextStyle(color: lightyellow, fontWeight: FontWeight.bold,fontSize: 16.sp),
                                    ),
                                    Text(cls.name,
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 14.sp),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.h,),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: (){
                                          showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                content: Container(
                                                  height: 150.h,
                                                  width: 350.w,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text('You want to book this Class ?',
                                                        style: TextStyle(fontWeight: FontWeight.bold, color: darkgrey),
                                                      ),
                                                      SizedBox(height: 30.h,),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          InkWell(
                                                            child: Container(
                                                              height: 30.h,
                                                              width: 100.w,
                                                              decoration: BoxDecoration(
                                                                border: Border.all(color: lightyellow),
                                                                borderRadius: BorderRadius.circular(25),
                                                              ),
                                                              child: Center(child: Text('Cancel', style: TextStyle(color: darkgrey, fontWeight: FontWeight.bold),)),
                                                            ),
                                                            onTap: () {
                                                              Navigator.pop(context);
                                                            },
                                                          ),
                                                          InkWell(
                                                            child: Container(
                                                              height: 30.h,
                                                              width: 100.w,
                                                              decoration: BoxDecoration(
                                                                color: lightyellow,
                                                                border: Border.all(color: lightyellow),
                                                                borderRadius: BorderRadius.circular(25),
                                                              ),
                                                              child: Center(child: Text('Book', style: TextStyle(color: darkgrey, fontWeight: FontWeight.bold),)),
                                                            ),
                                                            onTap: () async{
                                                              await BackendService().bookitem(cls);
                                                              final snackBar = SnackBar(
                                                                duration: Duration(milliseconds: 1500,),
                                                                elevation: 0,
                                                                behavior: SnackBarBehavior.floating,
                                                                backgroundColor: Colors.transparent,
                                                                content: AwesomeSnackbarContent(
                                                                  title: 'Success',
                                                                  message: 'Booked Successfully',
                                                                  contentType: ContentType.success,
                                                                ),
                                                              );
                                                              ScaffoldMessenger.of(context)
                                                                ..hideCurrentSnackBar()
                                                                ..showSnackBar(snackBar);
                                                              Navigator.pop(context);
                                                              },
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ));
                                        },
                                        child: Container(
                                          width: 100.w,
                                          height: 30.h,
                                          decoration: BoxDecoration(
                                            color: lightyellow,
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text('Book',
                                                style: TextStyle(color: darkgrey, fontSize: 15.sp,fontWeight: FontWeight.bold),
                                              ),
                                              SizedBox(width: 5.w,),
                                              Icon(Icons.calendar_month_outlined, color: darkgrey, size: 22,),
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
                  ),
                ),
              ],
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
      appBar: AppBar(
        backgroundColor: darkgrey,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  height: 40.h,
                  width: 130.w,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.w, ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    child: DropdownButton<String>(
                        underline: Container(color: Colors.white,),
                        isExpanded: true,
                        items: List11.map<DropdownMenuItem<String>>(
                                (String value)
                            {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Center(
                                        child: Text(value,
                                          style: TextStyle(color: lightyellow, fontSize: 15.sp),))),
                              );
                            }

                        ).toList(),
                        icon: Icon(Icons.arrow_drop_down),

                        value: List1,
                        onChanged:(alinanVeri) {}
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 18.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: (){
                  showCupertinoModalPopup(
                    context: context,
                    builder: (BuildContext context) => SizedBox(
                      height: 250.h,
                      child: CupertinoDatePicker(
                        backgroundColor: Colors.white,
                        initialDateTime: dateTime,
                        onDateTimeChanged: (DateTime newTime) {
                          setState(() => dateTime = newTime);
                        },
                        use24hFormat: true,
                        mode: CupertinoDatePickerMode.date,
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 140.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: lightyellow,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Calendar',
                        style: TextStyle(color: darkgrey, fontSize: 15.sp,fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.calendar_month_outlined, color: darkgrey,),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 50.h,),
          Text('Schedule',
            style: TextStyle(color: lightyellow, fontSize: 25.sp, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 15,
                itemBuilder: (context, index) {
                  return Card(
                    color: Color(0xFF333333),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 7,
                    margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '2:00 PM',
                                textAlign: TextAlign.start,
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 15.sp),
                              ),
                              SizedBox(width: 2.h,),
                              Icon(Icons.arrow_forward_ios, color: lightyellow,),
                              SizedBox(width: 2.h,),
                              Text(
                                '4:00 PM',
                                style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 15.sp),
                              ),
                            ],
                          ),
                          SizedBox(height: 25.h,),
                          Row(
                            children: [
                              Text('Name: ',
                                style: TextStyle(color: lightyellow, fontWeight: FontWeight.bold,fontSize: 16.sp),
                              ),
                              Text('Adham Eldeibany',
                                style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold,fontSize: 14.sp),
                              ),
                              SizedBox(width: 12.w,),
                            ],
                          ),
                          SizedBox(height: 20.h,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: (){},
                                  child: Container(
                                    width: 100.w,
                                    height: 30.h,
                                    decoration: BoxDecoration(
                                      color: lightyellow,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('Book',
                                          style: TextStyle(color: darkgrey, fontSize: 15.sp,fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(width: 5.w,),
                                        Icon(Icons.calendar_month_outlined, color: darkgrey, size: 22,),
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
            ),
          ),
        ],
      ),
    );
  }
}
