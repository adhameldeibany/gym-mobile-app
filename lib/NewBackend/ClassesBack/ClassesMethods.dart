import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flockergym/Methods/colors_methods.dart';
import 'package:flockergym/NewBackend/MainMethods.dart';
import 'package:flockergym/NewBackend/Models/ClassModel.dart';
import 'package:flockergym/NewBackend/Models/OfferModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ClassesMethods extends MainMethods{

  late List<ClassModel> classe;
  DatabaseReference ref = FirebaseDatabase.instance.ref("classes/");

  late String imgs;

  Scaffold MainScreen(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text("Classes",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 25.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: InkWell(
              onTap: (){
                context.go('/home/Profile');
              },
              child: Container(
                width: 40.w,
                height: 60.h,
                decoration: BoxDecoration(
                  color: darkgrey,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(imgs),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 40.h,),
              Image(image: AssetImage('assets/box.png')),
              SizedBox(height: 25.h,),
              Text('No scheduled classes yet?',
                style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 70.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Explore', style: TextStyle(color: lightyellow, fontSize: 20.sp, fontWeight: FontWeight.bold),),
                  Text(' now our classes', style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.bold),),
                ],
              ),
              SizedBox(height: 12.h,),
              Text('Check all the classes and book the \nbest bundle with you',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 12.sp),
              ),
              SizedBox(height: 20.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (){},
                    child: Container(
                      width: 80.w,
                      height: 80.h,
                      decoration: BoxDecoration(
                          color: silverdark,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 50.w,
                                      child: AutoSizeText('Yoga',
                                        maxLines: 1,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10.sp,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500,
                                          height: 0,
                                          letterSpacing: -0.11,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Image(
                                  width: 26.26.w,
                                  height: 40.h,
                                  image: AssetImage("assets/yoga.png"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20.w,),
                  InkWell(
                    onTap: (){},
                    child: Container(
                      width: 80.w,
                      height: 80.h,
                      decoration: BoxDecoration(
                          color: silverdark,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 50.w,
                                      child: AutoSizeText('Boxing',
                                        maxLines: 1,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10.sp,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500,
                                          height: 0,
                                          letterSpacing: -0.11,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Image(
                                  width: 26.26.w,
                                  height: 40.h,
                                  image: AssetImage("assets/boxing.png"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h,),
              InkWell(
                onTap: (){
                  context.go("/Class/Detailsclass");
                },
                child: Container(
                  width: 150.w,
                  height: 45.h,
                  decoration: BoxDecoration(
                      color: lightyellow,
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Center(child: Text('Explore', style: TextStyle(fontSize: 20.sp),)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Scaffold MakeStream(BuildContext Screencontext, String Extra){
    if (Extra == "Classes") {
      classe = [];
      late String imgurl;
      classe.clear();
      DatabaseReference ref2 = FirebaseDatabase.instance.ref('members/${FirebaseAuth.instance.currentUser!.uid.toString()}');
      ref2.onValue.listen((event) {
        imgurl = event.snapshot.child("imgurl").value.toString();
      });
      return Scaffold(
        body: StreamBuilder(
          stream: ref.onValue,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null && (snapshot.data! as DatabaseEvent).snapshot.value != null) {
              final classes = Map<dynamic, dynamic>.from((snapshot.data! as DatabaseEvent).snapshot.value as Map<dynamic, dynamic>); //typecasting
              classes.forEach((key, value) {
                final classelement = Map<String, dynamic>.from(value);
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
              });
              return Scaffold(
                backgroundColor: Colors.black,
                appBar: AppBar(
                  backgroundColor: Colors.black,
                  elevation: 0,
                  leading: BackButton(
                    color: Colors.white,
                  ),
                  title: Text("Classes",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: EdgeInsets.only(right: 12),
                      child: InkWell(
                        onTap: (){
                          context.go('/home/Profile');
                        },
                        child: Container(
                          width: 40.w,
                          height: 60.h,
                          decoration: BoxDecoration(
                            color: darkgrey,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(imgurl),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                body: Column(
                  children: [
                    SizedBox(height: 20.h,),
                    Center(
                      child: Container(
                        height: 45,
                        width: 320,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: silverdark,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search',
                              hintStyle: TextStyle(color: Colors.grey),
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h,),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 5,
                              mainAxisExtent: 310.h,
                            ),
                            itemCount: classe.length,
                            itemBuilder: (_,index){
                              final cls = classe[index];
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      context.go("/Class/offer",extra: cls);
                                    },
                                    child: Card(
                                      elevation: 7,
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 10, top: 10),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 100.w,
                                                  child: Text(cls.name,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18.sp),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 100.h,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                SizedBox(
                                                  height:120.h,
                                                  width: 141.w,
                                                  child: Image(
                                                    image: NetworkImage(cls.imgurl),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            else{
              return LoadingScreen();
            }
        }),
      );
    }
    else if(Extra == "Main"){
      DatabaseReference ref2 = FirebaseDatabase.instance.ref('members/${FirebaseAuth.instance.currentUser!.uid.toString()}');
      return Scaffold(
        body: StreamBuilder(
          stream: ref2.onValue,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null && (snapshot.data! as DatabaseEvent).snapshot.value != null) {
              imgs = snapshot.data!.snapshot.child("imgurl").value.toString();
              return MainScreen(context);
            }else{
              return LoadingScreen();
            }

        },
        ),
      );
    }
    else if(Extra.contains("offer")){
      bool a = false;
      bool s = false;
      bool d = false;
      List<offermodel> offers = [];
      FirebaseFirestore db = FirebaseFirestore.instance;

      return Scaffold(
        body: StreamBuilder(
          stream: db.collection("classesdetails").doc("classes")
              .collection(Extra.split("offer")[1].split("name")[0].toString()).snapshots(),
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
                                    Text(Extra.split("offer")[1].split("name")[1].toString(),
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontFamily: "Aquire",
                                        fontSize: 30.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 5.h,),
                                    Text(Extra.split("offer")[1].split("name")[1].toString(),
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontFamily: "Aquire",
                                        fontSize: 30.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 5.h,),
                                    Text(Extra.split("offer")[1].split("name")[1].toString(),
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
                                    if (s == false) {
                                      print(index);
                                      s = true;
                                      a = false;
                                      d = false;
                                    } else if (s == true) {
                                      s = false;
                                    }
                                  },
                                  child: Container(
                                    width: 320.w,
                                    height: 120.h,
                                    decoration: BoxDecoration(
                                        color: silverdark,
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(color: s ? lightyellow : silverdark, width: 2.w)
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
                        onTap: (){
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
    else{
      return LoadingScreen();
    }
  }

  Scaffold start(String Extra, BuildContext context){
    return MakeStream(context, Extra);
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

}