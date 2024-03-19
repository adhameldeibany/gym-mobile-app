import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flockergym/Methods/AuthMethods/AuthMethods.dart';
import 'package:flockergym/Methods/colors_methods.dart';
import 'package:flockergym/NewBackend/ClassesBack/ClassesMethods.dart';
import 'package:flockergym/NewBackend/MainMethods.dart';
import 'package:flockergym/NewBackend/Models/ClassModel.dart';
import 'package:flockergym/NewBackend/Models/OfferModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

late ClassModel Class;
offermodel? offerm= null;
late List<String> days;
late List<String> from;
late List<String> to;
class OfferScreen extends StatefulWidget {
  OfferScreen({required ClassModel classModel}){
    Class = classModel;
    int i = 0;
    List<String> daysonly = [];
    days = [];
    from = [];
    to = [];
    if(Class.daysandtimeandlength.split("|")[1].length == 0){
      daysonly.add(Class.daysandtimeandlength.split("|")[0]);
    }else{
      daysonly.addAll(Class.daysandtimeandlength.split("|"));
    }
    for(int j = i;j<daysonly.length;j++){
      days.add(daysonly[i].split("-")[0]);
      from.add(daysonly[i].split("-")[1].substring(0,7));
      to.add(daysonly[i].split("-")[1].substring(14,21));
      i ++;
    }
  }
  @override
  State<OfferScreen> createState() => _OfferScreenState();
}
bool a = false;
bool s = false;
bool d = false;

class _OfferScreenState extends State<OfferScreen> {

