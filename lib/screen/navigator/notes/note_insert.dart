import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../models/snackbar.dart';
import '../../home/nav_bar.dart';
import 'note_fetchData.dart';

class InsertData extends StatefulWidget {
  const InsertData({super.key});

  @override
  State<InsertData> createState() => _InsertDataState();
}

class _InsertDataState extends State<InsertData> {

  late double _height;
  late double _width;

  // TODO * Controller
  final titleController = TextEditingController();
  final typeController = TextEditingController();
  final contentController = TextEditingController();
  final descriptionController = TextEditingController();

  // TODO get database 
  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();

    // TODO Create Collections
    dbRef = FirebaseDatabase.instance.ref().child('Notes');
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
              child: Column(
                children: <Widget> [
                  const Text("Let's note Today!", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 5),
                  const Text("enter your data", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                  const SizedBox(height: 15),
      
                  // ! title insert
                  TextFormField(
                    controller: titleController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      labelText: "Title", 
                      hintText: "Enter title"),
                  ),
                  const SizedBox(height: 15),
      
                  // ! type insert
                  TextFormField(
                    controller: typeController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      labelText: "Type", 
                      hintText: "Enter type"),
                  ),
                  const SizedBox(height: 15),
      
                  // ! content insert
                  TextFormField(
                    controller: contentController,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(height: 1.5),
                    decoration: const InputDecoration(
                      labelText: "Content", 
                      hintText: "Enter content",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 40, horizontal: 15),),
                      maxLines: 7,
                      minLines: 2,
                  ),
                  const SizedBox(height: 15),
      
                  // ! description insert
                  TextFormField(
                    controller: descriptionController,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(height: 1.5),
                    decoration: const InputDecoration(
                      labelText: "Description", 
                      hintText: "Enter description",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),),
                      maxLines: 3,
                      minLines: 1,
                  ),

                  const SizedBox(height: 15),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12))),
                      child:  const Text('Submit', style: TextStyle(fontSize: 16),),
                      onPressed: () async {
                        // insert to realtime db
                        Map<String, String> notes = {
                          'title': titleController.text,
                          'type' : typeController.text,
                          'content': contentController.text,
                          'description': descriptionController.text,
                          'date': DateFormat.yMMMEd().format(DateTime.now()).toString(),
                          'time': DateFormat.jms().format(DateTime.now()).toString(),
                        };
                        dbRef.push().set(notes);
                        Get.to(() => NavBar());
                        print('notes is added : ${notes}');
                        AddDataSnackBar(context);
                      },
                    ),
                  ),
                  const SizedBox(height: 15),
      
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
