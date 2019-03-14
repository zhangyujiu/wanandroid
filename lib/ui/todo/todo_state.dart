import 'package:fish_redux/fish_redux.dart';
import 'package:wanandroid/model/todo.dart';

class TodoState implements Cloneable<TodoState> {
  var pageIndex = 1;
  List<Todo> todos = [];

  @override
  TodoState clone() {
    return TodoState()
      ..pageIndex = pageIndex
      ..todos = todos;
  }
}

TodoState initState(Map<String, dynamic> args) {
  return TodoState();
}
