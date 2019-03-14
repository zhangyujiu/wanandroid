import 'package:fish_redux/fish_redux.dart';
import 'package:wanandroid/model/todo.dart';
import 'package:wanandroid/ui/todo/component/todo_item_effect.dart';
import 'package:wanandroid/ui/todo/component/todo_item_reducer.dart';
import 'todo_item_view.dart';

class TodoItemComponent extends Component<Todo> {
  TodoItemComponent()
      : super(
            view: buildItemView,
            effect: buildEffect(),
            reducer: buildReducer());
}
