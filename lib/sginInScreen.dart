import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_again/loginInScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _tryOneState createState() => _tryOneState();
}

class _tryOneState extends State<RegisterScreen> {
  var controlUserName = TextEditingController();
  var controlPhone = TextEditingController();
  var controlEmailAddress = TextEditingController();
  var controlPassword = TextEditingController();
  var PasswordVisible = true;
  var iconVisible = Icons.remove_red_eye;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildPaddingBody(context),
    );
  }

  Padding buildPaddingBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildText(),
              buildSizedBox(),
              buildTextFormField(
                  controllerName: controlUserName,
                  typeOfText: TextInputType.name,
                  icon: Icons.person,
                  Text: 'User Name'),
              buildSizedBox(),
              buildTextFormField(
                  controllerName: controlPhone,
                  typeOfText: TextInputType.number,
                  icon: Icons.phone,
                  Text: 'The Phone'),
              buildSizedBox(),
              buildTextFormField(
                  controllerName: controlEmailAddress,
                  typeOfText: TextInputType.emailAddress,
                  icon: Icons.email,
                  Text: 'Email Address'),
              buildSizedBox(),
              buildTextFormFieldPassword(),
              buildSizedBox(),
              buildTextButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Container buildTextButton(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.lightBlue,
      child: TextButton(
        child: createAccountText(),
        onPressed: onPressedCreateAccount,
      ),
    );
  }

  onPressedCreateAccount() {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: controlEmailAddress.text, password: controlPassword.text)
        .then((value) => print("${value.user!.email}\n${value.user!.uid}"));
    Navigator.pop(context);
  }

  Text createAccountText() {
    return Text(
      'Create Account',
      style: TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontStyle: FontStyle.italic,
      ),
    );
  }

  Text buildText() {
    return Text(
      "Sign In",
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  TextFormField buildTextFormField(
      {required var controllerName,
      required var typeOfText,
      required String Text,
      required var icon}) {
    return TextFormField(
      controller: controllerName,
      keyboardType: typeOfText,
      decoration: buildNameInputDecoration(Text, icon),
    );
  }

  InputDecoration buildNameInputDecoration(String Text, icon) {
    return InputDecoration(
      border: OutlineInputBorder(),
      labelText: Text,
      prefixIcon: Icon(icon),
    );
  }

  SizedBox buildSizedBox() {
    return SizedBox(
      height: 15,
    );
  }

  TextFormField buildTextFormFieldPassword() {
    return TextFormField(
      obscureText: PasswordVisible,
      controller: controlPassword,
      keyboardType: TextInputType.visiblePassword,
      decoration: buildPasswordInputDecoration(),
    );
  }

  InputDecoration buildPasswordInputDecoration() {
    return InputDecoration(
      border: OutlineInputBorder(),
      labelText: 'Password',
      prefixIcon: Icon(Icons.lock),
      suffixIcon: IconButton(
        onPressed: () {
          setState(() {
            if (PasswordVisible == true)
              PasswordVisible = false;
            else
              PasswordVisible = true;
            if (iconVisible == Icons.remove_red_eye)
              iconVisible = Icons.remove_red_eye_outlined;
            else
              iconVisible = Icons.remove_red_eye;
          });
        },
        icon: Icon(
          iconVisible,
        ),
      ),
    );
  }
}
