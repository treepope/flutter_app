import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  File? image;
  
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to pick image $e');
    }
     
  } 

    String greeting(){
      var hour  = DateTime.now().hour;
      print(hour);
      if (hour < 12) { return "Morning";
      } else if(hour < 15) { return "Afternoon";
      } else if(hour < 18){ return "Evening";
      } else { return "Night"; } 
    }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(child: Padding(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
      child: Column(mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // CircleAvatar(
        //   radius: 50.0,
        //   backgroundImage: NetworkImage('${FirebaseAuth.instance.currentUser!.photoURL!}'),
        //   backgroundColor: Colors.transparent,
        // ),
        // Image.network(FirebaseAuth.instance.currentUser!.photoURL!),
        image != null ? Image.file(image!, width: 160, height: 160, fit: BoxFit.cover,) : Image.asset('assets/img/Do.png',scale: 5,),
        const SizedBox(height: 15),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    width: 100,
                    height: 20,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12))),
                      child:  const Text('Pick image', style: TextStyle(fontSize: 16),),
                      onPressed: () async {
                        pickImage();
                      },
                    ),
                  ),

        Text('Good ${greeting()}, ${FirebaseAuth.instance.currentUser!.displayName}',style: const TextStyle(fontSize: 32,fontWeight: FontWeight.bold)),
        
        const SizedBox(height: 5),

        Text('${FirebaseAuth.instance.currentUser!.email}',style: const TextStyle(fontSize: 22)),

        const SizedBox(height: 15),

      ],),
    ),),
  );
  
}