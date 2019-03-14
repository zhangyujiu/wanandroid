import 'package:fish_redux/fish_redux.dart';
import 'package:wanandroid/model/todo.dart';
import 'todo_item_view.dart';

class TodoItemComponent extends Component<Todo> {
  TodoItemComponent() : super(view: buildItemView);
}
