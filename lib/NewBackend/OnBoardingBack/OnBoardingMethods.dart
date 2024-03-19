import 'package:flockergym/NewBackend/MainMethods.dart';
import 'package:flockergym/main.dart';
import 'package:flutter/src/widgets/framework.dart';

class OnBoardingMethods extends MainMethods{

  @override
  savebooldata(String dataname, bool datavalue) async{
    await prefs.setBool(dataname, datavalue);
  }

  @override
  bool? readdata(String dataname){
    if (prefs.getBool(dataname) == null) {
      return false;
    }  else{
      return prefs.getBool(dataname);
    }
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

}