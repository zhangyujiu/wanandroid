import 'package:redux/redux.dart';
import 'package:wanandroid/model/user.dart';

final UserReducer =
    combineReducers<User>([TypedReducer<User, UpdateUserAction>(_update)]);

User _update(User user, action) {
  user = action.user;
  return user;
}

class UpdateUserAction {
  User user;

  UpdateUserAction(this.user);
}
