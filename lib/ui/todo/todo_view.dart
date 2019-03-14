import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/ui/todo/todo_state.dart';
import 'package:wanandroid/widget/titlebar.dart';

Widget buildView(TodoState state, Dispatch dispatch, ViewService viewService) {
  ListAdapter todoAdapter = viewService.buildAdapter();
  return Scaffold(
    appBar: TitleBar(
      isShowBack: true,
      title: "TODO",
    ),
    body: ListView.builder(itemBuilder: todoAdapter.itemBuilder,itemCount: todoAdapter.itemCount),
  );
}
