import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wanandroid/event/error_event.dart';
import 'package:wanandroid/ui/home/home_page.dart';
import 'package:wanandroid/ui/knowledge/knowledge_page.dart';
import 'package:wanandroid/ui/login_page.dart';
import 'package:wanandroid/ui/navigation/navigation_page.dart';
import 'package:wanandroid/ui/project/project_page.dart';
import 'package:wanandroid/utils/EventBus.dart';
import 'package:wanandroid/utils/color.dart';
import 'package:wanandroid/widget/titlebar.dart';
import 'package:event_bus/event_bus.dart';

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

  @override
  void initState() {
    super.initState();
    EventUtil.eventBus.on().listen((event) {
      if(event is ErrorEvent){
        Fluttertoast.showToast(msg: event.errorMsg);
        if(event.errorCode==-1001){//登录
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        }
      }
    });
  }

  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Fluttertoast.showToast(msg: "添加");
              })
        ],
      ),
      drawer: Drawer(
        child: Container(
          child: Image.network(
            'http://b.hiphotos.baidu.com/image/pic/item/0ff41bd5ad6eddc4802878ba34dbb6fd536633a0.jpg',
            fit: BoxFit.fitHeight,
          ),
        ),
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
    );
  }

  _tap(int index) {
    setState(() {
      _tabIndex = index;
      _pageCtr.jumpToPage(index);
    });
  }
}
