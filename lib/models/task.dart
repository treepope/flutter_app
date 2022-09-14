// ignore_for_file: unnecessary_new, prefer_collection_literals

import 'package:flutter/material.dart';
import 'package:flutter_application_1/constant.dart';

class Task {
  late dynamic id, countAll, countChecked, countUnChecked, icon, color;
  late String name;

  Task({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.countAll,
    required this.countChecked,
    required this.countUnChecked,
  });

  Task.fromJson(Map<String, dynamic> json){
    id                = json['id'];
    name              = json['name'];
    countAll          = json['count_all'];
    countChecked      = json['count_checked'];
    countUnChecked    = json['count_unchecked'];
    color             = json['color_task'];
    icon              = json['icon_task'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['count_all'] = countAll;
    data['count_checked'] = countChecked;
    data['count_unchecked'] = countUnChecked;
    data['color_task'] = color;
    data['icon_task'] = icon;
    return data;
  }

}

class CheckTask {
  late int idTask;
  late int id;
  late String name, createdAt;
  late int checked;

  CheckTask({
    required this.id,
    required this.idTask,
    required this.name,
    required this.checked,
    required this.createdAt,
  });

  CheckTask.fromJson(Map<String, dynamic> json){
    id       = json['id'];
    idTask   = json['id_task'];
    name     = json['name'];
    checked    = json['checked'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id']      = id;
    data['id_task'] = idTask;
    data['name']    = name;
    data['checked']   = checked;
    data['created_at'] = createdAt;
    return data;
  }

}