  Scaffold MakeStream(BuildContext Screencontext){
    List<offermodel> offers = [];
    FirebaseFirestore db = FirebaseFirestore.instance;

    return Scaffold(
      body: StreamBuilder(
        stream: db.collection("classesdetails").doc("classes")
            .collection(Class.id).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            final items = snapshot.data?.docs;
            offers.clear();
            for (var docSnapshot in items!) {
              final data = docSnapshot.data();
              offermodel offer = new offermodel(
                id: data['id'],
                name: data['name'],
                price: data['price'],
                recommended: data['recommended'],
              );
              print(offer.name);
              offers.add(offer);
            }

            return Scaffold(
              backgroundColor: Colors.black,
              body: SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(Screencontext).size.width,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/offerr.png')
                            )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: SizedBox(
                                width: 200.w,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(Class.name,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontFamily: "Aquire",
                                        fontSize: 30.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 5.h,),
                                    Text(Class.name,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontFamily: "Aquire",
                                        fontSize: 30.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 5.h,),
                                    Text(Class.name,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontFamily: "Aquire",
                                        fontSize: 30.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 45.w,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: (){
                                    Screencontext.go("/Class/Detailsclass");
                                  },
                                  child: Image(
                                    image: AssetImage("assets/close.png"),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h,),
                      Text('Select plan',
                        style: TextStyle(color: Colors.white, fontSize: 25.sp, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 20.h,),
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:offers.length,
                          itemBuilder: (context,index){
                            final offer = offers[index];
                            return Column(
                              children: [
                                InkWell(
                                  onTap: (){
                                    if (index == 0) {
                                      setState(() {
                                        if (s == false) {
                                        offerm = offer;
                                          s = true;
                                          a = false;
                                          d = false;
                                        } else if (s == true) {
                                          s = false;
                                          offerm = null;
                                        }
                                      });
                                    }else if(index == 1){
                                      setState(() {
                                        if (a == false) {
                                          offerm = offer;
                                          a = true;
                                          s = false;
                                          d = false;
                                        } else if (a == true) {
                                          offerm = null;
                                          a = false;
                                        }
                                      });
                                    }else{
                                      setState(() {
                                        if (d == false) {
                                          d = true;
                                          a = false;
                                          s = false;
                                          offerm = offer;
                                        } else if (d == true) {
                                          d = false;
                                          offerm = null;
                                        }
                                      });
                                    }
                                  },
                                  child: Container(
                                    width: 320.w,
                                    height: 120.h,
                                    decoration: BoxDecoration(
                                        color: silverdark,
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(color: index==0?s ? lightyellow : silverdark:index==1?a ? lightyellow : silverdark:d ? lightyellow : silverdark, width: 2.w)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(offer.name,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(fontWeight: FontWeight.bold, color: s ? Colors.white : Colors.white, fontSize: 18.sp),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right: 15),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                offer.recommended == "yes"?Container(
                                                  width: 140.w,
                                                  height: 25.h,
                                                  decoration: BoxDecoration(
                                                      color: s ? lightyellow : lightyellow,
                                                      borderRadius: BorderRadius.circular(20)
                                                  ),
                                                  child: Center(
                                                    child: Text('Recommended',
                                                      textAlign: TextAlign.start,
                                                      style: TextStyle(fontWeight: FontWeight.bold, color: s ? darkgrey : darkgrey, fontSize: 15.sp),
                                                    ),
                                                  ),
                                                ):SizedBox(height: 0,width: 0,),
                                                SizedBox(height: 5.h,),
                                                Row(
                                                  children: [
                                                    Text(offer.price+' EGP',
                                                      textAlign: TextAlign.start,
                                                      style: TextStyle(fontWeight: FontWeight.bold, color: s ? Colors.white : Colors.white, fontSize: 15.sp),
                                                    ),
                                                  ],
                                                ),
                                                Text('per month',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(fontWeight: FontWeight.bold, color: s ? Colors.grey : Colors.grey, fontSize: 11.sp),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15.h,),
                              ],
                            );
                          }),
                      InkWell(
                        onTap: () async {
                          if (offerm == null) {
                            final snackBar = SnackBar(
                              duration: Duration(milliseconds: 1500,),
                              elevation: 0,
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.transparent,
                              content: AwesomeSnackbarContent(
                                title: 'Wrong',
                                message: 'Please Choose An Option',
                                contentType: ContentType.failure,
                              ),
                            );
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(snackBar);
                            return;
                          }else{
                            print(offerm!.name.toLowerCase().split(" sessions")[0]);
                            if(await AuthService().checkIfDocExists(Class.id,
                                FirebaseAuth.instance.currentUser!.uid.toString())){
                              final docRef = db.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid.toString())
                                  .collection("classes").doc(Class.id);
                              docRef.get().then(
                                    (DocumentSnapshot doc) async {
                                    final userclasses = {
                                      "uid": FirebaseAuth.instance.currentUser!.uid.toString(),
                                    };
                                    final data = doc.data() as Map<String, dynamic>;
                                    int r = int.parse(data["remain"].toString());
                                    int t = int.parse(data["total"].toString());
                                    final classes = {
                                      "id": Class.id,
                                      "name": offerm!.name,
                                      "coachname": Class.coachname,
                                      "remain": (r + int.parse(offerm!.name.toLowerCase().split(" sessions")[0])).toString(),
                                      "total" : (t + int.parse(offerm!.name.toLowerCase().split(" sessions")[0])).toString(),
                                      "status":"pending",
                                      "classname":Class.name,
                                      "started":DateFormat('dd-MM-yyyy').format(DateTime.now()),
                                      "finished": DateFormat('dd-MM-yyyy').format(DateTime.now().add(Duration(days: 30)))
                                    };

                                    await db.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid.toString())
                                        .set(userclasses).onError((error, stackTrace) => print("Error"));

                                    await db.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid.toString())
                                        .collection("classes").doc(Class.id).set(classes).onError((error, stackTrace) => print("Error"));

                                    for(int i = 0; i< days.length;i++){
                                      final day = {
                                        "id":Class.id+"day"+(i+1).toString(),
                                        "day":days[i],
                                        "from":from[i],
                                        "to":to[i],
                                        "classid":Class.id
                                      };
                                      await db.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid.toString())
                                          .collection("days").doc(Class.id+"day"+(i+1).toString()).set(day)
                                          .onError((error, stackTrace) => print("Error"));

                                    }

                                    final snackBar = SnackBar(
                                      duration: Duration(milliseconds: 1500,),
                                      elevation: 0,
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.transparent,
                                      content: AwesomeSnackbarContent(
                                        title: 'Success',
                                        message: 'Session Booked Waiting For Approve',
                                        contentType: ContentType.success,
                                      ),
                                    );
                                    ScaffoldMessenger.of(context)
                                      ..hideCurrentSnackBar()
                                      ..showSnackBar(snackBar);
                                    Navigator.pop(Screencontext);
                                    },
                                onError: (e) => print("Error getting document: $e"),
                              );
                            }
                            else{
                              final userclasses = {
                                "uid": FirebaseAuth.instance.currentUser!.uid.toString(),
                              };
                              final classes = {
                                "id": Class.id,
                                "name": offerm!.name,
                                "coachname": Class.coachname,
                                "remain": offerm!.name.toLowerCase().split(" sessions")[0],
                                "total" : offerm!.name.toLowerCase().split(" sessions")[0],
                                "status":"pending",
                                "classname":Class.name,
                                "started":DateFormat('dd-MM-yyyy').format(DateTime.now()),
                                "finished": DateFormat('dd-MM-yyyy').format(DateTime.now().add(Duration(days: 30)))
                              };
                              await db.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid.toString())
                                  .set(userclasses).onError((error, stackTrace) => print("Error"));

                              await db.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid.toString())
                                  .collection("classes").doc(Class.id).set(classes).onError((error, stackTrace) => print("Error"));

                              for(int i = 0; i< days.length;i++){
                                final day = {
                                  "id":Class.id+"day"+(i+1).toString(),
                                  "day":days[i],
                                  "from":from[i],
                                  "to":to[i],
                                  "classid":Class.id

                                };
                                await db.collection("usersclasses").doc(FirebaseAuth.instance.currentUser!.uid.toString())
                                    .collection("days").doc(Class.id+"day"+(i+1).toString()).set(day)
                                    .onError((error, stackTrace) => print("Error"));

                              }

                              final snackBar = SnackBar(
                                    duration: Duration(milliseconds: 1500,),
                                    elevation: 0,
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.transparent,
                                    content: AwesomeSnackbarContent(
                                      title: 'Success',
                                      message: 'Session Booked Waiting For Approve',
                                      contentType: ContentType.success,
                                    ),
                                  );
                                  ScaffoldMessenger.of(context)
                                    ..hideCurrentSnackBar()
                                    ..showSnackBar(snackBar);
                              Navigator.pop(Screencontext);
                            }
                          }

                        },
                        child: Container(
                          width: 310.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                              color: lightyellow,
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: Center(child: Text('Confirm plan', style: TextStyle(fontSize: 20.sp),)),
                        ),
                      ),
                      SizedBox(height: 20.h,),
                    ],
                  ),
                ),
              ),
            );
          }
          else{
            return LoadingScreen();
          }
        },),
    );

  }

  @override
  Widget build(BuildContext context) {
    return MakeStream(context);
  }
}
