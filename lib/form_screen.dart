import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/big_states.dart';
import 'cubit/logic_cubit.dart';

class FormScreen extends StatelessWidget {
  var controlName = TextEditingController();
  var controlDescription = TextEditingController();
  var controlEmail = TextEditingController();
  var controlImage = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LogicShowCubit(),
      child: BlocConsumer<LogicShowCubit, BigShowStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(key:formKey,
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
                            TextFromFieldMethod(nameOfController: controlImage, typeOfText: TextInputType.url, labelText: "Image"),
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
                        TextButtonMethod(sendDataToFirestore: false,context: context,text: "Cancel"),

                        TextButtonMethod(sendDataToFirestore: true,context: context,text: "Save "),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  Widget TextFromFieldMethod({required var nameOfController,required var typeOfText,required String labelText}){
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

  Widget SizedBoxMethod(){
    return SizedBox(
      height: 15,
    );
  }

  Widget TextButtonMethod({required bool sendDataToFirestore,required var context, required String text}){

    return Expanded(
      child: TextButton(
        onPressed: () {
          if(sendDataToFirestore!=false){
            if (formKey.currentState!.validate()) {
              LogicShowCubit.get(context).setDataInFirestore(
                name: controlName.text,
                description: controlDescription.text,
                email: controlEmail.text,
                image: controlImage.text,
              );
              Navigator.pop(context);
            }
          }
          else if (text=="Cancel")
            Navigator.pop(context);
        },
        child: Text(text),
      ),
    );
  }
}
