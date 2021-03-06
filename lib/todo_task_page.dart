import 'package:firestore_again/form_screen.dart';
import 'package:flutter/material.dart';

class TodoTaskPage extends StatelessWidget {
  final model;
  final String id;
  TodoTaskPage({required this.model, required this.id});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(),
        body: buildContainerBody(),
        floatingActionButton: buildFloatingActionButton(context),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
        backgroundColor: Colors.white, iconTheme: IconThemeData.fallback());
  }

  Container buildContainerBody() {
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
          buildText(
              text: model["name"], fontSize: 50, fontWeight: FontWeight.bold),
          buildText(
              text: model["description"],
              fontSize: 20,
              fontWeight: FontWeight.normal),
          buildText(
              text: model["email"],
              fontSize: 15,
              fontWeight: FontWeight.normal),
        ],
      ),
    );
  }

  FloatingActionButton buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(
        Icons.edit_outlined,
        color: Colors.black87,
        size: 25,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => new FormScreen(
                    isUpdatingTask: true,
                    taskData: model,
                    taskDocId: id,
                  )),
        );
      },
      elevation: 20,
      backgroundColor: Colors.white,
    );
  }

  Widget buildText(
      {required String text,
      required double fontSize,
      required FontWeight fontWeight}) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          textBaseline: TextBaseline.alphabetic),
      maxLines: 2,
    );
  }
}
