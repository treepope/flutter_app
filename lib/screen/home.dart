import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/joinApps.dart';
import 'package:flutter_application_1/screen/login.dart';
import 'package:flutter_application_1/screen/register.dart';

import '../model/proflie.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {

  String? _email;
  String? _password;
  final formKey = GlobalKey<FormState>(); 
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool validateSave(){
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
      // print('Form is valid email: $_email, password: $_password');
    } else {
      return false;
      // print('Form is invalid email: $_email, password: $_password');
    }
  }

  // void validateSubmit() async{
  //   if (validateSave()) {
  //     FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email!, password: _password!);
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register/Login"),
      ),
      body: Container(decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/img/login-cover.png'),
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter)),

        child: Padding(padding: const EdgeInsets.fromLTRB(30, 220, 30, 20),
          child: Form(key: formKey,
            child: SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Welcome',style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      )),
                  
                  const Text('Sign in to continue!',style: TextStyle(
                        fontSize: 20,
                      )),
                 
                  const SizedBox(
                    height: 20,
                  ),

                  // SvgPicture.asset('assets/img/login-cover.svg'),
                  // Image.asset(
                  //   'assets/img/login-cover.png',
                  // ),
                  
                  const Text('E-mail', style: TextStyle(fontSize: 16)),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                  ),
                  
                  const SizedBox(
                    height: 15,
                  ),
                  
                  const Text('Password', style: TextStyle(fontSize: 16)),
                  TextFormField(
                    obscureText: true,
                  ),
                  
                  const SizedBox(
                    height: 15,
                  ),
                  
                  Container(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.login),
                      label: Text('Login', style: TextStyle(fontSize: 16)),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return LoginScreen();
                        }));
                      },
                    ),
                  ),
                  
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.add),
                      label: Text('Create account',
                          style: TextStyle(fontSize: 16)),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return JoinScreen();
                        }));
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
