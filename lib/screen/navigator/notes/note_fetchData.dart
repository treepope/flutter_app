import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter_application_1/screen/navigator/notes/note_insert.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'note_form.dart';
import 'note_update.dart';
class FetchData extends StatefulWidget {
  const FetchData({super.key});

  @override
  State<FetchData> createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {

  Query dbRef = FirebaseDatabase.instance.ref().child('Notes');
  DatabaseReference reference = FirebaseDatabase.instance.ref().child('Notes');

  // ! Dialog function
  void _showDialog({@required String? text}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: IntrinsicWidth(
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Note Details",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      text!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("OK"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget listItem({required Map note}) {
    return SingleChildScrollView(
      child: Card(
        elevation: 12,
        shadowColor: Colors.grey,
        margin: const EdgeInsets.all(10),
        color: Colors.blue,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onLongPress: () {
            _showDialog(
              text: 'content : ${note['content'] + '\n' + 
                    'description : ${note['description']}'}');
            print("Tapped");
          },
          child: Container(
            width: 100.0,
            height: 130.0,
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note['title'],
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 5,),
                Text(
                  note['type'],
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),
                ),
                const SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
              
                    // ! edit icon
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => UpdateRecord(noteKey: note['key'])));
              
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.edit, color: Color.fromARGB(255, 248, 195, 61),)
                        ],
                      ),
                    ),
                    const SizedBox(height: 5, width: 5,),
              
                    // ! delete icon
                    GestureDetector(
                      onTap: () {
                        reference.child(note['key']).remove();
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.delete, color: Color.fromARGB(255, 255, 91, 79),)
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        child: FirebaseAnimatedList(
          query: dbRef,
          itemBuilder: (
            BuildContext context, 
            DataSnapshot snapshot, 
            Animation<double> animation, 
            int index) {
              Map note = snapshot.value as Map;
              note['key'] = snapshot.key;

              return listItem(note: note);
          }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => const InsertData()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}