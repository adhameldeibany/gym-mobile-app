import 'package:firebase_auth/firebase_auth.dart';
import 'package:flockergym/Auth/signup2.dart';
import 'package:flockergym/NewBackend/OnBoardingBack/OnBoardingMethods.dart';
import 'package:flockergym/Onboarding/onboarding.dart';
import 'package:flockergym/navigation/router.dart';
import 'package:flutter/material.dart';


class Auth extends StatefulWidget{
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {

  @override
  Widget build(BuildContext context){
    return FirebaseAuth.instance.currentUser!= null?
         RouterScreen(): OnBoardingMethods().readdata('show')!? Signup2() : OnboardingScreen();
  }
}