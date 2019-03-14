import 'package:fish_redux/fish_redux.dart';
import 'package:wanandroid/model/todo.dart';
import 'package:wanandroid/net/dio_manager.dart';
import 'package:wanandroid/ui/todo/todo_action.dart';
import 'package:wanandroid/ui/todo/todo_state.dart';

Effect<TodoState> buildEffect() {
  return combineEffects(<Object, Effect<TodoState>>{
    Lifecycle.initState: _init,
  });
}

void _init(Action action, Context<TodoState> ctx) {
  DioManager.singleton
      .get("lg/todo/v2/list/${ctx.state.pageIndex}/json")
      .then((result) {
//    print(Todo.parseList(result.data["datas"]));
    ctx.dispatch(TodoActionCreator.onInitAction(Todo.parseList(result.data["datas"])));
  });
}

