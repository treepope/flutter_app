import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
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
        CircleAvatar(
          radius: 50.0,
          backgroundImage: NetworkImage('${FirebaseAuth.instance.currentUser!.photoURL!}'),
          backgroundColor: Colors.transparent,
        ),
        // Image.network(FirebaseAuth.instance.currentUser!.photoURL!),
        const SizedBox(height: 15),

        Text('Good ${greeting()}, ${FirebaseAuth.instance.currentUser!.displayName}',style: const TextStyle(fontSize: 32,fontWeight: FontWeight.bold)),
        
        const SizedBox(height: 5),

        Text('${FirebaseAuth.instance.currentUser!.email}',style: const TextStyle(fontSize: 22)),

        const SizedBox(height: 15),

      ],),
    ),),
  );
  
}