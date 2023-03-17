import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class TaskUpdateRecord extends StatefulWidget {
  const TaskUpdateRecord({Key? key, required this.taskKey});
  final String taskKey;

  @override
  State<TaskUpdateRecord> createState() => _TaskUpdateRecordState();
}

class _TaskUpdateRecordState extends State<TaskUpdateRecord> {
  // final formKey = GlobalKey<FormFieldBuilderState>();

  final TextEditingController tasksController= TextEditingController();
  late DatabaseReference dbRef; 

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('Tasks');
    getTaskData();
  }

  void getTaskData() async {
    DataSnapshot snapshot = await dbRef.child(widget.taskKey).get();

    Map task = snapshot.value as Map;

    tasksController.text = task['title'];

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
            padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
              children: <Widget> [
                const SizedBox(height: 50,),
                const Text(
                  'Updating your Tasks ! ',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30,),
      
                // ! update task
                TextField(
                  controller: tasksController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Tasks',
                    hintText: 'edit your tasks',
                  ),
                ),
                const SizedBox(height: 30,),
      
                // ! button
                MaterialButton(
                  onPressed: () {
                    Map<String, String> tasks = {
                      'items': tasksController.text,
                    };
                    dbRef.child(widget.taskKey).update(tasks)
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
    );
  }
}