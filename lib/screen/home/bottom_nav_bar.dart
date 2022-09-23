import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/snackbar.dart';
import 'package:flutter_application_1/screen/navigator/nav_page.dart';
import 'package:flutter_application_1/services/firebase_services.dart';
import 'package:flutter_application_1/screen/home/home_screen.dart';
import 'package:get/get.dart';

class BottomNavBar extends StatefulWidget {
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget> [
    HomeScreen(),
    Text('Done List', style: optionStyle,),
    Text('Tasks', style: optionStyle,),
    Text('My Account', style: optionStyle,),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavPage(),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex)),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.done_all_rounded), label: 'Done'),
            BottomNavigationBarItem(icon: Icon(Icons.my_library_books_rounded), label: 'Notes'),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle_rounded), label: 'Account'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
          iconSize: 27.0,
          unselectedItemColor: Colors.grey[600],
          onTap: _onItemTap,
        ),
    );
  }
    Widget _buildNavBar() => CustomScrollView(
      slivers: [
          const SliverAppBar(
            centerTitle: true,
            pinned: true,
            floating: true,
            snap: true,
            title: Text('Do app'),),
          SliverList(
            delegate: SliverChildListDelegate(
              [const Text('data',style: TextStyle(fontSize: 600),)]
            ),
          ),
        ],
    );

}