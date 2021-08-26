import 'package:cloud_firestore/cloud_firestore.dart';
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
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  updateFirestore({required String name, required String description, required String email, required String image, required String id}) {
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

  deleteDataFirestore({required String id}) {
    dbref
        .doc(id)
        .delete()
        .then((value) => print("deleting successfully"))
        .catchError((e) => print("$e \nerror while deleting the element"));
  }

  }

