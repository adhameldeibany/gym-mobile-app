import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flockergym/Data%20collection%20screens/gender_screen.dart';
import 'package:flockergym/NewBackend/MainMethods.dart';
import 'package:flockergym/main.dart';
import 'package:flockergym/navigation/router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SigninMethods extends MainMethods{

  @override
  savebooldata(String dataname, bool datavalue)async{
    await prefs.setBool(dataname,datavalue);
  }

  @override
  bool? readdata(String dataname){
    if (prefs.getBool(dataname) == null) {
      return false;
    }  else{
      return prefs.getBool(dataname);
    }
  }

  Future<bool>isExists(DatabaseReference databaseReference)async{
    final snapshot = await databaseReference.get();
    if (snapshot.exists) {
      return true;
    } else {
      return false;
    }
  }

  signInWithEmail(String email, String password, BuildContext context)async{
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      if (await isExists(FirebaseDatabase.instance.ref("members/"+FirebaseAuth.instance.currentUser!.uid.toString()))) {
        await savebooldata('done', true);
        await savebooldata('issocial', false);
        Get.off(RouterScreen());
      }else{
        Get.off(GenderScreen());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        final snackBar = SnackBar(
          duration: Duration(milliseconds: 1500,),
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Error',
            message: 'No user found for that email.',
            contentType: ContentType.failure,
          ),
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);

      }
      else if (e.code == 'wrong-password') {
        final snackBar = SnackBar(
          duration: Duration(milliseconds: 1500,),
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Error',
            message: 'Wrong password provided for that user.',
            contentType: ContentType.failure,
          ),
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    }
  }

  start(String email, String password, BuildContext context)async{
    await signInWithEmail(email, password, context);
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

}