import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseServices {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn(
    // scopes: ['https://www.googleapis.com/auth/contacts.readonly',]
  );

  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
      if (googleSignInAccount != null) {
        
        final AuthCredential authCredential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);
        await _auth.signInWithCredential(authCredential);
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      String msg = "Google account is disable !";
      // if (e.code == 'email-already-in-use') {
      //    msg = "email already in use";
      // } else if (e.code == 'weak-password') {
      //    msg = "password must be long 6 characters or more";
      // }
      Fluttertoast.showToast(
        msg: msg, // default = e.message!
        gravity: ToastGravity.BOTTOM
       );
      throw e;
    }
  }

  googleSignOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}