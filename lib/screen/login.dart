// ignore_for_file: unnecessary_new

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/joinApps.dart';
import 'package:flutter_application_1/screen/home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../services/firebase_services.dart';

class LoginScreen extends StatefulWidget {
  dynamic user = FirebaseAuth.instance.currentUser;
  LoginScreen(this.user, {Key ?key}) : super(key: key);
  
  @override
  _LoginScreenState createState() => _LoginScreenState();}

class _LoginScreenState extends State<LoginScreen> { 
  
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
  
// Future<void> loginWithGoogle(BuildContext context) async {
//     GoogleSignIn googleSignIn = GoogleSignIn(
//       scopes: [
//         'https://www.googleapis.com/auth/contacts.readonly',
//       ],
//     );
//     GoogleSignInAccount? user = await googleSignIn.signIn();
//     GoogleSignInAuthentication userAuth = await user!.authentication;

//     await _auth.signInWithCredential(GoogleAuthProvider.credential(
//         idToken: userAuth.idToken, accessToken: userAuth.accessToken));
//     // checkAuth(context); // after success route to home.
//   }

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

                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Email account',
                    ),
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: MultiValidator([
                      RequiredValidator(
                        errorText: "Please enter your email"),
                      EmailValidator(errorText: "Invalid email format!")
                            ]),
                  ),
                  
                  const SizedBox(
                    height: 15,
                  ),
                  
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    controller: _passwordController,
                    keyboardType: TextInputType.text,
                    validator: MultiValidator([
                      RequiredValidator(
                        errorText: "Please enter your password"),
                      ]),
                    obscureText: true,
                  ),
                  
                  const SizedBox(
                    height: 15,
                  ),
                  
                  InkWell(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10)
                          )
                        ),
                      child: const Text('Sign up',style: TextStyle(fontSize: 18 ),),
                        onPressed: () async{
                          User? user = await loginUsingEmailPassword(
                            email: _emailController.text, 
                            password: _passwordController.text, 
                            context: context);
                            print(user);
                            formKey.currentState?.reset();
                            if (user != null){
                              Navigator.push(context,MaterialPageRoute(builder: (context) => HomeScreen()));
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
                  ),
                  


                  InkWell(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                      width: double.infinity,
                      // alignment: Alignment.center,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10)
                            ),
                            // primary: Color.fromARGB(255, 255, 255, 255),
                            onPrimary: Colors.black,
                          ),
                        onPressed: () async {},
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Image(
                                image: AssetImage("assets/img/icon/facebook-white.png"),
                                height: 24,
                                width: 24,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 24, right: 8),
                                child: Text(
                                  'Sign in with Google',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  
                  InkWell(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                      // alignment: Alignment.center,
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10)
                            ),
                            primary: Color.fromARGB(255, 255, 255, 255),
                            onPrimary: Colors.black,
                          ),
                        onPressed: () async {
                          await FirebaseServices().signInWithGoogle();
                          Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Image(
                                image: AssetImage("assets/img/icon/google.png"),
                                height: 24,
                                width: 24,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 24, right: 8),
                                child: Text(
                                  'Sign in with Google',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                    alignment: Alignment.center,
                    child: const Text("───────────── or ─────────────",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(150, 160, 160, 160)
                      ),
                    ),
                  ),

                  InkWell(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(60, 30, 60, 0),
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
