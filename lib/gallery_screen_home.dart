import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_again/cubit/big_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/logic_cubit.dart';

class galleryScreenHome extends StatelessWidget {
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

              return GridView.builder(
                padding: EdgeInsets.all(15),
                physics: BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) =>
                    cubit.buildTwoContainerGridView(docs[index]),
                itemCount: docs.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 2 / 3,
                  mainAxisExtent: 200,
                  crossAxisCount: 2,
                ),
              );
            });
      },
    );
  }
}
