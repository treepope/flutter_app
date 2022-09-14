import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/snackbar.dart';
import 'package:flutter_application_1/screen/auth/register.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter_application_1/models/proflie.dart';
import 'package:flutter_application_1/services/users.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/models/snackbar.dart';

class GetUserName extends StatefulWidget {
  @override
  State<GetUserName> createState() => _GetUserNameState();
}

class _GetUserNameState extends State<GetUserName> {
  var firestoreCollection = [
    'username', 
    'register',
    ];
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile();
  final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  String? username;
  late TextEditingController usernameController;

  void UsernameSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text("What's up $username come to sign up!"),
      backgroundColor: success,
      padding: padding,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void initState(){
    super.initState();
    usernameController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
  }

  void logout() {
    _auth.signOut();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create account"),
        toolbarHeight: 50,
        // centerTitle: true,
        backgroundColor: Color.fromARGB(255, 60, 145, 255),
        titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(30, 170, 30, 0),
          child: Center(
            child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Text(
                  "What's your name",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                
                const SizedBox(height: 10),
                
                const Text(
                  "Enter the name to use in Do",
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 30),
                
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Username'),
                  controller: usernameController,
                  keyboardType: TextInputType.text,
                  validator: MultiValidator([
                    RequiredValidator(
                      errorText: "Please enter your name"),
                  ]),
                  onChanged: (value) {
                    username = value;
                  },
                  onSaved: (String? username) {
                    profile.username = username;
                  },
                ),
                
                const SizedBox(height: 60),
                
                Container(
                  margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: const Text('Next', style: TextStyle(fontSize: 16),),
                    onPressed: () async {
                      _fireStore.collection(firestoreCollection[0]).add({
                        'username' : username,
                        'create' : Timestamp.now(),
                      });

                      try {
                        if (username != null) {
                          Get.to(RegisterScreen());
                          UsernameSnackBar(context);
                          // Fluttertoast.showToast(
                          //   msg: "What's up $username come to sign up!",
                          //   gravity: ToastGravity.BOTTOM
                          // );
                        }
                        else if(username == null) {
                          UsernameErrorSnackBar(context);
                          // Fluttertoast.showToast(
                          //   msg: 'Please enter your name',
                          //   gravity: ToastGravity.BOTTOM,
                          // );
                        }
                      } catch (e) {
                        // print(e.toString());
                      }
                      usernameController.clear();
                      
                      // try {
                      //   await Firebase.initializeApp();
                      //   User? updateUser = FirebaseAuth.instance.currentUser;
                      //   updateUser?.updateProfile(displayName: usernameController.text);
                      //   userSetup(usernameController.text);

                      //   if (updateUser != null) {
                          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                          //   return RegisterScreen();
                          // }));
                          // Fluttertoast.showToast(
                          //   msg: 'Welcome ${updateUser.displayName}',
                          //   gravity: ToastGravity.BOTTOM
                          // );
                      //   }
                        // else if(updateUser == null){
                        //   Fluttertoast.showToast (
                        //     msg: 'Username not found!',
                        //     gravity: ToastGravity.BOTTOM,
                        //     textColor: Colors.white,
                        //     fontSize: 14,
                        //       );
                        //     }
                      // } catch (e) {
                      //   print(e.toString());
                      // }
                    },
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
