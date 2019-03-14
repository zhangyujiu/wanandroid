import 'package:fish_redux/fish_redux.dart';
import 'package:wanandroid/ui/todo/component/todo_adapter.dart';
import 'package:wanandroid/ui/todo/todo_effect.dart';
import 'package:wanandroid/ui/todo/todo_reducer.dart';
import 'package:wanandroid/ui/todo/todo_state.dart';
import 'package:wanandroid/ui/todo/todo_view.dart';

class TodoPage extends Page<TodoState, Map<String, dynamic>> {
  TodoPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer:buildReducer(),
          view: buildView,
    dependencies:Dependencies<TodoState>(adapter: TodoAdapter())
        );
}
