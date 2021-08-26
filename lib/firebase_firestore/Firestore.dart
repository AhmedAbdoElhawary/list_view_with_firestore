import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
class FirestoreOperation {
  var fire = FirebaseFirestore.instance.collection('data');

  setDataInFirestore({required String name, required String description, required String email, required String image,}) {
    fire
        .add({
          'name': name,
          'description': description,
          "email": email,
          "image": image,
        })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  updateFirestore({required String name, required String description, required String email, required String image, required String id}) {
    fire.doc(id)
        .update({
          'name': name,
          'description': description,
          "email": email,
          "image": image,
        })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  deleteDataFromFirestore({required String id}) {
    fire
        .doc(id)
        .delete()
        .then((value) => print("deleting successfully"))
        .catchError((e) => print("$e \nerror while deleting the element"));
  }

  Firestore(var urlImage,var pathOfImage)  {
    var firestoreImage;
   File file = File(pathOfImage);

   FirebaseStorage.instance
       .ref('data/$urlImage')
       .putFile(file)
       .then((v) =>{
     v.ref.getDownloadURL().then((value) => {
       firestoreImage=value
     }).catchError((e){})
   }).catchError((e){});
    return firestoreImage;
    }

  }

