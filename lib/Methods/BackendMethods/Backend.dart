import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flockergym/NewBackend/Models/ExtendedClassModel.dart';
import 'package:flockergym/NewBackend/Models/StoreItem.dart';
import 'package:flockergym/main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

FirebaseStorage storage = FirebaseStorage.instance;

class BackendService {

  pickimage(ImageSource source) async{
    final ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: source);
    if (file != null) {
      Uint8List imgfile = await file.readAsBytes();
      saveData(file: imgfile);
      return imgfile;
    }
    print("No Images Selected");
  }

  Future<String> saveData({required Uint8List file}) async {
    String resp = "Some Error Occurred";
    try{
      String imageUrl = await uploadImageToStorage(file);
      DatabaseReference ref = FirebaseDatabase.instance.ref("members/${FirebaseAuth.instance.currentUser?.uid.toString()}");
      await ref.update({
        "imgurl": imageUrl,
      });
      resp = 'success';
    }catch(err){
      resp = err.toString();
    }
    return resp;
  }

  Future<String> uploadImageToStorage(Uint8List file) async{
    Reference ref = storage.ref().child("profileimgs/"+FirebaseAuth.instance.currentUser!.uid.toString());
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await  uploadTask;
    String downloadurl = await snapshot.ref.getDownloadURL();
    prefs.setString('imgurl', downloadurl);
    return downloadurl;
  }

  changeName(String newName) async{
    String resp = "Some Error Occurred";
    try{
      DatabaseReference ref = FirebaseDatabase.instance.ref("members/${FirebaseAuth.instance.currentUser?.uid.toString()}");
      await ref.update({
        "name": newName,
      });
      resp = 'success';
    }catch(err){
      resp = err.toString();
    }
}

  shopitem(StoreItem storeItem, int quan)async{
    var uuid = Uuid();
    String uid = uuid.v1().replaceAll("-", "");
    DatabaseReference ref = FirebaseDatabase.instance.ref("shoprequests/${uid}/");
    await ref.set({
      "id":uid,
      "uid":FirebaseAuth.instance.currentUser!.uid,
      "email":FirebaseAuth.instance.currentUser!.email,
      "itemid":storeItem.id,
      "quantity":quan.toString(),
      "price":storeItem.price,
      "total": (double.parse(storeItem.price)*quan).toStringAsFixed(2),
      "itemname":storeItem.name,
      "requestedon":DateTime.now().toString()
    });
  }

  bookitem(ExtendedClassModel classModel)async{
    var uuid = Uuid();
    String uid = uuid.v1().replaceAll("-", "");
    DatabaseReference ref = FirebaseDatabase.instance.ref("bookrequests/${uid}/");
    await ref.set({
      "id":uid,
      "uid":FirebaseAuth.instance.currentUser!.uid,
      "email":FirebaseAuth.instance.currentUser!.email,
      "coachname":classModel.coachname,
      "coachid":classModel.coachid,
      "dayofweek":classModel.dayofweek,
      "from":classModel.from,
      "to":classModel.to,
      "classname":classModel.name,
      "classid":classModel.id,
      "requestedon":DateTime.now().toString()
    });
  }

}