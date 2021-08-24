import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/bigStates.dart';
import 'cubit/logicCubit.dart';

class FormScreen extends StatelessWidget {
  var controlName = TextEditingController();
  var controlDescription = TextEditingController();
  var controlEmail = TextEditingController();
  var controlImage = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LogicShowCubit(),
      child: BlocConsumer<LogicShowCubit, BigShowStates>(
        listener: (context, state) {},
        builder: (context, state) {
          LogicShowCubit cubit = LogicShowCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                Expanded(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SingleChildScrollView(
                        child: Column(children: [
                          TextFormField(
                            controller: controlName,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'The Name',
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: controlDescription,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Description',
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: controlEmail,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Email',
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: controlImage,
                            keyboardType: TextInputType.url,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Image',
                                suffixIcon: Icon(
                                  Icons.camera_alt,
                                )),
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
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Cancel"),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            cubit.setDataInFirestore(
                              name: controlName.text,
                              description: controlDescription.text,
                              email: controlEmail.text,
                              image: controlImage.text,
                            );
                            Navigator.pop(context);
                          },
                          child: Text("Save"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
