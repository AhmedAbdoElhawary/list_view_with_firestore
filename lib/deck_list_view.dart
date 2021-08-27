import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_again/firebase_firestore/Firestore.dart';
import 'package:firestore_again/form_screen.dart';
import 'package:firestore_again/todo_task_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

final db = FirebaseFirestore.instance;
final docsCollectionRef = db.collection('data');

class deckListView extends StatelessWidget {
  final docsSnapshots = docsCollectionRef.snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: docsSnapshots,
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        final docs = snapshot.data!.docs;

        return ListView.separated(
            physics: BouncingScrollPhysics(),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              var taskDoc = docs[index];
              return taskListItem(taskDoc: taskDoc, context: context);
            },
            separatorBuilder: (context, index) => Container(
                  width: double.infinity,
                  height: 5,
                ));
      },
    );
  }

  Widget taskListItem({required taskDoc, var context}) {
    var taskData = taskDoc.data();
    return taskListItemInkwell(
        child: Row(
          children: [
            taskListItemImage(taskData['image']),
            taskListItemInfo([
              BuildText(taskData["name"]),
              VerticalDivider(10),
              BuildText(taskData["description"]),
              ListItemActionBtns(taskDoc.id, taskData, context),
            ]),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    TodoTaskPage(model: taskData, id: taskDoc.id)),
          );
        });
  }

  Container taskListItemInfo(children) {
    return Container(
      width: 200,
      padding: EdgeInsets.only(top: 15, left: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  InkWell taskListItemInkwell({child, onTap}) {
    return InkWell(
      onTap: onTap,
      child: Card(
          shadowColor: Colors.blue[300],
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 4,
          margin: EdgeInsets.all(5.0),
          child: Container(
            color: Colors.white,
            height: 105,
            alignment: AlignmentDirectional.bottomEnd,
            child: child,
          )),
    );
  }

  SizedBox VerticalDivider(double height) => SizedBox(height: height);

  Row ListItemActionBtns(String taskDocId, taskData, context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        DeleteListItemBtn(taskDocId, taskData),
        EditListItemBtn(context, taskData, taskDocId),
      ],
    );
  }

  IconButton DeleteListItemBtn(String taskDocId, taskData) {
    return IconButton(
      icon: Icon(Icons.delete_outline),
      onPressed: () async {
        FirestoreOperation().deleteDataFirestore(
            id: taskDocId, model: taskData, fromUpdate: false);
      },
    );
  }

  IconButton EditListItemBtn(context, taskData, String taskDocId) {
    return IconButton(
      icon: Icon(Icons.edit_outlined),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => new FormScreen(
                    taskData: taskData,
                    taskDocId: taskDocId,
                    isUpdatingTask: true)));
      },
    );
  }

  SizedBox HorizontalDivider(double width) => SizedBox(width: width);

  Text BuildText(model) {
    return Text(
      model,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

Image taskListItemImage(String imageUrl) => Image.network(
      imageUrl,
      width: 130,
      height: 110,
      fit: BoxFit.fill,
    );
