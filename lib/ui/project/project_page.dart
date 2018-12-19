import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wanandroid/utils/color.dart';

class ProjectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProjectPageState();
  }
}

class _ProjectPageState extends State<ProjectPage> with AutomaticKeepAliveClientMixin,SingleTickerProviderStateMixin{
  TabController _controller;
  @override
  void initState() {
    super.initState();
//    _controller = TabController(
//        length: widget.knowledge.children.length, vsync: this, initialIndex: 0);
  }


  @override
  Widget build(BuildContext context) {
    return Text("")/*Column(
      children: <Widget>[
        TabBar(
          indicatorColor: ColorConst.color_primary,
          controller: _controller,
          isScrollable: true,
          tabs: _parseTabs(),
        ),
        Expanded(
          flex: 1,
          child: TabBarView(
            controller: _controller,
            children: _parsePages(),
          ),
        )
      ],
    )*/;
  }

  @override
  bool get wantKeepAlive => true;
}
