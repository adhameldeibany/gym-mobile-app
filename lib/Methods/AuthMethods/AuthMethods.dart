import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flockergym/Data%20collection%20screens/gender_screen.dart';
import 'package:flockergym/firebase_options.dart';
import 'package:flockergym/main.dart';
import 'package:flockergym/navigation/router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';


class AuthService {


  Future<bool>isExists(DatabaseReference databaseReference)async{
    final snapshot = await databaseReference.get();
    if (snapshot.exists) {
      print(snapshot.value);
      return true;
    } else {
      print('No data available');
      return false;
    }
  }
  Future<bool> checkIfDocExists(String docId, String user) async {
    try {
      var collectionRef = FirebaseFirestore.instance.collection("usersclasses").doc(user);
      var doc = await collectionRef.collection("classes").doc(docId).get();
      return doc.exists;
    } catch (e) {
      throw e;
    }
  }


  signInWithGoogle() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final GoogleSignInAccount? guser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication gauth = await guser!.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: gauth.accessToken,
        idToken: gauth.idToken
    );
    await  FirebaseAuth.instance.signInWithCredential(credential);
    if (await isExists(FirebaseDatabase.instance.ref("members/"+FirebaseAuth.instance.currentUser!.uid.toString()))) {
      savedone(true);
      savenameback(false);
      Get.off(RouterScreen());
    }else{
      //await makeuserindb("", FirebaseAuth.instance.currentUser!.email.toString(),"", FirebaseAuth.instance.currentUser!.email.toString());
      savenameback(true);
      Get.off(GenderScreen());
    }
  }

  signUpWithEmail(String Phone, String Email, String Password, String Name) async{
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: Email,
        password: Password,
      );
      //await makeuserindb(Phone,Email,Password, Name);
      Get.off(GenderScreen());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  savein(bool showed)async{
    await prefs.setBool('show', showed);
  }

  savegender(String gender)async{
    await prefs.setString('gender',gender);
  }

  saveform1(String form1)async{
    await prefs.setString('form1',form1);
  }

  saveform2(String form2)async{
    await prefs.setString('form2',form2);
  }

  savenotes(String notes)async{
    await prefs.setString('notes',notes);
  }

  savename(String name)async{
    await prefs.setString('name',name);
  }

  savedone(bool done)async{
    await prefs.setBool('done',done);
  }

  saveage(String age)async{
    await prefs.setString('age',age);
  }

  saveweight(String weight)async{
    await prefs.setString('weight',weight);
  }

  saveheight(String height)async{
    await prefs.setString('height',height);
  }

  savegoal(String goal)async{
    await prefs.setString('goal',goal);
  }
  savearea(String area)async{
    await prefs.setString('area',area);
  }

  savebody(String body)async{
    await prefs.setString('body',body);
  }

  saveactive(String active)async{
    await prefs.setString('active',active);
  }

  savepushup(String pushup)async{
    await prefs.setString('pushup',pushup);
  }

  savewalk(String walk)async{
    await prefs.setString('walk',walk);
  }

  savesubtype(String subtype)async{
    await prefs.setString('subtype',subtype);
  }

  savesleep(String sleep)async{
    await prefs.setString('sleep',sleep);
  }

  savenameback(bool backed)async{
    await prefs.setBool('backed',backed);
  }

  bool? read() {
    if (prefs.getBool('show') == null) {
      return false;
    }  else{
      return prefs.getBool('show');
    }
  }
  bool? readdone() {
    if (prefs.getBool('done') == null) {
      return false;
    }  else{
      return prefs.getBool('done');
    }
  }

  Future <void> makeuserindb() async{
    List<String> Alpha = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","0","1","2","3","4","5","6","7","8","9"];
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

    String Identity = "";
    FirebaseAuth.instance.currentUser!.uid.runes.forEach((item){
      var character=new String.fromCharCode(item);
      Identity += Alpha.indexOf(character).toString();
    });

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
      "endsAt":currentDate.add(Duration(days: 30)).toString().replaceAll(':','/').replaceAll('.000',''),
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

    await ref3.set({
      "id": "m1",
      "state":"new",
      "subtitle":"Welcome To Olympic Gym App",
      "time": currentDate.toString().replaceAll('.000','').substring(0,currentDate.toString().replaceAll('.000','').length-3),
      "title": "Welcome "+ prefs.getString('name')!,
      "uid": FirebaseAuth.instance.currentUser?.email.toString(),
    });

    savedone(true);

  }

}