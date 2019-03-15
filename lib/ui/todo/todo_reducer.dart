import 'package:fish_redux/fish_redux.dart';
import 'package:wanandroid/model/todo.dart';
import 'package:wanandroid/ui/todo/todo_action.dart';
import 'package:wanandroid/ui/todo/todo_state.dart';

Reducer<TodoState> buildReducer() {
  return asReducer(<Object, Reducer<TodoState>>{
    TodoAction.init: _onInitData,
    TodoAction.refresh:_refresh,
    TodoAction.loadMore:_loadMore,
    TodoAction.delete:_delete,
  });
}

TodoState _onInitData(TodoState state, Action action) {
  List<Todo> todos = action.payload ?? <Todo>[];
  var clone = state.clone();
  clone.todos.addAll(todos);
  return clone;
}

TodoState _refresh(TodoState state, Action action) {
  List<Todo> todos = action.payload ?? <Todo>[];
  var clone = state.clone();
  clone.todos.clear();
  clone.todos.addAll(todos);
  return clone;
}

TodoState _loadMore(TodoState state, Action action) {
  List<Todo> todos = action.payload ?? <Todo>[];
  var clone = state.clone();
  clone.todos.addAll(todos);
  return clone;
}

TodoState _delete(TodoState state, Action action) {
  var clone = state.clone();
  clone.todos.remove(action.payload);
  return clone;
}
