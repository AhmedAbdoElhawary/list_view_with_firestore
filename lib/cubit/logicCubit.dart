import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_again/card(GridView).dart';
import 'package:firestore_again/cubit/bigStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../deck(list_view).dart';
import '../gallery(ScreenHome).dart';

class LogicShowCubit extends Cubit<BigShowStates> {
  LogicShowCubit() : super(ShowInitialState());

  static LogicShowCubit get(context) =>
      BlocProvider.of<LogicShowCubit>(context);

  int c_index = 0;
  getIndex(int i) {
    c_index = i;
    emit(ShowGetIndexState());
  }

  Widget buildPaddingListView(model) {
    return Card(
      shadowColor: Colors.blue[300],
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 4,
      margin: EdgeInsets.all(5.0),
      child: Container(
        color: Colors.white,
        height: 105,
        alignment: AlignmentDirectional.bottomEnd,
        child: Row(
          children: [
            Image.network(
              "${model["image"]}",
              width: 100,
              height: 110,
              fit: BoxFit.fill,
            ),
            SizedBox(
              width: 6,
            ),
            Container(
              width: 240,
              padding: EdgeInsets.only(top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${model['name']}"),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${model["description"]}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.delete_outline),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.edit_outlined),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOneContainerGridView(m) {
    return Card(
      shadowColor: Colors.blue,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 6,
      child: Container(
        width: double.infinity,
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 25,
              ),
              Text(
                "Done",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "${m["name"]}",
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              Text(
                "${m["description"]}",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black38,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                "${m["email"]}",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      'COMPOSE EMAIL\n(AUTHOR)',
                    ),
                  ),
                  Icon(Icons.edit_outlined),
                  SizedBox(
                    width: 30,
                  ),
                  Icon(Icons.delete_outlined),
                  SizedBox(
                    width: 25,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTwoContainerGridView(m) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shadowColor: Colors.blue,
      elevation: 9,
      margin: EdgeInsets.all(5.0),
      child: Container(
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("${m["image"]}"),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "${m["name"]}",
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  decorationStyle: TextDecorationStyle.double,
                  textBaseline: TextBaseline.alphabetic),
              textWidthBasis: TextWidthBasis.longestLine,
            ),
          ],
        ),
      ),
    );
  }

  List<Color> list_color = [
    Colors.green,
    Colors.blue,
    Colors.teal,
  ];
  List<Widget> list_widget = [
    deckListView(),
    CardGridView(),
    galleryScreenHome(),
  ];

  setDataInFirestore({
    required String name,
    required String description,
    required String email,
    required String image,
  }) {
    FirebaseFirestore.instance.collection('data').add({
      'name': "$name",
      'description': '$description',
      "email": "$email",
      "image": "$image",
    });
    emit(ShowInsertFirestoreState());
  }
}
