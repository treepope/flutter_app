import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/event.dart';

class EditEvent extends StatefulWidget {
  final DateTime firstDate;
  final DateTime lastDate;
  final Event event;
  const EditEvent(
      {Key? key,
      required this.firstDate,
      required this.lastDate,
      required this.event})
      : super(key: key);

  @override
  State<EditEvent> createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  late DateTime _selectedDate;
  late TextEditingController titleController;
  late TextEditingController typeController;
  late TextEditingController contentController;
  late TextEditingController descriptionController;
  @override
  void initState() {
    super.initState();
    _selectedDate = widget.event.date;
    titleController = TextEditingController(text: widget.event.title);
    typeController = TextEditingController(text: widget.event.type);
    contentController = TextEditingController(text: widget.event.content);
    descriptionController =
        TextEditingController(text: widget.event.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Event")),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
         
          const Text("Have a good Day!",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),
          const SizedBox(height: 5),
          const Text("enter your data",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
          const SizedBox(height: 15),
           InputDatePickerFormField(
            firstDate: widget.firstDate,
            lastDate: widget.lastDate,
            initialDate: _selectedDate,
            onDateSubmitted: (date) {
              print(date);
              setState(() {
                _selectedDate = date;
              });
            },
          ),

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
          ElevatedButton(
            onPressed: () {
              _addEvent();
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  void _addEvent() async {
    final title = titleController.text;
    final type = typeController.text;
    final content = contentController.text;
    final description = descriptionController.text;
    if (title.isEmpty) {
      print('title cannot be empty');
      return;
    }
    await FirebaseFirestore.instance
        .collection('Notes')
        .doc(widget.event.id)
        .update({
      "title": title,
      "type": type,
      "content": content,
      "description": description,
      "date": Timestamp.fromDate(_selectedDate),
    });
    if (mounted) {
      Navigator.pop<bool>(context, true);
    }
  }
}
