import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/proflie.dart';
import 'package:flutter_application_1/models/snackbar.dart';
import 'package:flutter_application_1/screen/auth/login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? username;
  Profile profile = Profile();
  final formKey = GlobalKey<FormState>();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final CollectionReference registerCollection = FirebaseFirestore.instance.collection('register');
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController = TextEditingController();
  var _obscureText = true;

  void _togglePasswodView() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(title: const Text("Eror"),
              toolbarHeight: 50,
              titleTextStyle: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
              ),
              body: Center(child: Text("${snapshot.error}")),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(title: const Text("Sign up"),
                toolbarHeight: 50,
                // centerTitle: true,
                backgroundColor: const Color.fromARGB(255, 60, 145, 255),
                titleTextStyle: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
            ),
              body: Padding(
                padding: const EdgeInsets.fromLTRB(30, 80, 30, 0),
                child: Form(key: formKey,
                    child: SingleChildScrollView(
                        child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      
                      children: [
                        const Text("Come to sign up!", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),

                        Container( margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),height: 5),

                        const Text("enter your information", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),

                        Container(margin: const EdgeInsets.fromLTRB(0, 5, 0, 20),height: 20),
                        
                        // TextFormField(
                        //   decoration: const InputDecoration(labelText: 'username'),
                        //   controller: usernameController,
                        //   keyboardType: TextInputType.text,
                        //   validator: MultiValidator([
                        //     RequiredValidator(
                        //       errorText: "Please enter your name"),
                        //   ]),
                        //   onSaved: (String? username) {
                        //     profile.username = username;
                        //   },
                        // ),

                        const SizedBox(height: 15),

                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'email account',
                          ),
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: "Please enter your email"),
                            EmailValidator(errorText: "Invalid email format!")
                          ]),
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (String? email) {
                            profile.email = email;
                          },
                        ),
                        
                        const SizedBox(height: 15),

                        TextFormField(
                          obscureText: _obscureText,
                          maxLength: 12,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                          ),
                          keyboardType: TextInputType.text,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: "Please enter your password"),
                          ]),
                          onSaved: (String? password) {
                            profile.password = password;
                          },
                        ),

                        const SizedBox(
                          height: 15,
                        ),
                        
                        TextFormField(
                          obscureText: _obscureText,
                          maxLength: 12,
                          decoration: InputDecoration(
                            labelText: 'confirm password',
                            // prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText ? Icons.visibility : Icons.visibility_off),
                                onPressed: _togglePasswodView,
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          validator: (String? value){
                            
                            if (value!.isEmpty){
                              return "Please enter re-password";
                            } print(passwordController.text) ; print(confirmpasswordController.text);

                            if (passwordController.text != confirmpasswordController.text){
                              return "Password doesn't match";
                            } return null;
                          },
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                          width: double.infinity,
                          height: 40,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)
                            )
                          ),
                            child: const Text('Sign up',style: TextStyle(fontSize: 16),),
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState?.save();
                                
                                registerCollection.add({
                                  "Username" : profile.username,
                                  "Email" : profile.email,
                                  "Password" : profile.password,
                                  "Create" : Timestamp.now(),

                                });
                                try {
                                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                          email: profile.email!,
                                          password: profile.password!).then((value) {
                                    formKey.currentState?.reset();
                                    // Get.to(() => const emailVerify());
                                    Get.to(() => LoginScreen(User));
                                    CreateAccountSnackBar(context);
                                  });

                                } on FirebaseAuthException catch (e) {
                                  print(e.code);
                                  // print(e.message);
                                  var msg;
                                  msg = msg.toString();
                                  if (e.code == 'email-already-in-use') {
                                    msg = "email already in use";
                                  } else if (e.code == 'weak-password') {
                                    msg = "password must be long 6 characters or more";
                                  }

                                  // final CreateUserSnackBar = SnackBar(
                                  //   content: Text(msg),
                                  //   backgroundColor: error,
                                  //   padding: padding,
                                  // );
                                  // ScaffoldMessenger.of(context).showSnackBar(CreateUserSnackBar);
                                  
                                  Fluttertoast.showToast(
                                      msg: msg, // default = e.message!
                                      gravity: ToastGravity.BOTTOM
                                  );
                                }
                                usernameController.clear();
                              }
                            },
                          ),
                        ),
                      ],
                    ))),
              ),
            );
          }
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        });
  }
}
