// ignore_for_file: deprecated_member_use, unused_field

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
      toolbarHeight: 40,
      // centerTitle: true,
      backgroundColor: Color.fromARGB(255, 60, 145, 255),
      titleTextStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
      ),
      body: Container(decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/img/login-cover.png'),
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter)),

        child: Padding(padding: const EdgeInsets.fromLTRB(30, 210, 30, 20),
          child: Form(key: formKey,
            child: SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // const Text('Sign in', style: TextStyle(
                  //   fontSize: 30,
                  //   fontWeight: FontWeight.w900,
                  // )),

                  const Text('Welcome',style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                      )),
                  
                  const Text('Sign in to continue!',style: TextStyle(
                        fontSize: 16,
                      )),
                 
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                    height: 20,
                  ),

                  // SvgPicture.asset('assets/img/login-cover.svg'),
                  // Image.asset(
                  //   'assets/img/login-cover.png',
                  // ),
                     
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email account',
                    ),
                    keyboardType: TextInputType.emailAddress,
    
                  ),
                  
                  const SizedBox(
                    height: 15,
                  ),
                  
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    obscureText: true,
                    keyboardType: TextInputType.text,
               
                  ),
                  
                  const SizedBox(
                    height: 15,
                  ),
                  
                  // Container(
                  //   child: Text('Sign up',
                  //     textScaleFactor: 2,
                  //     style: TextStyle(fontSize: 10,color: Colors.black),
                  //   ),
                    
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(12),
                  //     color: Color.fromARGB(255, 231, 0, 0),
                  //   ),
                    
                  //   width: double.infinity,
                  //   height: 40,
                  //   alignment: Alignment.center, 
                  // ),
                  
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10)
                        )
                      ),
                    child: Text('Sign up',style: TextStyle(fontSize: 16),),
                      onPressed: () {

                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                            return LoginScreen();
                        }));
                      },
                    ),
                  ),
                  

                  Container(
                    margin: EdgeInsets.fromLTRB(60, 80, 60, 0),
                    width: double.infinity,
                    height: 32,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 23, 202, 77),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10),
                        )
                      ),
                    child: Text('Create new account',style: TextStyle(fontSize: 16),),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return JoinScreen();
                        }));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
