// กำหนดชื่อตารางไว้ในตัวแปร
final String tableNotes = 'Notes';
 
// กำหนดฟิลด์ข้อมูลของตาราง
class NoteFields {
  // สร้างเป็นลิสรายการสำหรับคอลัมน์ฟิลด์
  static final List<String> values = [
    id, note_id, title, type, content, description, publication_date
  ];
 
  // กำหนดแต่ละฟิลด์ของตาราง ต้องเป็น String ทั้งหมด
  static final String id = '_id'; // ตัวแรกต้องเป็น _id ส่วนอื่นใช้ชื่อะไรก็ได้
  static final String note_id = 'note_id';
  static final String title = 'title';
  static final String type = 'type';
  static final String content = 'content';
  static final String description = 'description';
  static final String publication_date = 'publication_date';
}
 
// ส่วนของ Data Model ของหนังสือ
class Note {
  final int? id; // จะใช้ค่าจากที่ gen ในฐานข้อมูล
  final int note_id; 
  final String title;
  final String type;
  final String content;
  final String description;
  final DateTime publication_date;
 
  // constructor
  const Note({
    this.id,
    required this.note_id,
    required this.title,
    required this.type,
    required this.content,
    required this.description,
    required this.publication_date,
  });
 
  // ฟังก์ชั่นสำหรับ สร้างข้อมูลใหม่ โดยรองรับแก้ไขเฉพาะฟิลด์ที่ต้องการ
  Note copy({
   int? id,
   int? note_id,
   String? title,
   String? type,
   String? content,
   String? description,
   DateTime? publication_date,
  }) => Note(
          id: id ?? this.id, 
          note_id: note_id ?? this.note_id,
          title: title ?? this.title,
          type: type ?? this.type,
          content: content ?? this.content,
          description: description ?? this.description,
          publication_date: publication_date ?? this.publication_date,
    );
 
  // สำหรับแปลงข้อมูลจาก Json เป็น Note object
  static Note fromJson(Map<String, Object?> json) =>  
    Note(
      id: json[NoteFields.id] as int?,
      note_id: json[NoteFields.note_id] as int,
      title: json[NoteFields.title] as String,
      type: json[NoteFields.type] as String,
      content: json[NoteFields.type] as String,
      description:json[NoteFields.type] as String,
      publication_date: DateTime.parse(json[NoteFields.publication_date] as String),
    );
 
  // สำหรับแปลง Note object เป็น Json บันทึกลงฐานข้อมูล
  Map<String, Object?> toJson() => {
    NoteFields.id: id,
    NoteFields.note_id: note_id,    
    NoteFields.title: title,
    NoteFields.type: type,
    NoteFields.content: content,
    NoteFields.description: description,
    NoteFields.publication_date: publication_date.toIso8601String(),
  };
 
 
}