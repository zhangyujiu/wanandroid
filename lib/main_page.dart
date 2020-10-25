import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:wanandroid/event/error_event.dart';
import 'package:wanandroid/generated/i18n.dart';
import 'package:wanandroid/net/dio_manager.dart';
import 'package:wanandroid/redux/main_redux.dart';
import 'package:wanandroid/redux/user_reducer.dart';
import 'package:wanandroid/ui/account/login_page.dart';
import 'package:wanandroid/ui/home/collection_page.dart';
import 'package:wanandroid/ui/home/home_page.dart';
import 'package:wanandroid/ui/home/search_page.dart';
import 'package:wanandroid/ui/knowledge/knowledge_page.dart';
import 'package:wanandroid/ui/navigation/navigation_page.dart';
import 'package:wanandroid/ui/project/project_page.dart';
import 'package:wanandroid/ui/todo/todo_page.dart';
import 'package:wanandroid/ui/webview_page.dart';
import 'package:wanandroid/utils/utils.dart';
import 'package:wanandroid/widget/titlebar.dart';

class MainPage extends StatefulWidget {
  @override
  State createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  var appBarTitles;

  int _tabIndex = 0;
  var _pageCtr = PageController(initialPage: 0, keepPage: true);
  DateTime _lastPressedAt; //上次点击时间

  @override
  void initState() {
    super.initState();
    EventUtil.eventBus.on().listen((event) {
      if (event is ErrorEvent) {
        CommonUtils.toast(event.errorMsg);
        if (event.errorCode == -1001) {
          //登录
          CommonUtils.pushIOS(context, LoginPage());
        }
      } else if (event is DioError) {
        String errorMsg = "";
        switch (event.type) {
          case DioErrorType.DEFAULT:
            errorMsg = S.of(context).network_error;
            break;
          case DioErrorType.CONNECT_TIMEOUT:
            errorMsg = S.of(context).connect_timeout;
            break;
          case DioErrorType.RECEIVE_TIMEOUT:
            errorMsg = S.of(context).receive_timeout;
            break;
          case DioErrorType.RESPONSE:
            errorMsg = S.of(context).server_error;
            break;
          case DioErrorType.CANCEL:
            errorMsg = S.of(context).request_cancel;
            break;
          default:
            break;
        }
        CommonUtils.toast(errorMsg);
      }
    });
    //visitElement(context);
  }

  void visitElement(Element e) {
    WidgetsBinding.instance.addPostFrameCallback((_){
      e.visitChildElements((visitor){
        print("------------"+visitor.widget.runtimeType.toString());
        if(visitor==null)return;
        visitElement(visitor);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    appBarTitles = [
      S.of(context).home,
      S.of(context).knowledge_system,
      S.of(context).navigation,
      S.of(context).project
    ];
    /*return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: ,
    );*/
    return WillPopScope(
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
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
                      CommonUtils.push(context, SearchPage());
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
                selectedFontSize: 12,
                unselectedFontSize: 12,
                items: [
                  BottomNavigationBarItem(
                      title: Text(appBarTitles[0]), icon: Icon(Icons.location_city)),
                  BottomNavigationBarItem(
                      title: Text(appBarTitles[1]), icon: Icon(Icons.dvr)),
                  BottomNavigationBarItem(
                      title: Text(appBarTitles[2]), icon: Icon(Icons.send)),
                  BottomNavigationBarItem(
                      title: Text(appBarTitles[3]), icon: Icon(Icons.school)),
                ]),
          ),
        ),
        onWillPop: () async {
          if (_lastPressedAt == null ||
              DateTime.now().difference(_lastPressedAt) >
                  Duration(seconds: 2)) {
            //两次点击间隔超过2秒则重新计时
            _lastPressedAt = DateTime.now();
            CommonUtils.toast(S.of(context).press_again_to_exit_the_app);
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
        ClipPath(
          clipper: ArcClipper(),
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            width: double.infinity,
            height: 180,
            imageUrl: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1603607132785&di=1b34e010ae664b8ba3f70f0f41acaabd&imgtype=0&src=http%3A%2F%2Fimg.pconline.com.cn%2Fimages%2Fupload%2Fupc%2Ftx%2Fwallpaper%2F1212%2F25%2Fc0%2F16875142_1356415699834.jpg",
            placeholder: (context, url) => Image.asset(
                  "assets/logo.png",
                  width: double.infinity,
                  height: 180,
                ),
            errorWidget: (context, url, error) => Image.asset(
                  "assets/load_fail.png",
                  width: double.infinity,
                  height: 180,
                ),
          ),
        ),
        SizedBox(
          width: 0,
          height: 5,
        ),
        _menuItem('TODO', Icons.work, () {
          CommonUtils.isLogin().then((isLogin) {
            if (isLogin) {
              CommonUtils.push(context, TodoPage().buildPage({}));
            } else {
              CommonUtils.toast(S.of(context).please_login_first);
              CommonUtils.pushIOS(context, LoginPage());
            }
          });
        }),
        _menuItem(S.of(context).collection, Icons.collections, () {
          CommonUtils.isLogin().then((isLogin) {
            if (isLogin) {
              CommonUtils.push(context, CollectionPage());
            } else {
              CommonUtils.toast(S.of(context).please_login_first);
              CommonUtils.pushIOS(context, LoginPage());
            }
          });
        }),
        _menuItem(S.of(context).about_us, Icons.people, () {
          CommonUtils.push(
              context,
              WebViewPage(
                title: S.of(context).about_us,
                url: "https://www.wanandroid.com/",
              ));
        }),
        StoreBuilder<MainRedux>(
          builder: (context, store) {
            _store = store;
            return Offstage(
              offstage: store.state.user == null,
              child: Container(
                margin: EdgeInsets.fromLTRB(20, 50, 20, 0),
                width: MediaQuery.of(context).size.width,
                height: 45,
                child: RaisedButton(
                  color: ColorConst.color_46be39,
                  onPressed: () {
                    CommonUtils.showCommitOptionDialog(
                        context,
                        S.of(context).prompt,
                        S.of(context).logout_prompt,
                        [S.of(context).ok, S.of(context).cancel], (index) {
                      if (index == 0) {
                        _logout(context);
                      }
                    }, bgColorList: [Colors.black26, ColorConst.color_primary]);
                  },
                  child: Text(S.of(context).logout,
                      style: TextStyle(color: Colors.white)),
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
        CommonUtils.toast(S.of(context).logout_success);
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

//CustomClipper 裁切路径
class ArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height - 30);
    var firstControlPoint = Offset(size.width / 2, size.height);
    var firstEndPoint = Offset(size.width, size.height - 30);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    path.lineTo(size.width, size.height - 30);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
