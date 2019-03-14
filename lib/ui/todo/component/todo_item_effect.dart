import 'package:dio/dio.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:wanandroid/model/todo.dart';
import 'package:wanandroid/net/dio_manager.dart';
import 'package:wanandroid/ui/todo/component/todo_item_action.dart';

Effect<Todo> buildEffect() {
  return combineEffects(<Object, Effect<Todo>>{
    TodoItemAction.onCheck: _onCheck,
  });
}

void _onCheck(Action action, Context<Todo> ctx) {
  bool payload = action.payload;
  DioManager.singleton
      .post("lg/todo/done/${ctx.state.id}/json",
          data: FormData.from({"status": payload ? 1 : 0}))
      .then((result) {
    ctx.dispatch(TodoItemCreator.check(ctx.state.id));
  });
}
