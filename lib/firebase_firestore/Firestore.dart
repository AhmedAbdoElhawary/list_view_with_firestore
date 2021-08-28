import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
class FirestoreOperation {
  var dbref = FirebaseFirestore.instance.collection('data');

  addDataFirestore({required String name, required String description, required String email, required var image,}) {
    dbref
        .add({
          'name': name,
          'description': description,
          "email": email,
          "image": image,
        })
        .then((value) => print("User Updat ed"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  updateDataFirestore({required String name, required String description, required String email, required String image, required String id}) {
    dbref.doc(id)
        .update({
          'name': name,
          'description': description,
          "email": email,
          "image": image,
        })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  deleteDataFirestore({required String id,required var model,required bool fromUpdate}) async {

    String filePath = model["image"].replaceAll(new RegExp(r'(\?alt).*'), '');

    List split=filePath.split("data%2F");

    FirebaseStorage.instance.ref("data").child(split[1]).delete()
        .then((_) => print('Successfully deleted $filePath storage item' ))
        .catchError((_){print("image not exist in the firebase storage");});

    if(!fromUpdate){
      dbref
          .doc(id)
          .delete()
          .then((value) => print("deleting successfully"))
          .catchError((e) => print("$e \nerror while deleting the element"));
      print(id);
    }
  }

  }

