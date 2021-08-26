import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firestore_again/firebase_firestore/Firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class FormScreen extends StatelessWidget {
  var controlName = TextEditingController();
  var controlDescription = TextEditingController();
  var controlEmail = TextEditingController();
  var controlImage = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var model;
  var id;
  bool whichPageCome;
  //true => it is come from InformationOfItemPage class and the FormScreen should be have the data of this item
  //false=> it is come from NavigationBar class and the FormScreen should be empty
  FormScreen({var model, var id, required this.whichPageCome}) {
    this.id = id;
    this.model = model;
    if (whichPageCome) {
      controlName.text = model["name"];
      controlDescription.text = model["description"];
      controlEmail.text = model["email"];
      controlImage.text = model["image"];
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
                      buildTextFromField(nameOfController: controlName, typeOfText: TextInputType.text, labelText: "the Name"),
                      buildSizedBox(),
                      buildTextFromField(nameOfController: controlDescription, typeOfText: TextInputType.text, labelText: "Description"),
                      buildSizedBox(),
                      buildTextFromField(nameOfController: controlEmail, typeOfText: TextInputType.emailAddress, labelText: "Email"),
                      buildSizedBox(),
                      buildContainerOfImage(),
                    ]),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            Container(
              color: Colors.white60,
              width: double.infinity,
              child: Row(
                children: [
                  buildTextButton(sendDataToFirestore: false, context: context, text: "Cancel"),
                  buildTextButton(sendDataToFirestore: true, context: context, text: "Save "),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String urlImageFirebaseStorage = "";
  bool ReadyUrlImageFirebaseStorage = false;
  bool isImageSelected = false;
  addDataToFirebaseStorage(var lastImagePath, var completeImagePath) async {
    File file = File(completeImagePath);
    isImageSelected = true;
    FirebaseStorage.instance
        .ref('data/$lastImagePath')
        .putFile(file)
        .then((v) => {
              v.ref.getDownloadURL().then((value) => {
                        urlImageFirebaseStorage = value,
                        ReadyUrlImageFirebaseStorage = true,

                      })
                  .catchError((e) {})
            })
        .catchError((e) {});
  }

  InkWell buildContainerOfImage() {
    return InkWell(
      onTap: () async {
        late File imageFullPath;
        final picker = ImagePicker();
        final pickedFile = await picker.pickImage(source: ImageSource.gallery);
        if (pickedFile != null) imageFullPath = File(pickedFile.path);
        var urlImageLastPath = Uri.file(imageFullPath.path).pathSegments.last;
        addDataToFirebaseStorage(urlImageLastPath, imageFullPath.path);
      },
      child: Container(
        child: Icon(Icons.camera_alt),
        height: 63,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.fromBorderSide(BorderSide(
            color: Colors.black45,
          )),
          borderRadius: BorderRadius.all(Radius.circular(6)),
          color: Colors.white,
        ),
      ),
    );
  }

  Widget buildTextFromField({required TextEditingController nameOfController, required var typeOfText, required String labelText}) {
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

  Widget buildSizedBox() => SizedBox(height: 15);

  Widget buildTextButton({required bool sendDataToFirestore, required var context, required String text}) {
    return Expanded(
      child: TextButton(
        onPressed: () {
          if (sendDataToFirestore) {
            if (formKey.currentState!.validate()) {
              if (whichPageCome) {
                String updateImage = model["image"];
                if (isImageSelected) updateImage = urlImageFirebaseStorage;
                if (ReadyUrlImageFirebaseStorage) {
                  FirestoreOperation().updateFirestore(
                      name: controlName.text,
                      description: controlDescription.text,
                      email: controlEmail.text,
                      image: updateImage,
                      id: id);
                  Navigator.pop(context);
                } else
                  buildShowToast();
              } else if (ReadyUrlImageFirebaseStorage) {
                FirestoreOperation().addDataFirestore(
                    name: controlName.text,
                    description: controlDescription.text,
                    email: controlEmail.text,
                    image: urlImageFirebaseStorage.toString());
                Navigator.pop(context);
              } else if (!ReadyUrlImageFirebaseStorage) buildShowToast();
            }
          } else if (text == "Cancel") Navigator.pop(context);
        },
        child: Text(text),
      ),
    );
  }

  Future<bool?> buildShowToast() {
    return Fluttertoast.showToast(
        msg: "uploading...",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 8,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
