import 'package:flutter/material.dart';
import 'package:teaching_firebase/auth/screens/login_screen.dart';
import 'package:teaching_firebase/home_screen/home_screen.dart';
import 'package:teaching_firebase/todo/screens/todo_screen.dart';

import '../notes/screens/view_note.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = "/bottom-bar";
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;

  List<Widget> pages = [
    const TodoScreen(),
    const ViewNotesScreen(),
    const HomeScreen(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: NavigationBar(
        indicatorColor: Colors.amber,
        selectedIndex: _page,
        elevation: 10,
        onDestinationSelected: updatePage,
        destinations: const [
          NavigationDestination(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          NavigationDestination(
            label: 'Favorites',
            icon: Icon(Icons.favorite),
          ),
          NavigationDestination(
            label: 'Profile',
            icon: Icon(
              Icons.person,
            ),
          ),
        ],
      ),
    );
  }
}
