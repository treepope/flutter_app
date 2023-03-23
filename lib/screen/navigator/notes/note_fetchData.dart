import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter_application_1/screen/navigator/notes/note_insert.dart';
import 'package:intl/intl.dart';

import '../../../constants/colors.dart';
import 'note_update.dart';
class FetchData extends StatefulWidget {
  
  const FetchData({super.key});

  @override
  State<FetchData> createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
  late DateTime _firstDay;
  late DateTime _lastDay;
  late DateTime _selectedDay;

  Query dbRef = FirebaseDatabase.instance.ref().child('Notes');
  DatabaseReference reference = FirebaseDatabase.instance.ref().child('Notes');
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat("dd MMMM yyyy");

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

  @override
  void initState() {
    super.initState();
    _firstDay = DateTime.now().subtract(const Duration(days: 1000));
    _lastDay = DateTime.now().add(const Duration(days: 1000));
    _selectedDay = DateTime.now();
    // TODO get Date Time from DB
    dbRef = FirebaseDatabase.instance.ref().child('Notes').orderByChild('date');
    dbRef = FirebaseDatabase.instance.ref().child('Notes').orderByChild('time');
  }

  Widget listItem({required Map note}) {
    return SingleChildScrollView(
      child: Card(
        margin: const EdgeInsets.all(15),
        color: Colors.white,
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
            height: 150.0,
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Text(
                  note['title'],
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: tdBlack),
                ),
                const SizedBox(height: 5,),
                Text(
                  note['type'],
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: tdGrey),
                ),
                const SizedBox(height: 15,),
                Text(
                  '${note['date'] + ' / ' + '${note['time']}'}',
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: tdGrey),
                ),
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
                          Icon(Icons.edit, color: Colors.blue,)
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
                          Icon(Icons.delete, color: Color(0xFFDA4040),)
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
      backgroundColor: tdBGColor,
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
              builder: (context) =>   InsertData(firstDate: _firstDay, lastDate: _lastDay ,selectedDate: _selectedDay,)));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}