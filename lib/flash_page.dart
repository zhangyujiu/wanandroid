import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:wanandroid/model/user.dart';
import 'package:wanandroid/net/dio_manager.dart';
import 'package:wanandroid/redux/main_redux.dart';
import 'package:wanandroid/redux/user_reducer.dart';
import 'package:wanandroid/utils/utils.dart';

class FlashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FlashPageState();
  }
}

class _FlashPageState extends State<FlashPage> {
  int times = 3;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initData();
    countDownTimer(3, (time, isFinish) {
      print(time);
      setState(() {
        times = time;
      });
      if (isFinish) {
        Navigator.pushReplacementNamed(context, 'main');
      }
    });
  }

  void initData() {
    Store<MainRedux> store = StoreProvider.of(context);

    CookieUtil.getCookiePath().then((path) async {
      var persistCookieJar = PersistCookieJar(dir: path);
      var cookies =
          persistCookieJar.loadForRequest(Uri.parse(DioManager.baseUrl));
      if (cookies != null && cookies.length > 0) {
        var cookie = cookies[0];
        if (cookie.expires == null) return;
        bool isExpires = cookie.expires.isBefore(DateTime.now());
        //Cookie过期则退出登录
        if (isExpires) {
          DioManager.singleton.get("user/logout/json").then((result) {
            if (result != null) {
              SpManager.singleton.save(Const.ID, -1);
              SpManager.singleton.save(Const.USERNAME, "");
              store.dispatch(UpdateUserAction(null));
            }
          });
        } else {
          int userID = await SpManager.singleton.getInt(Const.ID);
          String userName = await SpManager.singleton.getString(Const.USERNAME);
          if (userID != null &&
              userID > 0 &&
              userName != null &&
              userName.isNotEmpty) {
            store.dispatch(UpdateUserAction(User(userID, userName)));
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ConstrainedBox(
            constraints: BoxConstraints.expand(),
            child: Image.asset(
              "assets/flash.jpg",
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
              top: 40,
              right: 10,
              child: Container(
                padding: EdgeInsets.fromLTRB(25, 8, 25, 8),
                decoration: BoxDecoration(
                    color: Colors.grey.withAlpha(180),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Text(
                  "$times s",
                  style: TextStyle(
                      color: ColorConst.color_white,
                      fontSize: TextSizeConst.middleTextSize),
                ),
              ))
        ],
      ),
    );
  }
}
