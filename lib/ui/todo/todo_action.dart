import 'package:fish_redux/fish_redux.dart';
import 'package:wanandroid/model/todo.dart';

enum TodoAction { init }

class TodoActionCreator {
  static Action onInitAction(List<Todo> todos) {
    return Action(TodoAction.init, payload: todos);
  }
}
