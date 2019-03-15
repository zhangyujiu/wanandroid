import 'package:fish_redux/fish_redux.dart';
import 'package:wanandroid/model/todo.dart';
import 'package:wanandroid/ui/todo/add_todo_effect.dart';
import 'package:wanandroid/ui/todo/add_todo_state.dart';
import 'add_todo_view.dart';

class AddTodoPage extends Page<AddTodoState, Todo> {
  AddTodoPage()
      : super(initState: initState, view: buildView, effect: buildEffect());
}
