import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/model/todo.dart';

Widget buildItemView(
  Todo state,
  Dispatch dispatch,
  ViewService viewService,
) {
  return ListTile(
    title: Text(state.title),
  );
}
