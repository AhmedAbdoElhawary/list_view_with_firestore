import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_again/cubit/big_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogicShowCubit extends Cubit<BigShowStates> {
  LogicShowCubit() : super(ShowInitialState());

  static LogicShowCubit get(context) => BlocProvider.of<LogicShowCubit>(context);

  int c_index = 0;
  getIndex(int i) {
    c_index = i;
    emit(ShowGetIndexState());
  }

  var fire=FirebaseFirestore.instance.collection('data');

  setDataInFirestore({
    required String name,
    required String description,
    required String email,
    required String image,
  }) {
    fire.add({
      'name': name,
      'description': description,
      "email": email,
      "image": image,
    });
    emit(ShowInsertFirestoreState());
  }
//   updateFirestore({required String name, required String description, required String email, required String image, required String id}){
//     fire.doc(id)
//         .update({
//     'name': name,
//     'description': name,
//     "email":name,
//     "image": name,})
//         .then((value) => print("User Updated"))
//         .catchError((error) => print("Failed to update user: $error"));
// }
  deleteDataFromFirestore({required String id}){
    fire.doc(id)
        .delete()
        .then((value) => print("deleting successfully"))
        .catchError((e) => print(
        "$e \nerror while deleting the element"));
  }
  // var model;
  // var model;
  // dataOfItem({var model}){
  //   this.model=model;
  // }
  // bool checkItem=false;
  // setCheckItem({required bool b}){
  //   checkItem=b;
  // }
}
