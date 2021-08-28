import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_again/firebase_firestore/Firestore.dart';
import 'package:firestore_again/form_screen.dart';
import 'package:firestore_again/information_of_item_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class deckListView extends StatelessWidget {
  var dbRef = FirebaseFirestore.instance.collection("data").snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: dbRef,
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        final docs = snapshot.data!.docs;

        return ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => buildPaddingListView(
              model: docs[index], context: context, id: docs[index].id),
          separatorBuilder: (context, index) => Container(
            width: double.infinity,
            height: 5,
          ),
          itemCount: docs.length,
        );
      },
    );
  }

  Widget buildPaddingListView(
      {required model, var context, required String id}) {
    return InkWell(
      child: Card(
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
                model["image"],
                width: 130,
                height: 110,
                fit: BoxFit.fill,
              ),
              SizedBox(width: 6),
              Container(
                width: 200,
                padding: EdgeInsets.only(top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BuildText(model["name"]),
                    SizedBox(height: 10),
                    BuildText(model["description"]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () async {
                            FirestoreOperation().deleteDataFirestore(
                                id: id, model: model, fromUpdate: false);
                          },
                          icon: Icon(Icons.delete_outline),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => new FormScreen(
                                        model: model,
                                        id: id,
                                        whichPageCome: true)));
                          },
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
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  InformationOfItemPage(model: model, id: id)),
        );
      },
    );
  }

  Text BuildText(model) {
    return Text(
      model,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
