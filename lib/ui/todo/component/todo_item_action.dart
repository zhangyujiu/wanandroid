import 'package:fish_redux/fish_redux.dart';

enum TodoItemAction { onCheck, check }

class TodoItemCreator {
  static Action onCheckAction(bool check) {
    return Action(TodoItemAction.onCheck, payload: check);
  }
  static Action check(int id) {
    return Action(TodoItemAction.check, payload: id);
  }
}
