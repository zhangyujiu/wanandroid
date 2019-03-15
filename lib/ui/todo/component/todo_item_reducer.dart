import 'package:fish_redux/fish_redux.dart';
import 'package:wanandroid/model/todo.dart';
import 'package:wanandroid/ui/todo/component/todo_item_action.dart';
import 'package:wanandroid/utils/time.dart';

Reducer<Todo> buildReducer() {
  return asReducer(<Object, Reducer<Todo>>{
    TodoItemAction.check: _check,
  });
}

Todo _check(Todo state, Action action) {
  var payload = action.payload;
  if (state.id == payload) {
    return state.clone()..status = state.status == 1 ? 0 : 1
    ..completeDateStr=state.status == 1 ? "" : TimeUtils.getCurrentDate();
  }
  return state;
}
