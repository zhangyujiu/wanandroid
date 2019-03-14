import 'package:fish_redux/fish_redux.dart';
import 'package:wanandroid/model/todo.dart';
import 'package:wanandroid/net/dio_manager.dart';
import 'package:wanandroid/ui/todo/todo_action.dart';
import 'package:wanandroid/ui/todo/todo_state.dart';
import 'package:wanandroid/widget/page_widget.dart';

Effect<TodoState> buildEffect() {
  return combineEffects(<Object, Effect<TodoState>>{
    Lifecycle.initState: _init,
    TodoAction.onRefresh: _onRefresh,
    TodoAction.onLoadMore: _onLoadMore,
  });
}

void _init(Action action, Context<TodoState> ctx) {
  DioManager.singleton
      .get("lg/todo/v2/list/${ctx.state.pageIndex}/json")
      .then((result) {
    ctx.state.easyRefreshKey.currentState.callRefreshFinish();
    ctx.state.easyRefreshKey.currentState.callLoadMoreFinish();
    if (result != null) {
      ctx.state.pageStateController.changeState(PageState.LoadSuccess);
      ctx.dispatch(
          TodoActionCreator.onInitAction(Todo.parseList(result.data["datas"])));
    } else {
      ctx.state.pageStateController.changeState(PageState.LoadFail);
    }
  });
}

void _onRefresh(Action action, Context<TodoState> ctx) {
  ctx.state.pageIndex = 1;
  DioManager.singleton
      .get("lg/todo/v2/list/${ctx.state.pageIndex}/json")
      .then((result) {
    ctx.state.easyRefreshKey.currentState.callRefreshFinish();
    ctx.state.easyRefreshKey.currentState.callLoadMoreFinish();
    if (result != null) {
      ctx.state.pageStateController.changeState(PageState.LoadSuccess);
      ctx.dispatch(TodoActionCreator.refreshAction(
          Todo.parseList(result.data["datas"])));
    } else {
      ctx.state.pageStateController.changeState(PageState.LoadFail);
    }
  });
}

void _onLoadMore(Action action, Context<TodoState> ctx) {
  ctx.state.pageIndex++;
  DioManager.singleton
      .get("lg/todo/v2/list/${ctx.state.pageIndex}/json")
      .then((result) {
    ctx.state.easyRefreshKey.currentState.callRefreshFinish();
    ctx.state.easyRefreshKey.currentState.callLoadMoreFinish();
    if (result != null) {
      ctx.state.pageStateController.changeState(PageState.LoadSuccess);
      ctx.dispatch(TodoActionCreator.loadMoreAction(
          Todo.parseList(result.data["datas"])));
    } else {
      ctx.state.pageStateController.changeState(PageState.LoadFail);
    }
  });
}
