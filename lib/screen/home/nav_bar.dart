// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/home/home_screen.dart';
import 'package:flutter_application_1/screen/navigator/account/account_home.dart';
import 'package:flutter_application_1/screen/navigator/nav_page.dart';
import 'package:flutter_application_1/screen/navigator/tasks/tasks_home.dart';

import '../navigator/notes/note_fetchData.dart';

class NavBar extends StatefulWidget {

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;
  late ScrollController controller = ScrollController();
  PageController pageController = PageController(initialPage: 0);
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  
  static const List<BottomNavigationBarItem> NavItems = <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.done_all_rounded), label: 'Done'),
            BottomNavigationBarItem(icon: Icon(Icons.my_library_books_rounded), label: 'Notes'),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle_rounded), label: 'Account'),
          ];

  @override
  void initState(){
    super.initState();
    controller = ScrollController();
  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    drawer: NavPage(),
    body: NestedScrollView(
      controller: controller,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => <Widget>[
        const SliverAppBar(
          pinned: true,
          floating: true,
          snap: true,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Text('Do app'),
          ),
        ),
      ], 
      body: PageView(
        controller: pageController,
        onPageChanged: (newIndex){
          setState(() {
            _selectedIndex = newIndex;
          });
        },
        children: const [
          HomeScreen(),
          TasksPage(),
          FetchData(),
          AccountPage(),
        ],
      ),
    ),
    bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            items: NavItems,
            currentIndex: _selectedIndex,
            backgroundColor: Colors.blue,
            selectedItemColor: Colors.blue,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
            iconSize: 27.0,
            unselectedItemColor: Colors.grey[600],
            onTap: (index) {
              pageController.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.ease);
          },
          ),
         
        
  );
}