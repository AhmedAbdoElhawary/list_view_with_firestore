import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'FormScreen.dart';
import 'cubit/bigStates.dart';
import 'cubit/logicCubit.dart';

class NevigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogicShowCubit(),
      child: BlocConsumer<LogicShowCubit, BigShowStates>(
        listener: (context, state) {},
        builder: (context, state) {
          LogicShowCubit cubit = LogicShowCubit.get(context);
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 2.7,
              ),
              drawer: Drawer(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.account_balance),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "test",
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.account_balance),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "test",
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.account_balance),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "test",
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.account_balance),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "test",
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              body: cubit.list_widget[cubit.c_index],
              bottomNavigationBar: BottomNavigationBar(
                selectedItemColor: Colors.lightBlueAccent[350],
                // selectedItemColor: cubit.list_color[cubit.c_index],
                currentIndex: cubit.c_index,
                onTap: (value) {
                  cubit.getIndex(value);
                },
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.list_outlined), label: 'list view'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.credit_card_sharp), label: 'card'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.table_chart_outlined), label: 'gallery'),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  // print("${LogicShowCubit.task}");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FormScreen()),
                  );
                },
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                ),
                backgroundColor: Colors.grey[100],
                elevation: 12,
              ),
            ),
          );
        },
      ),
    );
  }
}
