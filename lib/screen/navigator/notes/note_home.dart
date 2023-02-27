
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/navigator/notes/note_form.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';

class NotePage extends StatefulWidget {
  static const routeName = '/note';

  const NotePage({Key? key}) : super(key: key);

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  
  // Dialog function
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Note").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children: snapshot.data!.docs.map((document) {
                return Card(
                  elevation: 16,
                  shadowColor: Colors.grey,
                  margin: const EdgeInsets.all(20),
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onLongPress: () {
                      _showDialog(
                          text: 'content : ${document['content'] + '\n' + 'description : ' + document['description']}');
                      print("tapped");
                    },
                    child: Container(
                      width: 100.0,
                      height: 70.0,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('${document['title']}', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                            const SizedBox(height: 5,),
                            Text('Type : ${document['type']}', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.grey),),
                            

                            // GestureDetector(
                            //   onTap: () {
                            //     reference.child(document['content']).remove();
                            //   },
                            //   child: Row(
                            //     children: [
                            //       Icon(Icons.delete,color: Colors.red[700],)
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => NoteForm());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
} //extend state  
