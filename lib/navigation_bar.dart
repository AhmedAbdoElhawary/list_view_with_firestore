import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'card_grid_view.dart';
import 'deck_list_view.dart';
import 'form_screen.dart';
import 'cubit/big_states.dart';
import 'cubit/logic_cubit.dart';
import 'gallery_screen_home.dart';

List<Widget> list_widget = [
  deckListView(),
  CardGridView(),
  galleryScreenHome(),
];

class NavigationBar extends StatelessWidget {
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
              appBar: MyAppBar(),
              drawer: AppDrawer(),
              body: list_widget[cubit.c_index],
              bottomNavigationBar: BottomNavBar(cubit),
              floatingActionButton: FloatingActionBtn(context),
            ),
          );
        },
      ),
    );
  }

  AppBar MyAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 2.7,
      iconTheme:IconThemeData.fallback() ,
    );
  }

  FloatingActionButton FloatingActionBtn(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
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
    );
  }

  BottomNavigationBar BottomNavBar(LogicShowCubit cubit) {
    BottomNavigationBarItem BottomNavIcon(IconData iconData, String label) {
      return BottomNavigationBarItem(icon: Icon(iconData), label: label);
    }

    return BottomNavigationBar(
      selectedItemColor: Colors.lightBlueAccent[350],
      currentIndex: cubit.c_index,
      onTap: (value) => cubit.getIndex(value),
      items: [
        BottomNavIcon(Icons.list_outlined, 'List View'),
        BottomNavIcon(Icons.credit_card_sharp, 'Card'),
        BottomNavIcon(Icons.table_chart_outlined, 'Gallery')
      ],
    );
  }

  Drawer AppDrawer() {
    return Drawer(
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
    );
  }
}
