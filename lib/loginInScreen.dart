import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_again/common_method/commonMethod.dart';
import 'package:firestore_again/home_page.dart';
import 'package:firestore_again/sginInScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var controlEmailAddress = TextEditingController();
  var controlPassword = TextEditingController();
  bool textVisible = true;
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
              buildLoginText(),
              buildSizedBox(),
              buildTextField(
                controller: controlEmailAddress,
                typeOfText: TextInputType.emailAddress,
                textVisible: textVisible,
              ),
              buildSizedBox(),
              buildTextField(
                controller: controlPassword,
                typeOfText: TextInputType.visiblePassword,
                textVisible: textVisible,
              ),
              buildSizedBox(),
              textButtonOfSignIn(context),
              buildRegisterRow(context),
            ],
          ),
        ),
      ),
    );
  }

  Row buildRegisterRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Don\'t have an account?"),
        TextButton(
          onPressed: () {
            buildNavigationPush(context, RegisterScreen());
          },
          child: Text("Register Now"),
        ),
      ],
    );
  }

  Container textButtonOfSignIn(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.lightBlue,
      child: TextButton(
        onPressed: onPressedSignIn,
        child: signInText(),
      ),
    );
  }

  onPressedSignIn() {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: controlEmailAddress.text, password: controlPassword.text)
        .then((value) {
      print("${value.user!.email}\n${value.user!.uid}");
      print(value.user);
      buildNavigationPush(context, HomePage());
    }).catchError((e) {
      buildShowToast(message: e.toString());
    });
  }

  Text signInText() {
    return Text(
      'sign in',
      style: TextStyle(
          fontSize: 22, fontStyle: FontStyle.italic, color: Colors.white),
    );
  }

  Future<dynamic> buildNavigationPush(BuildContext context, var pagePushed) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => pagePushed),
    );
  }

  TextFormField buildTextField({required var controller, required var typeOfText, required bool textVisible}) {
    return TextFormField(
      obscureText: textVisible,
      controller: controller,
      keyboardType: typeOfText,
      decoration: buildEmailInputDecoration(),
    );
  }

  InputDecoration buildEmailInputDecoration() {
    return InputDecoration(
      border: OutlineInputBorder(),
      labelText: 'Email Address',
      prefixIcon: Icon(Icons.email),
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
            if (textVisible)
              textVisible = false;
            else
              textVisible = true;
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

  SizedBox buildSizedBox() => SizedBox(height: 15);

  Text buildLoginText() {
    return Text(
      "LOGIN",
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
