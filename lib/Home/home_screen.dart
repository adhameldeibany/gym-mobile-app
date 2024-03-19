import 'dart:typed_data';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flockergym/HomePolicyScreen/HomePivacyScreen.dart';
import 'package:flockergym/Methods/colors_methods.dart';
import 'package:flockergym/NewBackend/DataCollectionBack/DataCollectionMethods.dart';
import 'package:flockergym/NewBackend/MainMethods.dart';
import 'package:flockergym/NewBackend/Models/HeroAdModel.dart';
import 'package:flockergym/NewBackend/Models/MemberModel.dart';
import 'package:flockergym/NewBackend/Models/ShortCutsModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

List<ShortcutModel> shortcutslist = [];
List<ShortcutModel> allprods = [];
late Uri uri;

StatefulNavigationShell? Navi;
late MemberModel memberModel;
TextEditingController controller = new TextEditingController();
List<ShortcutModel> searchval = [];


class HomeScreen extends StatefulWidget {
  HomeScreenWithApi(StatefulNavigationShell navigationShell){
    Navi = navigationShell!;
  }

  @override
  State<HomeScreen> createState() => HomeScreenState();
}


class HomeScreenState extends State<HomeScreen> {
  DatabaseReference ref = FirebaseDatabase.instance.ref('heroad/');
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Uint8List? image;

