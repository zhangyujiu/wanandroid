import 'package:flutter/material.dart';
import 'package:wanandroid/widget/load_fail_widget.dart';

typedef ReloadData = Function();

//页面加载状态
class PageWidget extends StatefulWidget {
  Widget child;
  PageStateController controller;
  ReloadData reload;
  int index = 2;

  PageWidget({this.child, controller, this.reload, this.index = 2})
      : controller = controller != null ? controller : PageStateController();

  @override
  State<StatefulWidget> createState() {
    return _PageWidgetState();
  }
}

class _PageWidgetState extends State<PageWidget> {
  int index;
  VoidCallback _listener;

  @override
  void initState() {
    super.initState();
    index = widget.index;
    _listener = () {
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
    };
    widget.controller.loadingNotifier.addListener(_listener);
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: index,
      children: <Widget>[
        widget.child,
        LoadFailWidget(
          onTap: () {
            widget.controller.changeState(PageState.Loading);
            widget.reload();
          },
        ),
//        _loadFailWidget(),
        Center(
          child: CircularProgressIndicator(),
        )
      ],
    );
  }

  @override
  void dispose() {
    widget.controller.loadingNotifier.removeListener(_listener);
    super.dispose();
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
