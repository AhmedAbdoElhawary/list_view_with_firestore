import 'package:firebase_core/firebase_core.dart';
import 'package:firestore_again/navigation_bar.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
