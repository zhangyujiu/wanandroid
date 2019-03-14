import 'dart:convert' show json;

import 'package:fish_redux/fish_redux.dart';

class Todo implements Cloneable<Todo> {
  int completeDate;
  int date;
  int id;
  int priority;
  int status;
  int type;
  int userId;
  String completeDateStr;
  String content;
  String dateStr;
  String title;

  Todo.fromParams(
      {this.completeDate,
      this.date,
      this.id,
      this.priority,
      this.status,
      this.type,
      this.userId,
      this.completeDateStr,
      this.content,
      this.dateStr,
      this.title});

  factory Todo(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new Todo.fromJson(json.decode(jsonStr))
          : new Todo.fromJson(jsonStr);

  Todo.fromJson(jsonRes) {
    completeDate = jsonRes['completeDate'];
    date = jsonRes['date'];
    id = jsonRes['id'];
    priority = jsonRes['priority'];
    status = jsonRes['status'];
    type = jsonRes['type'];
    userId = jsonRes['userId'];
    completeDateStr = jsonRes['completeDateStr'];
    content = jsonRes['content'];
    dateStr = jsonRes['dateStr'];
    title = jsonRes['title'];
  }

  static List<Todo> parseList(List<dynamic> list) {
    List<Todo> articles = List();
    for (var a in list) {
      Todo todo = Todo.fromJson(a);
      articles.add(todo);
    }
    return articles;
  }

  @override
  String toString() {
    return '{"completeDate": $completeDate,"date": $date,"id": $id,"priority": $priority,"status": $status,"type": $type,"userId": $userId,"completeDateStr": ${completeDateStr != null ? '${json.encode(completeDateStr)}' : 'null'},"content": ${content != null ? '${json.encode(content)}' : 'null'},"dateStr": ${dateStr != null ? '${json.encode(dateStr)}' : 'null'},"title": ${title != null ? '${json.encode(title)}' : 'null'}}';
  }

  @override
  Todo clone() {
    return Todo.fromParams()
      ..completeDate = completeDate
      ..date = date
      ..id = id
      ..priority = priority
      ..status = status
      ..type = type
      ..userId = userId
      ..completeDateStr = completeDateStr
      ..content = content
      ..dateStr = dateStr
      ..title = title;
  }
}
