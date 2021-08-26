import 'package:firestore_again/form_screen.dart';
import 'package:flutter/material.dart';

class InformationOfItemPage extends StatelessWidget {
  var model;
  String id;
  InformationOfItemPage({required this.model,required this.id});

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBarMethod(),
        body: ContainerBodyMethod(),
        floatingActionButton: FloatingActionButtonMethod(context),
      ),
    );

  }
  AppBar AppBarMethod() {
    return AppBar(
        backgroundColor: Colors.white, iconTheme: IconThemeData.fallback());
  }

  Container ContainerBodyMethod() {
    return Container(
      child: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            shadowColor: Colors.teal,
            elevation: 25,
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("${model["image"]}"),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
              ),
            ),
          ),
          TextMethod(text: model["name"], fontSize: 50, fontWeight: FontWeight.bold),
          TextMethod(text: model["description"], fontSize: 20, fontWeight: FontWeight.normal),
          TextMethod(text: model["email"], fontSize: 15, fontWeight: FontWeight.normal),
        ],
      ),
    );
  }

  FloatingActionButton FloatingActionButtonMethod(BuildContext context) {
    return FloatingActionButton(
        child: Icon(
          Icons.edit_outlined,
          color: Colors.black87,size: 25,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>new FormScreen(checkForWhichPath: true,model:model,id: id,)),
          );
        },
        elevation: 20,
        backgroundColor: Colors.white,
      );
  }

  Widget TextMethod({required String text, required double fontSize, required FontWeight fontWeight}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        textBaseline: TextBaseline.alphabetic,
        overflow: TextOverflow.ellipsis,
      ),
      maxLines: 2,
    );
  }
}
