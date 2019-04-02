import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wanandroid/generated/i18n.dart';
import 'package:wanandroid/ui/todo/add_todo_action.dart';
import 'package:wanandroid/ui/todo/add_todo_state.dart';
import 'package:wanandroid/utils/utils.dart';
import 'package:wanandroid/widget/titlebar.dart';

Widget buildView(
    AddTodoState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: TitleBar(
      isShowBack: true,
      title:
          "${state.todo == null ? S.of(viewService.context).add : S.of(viewService.context).update} TODO",
      rightButtons: <Widget>[
        TitleBar.textButton(S.of(viewService.context).save,
            color: ColorConst.color_white, press: () {
          String title = state.titleEditController.text.toString();
          String content = state.contentEditController.text.toString();
          if(title.isEmpty){
            Fluttertoast.showToast(msg: S.of(viewService.context).title_can_not_be_blank);
            return;
          }
          if(content.isEmpty){
            Fluttertoast.showToast(msg: S.of(viewService.context).content_can_not_be_blank);
            return;
          }
          if (state.todo == null) {
            //添加
            dispatch(AddTodoActionCreator.onAddAction(
                <String, String>{"title": title, "content": content}));
          } else {
            //修改
            dispatch(AddTodoActionCreator.onEditAction(
                <String, String>{"title": title, "content": content}));
          }
        })
      ],
    ),
    body: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4.0)),
                  child: TextField(
                    controller: state.titleEditController,
                    maxLines: 1,
                    style: TextStyle(color: ColorConst.color_555, fontSize: 14),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: S.of(viewService.context).please_input_title,
                        contentPadding: EdgeInsets.all(10),
                        hintStyle: TextStyle(
                            color: ColorConst.color_999, fontSize: 14)),
                  ),
                ))
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4.0)),
                  child: TextField(
                    controller: state.contentEditController,
                    maxLines: 8,
                    style: TextStyle(color: ColorConst.color_555, fontSize: 14),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText:
                            S.of(viewService.context).please_input_content,
                        contentPadding: EdgeInsets.all(10),
                        hintStyle: TextStyle(
                            color: ColorConst.color_999, fontSize: 14)),
                  ),
                ))
          ],
        )
      ],
    ),
  );
}
