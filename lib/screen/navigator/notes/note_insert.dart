import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../models/snackbar.dart';
import 'note_fetchData.dart';

class InsertData extends StatefulWidget {
  const InsertData({super.key});

  @override
  State<InsertData> createState() => _InsertDataState();
}

class _InsertDataState extends State<InsertData> {

  late double _height;
  late double _width;

  late String _setTime, _setDate;
  late String _hour, _minute, _time;
  late String dateTime;


  // TODO var of date
  DateTime selectedDate = DateTime.now();

  // TODO var of time
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  // ! Select Date
  Future<void> _selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(2023),
      lastDate: DateTime(2101));
  if (picked != null) {
    setState(() {
      selectedDate = picked;
      dateController.text = DateFormat.yMd().format(selectedDate);
    });
  }
}

// ! Select Time
// Future<void> _selectTime(BuildContext context) async {
//     final TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: selectedTime,
//     );
//     if (picked != null) {
//       setState(() {
//         selectedTime = picked;
//         _hour = selectedTime.hour.toString();
//         _minute = selectedTime.minute.toString();
//         _time = _hour + ' : ' + _minute;
//         timeController.text = _time;
//         timeController.text = formatDate(
//             DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
//             [hh, ':', nn, " ", am]).toString();
//       });
//     }
//   }

  // TODO ex. March 10,2023
  String currentDate = DateFormat().add_yMMMMd().format(DateTime.now());
  // TODO ex. 2:19 AM
  String currentTime = DateFormat().add_jm().format(DateTime.now());

  // TODO * Controller
  final TextEditingController titleController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  // TODO get database 
  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    // TODO Date format setup
    dateController.text = DateFormat.yMd().format(DateTime.now());

    // TODO Create Collections
    dbRef = FirebaseDatabase.instance.ref().child('Notes');
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    dateTime = DateFormat.yMd().format(DateTime.now());

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

                  // ! date insert
                  const SizedBox(height: 30),
                  const Text("choose date", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  InkWell(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: Container(
                      width: _width / 1.0,
                      height: _height / 12.0,
                      margin: const EdgeInsets.only(top: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],),
                      
                      child: TextFormField(
                        style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                        enabled: false,
                        keyboardType: TextInputType.text,
                        controller: dateController,
                        decoration: const InputDecoration(
                          disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide.none
                          ),
                        ),
                        onSaved: (val) {
                          _setDate = val!;
                        },
                      ),
                    ),
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
                        };
                        dbRef.push().set(notes);
                        Get.to(() => const FetchData());
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
