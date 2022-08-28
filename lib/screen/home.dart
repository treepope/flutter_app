// ignore_for_file: deprecated_member_use, unused_field

import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/joinApps.dart';
import 'package:flutter_application_1/screen/login.dart';
import 'package:flutter_application_1/screen/register.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter_application_1/model/proflie.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  dynamic user = FirebaseAuth.instance.currentUser;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email'
    ]);
  HomeScreen(this.user, {Key ?key}) : super(key: key);
  
  
  
  @override
  _HomeScreenState createState() => _HomeScreenState();}

class _HomeScreenState extends State<HomeScreen> { 
  
  static Future<User?> loginUsingEmailPassword({required String email, required String password, required BuildContext context }) async{
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try{
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e){
      if (e.code == "user-not-found"){
        print("No User found that email");
      }
    }
    return user;
  }

  Future<FirebaseApp> _initializeFirebase() async{
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }
  
  String? _email;
  String? _password;
  final formKey = GlobalKey<FormState>(); 
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignInAccount? _account;


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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  // void validateSubmit() async{
  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    return Scaffold(
      // appBar: AppBar(title: Text("Register/Login"),
      // toolbarHeight: 40,
      // // centerTitle: true,
      // backgroundColor: Color.fromARGB(255, 60, 145, 255),
      // titleTextStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
      // ),
      body: 
      Container(padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/img/login-cover.png'),
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter),
                ),
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
                    margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    height: 20,
                  ),

                  // SvgPicture.asset('assets/img/login-cover.svg'),
                  // Image.asset(
                  //   'assets/img/login-cover.png',
                  // ),
                     
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email account',
                    ),
                    validator: MultiValidator([
                      RequiredValidator(
                        errorText: "Please enter your email"),
                      EmailValidator(errorText: "Invalid email format!")
                            ]),
                    keyboardType: TextInputType.emailAddress,
    
                  ),
                  
                  const SizedBox(
                    height: 15,
                  ),
                  
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    validator: MultiValidator([
                      RequiredValidator(
                        errorText: "Please enter your password"),
                      ]),
               
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
                    margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10)
                        )
                      ),
                    child: const Text('Sign up',style: TextStyle(fontSize: 16),),
                      onPressed: () async{
                        User? user = await loginUsingEmailPassword(
                          email: _emailController.text, 
                          password: _passwordController.text, 
                          context: context);
                          print(user);
                          formKey.currentState?.reset();
                          if (user != null){
                            Navigator.push(context,MaterialPageRoute(builder: (context) => LoginScreen()));
                            Fluttertoast.showToast(
                              msg: 'Login is successful',
                              gravity: ToastGravity.BOTTOM
                            );
                          }
                          else if(user == null){
                            Fluttertoast.showToast(
                              msg: 'user not found!',
                              gravity: ToastGravity.BOTTOM
                            );
                          }
                      },
                    ),
                  ),
                  

                  Container(
                    margin: const EdgeInsets.fromLTRB(60, 80, 60, 0),
                    width: double.infinity,
                    height: 32,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 23, 202, 77),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10),
                        )
                      ),
                    child: const Text('Create new account',style: TextStyle(fontSize: 16),),
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
