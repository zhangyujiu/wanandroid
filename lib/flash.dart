import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:wanandroid/model/user.dart';
import 'package:wanandroid/redux/main_redux.dart';
import 'package:wanandroid/redux/user_reducer.dart';
import 'package:wanandroid/utils/const.dart';
import 'package:wanandroid/utils/sp.dart';

class FlashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FlashPageState();
  }
}

class _FlashPageState extends State<FlashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4)).whenComplete(() {
      Navigator.pushReplacementNamed(context, 'main');
    });
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initData();
  }

  void initData() {
    int userID;
    String userName;
    Store<MainRedux> store=StoreProvider.of(context);
    SpManager.singleton.getInt(Const.ID).then((id) {
      userID = id;
    }).whenComplete(() {
      SpManager.singleton.getString(Const.USERNAME).then((name) {
        userName = name;
        if (userID != null&&userID>0 && userName != null&&userName.isNotEmpty) {
          store.dispatch(UpdateUserAction(User(userID, userName)));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Image.network(
      'http://b.hiphotos.baidu.com/image/pic/item/0ff41bd5ad6eddc4802878ba34dbb6fd536633a0.jpg',
      fit: BoxFit.fitHeight,
    );
  }
}
