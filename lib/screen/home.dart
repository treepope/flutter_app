import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/screen/login.dart';

import '../services/firebase_services.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  initState() {
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text('Login'),),
      body: Container(
        child: ElevatedButton(
          child: Text("Logout"),
            onPressed: () async {
              await FirebaseServices().googleSignOut();
              Navigator.push(
                context, MaterialPageRoute(
                  builder: (context) => LoginScreen(User)));
              },
        ),
      ),
    );
  }
}
