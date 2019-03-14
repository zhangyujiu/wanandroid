import 'package:fish_redux/fish_redux.dart';
import 'package:wanandroid/model/todo.dart';
import 'package:wanandroid/ui/todo/component/todo_item_componet.dart';
import 'package:wanandroid/ui/todo/todo_state.dart';

class TodoAdapter extends DynamicFlowAdapter<TodoState> {
  TodoAdapter()
      : super(
            pool: <String, Component<Object>>{"todo": TodoItemComponent()},
            connector: _ListConnector());
}

class _ListConnector implements Connector<TodoState, List<ItemBean>> {
  @override
  List<ItemBean> get(TodoState state) {
    if (state.todos?.isNotEmpty == true) {
      return state.todos
          .map<ItemBean>((Todo data) => ItemBean('todo', data))
          .toList(growable: true);
    } else {
      return <ItemBean>[];
    }
  }

  @override
  void set(TodoState state, List<ItemBean> substate) {
    if (substate?.isNotEmpty == true) {
      state.todos = List<Todo>.from(
          substate.map<Todo>((ItemBean bean) => bean.data).toList());
    } else {
      state.todos = <Todo>[];
    }
  }
}
