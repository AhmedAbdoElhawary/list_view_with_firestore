import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_again/firebase_firestore/Firestore.dart';
import 'package:firestore_again/form_screen.dart';
import 'package:firestore_again/information_of_item_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'common_ui/grid_sliver_delegates.dart';

var dbrefSnap = FirebaseFirestore.instance.collection("data").snapshots();

typedef dbDoc = QueryDocumentSnapshot<Map<String, dynamic>>;
typedef dbDocData = Map<String, dynamic>;

class CardGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: dbrefSnap,
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return CircularProgressIndicator();
          final docs = snapshot.data!.docs;
          return CardGridViewBuilder(docs);
        });
  }

  GridView CardGridViewBuilder(List<dbDoc> docs) {
    return GridView.builder(
      padding: EdgeInsets.all(7),
      physics: BouncingScrollPhysics(),
      gridDelegate: CardGridSliverDelegate(),
      itemCount: docs.length,
      itemBuilder: (BuildContext context, int index) =>
          CardGridViewItem(docs[index].data(), context,docs[index].id),
    );
  }

  Widget CardGridViewItem(dbDocData docData, var context,String id) {
    return InkWell(
      child: Card(
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
              children: CardGridViewItemContent(docData,context,id),
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => InformationOfItemPage(model:docData,id: id,)),
        );
      },
    );
  }

  List<Widget> CardGridViewItemContent(dbDocData docData,var context,String id) {
    return [
      CardViewDivider(40),
      NameText(docData),
      DescriptionText(docData),
      CardViewDivider(25),
      EmailText(docData),
      CardViewDivider(25),
      CardViewActionItems(docData,context,id),
    ];
  }

  Row CardViewActionItems(var docData,var context,String id) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(child: Text('COMPOSE EMAIL\n(AUTHOR)')),
        IconButton(
          icon: Icon(Icons.edit_outlined),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>new FormScreen(whichPageCome: true,model:docData,id: id,)),

            );
          },
        ),
        CardViewDivider(35),
        IconButton(
          icon: Icon(Icons.delete_outline),
          onPressed: () {
            FirestoreOperation().deleteDataFirestore(id: id,model: docData,fromUpdate: false);
          },
        ),
        CardViewDivider(45)
      ],
    );
  }

  Text NameText(dbDocData docData) {
    return Text(
      docData['name'],
      style: TextStyle(fontSize: 25),
      maxLines: 1,
    );
  }

  Text DescriptionText(dbDocData docData) {
    return Text(
      docData["description"],
      style: TextStyle(fontSize: 15, color: Colors.black38),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Text EmailText(dbDocData docData) {
    return Text(
      docData["email"],
      style: TextStyle(
        fontSize: 16,
      ),
    );
  }

  SizedBox CardViewDivider(double height) => SizedBox(height: height);

}
