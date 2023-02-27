// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_database/ui/firebase_animated_list.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'note_form.dart';

// class FetchData extends StatefulWidget {
//   const FetchData({super.key});

//   @override
//   State<FetchData> createState() => _FetchDataState();
// }

// class _FetchDataState extends State<FetchData> {

// Query dbRef = FirebaseDatabase.instance.ref().child('Note');
// DatabaseReference reference = FirebaseDatabase.instance.ref().child('Note');

//   @override
//   Widget listItem({required Map note}) {
//     return Container(
//       margin: const EdgeInsets.all(10),
//       padding: const EdgeInsets.all(10),
//       height: 110,
//       child: const Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text('Title', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
//         ],
//       ),
//     );
//   }
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height: double.infinity,
//         child: FirebaseAnimatedList(
//           query: dbRef,
//           itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {

//             Map note = snapshot.value as Map;
//             note['title'] = snapshot.key;
//             note['type'] = snapshot.key;

//             return listItem(note: note);
//           },
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Get.to(() => NoteForm());
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
  
// }