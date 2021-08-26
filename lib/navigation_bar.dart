import 'package:flutter/material.dart';
import 'card_grid_view.dart';
import 'deck_list_view.dart';
import 'form_screen.dart';
import 'gallery_screen_home.dart';

List<Widget> list_widget = [
  deckListView(),
  CardGridView(),
  galleryScreenHome(),
];

int c_index = 0;

class NavigationBar extends StatefulWidget {

  @override
  State<NavigationBar> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(),
        drawer: AppDrawer(),
        body: list_widget[c_index],
        bottomNavigationBar: BottomNavBar(),
        floatingActionButton: FloatingActionBtn(context),
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
          MaterialPageRoute(builder: (context) =>new FormScreen(checkForWhichPath: false,id: "")),
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

  BottomNavigationBar BottomNavBar() {
    BottomNavigationBarItem BottomNavIcon(IconData iconData, String label) {
      return BottomNavigationBarItem(icon: Icon(iconData), label: label);
    }

    return BottomNavigationBar(
      selectedItemColor: Colors.lightBlueAccent[350],
      currentIndex: c_index,
      onTap: (value) {
        setState(() {
          c_index = value;
        });
      },
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
          paddingAppDrawer(),
          paddingAppDrawer(),
          paddingAppDrawer(),
          paddingAppDrawer(),
        ],
      ),
    );
  }

  Padding paddingAppDrawer(){
    return Padding(
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
    );
  }
}
