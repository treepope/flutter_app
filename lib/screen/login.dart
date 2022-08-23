import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  // final User user;


  // LoginScreen(this.user, {Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  initState() {
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text('Login'),),
      body: Container(child: Text("Welcome My Application has nothing")),
    );
  }
}
