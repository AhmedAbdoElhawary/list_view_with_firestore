import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_again/cubit/big_states.dart';
import 'package:firestore_again/cubit/logic_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class deckListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogicShowCubit, BigShowStates>(
      listener: (context, state) {},
      builder: (context, state) {
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
                  buildPaddingListView(docs[index]),
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
}
