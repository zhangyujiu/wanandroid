import 'package:flutter/material.dart';
import 'package:wanandroid/utils/textsize.dart';

class PageWidget extends StatefulWidget {
  Widget child;
  PageStateController controller;

  PageWidget({this.child, controller})
      : controller = controller != null ? controller : PageStateController();

  @override
  State<StatefulWidget> createState() {
    return _PageWidgetState();
  }
}

class _PageWidgetState extends State<PageWidget> {
  int index = 2;

  @override
  void initState() {
    super.initState();
    widget.controller.loadingNotifier.addListener(() {
      setState(() {
        switch (widget.controller._state) {
          case PageState.Loading:
            index = 2;
            break;
          case PageState.LoadSuccess:
            index = 0;
            break;
          case PageState.LoadFail:
            index = 1;
            break;
          default:
            index = 2;
            break;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: index,
      children: <Widget>[
        widget.child,
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ImageIcon(AssetImage("assets/load_fail.png"),size: 50,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "加载失败",
                  style: TextStyle(fontSize: TextSizeConst.middleTextSize),
                ),
              )
            ],
          ),
        ),
        Center(
          child: CircularProgressIndicator(),
        )
      ],
    );
  }
}

class PageStateController {
  //属性监听，也可以用InheritedWidget、Redux实现
  ValueNotifier<PageState> loadingNotifier = ValueNotifier(PageState.Loading);
  PageState _state = PageState.Loading;

  void changeState(PageState state) {
    this._state = state;
    loadingNotifier.value = state;
  }
}

enum PageState { Loading, LoadSuccess, LoadFail }
