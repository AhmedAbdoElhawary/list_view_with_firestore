import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_again/cubit/bigStates.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/logicCubit.dart';

class galleryScreenHome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogicShowCubit,BigShowStates>(

      listener: (context, state) {},
      builder: (context, state) {
        var cubit = LogicShowCubit.get(context);

        return StreamBuilder(
            stream: FirebaseFirestore.instance.collection("data").snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {

              if(snapshot.connectionState==ConnectionState.waiting){
                return CircularProgressIndicator();
              }

              final docs = snapshot.data!.docs;

              return GridView.builder(
                padding: EdgeInsets.all(15),
                physics: BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) =>
                    cubit.buildTwoContainerGridView(docs[index]),

                itemCount: docs.length,
                // Container(
                //
                //   width: double.infinity,
                //   alignment: Alignment.bottomCenter,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(5),
                //     color: Colors.white,
                //   ),
                //   child: Padding(
                //     padding: const EdgeInsets.all(15.0),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         SizedBox(height: 25,),
                //         Text(
                //           "Done",
                //           style: TextStyle(
                //             fontSize: 15,
                //             fontWeight: FontWeight.bold
                //           ),
                //         ),
                //         SizedBox(height: 40,),
                //         Text(
                //           "ahmed",
                //           style: TextStyle(
                //             fontSize: 25,
                //           ),
                //         ),
                //         Text(
                //           "personal",
                //           style: TextStyle(
                //             fontSize: 15,
                //             color: Colors.black38,
                //           ),
                //         ),
                //         SizedBox(height: 25,),
                //         Text(
                //           "ahmedabdo@gmail.com",
                //           style: TextStyle(
                //             fontSize: 16,
                //
                //           ),
                //         ),
                //         SizedBox(height: 25,),
                //         Row(mainAxisSize:  MainAxisSize.max,
                //           children: [
                //             Expanded(
                //                 child: Text(
                //                   'COMPOSE EMAIL\n(AUTHOR)',
                //                 ),
                //             ),
                //             Icon(Icons.edit_outlined),
                //             SizedBox(width: 30,),
                //             Icon(Icons.delete_outlined),
                //             SizedBox(width: 25,),
                //           ],
                //         ),
                //       ],
                //
                //     ),
                //   ),
                // ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 2 / 3,
                  mainAxisExtent: 200,
                  crossAxisCount: 2,
                ),
              );
            }
        );
      },
    );
  }
}













