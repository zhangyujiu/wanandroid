import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:redux/redux.dart';
import 'package:wanandroid/event/error_event.dart';
import 'package:wanandroid/model/user.dart';
import 'package:wanandroid/redux/main_redux.dart';
import 'package:wanandroid/redux/user_reducer.dart';
import 'package:wanandroid/ui/home/home_page.dart';
import 'package:wanandroid/ui/knowledge/knowledge_page.dart';
import 'package:wanandroid/ui/login_page.dart';
import 'package:wanandroid/ui/navigation/navigation_page.dart';
import 'package:wanandroid/ui/project/project_page.dart';
import 'package:wanandroid/utils/const.dart';
import 'package:wanandroid/utils/cookieutil.dart';
import 'package:wanandroid/utils/common.dart';
import 'package:wanandroid/utils/eventbus.dart';
import 'package:wanandroid/utils/color.dart';
import 'package:wanandroid/utils/sp.dart';
import 'package:wanandroid/utils/textsize.dart';
import 'package:wanandroid/widget/titlebar.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter_redux/flutter_redux.dart';

class MainPage extends StatefulWidget {
  @override
  State createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  var appBarTitles = ['首页', '知识体系', '导航', "项目"];
  int _tabIndex = 0;
  var _pageCtr = PageController(initialPage: 0, keepPage: true);
  DateTime _lastPressedAt; //上次点击时间

  @override
  void initState() {
    super.initState();
    EventUtil.eventBus.on().listen((event) {
      if (event is ErrorEvent) {
        Fluttertoast.showToast(msg: event.errorMsg);
        if (event.errorCode == -1001) {
          //登录
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        }
      }
    });
    int userID;
    String userName;
    SpManager.singleton.getInt(Const.ID).then((id) {
      userID = id;
    }).whenComplete(() {
      SpManager.singleton.getString(Const.USERNAME).then((name) {
        userName = name;
        if (userID != null && userName != null) {
          StoreProvider.of(context)
              .dispatch(UpdateUserAction(User(userID, userName)));
        }
      });
    });
  }

  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: TitleBar(
            isShowBack: true,
            leftButton: Builder(builder: (cxt) {
              return IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Scaffold.of(cxt).openDrawer();
                  });
            }),
            title: appBarTitles[_tabIndex],
            rightButtons: <Widget>[
              TitleBar.iconButton(
                  icon: Icons.search,
                  color: ColorConst.color_white,
                  press: () {
                    CommonUtils.showLoadingDialog(context);
                    Future.delayed(Duration(seconds: 3)).then((_) {
                      Navigator.pop(context);
                    });
                  })
            ],
          ),
          drawer: Drawer(
            child: _drawerChild(),
          ),
          body: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _pageCtr,
            children: <Widget>[
              HomePage(),
              KnowledgePage(),
              NavigationPage(),
              ProjectPage(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: _tabIndex,
              type: BottomNavigationBarType.fixed,
              fixedColor: Color(ColorConst.primaryColor),
              onTap: (index) => _tap(index),
              items: [
                BottomNavigationBarItem(
                    title: Text(appBarTitles[0]), icon: Icon(Icons.home)),
                BottomNavigationBarItem(
                    title: Text(appBarTitles[1]), icon: Icon(Icons.theaters)),
                BottomNavigationBarItem(
                    title: Text(appBarTitles[2]), icon: Icon(Icons.navigation)),
                BottomNavigationBarItem(
                    title: Text(appBarTitles[3]), icon: Icon(Icons.print)),
              ]),
        ),
        onWillPop: () async {
          if (_lastPressedAt == null ||
              DateTime.now().difference(_lastPressedAt) >
                  Duration(seconds: 2)) {
            //两次点击间隔超过2秒则重新计时
            _lastPressedAt = DateTime.now();
            Fluttertoast.showToast(msg: "再按一次退出应用程序");
            return false;
          }
          return true;
        });
  }

  _tap(int index) {
    setState(() {
      _tabIndex = index;
      _pageCtr.jumpToPage(index);
    });
  }

  Widget _drawerChild() {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 200,
          child: Column(
            children: <Widget>[],
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "http://t2.hddhhn.com/uploads/tu/201612/98/st93.png"),
                fit: BoxFit.fill),
          ),
          padding: EdgeInsets.fromLTRB(15, 25, 15, 10),
        ),
        SizedBox(
          width: 0,
          height: 5,
        ),
        _menuItem("收藏", Icons.collections, () {}),
        _menuItem("关于我们", Icons.people, () {}),
        StoreConnector<MainRedux, User>(
          converter: (store) => store.state.user,
          builder: (ctx, model) {
            return Offstage(
              offstage: model == null,
              child: Container(
                margin: EdgeInsets.only(top: 20),
                width: 200,
                child: RaisedButton(
                  color: Colors.lightBlueAccent,
                  onPressed: () {
                    CookieUtil.deleteAllCookies().then((_) {
                      Fluttertoast.showToast(msg: "退出成功");
                      StoreProvider.of(context)
                          .dispatch(UpdateUserAction(null));
                      Navigator.pop(context);
                    });
                  },
                  child: Text('退出登录', style: TextStyle(color: Colors.white)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _menuItem(String text, IconData icon, Function() tap) {
    return InkWell(
      onTap: tap,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              color: Colors.black45,
            ),
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                text,
                style: TextStyle(
                    color: ColorConst.color_333,
                    fontSize: TextSizeConst.smallTextSize),
              ),
            )
          ],
        ),
      ),
    );
  }
}
