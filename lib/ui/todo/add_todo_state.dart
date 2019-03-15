import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/model/todo.dart';

class AddTodoState implements Cloneable<AddTodoState> {
  TextEditingController titleEditController;
  TextEditingController contentEditController;
  Todo todo;

  @override
  AddTodoState clone() {
    return AddTodoState()
      ..todo = todo
      ..titleEditController = titleEditController
      ..contentEditController = contentEditController;
  }
}

AddTodoState initState(Todo arg) {
  var addTodoState = AddTodoState();
  addTodoState.todo = arg?.clone() ?? null;
  addTodoState.titleEditController = TextEditingController(text: arg?.title);
  addTodoState.contentEditController =
      TextEditingController(text: arg?.content);
  return addTodoState;
}
