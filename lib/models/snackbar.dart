// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/auth/login.dart';
// TODO : var setup
var success = Colors.green;
var error = Colors.red; 
var padding = EdgeInsets.all(20);

// ! : Login W Google success
  void GoogleLoginSnackBar(BuildContext context) {
      final snackBar = SnackBar(
        content: Text('Welcome ${FirebaseAuth.instance.currentUser!.displayName},\n Login with Google is successful'),
        backgroundColor: success,
        padding: padding,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

// ! : Login W email & password success
  void LoginSuccessSnackBar(BuildContext context) {
      final snackBar = SnackBar(
        content: Text('Welcome ${FirebaseAuth.instance.currentUser!.email}, Login is successful'),
        backgroundColor: success,
        padding: padding,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

// ! : Logout success
  void LogoutSuccessSnackBar(BuildContext context) {
      final snackBar = SnackBar(
        content: Text('You has logged out'),
        backgroundColor: error,
        padding: padding,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

// ! : User not found
  void UserFoundSnackBar(BuildContext context) {
      final snackBar = SnackBar(
        content: Text('Error, User not found'),
        backgroundColor: error,
        padding: padding,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

// ! : Username not found
  void UsernameErrorSnackBar(BuildContext context) {
      final snackBar = SnackBar(
        content: Text('Please enter your name!'),
        backgroundColor: error,
        padding: padding,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  
// ! : Create account is successful
  void CreateAccountSnackBar(BuildContext context) {
      final snackBar = SnackBar(
        content: Text('Create account is successful!'),
        backgroundColor: success,
        padding: padding,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }