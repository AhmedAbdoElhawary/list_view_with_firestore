import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'NavigationBar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Stream collectionStream = FirebaseFirestore.instance.collection('users').snapshots();
  // FirebaseFirestore.instance
  //     .collection('data')
  //     .get()
  //     .then((QuerySnapshot querySnapshot) {
  //   querySnapshot.docs.forEach((doc) {
  //     print("${doc["name"]} done !");
  //   });
  // });
  //   QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("data").get();
  //   for (int i = 0; i < querySnapshot.docs.length; i++) {
  //     var a = querySnapshot.docs[i];
  //     print(a.data());
  //   }
// final databaseReference = FirebaseFirestore.instance;
//
//   await databaseReference.collection("books")
//       .doc("1")
//       .set({
//     'title': 'Mastering Flutter',
//     'description': 'Programming Guide for Dart'
//   });
//
//   DocumentReference ref = await databaseReference.collection("books")
//       .add({
//     'title': 'Flutter in Action',
//     'description': 'Complete Programming Guide to learn Flutter'
//   });

  // CollectionReference users = FirebaseFirestore.instance.collection('users');

  // FirebaseApp secondaryApp = Firebase.app('SecondaryApp');
  // FirebaseFirestore firestore = FirebaseFirestore.instanceFor(app: secondaryApp);
  // users.add({
  // 'full_name': "fullName", // John Doe
  // 'company': "company", // Stokes and Sons
  // 'age': "age" ,})
  //     .then((value) => print("user added $value"))
  //     .catchError((error)=>print("error catched $error" ));
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp().whenComplete(() => print("completed"));

  //runApp( MyApp());

  // WidgetsFlutterBinding.ensureInitialized();
  // DatabaseReference ref=FirebaseDatabase.instance.reference().child('name');
  // ref.set("20");
  // FirebaseFirestore.instance.doc("test/test").get().then((v) {
  //   print(v.data());
  // });

  // Bloc.observer = MyBlocObserver();

  //runApp( MyApp());
  // entries.add();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AppSheet',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: NavigationBar(),
    );
  }
}
