import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FormScreen extends StatelessWidget {
  var controlName = TextEditingController();
  var controlDescription = TextEditingController();
  var controlEmail = TextEditingController();
  var controlImage = TextEditingController();
  final formKey = GlobalKey<FormState>();
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
                      TextFromFieldMethod(nameOfController: controlName, typeOfText: TextInputType.text, labelText: "the Name"),
                      SizedBoxMethod(),
                      TextFromFieldMethod(nameOfController: controlDescription, typeOfText: TextInputType.text, labelText: "Description"),
                      SizedBoxMethod(),
                      TextFromFieldMethod(nameOfController: controlEmail, typeOfText: TextInputType.emailAddress, labelText: "Email"),
                      SizedBoxMethod(),
                      TextFromFieldMethod(nameOfController: controlImage, typeOfText: TextInputType.url, labelText: "Image"
                      ),
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

  Widget TextFromFieldMethod ({required TextEditingController nameOfController, required var typeOfText, required String labelText}) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
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
                FirebaseFirestore.instance.collection('data')
                    .doc(id)
                    .update({
                  'name': controlName.text,
                  'description': controlDescription.text,
                  "email":controlEmail.text,
                  "image": controlImage.text,})
                    .then((value) => print("User Updated"))
                    .catchError((error) => print("Failed to update user: $error"));
                Navigator.pop(context);
              }
              else{
                FirebaseFirestore.instance.collection('data').add({
                  "name": controlName.text,
                  "description": controlDescription.text,
                  "email": controlEmail.text,
                  "image": controlImage.text,
                });
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
