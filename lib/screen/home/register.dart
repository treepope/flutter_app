import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/proflie.dart';
import 'package:flutter_application_1/screen/home/login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  CollectionReference _registerCollection = FirebaseFirestore.instance.collection('register');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(title: Text("Eror"),
              ),
              body: Center(child: Text("${snapshot.error}")),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(title: Text("Sign up"),
                toolbarHeight: 40,
                // centerTitle: true,
                backgroundColor: Color.fromARGB(255, 60, 145, 255),
                titleTextStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
            ),
              body: Padding(
                padding: const EdgeInsets.fromLTRB(30, 110, 30, 0),
                child: Container(
                  child: Form(key: formKey,
                      child: SingleChildScrollView(
                          child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        
                        children: [
                       
                          const Text("What's your email",style: 
                            TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),

                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            height: 5,
                          ),

                          const Text("enter your email",style: 
                            TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),

                          Container(
                            margin: EdgeInsets.fromLTRB(0, 5, 0, 20),
                            height: 20,
                          ),

                          TextFormField(
                            decoration: InputDecoration(
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
                          
                          const SizedBox(
                            height: 15,
                          ),

                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'password',
                            ),
                            controller: password,
                            keyboardType: TextInputType.text,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: "Please enter your password"),
                            ]),
                            obscureText: true,
                            onSaved: (String? password) {
                              profile.password = password;
                            },
                          ),

                          const SizedBox(
                            height: 15,
                          ),
                          
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'confirm password',
                            ),
                            controller: confirmpassword,
                            obscureText: true,
                            keyboardType: TextInputType.text,
                            validator: (String? value){
                              
                              if(value!.isEmpty)
                              {
                                return "Please enter re-password";
                              }print(password.text) ; print(confirmpassword.text);

                              if(password.text != confirmpassword.text){
                                return "Password does not match";
                              } return null;
                            },
                          ),

                          const SizedBox(
                            height: 15,
                          ),

                          Container(
                            margin: EdgeInsets.fromLTRB(0, 70, 0, 0),
                            width: double.infinity,
                            height: 40,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(12)
                              )
                            ),
                              child: Text('Sign up',style: TextStyle(fontSize: 16),),
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState?.save();
                                  
                                  _registerCollection.add({
                                    "email" : profile.email,
                                    "password" : profile.password,

                                  });
                                  try {
                                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                            email: profile.email!,
                                            password: profile.password!).then((value) {
                                      formKey.currentState?.reset();
                                      
                                      Fluttertoast.showToast(
                                          msg: 'create account is successful!',
                                          gravity: ToastGravity.BOTTOM
                                      );

                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                        return LoginScreen(User);
                                      }));
                                    });

                                  } on FirebaseAuthException catch (e) {
                                    print(e.code);
                                    // print(e.message);
                                    var msg;
                                    if (e.code == 'email-already-in-use') {
                                      msg = "email already in use";
                                    } else if (e.code == 'weak-password') {
                                      msg =
                                          "password must be long 6 characters or more";
                                    }

                                    Fluttertoast.showToast(
                                        msg: msg, // default = e.message!
                                        gravity: ToastGravity.BOTTOM
                                    );
                                  }
                                }
                              },
                            ),
                          ),
                        ],
                      ))),
                ),
              ),
            );
          }
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        });
  }
}
