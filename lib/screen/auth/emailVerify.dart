import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/screen/home/nav_bar.dart';

class emailVerify extends StatefulWidget {
  const emailVerify({Key? key}) : super(key: key);

  @override
  State<emailVerify> createState() => _emailVerifyState();
}

class _emailVerifyState extends State<emailVerify> {
  bool isEmailVerifired = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();  

    // user needs to be created before!
    isEmailVerifired  = FirebaseAuth.instance.currentUser!.emailVerified ;

    if (!isEmailVerifired) {
      sendVerificationEmail();

      Timer.periodic(Duration(seconds: 3), 
        (_) => checkEmailVerifired(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose(); 
  }

  Future checkEmailVerifired() async {
    // call after email verification!
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerifired = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerifired) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
    } catch (e) {
      print(e.toString());
    }
    
  }

  Widget build(BuildContext context) => isEmailVerifired
    ? NavBar()
    : Scaffold(
      appBar: AppBar(title: const Text("Verify Email"),
              toolbarHeight: 50,
              titleTextStyle: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
    ));
  }