import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_again/cubit/bigStates.dart';
import 'package:firestore_again/cubit/logicCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class deckListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogicShowCubit, BigShowStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = LogicShowCubit.get(context);

        return StreamBuilder(
          stream: FirebaseFirestore.instance.collection("data").snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            final docs = snapshot.data!.docs;

            return ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  cubit.buildPaddingListView(docs[index]),
              separatorBuilder: (context, index) => Container(
                width: double.infinity,
                height: 5,
              ),
              itemCount: docs.length,
            );
          },
        );
      },
    );
  }
}
