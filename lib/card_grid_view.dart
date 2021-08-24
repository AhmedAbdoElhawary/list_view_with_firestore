import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_again/cubit/big_states.dart';
import 'package:firestore_again/cubit/logic_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardGridView extends StatelessWidget {
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

              return GridView.builder(
                padding: EdgeInsets.all(7),
                physics: BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) =>
                    buildOneContainerGridView(docs[index]),
                itemCount: docs.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 20,
                  childAspectRatio: 2 / 3,
                  mainAxisExtent: 270,
                  crossAxisCount: 1,
                ),
              );
            });
      },
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
}