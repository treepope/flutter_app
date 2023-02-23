import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../../../database/note_db.dart';
import '../../../models/note_model.dart';

class NotePage extends StatefulWidget {
  static const routeName = '/note';

  const NotePage({Key? key}) : super(key: key);
  
  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
    late NotesDatabase _db; // อ้างอิงฐานข้อมูล
    late Future<List<Note>> notes; // ลิสรายการหนังสือ
    int i = 0; // จำลองตัวเลขการเพิ่่มจำนวน
    late DateFormat dateFormat; // รูปแบบการจัดการวันที่และเวลา

  @override
  void initState(){
    // * format date & time
      Intl.defaultLocale = 'th';
      initializeDateFormatting();
      dateFormat = DateFormat.yMMMMEEEEd('th');

      // * Database Refferences
       _db = NotesDatabase.instance;
      notes = _db.readAllNote(); // แสดงรายการหนังสือ
      super.initState();
  }
   // * Delete all list command
    Future<void> clearNote() async {
      await _db.deleteAll(); // ทำคำสั่งลบข้อมูลทั้งหมด
      setState(() {
        notes = _db.readAllNote(); // แสดงรายการหนังสือ
      });      
    }

  // * คำสั่งลบเฉพาะรายการที่กำหนดด้วย id ที่ต้องการ
    Future<void> deleteNote(int id) async {
      await _db.delete(id); // ทำคำสั่งลบข้มูลตามเงื่อนไข id
      setState(() {
        notes = _db.readAllNote(); // แสดงรายการหนังสือ
      });    
    }
 
    // * จำลองทำคำสั่งแก้ไขรายการ
    Future<void> editNote(Note note) async {
      // เลื่อกเปลี่ยนเฉพาะส่วนที่ต้องการ โดยใช้คำสั่ง copy
      note = note.copy(
        title: note.title+' new ',
        content: 'Hello Flutter',
        description: 'description',
        publication_date: DateTime.now()
      );      
      await _db.update(note); // ทำคำสั่งอัพเดทข้อมูล
      setState(() {
        notes = _db.readAllNote(); // แสดงรายการหนังสือ
      });    
    }

     // * จำลองทำคำสั่งเพิ่มข้อมูลใหม่
    Future<void> newNote() async {
      i++;
      Note note = Note(
        note_id: i,
        title: 'Book title $i',
        type: 'General Note',
        content: 'content',
        description: 'description',
        publication_date: DateTime.now(), 
        
      );
      Note new_note = await _db.create(note); // ทำคำสั่งเพิ่มข้อมูลใหม่
      setState(() {
        notes = _db.readAllNote(); // แสดงรายการหนังสือ
      });
    }

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      appBar: AppBar(
                title: const Text('Book'),
                actions: <Widget>[ // 
                  IconButton(
                    onPressed: () => clearNote(), // ปุ่มลบข้อมูลทั้งหมด
                    icon: const Icon(Icons.clear_all),
                  ),
                ],
            ),
      body: Center(
        child: FutureBuilder<List<Note>>( // Data types
          future: notes, // Future Data
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Expanded( // Data list section
                    child: snapshot.data!.isNotEmpty // กำหนดเงื่อนไขนี้
                    ? ListView.separated( // กรณีมีรายการ แสดงปกติหมด controller ที่จะใช้งานร่วม
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
                            ),
                          ],
                        )
                      );
                      return card;
                    },
                    separatorBuilder: (BuildContext context, int index)  => const SizedBox(),
                    )
                    : const Center(child: Text('No items')), // กรณีไม่มีรายการ
                  ),
                ],  
              );
            } else if  (snapshot.hasError) { // กรณี error
                return Text('${snapshot.error}');
            } 
              // กรณีสถานะเป็น waiting ยังไม่มีข้อมูล แสดงตัว loading
                return const RefreshProgressIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => newNote(),
        child: const Icon(Icons.add),
      ),
    );
  }


// สร้างฟังก์ชั่นจำลองการแสดงรายละเอียดข้อมูล
    Future<Widget?> _viewDetail(int id) async {
      Future<Note> note = _db.readNote(id); // ดึงข้อมูลจากฐานข้อมูลมาแสดง
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context){
            return FutureBuilder<Note>(
              future: note,
              builder: (context,snapshot){
                if (snapshot.hasData) {
                  var note = snapshot.data!;
                  return Container(
                    height: 200,
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ID: ${note.id}'), // * 1
                          const SizedBox(height: 5,),
                        Text('ชื่อโน้ต: ${note.title}'), // * 2
                          const SizedBox(height: 5,),
                        Text('รหัส: ${note.note_id}'), // * 3
                          const SizedBox(height: 5,),
                        Text('ประเภท: ${note.type}'), // * 4
                          const SizedBox(height: 5,),
                        Text('เนื้อหา: ${note.content}'), // * 5
                          const SizedBox(height: 5,),
                        Text('จำนวนหน้า: ${note.description}'), // * 6
                          const SizedBox(height: 5,),
                        Text('วันที่: ${dateFormat.format(note.publication_date)}'), // * 7
                        
                      ],
                    ),
                  );
                } else if (snapshot.hasError) { // กรณี error
                  return Text('${snapshot.error}');
                }
                return const RefreshProgressIndicator();
              }
            );
        }
      );
    }
} //extend state  
