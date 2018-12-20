import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:redux/redux.dart';
import 'package:wanandroid/event/error_event.dart';
import 'package:wanandroid/net/dio_manager.dart';
import 'package:wanandroid/redux/main_redux.dart';
import 'package:wanandroid/redux/user_reducer.dart';
import 'package:wanandroid/ui/home/home_page.dart';
import 'package:wanandroid/ui/knowledge/knowledge_page.dart';
import 'package:wanandroid/ui/login_page.dart';
import 'package:wanandroid/ui/navigation/navigation_page.dart';
import 'package:wanandroid/ui/project/project_page.dart';
import 'package:wanandroid/utils/color.dart';
import 'package:wanandroid/utils/common.dart';
import 'package:wanandroid/utils/const.dart';
import 'package:wanandroid/utils/eventbus.dart';
import 'package:wanandroid/utils/sp.dart';
import 'package:wanandroid/utils/textsize.dart';
import 'package:wanandroid/widget/titlebar.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
          CommonUtils.pushIOS(context, LoginPage());
        }
      } else if (event is DioError) {
        String errorMsg = "";
        switch (event.type) {
          case DioErrorType.DEFAULT:
            errorMsg = "网络错误";
            break;
          case DioErrorType.CONNECT_TIMEOUT:
            errorMsg = "连接超时";
            break;
          case DioErrorType.RECEIVE_TIMEOUT:
            errorMsg = "接收超时";
            break;
          case DioErrorType.RESPONSE:
            errorMsg = "服务器错误";
            break;
          case DioErrorType.CANCEL:
            errorMsg = "请求取消";
            break;
          default:
            break;
        }
        Fluttertoast.showToast(msg: errorMsg);
      }
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

  Store _store;

  Widget _drawerChild() {
    return Column(
      children: <Widget>[
        CachedNetworkImage(
          fit: BoxFit.fill,
          width: double.infinity,
          height: 200,
          imageUrl: "http://t2.hddhhn.com/uploads/tu/201612/98/st93.png",
          placeholder: Icon(
            Icons.info_outline,
            color: ColorConst.color_999,
            size: 100,
          ),
          errorWidget: Icon(Icons.info_outline),
        ),
        SizedBox(
          width: 0,
          height: 5,
        ),
        _menuItem("收藏", Icons.collections, () {}),
        _menuItem("关于我们", Icons.people, () {}),
        StoreBuilder<MainRedux>(
          builder: (context, store) {
            _store = store;
            return Offstage(
              offstage: store.state.user == null,
              child: Container(
                margin: EdgeInsets.only(top: 20),
                width: 200,
                child: RaisedButton(
                  color: Colors.lightBlueAccent,
                  onPressed: () {
                    _logout(context);
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

  void _logout(BuildContext context) {
    DioManager.singleton.get("user/logout/json").then((result) {
      if (result != null) {
        Fluttertoast.showToast(msg: "退出成功");
        SpManager.singleton.save(Const.ID, -1);
        SpManager.singleton.save(Const.USERNAME, "");
        _store.dispatch(UpdateUserAction(null));
        Navigator.pop(context);
      }
    });
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
