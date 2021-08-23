import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firestore_again/ListOfItems.dart';
import 'package:firestore_again/card(GridView).dart';
import 'package:firestore_again/cubit/bigStates.dart';
import 'package:firestore_again/emailPageShow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  // setInList(dynamic v){
  //   task.add(v);
  //   // print("add ${task.length}");
  //   emit(ShowSetInListState());
  // }
  Widget buildPaddingListView(model) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 1.0),
      child: Container(
        color: Colors.white,
        height: 105,
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.network(
              "${model["image"]}",
              width: 100,
              height: 110,
              fit: BoxFit.fill,
            ),
            // Icon(
            //   Icons.waves_outlined,
            //   size: 110,
            // ),
            // Images( url: "https://thumbs.dreamstime.com/b/racial-love-white-caucasion-black-african-american-hands-shaped-as-interracial-heart-representing-world-unity-ethnic-162292478.jpg",),
            SizedBox(
              width: 6,
            ),
            Container(
              width: 301.42,
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
                      // IconButton(
                      //   onPressed: () {
                      //     // Navigator.push(
                      //     //   context,
                      //     //   MaterialPageRoute(builder: (context) => EmailPage()),
                      //     // );
                      //   },
                      //   icon: Icon(Icons.mail_outline),
                      // ),
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

  Widget buildOneContainerGridView(m){
    return Container(

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
            SizedBox(height: 25,),
            Text(
              "Done",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 40,),
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
            ),
            SizedBox(height: 25,),
            Text(
              "${m["email"]}",
              style: TextStyle(
                fontSize: 16,

              ),
            ),
            SizedBox(height: 25,),
            Row(mainAxisSize:  MainAxisSize.max,
              children: [
                Expanded(
                  child: Text(
                    'COMPOSE EMAIL\n(AUTHOR)',
                  ),
                ),
                Icon(Icons.edit_outlined),
                SizedBox(width: 30,),
                Icon(Icons.delete_outlined),
                SizedBox(width: 25,),
              ],
            ),
          ],

        ),
      ),
    );
  }

  Widget buildTwoContainerGridView(m){
    return  Container(
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage("${m["image"]}"),
          fit: BoxFit.cover,
        ),
        // border: Border.symmetric(horizontal: BorderSide(width: 7),
        //   // color: Colors.black26,
        //   // width: 7,
        // ),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight:Radius.circular(10) ),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          // Image.network(
          //   "${m["image"]}",
          //   width: 160,
          //   height: 170,
          //   fit: BoxFit.fill,
          // ),
          Text(
            "${m["name"]}",
            style: TextStyle(
              fontSize: 25,
              backgroundColor: Colors.white60,

            ),

          ),
        ],
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

  /*database functions*/
  //
  //  static late Database database;
  //
  //  void createDatabase() async {
  //    database=await openDatabase(
  //      'appSheet2.db',
  //      version: 1,
  //      onCreate: (database, version) {
  //        print("database created");
  //        database
  //            .execute(
  //            'CREATE TABLE tasks ( id INTEGER PRIMARY KEY,name TEXT,description TEXT,email TEXT,image TEXT)')
  //            .then((value) {
  //          print("table created");
  //        }).catchError((e) {
  //          print('Error when creating table ${e.toString()}');
  //        });
  //        emit(ShowCreateDatabaseState());
  //      },
  //      onOpen: (database) {
  //        print("database opened");
  //
  //      },
  //
  //    );
  //
  //  }
  //  insertDatabase({
  //    required String name,
  //    required String description,
  //    required String email,
  //    required String image,
  //  }) async {
  //    await database.transaction((txn) async {
  //       await txn
  //          .rawInsert('INSERT INTO tasks (name, description, email, image) VALUES("${name.toString()} ","${description.toString()}","${email.toString()}","${image.toString()}")')
  //          .then((value) {
  //        print("$value inserted successfully");
  //
  //        getData(database).then((value) {
  //          // setInList(value);
  //          deckListView.task1.cast().add(
  //              {"name":"$name","description":"$description","email":"$email","image":"$image",}
  //          );
  //          print(deckListView.task1);
  //          print("==================================================");
  //          print(deckListView.task1.length);
  //          emit(ShowGetDataState());
  //        });
  //
  //      }).catchError((e) {
  //        print("not good");
  //      });
  //    });
  //    emit(ShowInsertDatabaseState());
  //    return null;
  //  }
  //
  // static dynamic getData(database) async {
  //    return await database.rawQuery("SELECT * FROM tasks");
  //  }
  //
  //  void deltedb(int id){
  //    database
  //        .rawDelete('DELETE FROM tasks WHERE id = ?', [id]);
  //    print ("delete ");
  //  }

// void getData(database)async{
//   List<Map> task= await database.rawQuery("SELECT * FROM tasks");
//   print(task);
// }

  List task = [];

// realtime firebase
//   final databaseRef = FirebaseDatabase.instance.reference();
//
//   setDataInFirebase({
//     required String name,
//     required String description,
//     required String email,
//     required String image,
// }){
//     databaseRef.push().set({
//       'name': "$name",
//       'description': '$description',
//       "email":"$email",
//       "Image":"$image",
//     });
//     emit(ShowInsertFirebaseState());
//   }
//
//   getDataFromFirebase(){
//     databaseRef.once().then((DataSnapshot snapshot) {
//       print('Data : ${snapshot.value}');
//       task=snapshot.value;
//       print("\n\nthis is the task $task\n\n");
//       print(task.length);
//
//     });
//
//     emit(ShowGetDataState());
//   }
//

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

  // getDataFromFirestore() async {
  //   CollectionReference _collectionRef =
  //   FirebaseFirestore.instance.collection('data');
  //
  //   // Get docs from collection reference
  //   QuerySnapshot querySnapshot = await _collectionRef.get();
  //
  //   // Get data from docs and convert map to List
  //   final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
  //
  //   task=allData;
  //   print(task);
  //   print(task.length);
  //   print(allData);
  //
  // }

}
