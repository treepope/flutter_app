import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/screen/navigator/tasks/tasks_update.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../models/snackbar.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _HomeState();
}

class _HomeState extends State<TasksPage> {
  bool? isChecked = false;

  // TODO set key form
  final formKey = GlobalKey<FormState>();

  // TODO * Controller
  final tasksController = TextEditingController();
  final serachFilter = TextEditingController();
  final editController = TextEditingController();

  // TODO get database
  Query dbRef = FirebaseDatabase.instance.ref().child('Tasks');
  late DatabaseReference databaseReference =
      FirebaseDatabase.instance.ref().child('Tasks');

  // Future<void> _showDialog() async {
  //   return showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: const Text('Update'),
  //           content: Container(
  //             child: TextField(
  //               controller: editController,
  //               decoration: const InputDecoration(hintText: 'Edit Tasks'),
  //             ),
  //           ),
  //           actions: [
  //             TextButton(
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 },
  //                 child: const Text('Cancel')),
  //             TextButton(
  //                 onPressed: () {
  //                   Map<String, dynamic> tasks = {'items': editController.text};
  //                   databaseReference
  //                       .child(widget.taskKey)
  //                       .update(tasks)
  //                       .then((value) => {Navigator.pop(context)});
  //                 },
  //                 child: const Text('Update')),
  //           ],
  //         );
  //       });
  // }

  @override
  void initState() {
    super.initState();
    // TODO get Date Time from DB
    dbRef = FirebaseDatabase.instance.ref().child('Tasks').orderByChild('date');
    dbRef = FirebaseDatabase.instance.ref().child('Tasks').orderByChild('time');
    // TODO Create Collections
    databaseReference = FirebaseDatabase.instance.ref().child('Tasks');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: tdBGColor,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                margin: const EdgeInsets.only(
                  top: 20,
                  bottom: 0,
                ),
                child: const Text(
                  'All Tasks',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 36,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  print('Tapped');
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: const EdgeInsets.only(
                    top: 5,
                    bottom: 20,
                  ),
                  child: const Text(
                    'Done Tasks',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: FirebaseAnimatedList(
                      query: dbRef,
                      defaultChild: const Text('Loading'),
                      itemBuilder: (BuildContext context, DataSnapshot snapshot,
                          Animation<double> animation, int index) {
                        Map task = snapshot.value as Map;
                        task['key'] = snapshot.key;

                        return listTasks(task: task);
                      })),
              Align(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: addBox(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ));
  }

  // Widget searchBox() {
  //   return Container(
  //     padding: const EdgeInsets.symmetric(horizontal: 15),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(20),
  //     ),
  //     child: Form(
  //       key: formKey,
  //       child: TextFormField(
  //         controller: serachFilter,
  //         onChanged: (String value) {
  //           setState(() {

  //           });
  //         },
  //         decoration: const InputDecoration(
  //           contentPadding: EdgeInsets.all(0),
  //           prefixIcon: Icon(
  //             Icons.search,
  //             color: tdBlack,
  //             size: 20,
  //           ),
  //           prefixIconConstraints: BoxConstraints(
  //             maxHeight: 20,
  //             minWidth: 25,
  //           ),
  //           border: InputBorder.none,
  //           hintText: 'Search',
  //           hintStyle: TextStyle(color: tdGrey),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget listTasks({required Map task}) {
    return SingleChildScrollView(
      child: Card(
        margin: const EdgeInsets.all(10),
        color: Colors.white,
        child: InkWell(
          onDoubleTap: () {
            databaseReference.child(task['items']).remove();
            deleteDataSnackBar(context);
          },
          child: Container(
            width: 100.0,
            height: 120.0,
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task['items'],
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: tdBlack),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(task['date']),
                Text(task['time']),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    PopupMenuButton(
                        icon: const Icon(Icons.more_vert_rounded),
                        itemBuilder: (context) => [
                              PopupMenuItem(
                                  value: 1,
                                  child: ListTile(
                                    leading: const Icon(Icons.check_box_rounded),
                                    title: const Text('Done'),
                                    onTap: () {
                                      databaseReference
                                          .child(task['key'])
                                          .remove();
                                      DoneDataSnackBar(context);
                                    },
                                  )),
                              PopupMenuItem(
                                  value: 1,
                                  child: ListTile(
                                    leading: const Icon(Icons.edit),
                                    title: const Text('Edit'),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => TaskUpdateRecord(
                                                  taskKey: task['key'])));
                                    },
                                  )),
                              PopupMenuItem(
                                  value: 1,
                                  child: ListTile(
                                    leading: const Icon(Icons.delete_rounded),
                                    title: const Text('Delete'),
                                    onTap: () {
                                      databaseReference
                                          .child(task['key'])
                                          .remove();
                                      deleteDataSnackBar(context);
                                    },
                                  )),
                            ]),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget addBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Form(
        key: formKey,
        child: TextFormField(
          controller: tasksController,
          decoration: InputDecoration(
            prefixIcon: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () async {
                // ! insert to realtime db
                Map<String, String> tasks = {
                  'items': tasksController.text,
                  'date': DateFormat.yMMMEd().format(DateTime.now()).toString(),
                  'time': DateFormat.jms().format(DateTime.now()).toString(),
                };
                databaseReference.push().set(tasks);
                // ! output
                print('tasks is added : ${tasks}');
                AddTasksSnackBar(context);
                formKey.currentState?.reset();
              },
            ),
            border: InputBorder.none,
            hintText: 'Add a new item',
            hintStyle: const TextStyle(color: tdGrey, fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget buildCheckbox() => Checkbox(
      value: isChecked,
      onChanged: (isChecked) {
        setState(() {
          this.isChecked = isChecked;
        });
      });
}
