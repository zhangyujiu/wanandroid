import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:wanandroid/model/todo.dart';
import 'package:wanandroid/widget/page_widget.dart';

class TodoState implements Cloneable<TodoState> {
  PageStateController pageStateController;
  GlobalKey<EasyRefreshState> easyRefreshKey;

  GlobalKey<RefreshHeaderState> headerKey;

  GlobalKey<RefreshFooterState> footerKey;

  var pageIndex = 1;
  List<Todo> todos = [];

  @override
  TodoState clone() {
    return TodoState()
      ..pageStateController = pageStateController
      ..easyRefreshKey = easyRefreshKey
      ..headerKey = headerKey
      ..footerKey = footerKey
      ..pageIndex = pageIndex
      ..todos = todos;
  }
}

TodoState initState(Map<String, dynamic> args) {
  var state = TodoState();
  state.pageStateController = PageStateController();
  state.easyRefreshKey = GlobalKey<EasyRefreshState>();
  state.headerKey = GlobalKey<RefreshHeaderState>();
  state.footerKey = GlobalKey<RefreshFooterState>();
  return state;
}
