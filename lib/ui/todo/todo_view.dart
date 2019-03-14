import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/ui/todo/todo_action.dart';
import 'package:wanandroid/ui/todo/todo_state.dart';
import 'package:wanandroid/widget/custom_refresh.dart';
import 'package:wanandroid/widget/page_widget.dart';
import 'package:wanandroid/widget/titlebar.dart';

Widget buildView(TodoState state, Dispatch dispatch, ViewService viewService) {
  ListAdapter todoAdapter = viewService.buildAdapter();
  return Scaffold(
    appBar: TitleBar(
      isShowBack: true,
      title: "TODO",
    ),
    body: PageWidget(
        controller: state.pageStateController,
        reload: () {
          dispatch(TodoActionCreator.onRefreshAction());
        },
        child: CustomRefresh(
          easyRefreshKey: state.easyRefreshKey,
          headerKey: state.headerKey,
          footerKey: state.footerKey,
          onRefresh: () {
            dispatch(TodoActionCreator.onRefreshAction());
          },
          loadMore: () {
            dispatch(TodoActionCreator.onLoadMoreAction());
          },
          child: ListView.builder(
              itemBuilder: todoAdapter.itemBuilder,
              itemCount: todoAdapter.itemCount),
        )),
  );
}
