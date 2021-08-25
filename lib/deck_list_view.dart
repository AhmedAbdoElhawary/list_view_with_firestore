import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_again/cubit/big_states.dart';
import 'package:firestore_again/cubit/logic_cubit.dart';
import 'package:firestore_again/form_screen.dart';
import 'package:firestore_again/information_of_item_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class deckListView extends StatelessWidget {
  var fire = FirebaseFirestore.instance.collection("data");
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogicShowCubit, BigShowStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return StreamBuilder(
          stream: fire.snapshots(),
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
      },
    );
  }

  Widget buildPaddingListView({required model, var context, required String id}) {
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
                "${model["image"]}",
                width: 130,
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
                          onPressed: () async {
                            LogicShowCubit.get(context).deleteDataFromFirestore(id: id);
                          },
                          icon: Icon(Icons.delete_outline),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>new FormScreen(model: model,id: id,check:true)),

                            );
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
          MaterialPageRoute(builder: (context) => InformationPage(model: model,id:id,)),
        );
      },
    );
  }
}
