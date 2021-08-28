import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_again/information_of_item_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class galleryScreenHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                buildTwoContainerGridView(docs[index], context, docs[index].id),
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
  }

  Widget buildTwoContainerGridView(var model, var context, String id) {
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
                maxLines: 1,
                textWidthBasis: TextWidthBasis.longestLine,
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TodoTaskPage(
                model: model,
                id: id,
              )),
        );
      },
    );
  }
}