import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_again/card_grid_view.dart';
import 'package:firestore_again/cubit/big_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../deck_list_view.dart';
import '../gallery_screen_home.dart';

class LogicShowCubit extends Cubit<BigShowStates> {
  LogicShowCubit() : super(ShowInitialState());

  static LogicShowCubit get(context) =>
      BlocProvider.of<LogicShowCubit>(context);

  int c_index = 0;
  getIndex(int i) {
    c_index = i;
    emit(ShowGetIndexState());
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
      'name': name,
      'description': description,
      "email": email,
      "image": image,
    });
    emit(ShowInsertFirestoreState());
  }
}
