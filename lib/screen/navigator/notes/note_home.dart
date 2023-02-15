import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/note_model.dart';
import 'package:flutter_application_1/screen/home/widget/note_card..dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../../database/database_helper.dart';
import '../../../database/note_db.dart';

class NotePage extends StatefulWidget {
  static const routeName = '/note';

  const NotePage({Key? key}) : super(key: key);
  
  
  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
    late final NotesDatabase_db; // อ้างอิงฐานข้อมูล
    late Future<List<Note>> notes; // ลิสรายการหนังสือ
    int i = 0; // จำลองตัวเลขการเพิ่่มจำนวน
    late DateFormat dateFormat; // รูปแบบการจัดการวันที่และเวลา
    late final _db;

 TextEditingController txtID=TextEditingController();
 TextEditingController txtName=TextEditingController();
 TextEditingController txtAge=TextEditingController();
  int _counter = 0;
  //ประกาศคัวแปร dbHelper
  final dbHelper=DatabaseHelper.instance;
  int TotalCount=0;

  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }
  @override
  void initState(){
    // กำหนดรูปแบบการจัดการวันที่และเวลา มีเพิ่มเติมเล็กน้อยในในท้ายบทความ
      Intl.defaultLocale = 'th';
      initializeDateFormatting();
      dateFormat = DateFormat.yMMMMEEEEd('th');

      final _db = NotesDatabase.instance;
      notes = _db.readAllNote(); // แสดงรายการหนังสือ
      super.initState();
  }
   // คำสั่งลบรายการทั้งหมด
    Future<void> clearNote() async {
      await _db.deleteAll(); // ทำคำสั่งลบข้อมูลทั้งหมด
      setState(() {
        notes = _db.readAllNote(); // แสดงรายการหนังสือ
      });      
    }

  // คำสั่งลบเฉพาะรายการที่กำหนดด้วย id ที่ต้องการ
    Future<void> deleteNote(int id) async {
      await _db.delete(id); // ทำคำสั่งลบข้มูลตามเงื่อนไข id
      setState(() {
        notes = _db.readAllBook(); // แสดงรายการหนังสือ
      });    
    }
 
    // จำลองทำคำสั่งแก้ไขรายการ
    Future<void> editNote(Note note) async {
      // เลื่อกเปลี่ยนเฉพาะส่วนที่ต้องการ โดยใช้คำสั่ง copy
      note = note.copy(
        title: note.title+' new ',
        content: '',
        num_pages: 300,
        publication_date: DateTime.now()
      );      
      await _db.update(note); // ทำคำสั่งอัพเดทข้อมูล
      setState(() {
        notes = _db.readAllBook(); // แสดงรายการหนังสือ
      });    
    }

     // จำลองทำคำสั่งเพิ่มข้อมูลใหม่
    Future<void> newBook() async {
      i++;
      Note note = Note(
        note_id: i,
        title: 'Book title $i',
        type: '',
        content: 'ABC',
        num_pages: 200,
        publication_date: DateTime.now(), 
        
      );
      Note new_note = await _db.create(note); // ทำคำสั่งเพิ่มข้อมูลใหม่
      setState(() {
        notes = _db.readAllBook(); // แสดงรายการหนังสือ
      });
    }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SingleChildScrollView(
        child: FutureBuilder<List<Note>>(
          future: notes,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Expanded(child: snapshot.data!.isNotEmpty // กำหนดเงื่อนไขนี้
                    ? ListView.separated( // กรณีมีรายการ แสดงปกติหนด controller ที่จะใช้งานร่วม
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Note note = snapshot.data![index];

                      Widget card;
                      card = Card(
                        margin: const EdgeInsets.all(5.0), // การเยื้องขอบ
                        child: Column(
                          children: [
                            ListTile(
                              leading: IconButton(
                                onPressed: () => editNote(note), // จำลองแก้ไขข้อมูล
                                icon: const Icon(Icons.edit),
                              ),
                              title: Text(note.title),
                              subtitle: Text('Date: ${dateFormat.format(note.publication_date)}'),
                              trailing: IconButton(
                                  onPressed: () => deleteNote(note.id!), // ลบข้อมูล
                                   icon: const Icon(Icons.delete),
                              ),
                              onTap: (){
                                _viewDetail(note.id!);
                              },
                            )
                          ],
                        ),
                      )
                    },
                    separatorBuilder: (BuildContext context, int index) {},
                    )
                  ),
                ],
              );
            }
          },
        ),
        ),
      );
  
  //คำสั่ง Insert ข้อมูล
  void _insert() async{
      //row insert
      Map<String,dynamic>row={
        DatabaseHelper.columnName : 'treepope',
        DatabaseHelper.columnAge : '18'
      };
      //ประกาศคัวแปร dbHelper ด้านบน ... extend State<....
      final id=await dbHelper.insert(row); // คำสั่งเต็มจริงๆ insert into table(filed1,filed2...)VALUES(value1,value2..)
      print('บันทึกแล้วโดยมี id = $id');
  }
    //เรียกดูข้อมูลใน table ว่ามีกี่ row
   void _query() async{
     final int? totalrow=await dbHelper.queryRowCount();
     TotalCount=totalrow!;
     print("มีข้อมูลทั้งหมดใน table = $totalrow row");
     reloaddata();
   }

  void _queryAll() async{
   final allRows=await dbHelper.queryAllRow();
   print("มีข้อมูลทั้งหมดใน table");
   allRows.forEach((row)=>print(row));
    reloaddata();
  }

  void _update() async{
     Map<String,dynamic> row={
       DatabaseHelper.columnId:int.parse(txtID.text),
       DatabaseHelper.columnName:txtName.text,
       DatabaseHelper.columnAge:txtAge.text
     };
     final rowsAffected=await dbHelper.update(row);
     print('บันทึกเรียบร้อย id = $rowsAffected');
  }

  void _delete() async{
    final rowsDeleted=await dbHelper.delete(int.parse(txtID.text));
    print('deleted');
  }

   void reloaddata(){
    setState(() {
    });
   }
} //extend state