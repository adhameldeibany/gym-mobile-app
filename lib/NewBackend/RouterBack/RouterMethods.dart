import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flockergym/Auth/signup2.dart';
import 'package:flockergym/Data%20collection%20screens/gender_screen.dart';
import 'package:flockergym/Data%20collection%20screens/name_screen.dart';
import 'package:flockergym/Home/newhome_screen.dart';
import 'package:flockergym/NewBackend/MainMethods.dart';
import 'package:flockergym/NewBackend/Models/MemberModel.dart';
import 'package:flockergym/Onboarding/onboarding.dart';
import 'package:flockergym/main.dart';
import 'package:flockergym/navigation/app_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RouterMethods extends MainMethods{
  late DatabaseReference ref;
  late bool where;
  @override
  Scaffold MakeStream(BuildContext DoneScreen, String Extra) {
    if (FirebaseAuth.instance.currentUser!= null) {
      DatabaseReference ref = FirebaseDatabase.instance.ref("members/${FirebaseAuth.instance.currentUser!.uid}/");
      Future<bool> exists = isExists(ref);
      return Scaffold(
        body: FutureBuilder(
            future: exists,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final exist = snapshot.data!;
                return StreamBuilder(
                    stream: ref.onValue,
                    builder: (context, snapshot) {
                      if (exist) {
                        if (snapshot.hasData && snapshot.data != null && (snapshot.data! as DatabaseEvent).snapshot.value !=  null) {
                          memberModel = MemberModel(
                              age: snapshot.data?.snapshot
                                  .child('age')
                                  .value
                                  .toString(),
                              createdat: snapshot.data?.snapshot
                                  .child('createdat')
                                  .value
                                  .toString(),
                              email: snapshot.data?.snapshot
                                  .child('email')
                                  .value
                                  .toString(),
                              endsAt: snapshot.data?.snapshot
                                  .child('endsAt')
                                  .value
                                  .toString(),
                              gender: snapshot.data?.snapshot
                                  .child('gender')
                                  .value
                                  .toString(),
                              height: snapshot.data?.snapshot
                                  .child('height')
                                  .value
                                  .toString(),
                              id: snapshot.data?.snapshot
                                  .child('id')
                                  .value
                                  .toString(),
                              imgurl: snapshot.data?.snapshot
                                  .child('imgurl')
                                  .value
                                  .toString(),
                              memberstatus: snapshot.data?.snapshot
                                  .child('memberstatus')
                                  .value
                                  .toString(),
                              mobile: snapshot.data?.snapshot
                                  .child('mobile')
                                  .value
                                  .toString(),
                              name: snapshot.data?.snapshot
                                  .child('name')
                                  .value
                                  .toString(),
                              password: snapshot.data?.snapshot
                                  .child('password')
                                  .value
                                  .toString(),
                              weight: snapshot.data?.snapshot
                                  .child('weight')
                                  .value
                                  .toString(),
                              uniq: snapshot.data?.snapshot
                                  .child('uniq')
                                  .value
                                  .toString(),
                              active: snapshot.data?.snapshot
                                  .child('active')
                                  .value
                                  .toString(),
                              goal: snapshot.data?.snapshot
                                  .child('goal')
                                  .value
                                  .toString(),
                            motivate: snapshot.data?.snapshot
                                  .child('motivate')
                                  .value
                                  .toString(),
                          );
                          if (memberModel.memberstatus  == "basic plan") {
                            return MaterialApp.router(
                              debugShowCheckedModeBanner: false,
                              routerConfig: AppNavigation.router,
                            );
                          }else{
                            return MaterialApp.router(
                              debugShowCheckedModeBanner: false,
                              routerConfig: AppNavigation.router,
                            );
                          }
                        }
                        else{
                          return LoadingScreen();
                        }
                      }else{
                        return readdata('issocial')!?NameScreen():GenderScreen();
                      }
                    },
                );
              }else if (snapshot.connectionState == ConnectionState.waiting) {
                return LoadingScreen();
              }
              else{
                return Scaffold(
                  backgroundColor: Colors.red,
                );
              }
            },),
      );
    }
    else{
      if(readdata('show')!){
        Get.off(Signup2());
        return Scaffold();
      }
      else {
        Get.off(OnboardingScreen());
        return Scaffold();
      }
    }
  }

  @override
  bool? readdata(String dataname) {
    if (prefs.getBool(dataname) == null) {
      return false;
    }  else{
      return prefs.getBool(dataname);
    }
  }

  Scaffold start(BuildContext context){
    return MakeStream(context, '');
  }

  Future<bool>isExists(DatabaseReference databaseReference)async{
    final snapshot = await databaseReference.get();
    if (snapshot.exists) {
      return true;
    } else {
      print('No data available');
      return false;
    }
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

}