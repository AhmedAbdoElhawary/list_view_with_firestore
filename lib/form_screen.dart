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
  bool checkForWhichPath;
  //true => it is come from InformationOfItemPage class and the FormScreen should be have the data of this item
  //false=> it is come from NavigationBar class and the FormScreen should be empty
  FormScreen({var model, var id, required this.checkForWhichPath}) {
    this.id = id;
    this.model = model;
    if (checkForWhichPath) {
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
                      TextFromFieldMethod(nameOfController: controlName, typeOfText: TextInputType.text, labelText: "the Name", checkGallery: false),
                      SizedBoxMethod(),
                      TextFromFieldMethod(nameOfController: controlDescription, typeOfText: TextInputType.text, labelText: "Description", checkGallery: false),
                      SizedBoxMethod(),
                      TextFromFieldMethod(nameOfController: controlEmail, typeOfText: TextInputType.emailAddress, labelText: "Email", checkGallery: false),
                      SizedBoxMethod(),
                      ContainerMethod(),
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

  String storageUrlImage = "";
  bool checkReadyImageToUpload = false;
  bool checkForSelectImage = false;
  Firestore(var lastImagePath, var completeImagePath) async {
    File file = File(completeImagePath);
    checkForSelectImage = true;
    FirebaseStorage.instance
        .ref('data/$lastImagePath')
        .putFile(file)
        .then((v) => {
              v.ref.getDownloadURL().then((value) => {
                        storageUrlImage = value,
                        checkReadyImageToUpload = true,
                        print(value),
                      })
                  .catchError((e) {})
            })
        .catchError((e) {});
  }

  InkWell ContainerMethod() {
    return InkWell(
      onTap: () async {
        late File image;
        final picker = ImagePicker();
        final pickedFile = await picker.pickImage(source: ImageSource.gallery);
        if (pickedFile != null) image = File(pickedFile.path);
        var urlImage = Uri.file(image.path).pathSegments.last;
        Firestore(urlImage, image.path);
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

  Widget TextFromFieldMethod({required TextEditingController nameOfController, required var typeOfText, required String labelText, required bool checkGallery}) {
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
              if (checkForWhichPath) {
                String updateImage = model["image"];
                if (checkForSelectImage) updateImage = storageUrlImage;
                if (checkReadyImageToUpload) {
                  FirestoreOperation().updateFirestore(
                      name: controlName.text,
                      description: controlDescription.text,
                      email: controlEmail.text,
                      image: updateImage,
                      id: id);
                  Navigator.pop(context);
                } else
                  showToastMethod();
              } else if (checkReadyImageToUpload) {
                FirestoreOperation().setDataInFirestore(
                    name: controlName.text,
                    description: controlDescription.text,
                    email: controlEmail.text,
                    image: storageUrlImage.toString());
                Navigator.pop(context);
              } else if (!checkReadyImageToUpload) showToastMethod();
            }
          } else if (text == "Cancel") Navigator.pop(context);
        },
        child: Text(text),
      ),
    );
  }

  Future<bool?> showToastMethod() {
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
