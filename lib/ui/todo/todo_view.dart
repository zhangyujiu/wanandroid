import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/ui/todo/add_todo_page.dart';
import 'package:wanandroid/ui/todo/todo_action.dart';
import 'package:wanandroid/ui/todo/todo_state.dart';
import 'package:wanandroid/utils/utils.dart';
import 'package:wanandroid/widget/custom_refresh.dart';
import 'package:wanandroid/widget/page_widget.dart';
import 'package:wanandroid/widget/titlebar.dart';

Widget buildView(TodoState state, Dispatch dispatch, ViewService viewService) {
  ListAdapter todoAdapter = viewService.buildAdapter();
  return Scaffold(
    appBar: TitleBar(
      isShowBack: true,
      title: "TODO",
      rightButtons: <Widget>[
        TitleBar.iconButton(
            icon: Icons.add,
            color: ColorConst.color_white,
            press: () {
              CommonUtils.push(
                      viewService.context, AddTodoPage().buildPage(null))
                  .then((value) {
                if (value == "yes") {
                  dispatch(TodoActionCreator.onRefreshAction());
                }
              });
            })
      ],
    ),
    body: PageWidget(
        controller: state.pageStateController,
        reload: () {
          dispatch(TodoActionCreator.onRefreshAction());
        },
        child: CustomRefresh(
          easyRefreshKey: state.easyRefreshKey,
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
