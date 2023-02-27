import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/models/data.dart';

class DataProvider with ChangeNotifier {
  // Data example
  List<Data> datas = [
    Data(note_id: "001",title: "note",type: "work",content: "no content",description: "no desc",date: DateTime.now()),
    Data(note_id: "002",title: "notes",type: "life",content: "no content kub",description: "no desc",date: DateTime.now()),
    Data(note_id: "003",title: "notess",type: "personal",content: "no content jaaa",description: "no desc",date: DateTime.now()),
  ];

  List<Data> getData(){
    return datas;
  }

  void addData(Data statement){
    datas.add(statement);
  }
}