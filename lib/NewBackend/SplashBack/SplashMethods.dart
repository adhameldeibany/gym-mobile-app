import 'package:animate_do/animate_do.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flockergym/Auth/Auth.dart';
import 'package:flockergym/NewBackend/MainMethods.dart';
import 'package:flockergym/NewBackend/Models/UpdateModel.dart';
import 'package:flockergym/Update/update_screen.dart';
import 'package:flutter/material.dart';

class SplashMethods extends MainMethods{

  Scaffold MainScreen(BuildContext context){
    return Scaffold(
      body: FadeIn(
        duration: Duration(seconds: 1),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image(
            fit: BoxFit.cover,
            image: AssetImage('assets/splash.png',),
          ),
        ),
      ),
    );
  }

  @override
  Scaffold MakeStream(BuildContext mainScreen,String version){
    DatabaseReference ref = FirebaseDatabase.instance.ref("update");
    return Scaffold(
      body: StreamBuilder(
        stream: ref.onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null &&
              (snapshot.data! as DatabaseEvent).snapshot.value != null) {
            UpdateModel updateModel = new UpdateModel(
              url: snapshot.data?.snapshot
                  .child('url')
                  .value
                  .toString(),
              description: snapshot.data?.snapshot
                  .child('description')
                  .value
                  .toString(),
              version: snapshot.data?.snapshot
                  .child('version')
                  .value
                  .toString(),
            );
            if (int.parse(version) < int.parse(updateModel.version!)) {
              return UpdateScreen(update:updateModel);
            }
            else{
              return Auth();
            }
          }
          else{
            return LoadingScreen();
          }
        },
      ),
    );
  }

  Scaffold start(String version,BuildContext context){
    return MakeStream(context, version);
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

}