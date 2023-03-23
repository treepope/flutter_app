import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import '../../../models/snackbar.dart';
import '../../home/nav_bar.dart';

class InsertData extends StatefulWidget {
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime? selectedDate;
  const InsertData(
      {Key? key,
      required this.firstDate,
      required this.lastDate,
      this.selectedDate})
      : super(key: key);

  @override
  State<InsertData> createState() => _InsertDataState();
}

class _InsertDataState extends State<InsertData> {
  late double _height;
  late double _width;

  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final CollectionReference noteCollection =
      FirebaseFirestore.instance.collection('Note');

  // TODO * Controller
  late DateTime _selectedDate;
  final titleController = TextEditingController();
  final typeController = TextEditingController();
  final contentController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();

  DateTime dateTime = DateTime.now();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // TODO get database
  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate ?? DateTime.now();

    // TODO Create Collections
    dbRef = FirebaseDatabase.instance.ref().child('Notes');

    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("@mipmap/ic_launcher");

    const IOSInitializationSettings iosInitializationSettings =
        IOSInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
    );
  }

  showNotification() {
    if (titleController.text.isEmpty || descriptionController.text.isEmpty) {
      return;
    }

    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      "ScheduleNotification001",
      "Notify Me",
      'noti',
      importance: Importance.high,
    );

    const IOSNotificationDetails iosNotificationDetails =
        IOSNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
      macOS: null,
    );

    flutterLocalNotificationsPlugin.show(
        01, "Done !", titleController.text, notificationDetails);

    tz.initializeTimeZones();
    final tz.TZDateTime scheduledAt = tz.TZDateTime.from(dateTime, tz.local);

    flutterLocalNotificationsPlugin.zonedSchedule(01, titleController.text,
        descriptionController.text, scheduledAt, notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime,
        androidAllowWhileIdle: true,
        payload: 'Ths s the data');
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
                children: <Widget>[
                  const Text("Let's note Today!",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 5),
                  const Text("enter your data",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                  const SizedBox(height: 15),

                  // ! title insert
                  TextFormField(
                    controller: titleController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                        labelText: "Title", hintText: "Enter title"),
                  ),
                  const SizedBox(height: 15),

                  // ! type insert
                  TextFormField(
                    controller: typeController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                        labelText: "Type", hintText: "Enter type"),
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
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 40, horizontal: 15),
                    ),
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
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                    ),
                    maxLines: 3,
                    minLines: 1,
                  ),
                  const SizedBox(height: 15),

                  

                  TextField(
                    controller: dateController,
                    decoration: InputDecoration(
                        suffixIcon: InkWell(
                          child: Icon(Icons.date_range),
                          onTap: () async {
                            final DateTime? newlySelectedDate =
                                await showDatePicker(
                              context: context,
                              initialDate: _selectedDate,
                              firstDate: widget.firstDate,
                              lastDate: widget.lastDate,
                            );

                            if (newlySelectedDate == null) {
                              return;
                            }

                            setState(() {
                              _selectedDate = newlySelectedDate;
                              dateController.text =
                                  "${_selectedDate.year}/${_selectedDate.month}/${_selectedDate.day}";
                            });
                          },
                        ),
                        label: const Text("Date")),
                  ),
                  const SizedBox(height: 15),

                  TextField(
                    controller: timeController,
                    decoration: InputDecoration(
                        suffixIcon: InkWell(
                          child: const Icon(
                            Icons.timer_outlined,
                          ),
                          onTap: () async {
                            final TimeOfDay? slectedTime = await showTimePicker(
                                context: context, initialTime: TimeOfDay.now());

                            if (slectedTime == null) {
                              return;
                            }

                            timeController.text =
                                "${slectedTime.hour}:${slectedTime.minute}:${slectedTime.period.toString()}";

                            DateTime newDT = DateTime(
                              dateTime.year,
                              dateTime.month,
                              dateTime.day,
                              slectedTime.hour,
                              slectedTime.minute,
                            );
                            setState(() {
                              dateTime = newDT;
                            });
                          },
                        ),
                        label: Text("Time")),
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
                        showNotification();
                        // insert to realtime db
                        Map<String, String> notes = {
                          'title': titleController.text,
                          'type': typeController.text,
                          'content': contentController.text,
                          'description': descriptionController.text,
                          'date': DateFormat.yMMMEd()
                              .format(DateTime.now())
                              .toString(),
                          'time': DateFormat.jms()
                              .format(DateTime.now())
                              .toString(),
                        };

                        noteCollection.add({
                          'title': titleController.text,
                          'type': typeController.text,
                          'content': contentController.text,
                          'description': descriptionController.text,
                          'date': Timestamp.fromDate(_selectedDate),
                          'time': DateFormat.jms()
                              .format(DateTime.now())
                              .toString(),
                        });

                        dbRef.push().set(notes);
                        _addEvent();
                        Navigator.pop(context);
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
    void _addEvent() async {
    final title = titleController.text;
    final description = descriptionController.text;
    if (title.isEmpty) {
      print('title cannot be empty');
      return;
    }
    await FirebaseFirestore.instance.collection('events').add({
      "title": title,
      "description": description,
      "date": Timestamp.fromDate(_selectedDate),
    });
    if (mounted) {
      Navigator.pop<bool>(context, true);
    }
  }
}
