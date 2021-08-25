import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_again/cubit/big_states.dart';
import 'package:firestore_again/information_of_item_page.dart';
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
                    buildTwoContainerGridView(docs[index],context),
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

  Widget buildTwoContainerGridView(var model,var context) {
    return InkWell(
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shadowColor: Colors.blue,
        elevation: 9,
        margin: EdgeInsets.all(5.0),
        child: Container(
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage("${model["image"]}"),
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
                "${model["name"]}",
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
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => InformationPage(model)),
        );
      },
    );
  }
}
