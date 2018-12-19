import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: widget.controller.isLoadingSuccess ? 0 : 1,
      children: <Widget>[
        widget.child,
        Center(
          child: CircularProgressIndicator(),
        )
      ],
    );
  }
}

class PageStateController {
  bool isLoadingSuccess = false;
}
