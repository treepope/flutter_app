import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class UpdateRecord extends StatefulWidget {
  const UpdateRecord({Key? key, required this.noteKey});
  final String noteKey;

  @override
  State<UpdateRecord> createState() => _UpdateRecordState();
}

class _UpdateRecordState extends State<UpdateRecord> {

  final TextEditingController titleController = TextEditingController();
  final TextEditingController typeController = TextEditingController();  
  final TextEditingController contentController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController(); 

  late DatabaseReference dbRef; 

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('Notes');
    getNoteData();
  }

  void getNoteData() async {
    DataSnapshot snapshot = await dbRef.child(widget.noteKey).get();

    Map note = snapshot.value as Map;

    titleController.text = note['title'];
    typeController.text = note['type'];
    contentController.text = note['content'];
    descriptionController.text = note['description'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
            child: Column(
              children: [
                const SizedBox(height: 50,),
                const Text(
                  'Updating ur data',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30,),
      
                // ! update title
                TextField(
                  controller: titleController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Title',
                    hintText: 'Enter title',
                  ),
                ),
                const SizedBox(height: 30,),
      
                // ! update type
                TextField(
                  controller: typeController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Type',
                    hintText: 'Enter type',
                  ),
                ),
                const SizedBox(height: 30,),
      
                // ! update content
                TextField(
                  controller: contentController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Content',
                    hintText: 'Enter content',
                  ),
                ),
                const SizedBox(height: 30,),
      
                // ! update description
                TextField(
                  controller: descriptionController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Description',
                    hintText: 'Enter description',
                  ),
                ),
                const SizedBox(height: 30,),
      
                // ! button
                MaterialButton(
                  onPressed: () {
                    Map<String, String> notes = {
                      'title': titleController.text,
                      'type' : typeController.text,
                      'content': contentController.text,
                      'description': descriptionController.text,
                    };
                    dbRef.child(widget.noteKey).update(notes)
                    .then((value) => {
                       Navigator.pop(context) 
                    });
                  },
                  color: Colors.blue,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  minWidth: 300,
                  height: 40,
                  child:  const Text('Update Data'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}