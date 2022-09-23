// ignore_for_file: unrelated_type_equality_checks

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/home/widget/note_card..dart';

class NotePage extends StatefulWidget {
  const NotePage({Key? key}) : super(key: key);

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  @override
  Widget build(BuildContext context) => Scaffold(
     body: Padding(
       padding: const EdgeInsets.all(16.0),
       child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Your recent Notes", 
            style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
          
          const SizedBox(height: 20.0,),
          
          Expanded(
            child: StreamBuilder <QuerySnapshot> (
              stream: FirebaseFirestore.instance.collection('Notes').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState) {
                  return const Center(child: CircularProgressIndicator(),);
                }
                if (snapshot.hasData) {
                  return GridView(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                      children: snapshot.data!.docs.map((note) => noteCard(() {},note)).toList()
                      );
                }
                return const Text("ther's no Notes",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),);
              },
            ),
          )
        ],
      ),
     )
  );
}