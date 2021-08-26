import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:firestore_again/firebase_firestore/Firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class FormScreen extends StatelessWidget {
  var controlName = TextEditingController();
  var controlDescription = TextEditingController();
  var controlEmail = TextEditingController();
  var controlImage = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var firestoreImage;
  var model;
  var id;
  bool check;
  FormScreen({var model,var id, required this.check}){
    this.id=id;
    this.model=model;

    if (check){
      controlName.text=model["name"];
      controlDescription.text=model["description"];
      controlEmail.text=model["email"];
      controlImage.text=model["image"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SingleChildScrollView(
                    child: Column(children: [
                      TextFromFieldMethod(nameOfController: controlName, typeOfText: TextInputType.text, labelText: "the Name",checkGallery:false),
                      SizedBoxMethod(),
                      TextFromFieldMethod(nameOfController: controlDescription, typeOfText: TextInputType.text, labelText: "Description",checkGallery:false),
                      SizedBoxMethod(),
                      TextFromFieldMethod(nameOfController: controlEmail, typeOfText: TextInputType.emailAddress, labelText: "Email",checkGallery:false),
                      SizedBoxMethod(),
                      TextFromFieldMethod(nameOfController: controlImage, typeOfText: TextInputType.url, labelText: "Image",checkGallery:true),
                    ]),
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white60,
              width: double.infinity,
              child: Row(
                children: [
                  TextButtonMethod(sendDataToFirestore: false, context: context, text: "Cancel"),

                  TextButtonMethod(sendDataToFirestore: true, context: context, text: "Save "),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget TextFromFieldMethod ({required TextEditingController nameOfController, required var typeOfText, required String labelText,required bool checkGallery}) {

    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },

      onTap: () async {
        if(checkGallery){
          late File image;
          var urlImage;
          final picker = ImagePicker();
          final pickedFile = await picker.pickImage(source:ImageSource.gallery);

          if(pickedFile!=null)
            image=File(pickedFile.path);
          urlImage=Uri.file(image.path).pathSegments.last;
          firestoreImage=FirestoreOperation().Firestore(urlImage,pickedFile!.path);
        }
      },

      controller: nameOfController,
      keyboardType: typeOfText,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: labelText,
      ),

    );
  }

  Widget SizedBoxMethod() => SizedBox(height: 15);

  Widget TextButtonMethod({required bool sendDataToFirestore, required var context, required String text}) {
    return Expanded(
      child: TextButton(
        onPressed: () {
          if (sendDataToFirestore) {
            if (formKey.currentState!.validate()) {
              if(check){
                FirestoreOperation().updateFirestore(name: controlName.text, description: controlDescription.text, email: controlEmail.text, image: firestoreImage, id: id);

                Navigator.pop(context);
              }
              else{
                FirestoreOperation().setDataInFirestore(name: controlName.text, description: controlDescription.text, email: controlEmail.text, image: firestoreImage);

                Navigator.pop(context);
              }
            }
          } else if (text == "Cancel") Navigator.pop(context);

        },
        child: Text(text),
      ),
    );
  }

}