  Scaffold DataScreen(String imgurl, HeroAdModel hero, BuildContext Screencontext, String name){
    return Scaffold(
      backgroundColor: Colors.black,
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text("Olympic Gym",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontFamily: "Aquire",
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: lightyellow,
          ),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8, top: 8),
          child: Container(
            width: 35.w,
            height: 35.h,
            decoration: BoxDecoration(
                color: silverdark,
                shape: BoxShape.circle
            ),
            child: IconButton(
              onPressed: () => _scaffoldKey.currentState?.openDrawer(),
              icon: Icon(Icons.menu, color: Colors.white, size: 30,),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: InkWell(
              onTap: (){
                Screencontext.go('/home/Profile');
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
          // Padding(
          //   padding: const EdgeInsets.only(right: 12),
          //   child: IconButton(
          //       onPressed: (){
          //         context.go('/home/Profile');
          //       },
          //       icon: Icon(Icons.notifications_active_outlined, color: darkgrey, size: 35,),
          //   ),
          // )
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.black,
        width: 258.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30.h,),
            Container(
              width: 100.w,
              height: 130.h,
              decoration: image != null?
              BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: MemoryImage(image!),
                  )
              ):BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(imgurl),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 120.w,
                  child: AutoSizeText(name,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0,
                      letterSpacing: 0.12,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
                width: 200.w,
                child: Divider(color: silverdark,)),
            SizedBox(height: 10.h,),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.person, color: Colors.white,),
                      TextButton(
                          onPressed: (){
                            Screencontext.go('/home/Profile');
                          },
                          child: Text('Account',
                            style: TextStyle(fontSize: 14.sp, color: Colors.white, fontWeight: FontWeight.bold),
                          )
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.policy, color: Colors.white,),
                      TextButton(
                          onPressed: (){
                            Get.to(HomePolicyScreen());
                          },
                          child: Text('Policy & privacy',
                            style: TextStyle(fontSize: 14.sp, color: Colors.white, fontWeight: FontWeight.bold),
                          )
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.h,),
            Center(
              child: Container(
                height: 50.h,
                width: 320.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: silverdark,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Center(
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: controller,
                      onChanged: onSearchTextChanged,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 8.h),
                        border: InputBorder.none,
                        hintText: 'Search',
                        hintStyle: TextStyle(color: Colors.grey),
                        labelStyle: TextStyle(color: lightyellow),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h,),
            Card(
              color: silverdark,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(hero.main1.replaceAll("\\n", "\n"),
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(hero.main2.replaceAll("\\n", "\n"),
                          style: TextStyle(color: lightyellow, fontSize: 25.sp, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 100.w,
                          child: Text(hero.main3.replaceAll("\\n", "\n"),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        InkWell(
                          onTap: (){
                            Screencontext.goNamed(hero.action);
                          },
                          child: Container(
                            width: 120.w,
                            height: 30.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: lightyellow,
                            ),
                            child: Center(
                              child: Text(hero.msg,
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: 120.h,
                          width: 120.w,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(10)),
                            child: Image(
                              image: NetworkImage(hero.imgurl),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h,),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: searchval.length != 0 || controller.text.isNotEmpty?GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 2,
                    mainAxisExtent: 115.h,
                  ),
                  itemCount: searchval.length,
                  itemBuilder: (_,index){
                    final shortcut = searchval[index];
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: (){
                                Screencontext.go(shortcut.page);
                              },
                              child: Container(
                                width: 157.w,
                                height: 100.h,
                                decoration: BoxDecoration(
                                  color: Color(0xFF191919),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 12),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            shortcut.icon,
                                          ],
                                        ),
                                        SizedBox(height: 10.h,),
                                        Row(
                                          children: [
                                            Text(shortcut.name,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16.sp),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }):GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 2,
                    mainAxisExtent: 115.h,
                  ),
                  itemCount: shortcutslist.length,
                  itemBuilder: (_,index){
                    final shortcut = shortcutslist[index];
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: (){
                                Screencontext.go(shortcut.page);
                              },
                              child: Container(
                                width: 157.w,
                                height: 100.h,
                                decoration: BoxDecoration(
                                  color: Color(0xFF191919),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            shortcut.icon,
                                          ],
                                        ),
                                        SizedBox(height: 10.h,),
                                        Row(
                                          children: [
                                            Text(shortcut.name,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16.sp,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w600,
                                                height: 0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Scaffold MakeStream(BuildContext Screencontext, String Extra) {
    late String imgurl;
    late String name;
    DatabaseReference ref2 = FirebaseDatabase.instance.ref('members/${FirebaseAuth.instance.currentUser!.uid.toString()}');

    return Scaffold(
      body: StreamBuilder(
        stream: ref2.onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null && (snapshot.data! as DatabaseEvent).snapshot.value != null) {
            imgurl = snapshot.data!.snapshot.child("imgurl").value.toString();
            name = snapshot.data!.snapshot.child("name").value.toString();
            DataCollectionMethods().savestringdata("imgurl", imgurl);
            return Scaffold(
              body: StreamBuilder(
                stream: ref.onValue,
                builder: (context, snapshot1) {
                  if (snapshot1.hasData && snapshot1.data != null && (snapshot1.data! as DatabaseEvent).snapshot.value != null) {
                    HeroAdModel hero = new HeroAdModel(
                      imgurl: snapshot1.data!.snapshot.child("imgurl").value.toString(),
                      main1: snapshot1.data!.snapshot.child("main1").value.toString(),
                      main2: snapshot1.data!.snapshot.child("main2").value.toString(),
                      main3: snapshot1.data!.snapshot.child("main3").value.toString(),
                      action: snapshot1.data!.snapshot.child("action").value.toString(),
                      msg: snapshot1.data!.snapshot.child("msg").value.toString(),
                    );
                    return DataScreen(imgurl, hero, Screencontext,name);
                  }else{
                    return LoadingScreen();
                  }
                },
              ),
            );

          }else{
            return LoadingScreen();
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    shortcutslist.clear();
    allprods.clear();
    shortcutslist.add(
      ShortcutModel(icon: Icon(Icons.qr_code_scanner, size: 24, color: lightyellow,), name: 'Check-In', page: '/home/Checkin'),
    );
    shortcutslist.add(
      ShortcutModel(icon: Icon(FontAwesomeIcons.calendarCheck, size: 24, color: lightyellow,), name: 'Invitations', page: '/home/Invitations'),
    );
    shortcutslist.add(
      ShortcutModel(icon: Icon(FontAwesomeIcons.addressCard, size: 24, color: lightyellow,), name: 'Subscription', page: '/home/Subscription'),
    );
    shortcutslist.add(
      ShortcutModel(icon: Icon(FontAwesomeIcons.rightToBracket, size: 24, color: lightyellow,), name: 'Book Class', page: '/Class'),
    );
    allprods.addAll(shortcutslist);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: MakeStream(context,""),
    );
  }

  onSearchTextChanged(String text) async {
    searchval.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    allprods.forEach((service) {
      if (service.name.toLowerCase().contains(text.toLowerCase()))
        searchval.add(service);
    });
    setState(() {
      controller.text = text;
    });
  }

}