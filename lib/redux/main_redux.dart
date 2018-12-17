import 'package:wanandroid/model/user.dart';
import 'user_reducer.dart';

class MainRedux{
  User user;

  MainRedux({this.user});
}

MainRedux appReducer(MainRedux state, dynamic action) {
  return MainRedux(user: UserReducer(state.user, action));
}