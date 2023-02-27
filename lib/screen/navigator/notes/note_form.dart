import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/navigator/notes/note_home.dart';
import 'package:flutter_application_1/screen/navigator/notes/note_home_new.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/models/note.dart';
import 'package:flutter_application_1/models/snackbar.dart';

class NoteForm extends StatefulWidget {
  NoteForm({Key? key}) : super(key: key);

  @override
  State<NoteForm> createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> {
  Note note = Note();
  final formKey = GlobalKey<FormState>();
  final dropdownFormKey = GlobalKey<FormState>();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final CollectionReference noteCollection = FirebaseFirestore.instance.collection('Note');
  late DatabaseReference dbRef;

  final TextEditingController titleController = TextEditingController();
  late TextEditingController typeController = TextEditingController();  
  final TextEditingController contentController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController(); 

  String? _selectedVal = null;
  _NoteFormState() {
    _selectedVal = _menuList[0];
  }
  final _menuList = [
    "Note",
    "Personal",
    "Work",
    "Travel",
    "Financial",
    "Gaming",
    "Life",
    "Love",
    "Music",
    "Problems",
    "Saving",
    "Documents",
    "Education",
    "Secret",
  ];
  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('Note');

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(child: Text("${snapshot.error}")),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Note"),
                toolbarHeight: 50,
                // centerTitle: true,
                backgroundColor: const Color.fromARGB(255, 60, 145, 255),
                titleTextStyle:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              body: Padding(
                padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
                child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                        child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        const Text("Let's note Today!",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w900)),
                        const SizedBox(height: 5),

                        const Text("enter your data",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400)),
                        const SizedBox(height: 15),

                        TextFormField(
                          controller: titleController,
                          decoration: const InputDecoration(
                            labelText: "Title",
                          ),
                          validator: RequiredValidator(
                              errorText: "Please enter title"),
                          onSaved: (String? title) {
                            note.title = title;
                          },
                        ),

                        const SizedBox(height: 15),

                        TextFormField(
                          controller: typeController,
                          decoration: const InputDecoration(
                            labelText: "Type",
                          ),
                          validator: RequiredValidator(
                              errorText: "Please enter type"),
                          onSaved: (String? type) {
                            note.type = type;
                          },
                        ),
                        // TODO DropdownButton *
                        // DropdownButtonFormField(
                        //   isExpanded: true,
                        //   style: const TextStyle(
                        //       color: Colors.white,
                        //       fontSize: 16,
                        //       fontWeight: FontWeight.bold),
                        //   value: _selectedVal,
                        //   items: _menuList
                        //       .map((e) => DropdownMenuItem(
                        //             child: Text(e),
                        //             value: e,
                        //           ))
                        //       .toList(),
                        //   onChanged: (val) {
                        //     setState(() {
                        //       _selectedVal = val as String;
                        //     });
                        //   },
                        //   onSaved: (String? type) {
                        //     note.type = type;
                        //   },
                        //   icon: const Icon(
                        //     Icons.arrow_drop_down_circle,
                        //     color: Colors.white,
                        //   ),
                        //   menuMaxHeight: 200,
                        //   dropdownColor: Colors.lightBlue,
                        //   decoration: InputDecoration(
                        //     enabledBorder: OutlineInputBorder(
                        //       borderSide: const BorderSide(
                        //           color: Colors.blue, width: 2),
                        //       borderRadius: BorderRadius.circular(20),
                        //     ),
                        //     border: OutlineInputBorder(
                        //       borderSide: const BorderSide(
                        //           color: Colors.blue, width: 2),
                        //       borderRadius: BorderRadius.circular(20),
                        //     ),
                        //     filled: true,
                        //     fillColor: Colors.blueAccent,
                        //   ),
                        //   // validator: (value) => value == null ? "Select a Type" : null,
                        // ),

                        const SizedBox(height: 15),

                        TextFormField(
                          controller: contentController,
                          style: const TextStyle(height: 1.5),
                          decoration: const InputDecoration(
                            labelText: "Content",
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 40, horizontal: 15),
                          ),
                          maxLines: 7,
                          minLines: 2,
                          onSaved: (String? content) {
                            note.content = content;
                          },
                        ),

                        const SizedBox(height: 15),

                        TextFormField(
                          controller: descriptionController,
                          style: const TextStyle(height: 1.5),
                          decoration: const InputDecoration(
                            labelText: "Description",
                            border: OutlineInputBorder(),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 30, horizontal: 15),
                          ),
                          maxLines: 3,
                          minLines: 1,
                          onSaved: (String? description) {
                            note.description = description;
                          },
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
                            child: const Text(
                              'Submit',
                              style: TextStyle(fontSize: 16),
                            ),
                            onPressed: () async {
                              

                              if (formKey.currentState!.validate()) {
                                Map<String, String> notes = {
                                  'title': titleController.text,
                                  'type' : typeController.text,
                                  'content': contentController.text,
                                  'description': descriptionController.text,
                                };
                                dbRef.push().set(notes);
                                formKey.currentState?.save();
                                noteCollection.add({
                                  "title": note.title,
                                  "type": note.type,
                                  "content": note.content,
                                  "description": note.description,
                                  "create": DateTime.now()
                                });

                                Get.to(() => const NotePage());
                                AddDataSnackBar(context);
                              }
                            },
                          ),
                        ),
                      ],
                    ))),
              ),
            );
          }
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        });
  }
}
