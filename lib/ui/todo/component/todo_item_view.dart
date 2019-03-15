import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/model/todo.dart';
import 'package:wanandroid/ui/todo/add_todo_page.dart';
import 'package:wanandroid/ui/todo/component/todo_item_action.dart';
import 'package:wanandroid/ui/todo/todo_action.dart';
import 'package:wanandroid/utils/color.dart';
import 'package:wanandroid/utils/common.dart';
import 'package:wanandroid/utils/textsize.dart';

Widget buildItemView(
  Todo state,
  Dispatch dispatch,
  ViewService viewService,
) {
  return GestureDetector(
    onLongPress: () {
      dispatch(TodoActionCreator.onDeleteAction());
    },
    onTap: () {
      CommonUtils.push(viewService.context, AddTodoPage().buildPage(state))
          .then((value) {
        if (value == "yes") {
          dispatch(TodoActionCreator.onRefreshAction());
        }
      });
    },
    child: Card(
      margin: EdgeInsets.all(5),
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: state.status == 0
                      ? ColorConst.color_46be39
                      : ColorConst.color_FFA500,
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(4.0), bottom: Radius.circular(0.0))),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        state.title,
                        style: TextStyle(color: ColorConst.color_white),
                      ),
                    ),
                  ),
                  Checkbox(
                    value: state.status == 1,
                    activeColor: ColorConst.color_46be39,
                    onChanged: (b) {
                      dispatch(TodoItemCreator.onCheckAction(b));
                    },
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  state.content,
                  style: TextStyle(
                      color: ColorConst.color_555,
                      fontSize: TextSizeConst.smallTextSize),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "完成时间：${state.completeDateStr.isEmpty ? "未完成" : state.completeDateStr}",
                  style: TextStyle(
                      color: ColorConst.color_555,
                      fontSize: TextSizeConst.smallTextSize),
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
