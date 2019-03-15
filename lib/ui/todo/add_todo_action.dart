import 'package:fish_redux/fish_redux.dart';

enum AddTodoAction { onAdd, onEdit }

class AddTodoActionCreator {
  static Action onAddAction(Map<String, String> todos) {
    return Action(AddTodoAction.onAdd, payload: todos);
  }

  static Action onEditAction(Map<String, String> todos) {
    return Action(AddTodoAction.onEdit, payload: todos);
  }
}
