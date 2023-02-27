import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/tasks.dart';
import 'package:flutter_application_1/screen/navigator/tasks/tasks_home.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

import '../../../models/snackbar.dart';

class TasksForm extends StatefulWidget {
  const TasksForm({super.key});

  @override
  State<TasksForm> createState() => _TasksFormState();
}

class _TasksFormState extends State<TasksForm> {
  Tasks tasks = Tasks();
  final formKey = GlobalKey<FormState>();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final CollectionReference tasksCollection = FirebaseFirestore.instance.collection('Tasks');
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
                title: const Text("Tasks"),
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
                    children: [
                      const Text("Write Tasks Today!",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w900)),
                      const SizedBox(height: 5),
                       TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Title",
                          ),
                          validator: RequiredValidator(
                              errorText: "Please enter title"),
                          onSaved: (String? title) {
                            tasks.title = title;
                          },
                        ),
                       TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Subtitle",
                          ),
                          validator: RequiredValidator(
                              errorText: "Please enter subtitle"),
                          onSaved: (String? title) {
                            tasks.title = title;
                          },
                        ),
                        const SizedBox(height: 15),

                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                          width: double.infinity,
                          height: 40,
                          child: ElevatedButton(
                            child: const Text('Submit',style: TextStyle(fontSize: 16),),
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            onPressed: () async {
                              if(formKey.currentState!.validate()){
                                formKey.currentState?.save();
                                tasksCollection.add({
                                  "title": tasks.title,
                                  "subtitle": tasks.subtitle,
                                  "create": DateTime.now()
                                });

                                Get.to(() => const TasksPage());
                                AddDataSnackBar(context);
                              }
                            },
                          ),
                        )
                    ],
                  ),
                )),),
          );
        }
        return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
      }
    );
  }
}