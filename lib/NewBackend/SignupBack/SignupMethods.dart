import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flockergym/Data%20collection%20screens/gender_screen.dart';
import 'package:flockergym/Data%20collection%20screens/name_screen.dart';
import 'package:flockergym/NewBackend/MainMethods.dart';
import 'package:flockergym/firebase_options.dart';
import 'package:flockergym/main.dart';
import 'package:flockergym/navigation/router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignupMethods extends MainMethods{

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
      savebooldata('done',true);
      savebooldata('backed',false);
      savebooldata('issocial',false);
      Get.off(RouterScreen());
    }
    else{
      savebooldata('backed',true);
      savebooldata('issocial', true);
      Get.off(NameScreen());
    }
  }

  signUpWithEmail(String Phone, String Email, String Password, String Name, BuildContext context) async{
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: Email,
        password: Password,
      );
      savebooldata('issocial', false);
      savestringdata('name', Name);
      savestringdata('email', Email);
      savestringdata('phone', Phone);
      savestringdata('password', Password);
      Get.off(GenderScreen());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        final snackBar = SnackBar(
          duration: Duration(milliseconds: 1500,),
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Error',
            message: 'The password provided is too weak.',
            contentType: ContentType.failure,
          ),
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);

      } else if (e.code == 'email-already-in-use') {
        final snackBar = SnackBar(
          duration: Duration(milliseconds: 1500,),
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Error',
            message: 'The account already exists for that email.',
            contentType: ContentType.failure,
          ),
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    } catch (e) {
      print(e);
    }
  }

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

  start(int num_of_screen,String? Phone,String? Email,String? Password,String? Name,BuildContext? context) async{
    if (num_of_screen == 2) {
      await signInWithGoogle();
    }else{
      await signUpWithEmail(Phone!, Email!, Password!, Name!,context!);
    }
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

}