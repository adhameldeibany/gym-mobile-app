import 'package:firebase_core/firebase_core.dart';
import 'package:flockergym/Methods/colors_methods.dart';
import 'package:flockergym/firebase_options.dart';
import 'package:flockergym/main.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Scaffold LoadingScreen(){
  return Scaffold(
    backgroundColor: lightyellow,
    body: Center(
      child: Lottie.asset('assets/ogloading.json'),
    ),
  );
}
abstract class MainMethods extends StatefulWidget{

  void db()async{
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  Scaffold MakeStream(BuildContext Screencontext,String Extra){
    return LoadingScreen();
  }


  savebooldata(String dataname, bool datavalue)async{}

  savestringdata(String dataname, String datavalue)async{
    await prefs.setString(dataname,datavalue);
  }

  bool? readdata(String dataname){}

}