import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/auth/joinRegister.dart';
import 'package:flutter_application_1/screen/home/nav_bar.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:form_field_validator/form_field_validator.dart';  
import 'package:flutter_application_1/services/firebase_services.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/models/proflie.dart';
import 'package:flutter_application_1/models/snackbar.dart';

import '../../main.dart';

class LoginScreen extends StatefulWidget {
  dynamic user = FirebaseAuth.instance.currentUser;
  LoginScreen(this.user, {Key ?key}) : super(key: key);
  
  @override
  _LoginScreenState createState() => _LoginScreenState();}

class _LoginScreenState extends State<LoginScreen> { 
  final formKey = GlobalKey<FormState>(); 
  Profile profile = Profile();
  var _obscureText = true;
  Map<String, dynamic>? _userData;
  AccessToken? _accessToken;
  bool _checking = true;

  // notification google
Future<void> _showNotification_Google() async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      'Do_noti_001' , 'General Notifications', 'noti',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'tricker'
    );

    const NotificationDetails platfromChannelDetails = 
    NotificationDetails(
      android: androidNotificationDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      0, 'Hello', '${FirebaseAuth.instance.currentUser!.displayName}', platfromChannelDetails);
  }

// notification signup
Future<void> _showNotification_SignUp() async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      'Do_noti_001' , 'General Notifications', 'noti',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'tricker'
    );

    const NotificationDetails platfromChannelDetails = 
    NotificationDetails(
      android: androidNotificationDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      0, 'Hello', '${FirebaseAuth.instance.currentUser!.email}', platfromChannelDetails);
  }


  static Future<User?> loginUsingEmailPassword({
    required String email, 
    required String password, 
    required BuildContext context }) async {
      FirebaseAuth auth = FirebaseAuth.instance;
      User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e){
      if (e.code == "user-not-found"){
        print("No User found that email");
      }
    }
    return user;
  }

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  bool validateSave(){
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else { return false; }
  }

  void _togglePasswodView() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    
    return Scaffold(
      body: Container(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/img/login-cover.png'),
          fit: BoxFit.fitWidth,
          alignment: Alignment.topCenter,
        ),
      ),
         child: Container(margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Form(key: formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(padding: EdgeInsets.fromLTRB(0, 150, 0, 20)),
                  // TODO : Text Title
                  const Text('Welcome',style: TextStyle(fontSize: 32,fontWeight: FontWeight.w900,)),
                  const Text('Sign in to continue!',style: TextStyle(fontSize: 16,)),
                 
                  Container(margin: const EdgeInsets.fromLTRB(0, 0, 0, 0), height: 20),

                  // TODO : Email FormField 
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email account',
                      prefixIcon: Icon(Icons.email),
                    ),
                    // controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: MultiValidator([
                      RequiredValidator(
                        errorText: "Please enter your email"),
                      EmailValidator(errorText: "Invalid email format!")
                    ]),
                  ),
                  
                  const SizedBox(height: 15),

                  // TODO : Password FormField
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscureText,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      // suffixIcon: IconButton(
                      //   icon: Icon(
                      //     _obscureText ? Icons.visibility : Icons.visibility_off),
                      //   onPressed: _togglePasswodView,
                      // ),
                    ),
                    keyboardType: TextInputType.text,
                    validator: MultiValidator([
                      RequiredValidator(
                        errorText: "Please enter your password"),
                    ]),
                  ),
                  
                  const SizedBox(height: 15,),
                  
                  // TODO : Sign up
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
                            context: context
                          );
                            print(user);
                            formKey.currentState?.reset();
                            if (user != null) {
                              Get.to(() => NavBar());
                              LoginSuccessSnackBar(context);
                            } else {
                              UserFoundSnackBar(context);
                            } 
                        },
                      ),
                    ),
                  ),
                  

                  // TODO Facebook !
                  // InkWell(
                  //   child: Container(
                  //     margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                  //     width: double.infinity,
                  //     // alignment: Alignment.center,
                  //     child: ElevatedButton(
                  //         style: ElevatedButton.styleFrom(
                  //           shape: new RoundedRectangleBorder(
                  //             borderRadius: new BorderRadius.circular(10)
                  //           ),
                  //           // primary: Color.fromARGB(255, 255, 255, 255),
                  //           onPrimary: Colors.black,
                  //         ),
                  //     onPressed: () async {
                  //       // _userData != null ? _facebooklogout() : _facebooklogin();
                  //     },
                  //       child: Padding(
                  //         padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  //         child: Row(
                  //           mainAxisSize: MainAxisSize.min,
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: const [
                  //             Image(
                  //               image: AssetImage("assets/img/icon/facebook-white.png"),
                  //               height: 24,
                  //               width: 24,
                  //             ),
                  //             Padding(
                  //               padding: EdgeInsets.only(left: 24, right: 8),
                  //               child: Text(
                  //                 'Sign up with Facebook',
                  //                 style: TextStyle(
                  //                   fontSize: 18,
                  //                   color: Color.fromARGB(255, 255, 255, 255),
                  //                   fontWeight: FontWeight.w600,
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  // TODO : Sign in W Google acc
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
                            primary: const Color.fromARGB(255, 255, 255, 255),
                            onPrimary: Colors.black,
                          ),
                        onPressed: () async {
                          await FirebaseServices().signInWithGoogle();
                          Get.to(() => NavBar());
                          _showNotification_Google();
                          GoogleLoginSnackBar(context);
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
                                  'Sign up with Google',
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
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    alignment: Alignment.center,
                    child: const Text("───────────── or ─────────────",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(150, 160, 160, 160)
                      ),
                    ),
                  ),

                  // TODO : Create a new acc
                  InkWell(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(60, 20, 60, 0),
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
                          Get.to(JoinScreen());
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
