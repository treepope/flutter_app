import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/navigator/notes/note_form.dart';
import 'package:get/get.dart';

class NotePage extends StatefulWidget {
  static const routeName = '/note';

  const NotePage({Key? key}) : super(key: key);
  
  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {

  @override
  void initState(){}
  
  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      body: ListView.builder(itemBuilder: ((context, index) => 
        const Card(
          elevation: 5,
          margin: EdgeInsets.symmetric(vertical: 10 ,horizontal: 20),
          child: ListTile(title: Text("Menu"),subtitle: Text('23-02-2023'),),
        ))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => NoteForm());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
} //extend state  
