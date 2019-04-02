import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wanandroid/generated/i18n.dart';
import 'package:wanandroid/model/base_data.dart';
import 'package:wanandroid/model/project_sort.dart';
import 'package:wanandroid/net/dio_manager.dart';
import 'package:wanandroid/ui/project/project_list_page.dart';
import 'package:wanandroid/utils/utils.dart';
import 'package:wanandroid/widget/async_snapshot_widget.dart';
import 'package:wanandroid/widget/load_fail_widget.dart';

class ProjectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProjectPageState();
  }
}

class _ProjectPageState extends State<ProjectPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  TabController _controller;
  List<ProjectSort> sorts = List();
  Future getSort;

  @override
  void initState() {
    super.initState();
    getSort = getSorts();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(builder: _buildFuture, future: getSort);
  }

  Widget _buildFuture(BuildContext context, AsyncSnapshot snapshot) {
    return AsyncSnapshotWidget(
        snapshot: snapshot,
        successWidget: (snapshot) {
          ResultData result = snapshot.data;

          if (result != null) {
            List<ProjectSort> list = ProjectSort.parseList(result.data);
            sorts.clear();
            sorts.addAll(list);
            if (_controller == null) {
              _controller = TabController(
                  length: sorts.length, vsync: this, initialIndex: 0);
            }
            return Column(
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
            );
          } else {
            return LoadFailWidget(onTap: (){
              print(S.of(context).reload);
              setState(() {});
            },);
          }
        });
  }

  List<Widget> _parseTabs() {
    List<Widget> widgets = List();
    for (ProjectSort item in sorts) {
      var tab = Tab(
        text: item.name,
      );
      widgets.add(tab);
    }
    return widgets;
  }

//  final AsyncMemoizer _memoizer = AsyncMemoizer();

  //获取分类
  Future getSorts() async {
    /*return _memoizer.runOnce(() {
      return DioManager.singleton.get("project/tree/json");
    });*/
    return DioManager.singleton.get("project/tree/json");
  }

  @override
  bool get wantKeepAlive => true;

  _parsePages() {
    List<ProjectListPage> pages = List();
    for (ProjectSort item in sorts) {
      var page = ProjectListPage(cid: item.id);
      pages.add(page);
    }
    return pages;
  }
}
