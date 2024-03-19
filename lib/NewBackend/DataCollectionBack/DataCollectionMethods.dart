import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flockergym/NewBackend/MainMethods.dart';
import 'package:flockergym/main.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:uuid/uuid.dart';

class DataCollectionMethods extends MainMethods{

  @override
  savestringdata(String dataname, String datavalue) async {
    await prefs.setString(dataname,datavalue);
  }

  @override
  bool? readdata(String dataname) {
    if (prefs.getBool(dataname) == null) {
      return false;
    }  else{
      return prefs.getBool(dataname);
    }
  }

  Future <void> makeuserindb() async{
    var uuid = Uuid();

    final currentTime = DateTime.now();
    final currentDate = DateTime(
        currentTime.year,
        currentTime.month,
        currentTime.day,
        currentTime.hour ,
        currentTime.minute,
        currentTime.second
    );
    DatabaseReference ref = FirebaseDatabase.instance.ref("members/${FirebaseAuth.instance.currentUser?.uid.toString()}/");
    DatabaseReference ref2 = FirebaseDatabase.instance.ref("users/${FirebaseAuth.instance.currentUser?.uid.toString()}/");
    DatabaseReference ref3 = FirebaseDatabase.instance.ref("notifications/${FirebaseAuth.instance.currentUser?.uid.toString()}/m1/");

    String Identity = uuid.v1().replaceAll('-', '0').substring(0,8);

    await ref.set({
      "age": prefs.getString('age'),
      "createdat": currentDate.toString().replaceAll(':','/').replaceAll('.000',''),
      "email":FirebaseAuth.instance.currentUser?.email.toString(),
      "gender":prefs.getString('gender'),
      "height":prefs.getString('height'),
      "id":FirebaseAuth.instance.currentUser?.uid.toString(),
      "imgurl":prefs.getString('gender') == "Male"?"https://firebasestorage.googleapis.com/v0/b/fl-gym-management-system.appspot.com/o/profileimgs%2Fprofile.png?alt=media&token=c7536405-c0a8-4a86-8dce-6109f88e2002":"https://firebasestorage.googleapis.com/v0/b/fl-gym-management-system.appspot.com/o/profileimgs%2Fpng-transparent-female-avatar-girl-face-woman-user-flat-classy-users-icon%20(1).png?alt=media&token=65b9e156-2705-4a02-8836-cc21a7988258",
      "memberstatus":"basic plan",
      "mobile":"",
      "name":prefs.getString('name'),
      "goal":prefs.getString('goal'),
      "password": "",
      "weight":prefs.getString('weight'),
      "endsAt":currentDate.toString().replaceAll(':','/').replaceAll('.000',''),
      "area": prefs.getString('area'),
      "body":prefs.getString('body'),
      "active":prefs.getString('active'),
      "pushup":prefs.getString('pushup'),
      "walk":prefs.getString('walk'),
      "sleep":prefs.getString('sleep'),
      "uniq": Identity.substring(0,8),
      "invitations":"10",
      "notes":prefs.getString('notes'),
      "form1":prefs.getString('form1'),
      "form2":prefs.getString('form2'),
      "subtype":prefs.getString('subtype'),
    });

    await ref2.set({
      "state": "member",
      "id":FirebaseAuth.instance.currentUser?.uid.toString(),
    });
  try{
    await ref3.set({
      "id": "m1",
      "state":"new",
      "subtitle":"Welcome To Olympic Gym App",
      "time": currentDate.toString().replaceAll('.000','').substring(0,currentDate.toString().replaceAll('.000','').length-3),
      "title": "Welcome "+ prefs.getString('name')!,
      "uid": FirebaseAuth.instance.currentUser?.email.toString(),
    });
  }catch(e){
    await ref3.set({
      "id": "m1",
      "state":"new",
      "subtitle":"Welcome To Olympic Gym App",
      "time": currentDate.toString().replaceAll('.000','').substring(0,currentDate.toString().replaceAll('.000','').length-3),
      "title": "Welcome",
      "uid": FirebaseAuth.instance.currentUser?.email.toString(),
    });
  }

    savebooldata('done',true);

  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }


}