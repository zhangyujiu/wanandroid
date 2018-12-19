import 'package:flutter/material.dart';
import 'package:wanandroid/model/category.dart';
import 'package:wanandroid/net/dio_manager.dart';
import 'package:wanandroid/ui/webview_page.dart';
import 'package:wanandroid/utils/color.dart';
import 'package:wanandroid/utils/common.dart';
import 'package:wanandroid/utils/textsize.dart';
import 'package:wanandroid/widget/page_widget.dart';

class NavigationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NavigationPageState();
  }
}

class _NavigationPageState extends State<NavigationPage>
    with AutomaticKeepAliveClientMixin {
  int _selectPos = 0;
  List<Category> datas = List();
  PageStateController _pageStateController;

  @override
  void initState() {
    super.initState();
    _pageStateController = PageStateController();
    _getList();
  }

  @override
  Widget build(BuildContext context) {
    return PageWidget(
      controller: _pageStateController,
      child: Row(
        children: <Widget>[
          Expanded(
              //左边分类数据
              flex: 1,
              child: ListView.builder(
                  itemCount: datas.length,
                  itemBuilder: (context, index) {
                    return _buildItem(index);
                  })),
          Expanded(
            //右边导航数据
            flex: 3,
            child: SingleChildScrollView(
              child: Container(
//                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.all(10.0),
                alignment: Alignment.topLeft,
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 15),
                        child: Text(
                          datas.length > 0 ? datas[_selectPos].name : "",
                          style: TextStyle(
                              fontSize: TextSizeConst.middleTextSize,
                              color: ColorConst.color_333),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: datas.length > 0
                          ? Wrap(
                              spacing: 8,
                              runSpacing: 2,
                              children: _buildSortItem(datas[_selectPos]),
                            )
                          : Container(),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  Widget _buildItem(int index) {
    Category category = datas[index];
    return InkWell(
      onTap: () {
        setState(() {
          _selectPos = index;
        });
      },
      child: Container(
        alignment: Alignment.center,
        color: _selectPos == index
            ? ColorConst.color_white
            : ColorConst.color_ccc.withAlpha(100),
        padding: EdgeInsets.all(10),
        child: Text(
          category.name,
          style: TextStyle(
              color: _selectPos == index
                  ? ColorConst.color_primary
                  : ColorConst.color_777),
        ),
      ),
    );
  }

  List<Widget> _buildSortItem(Category category) {
    List<Widget> widgets = List();

    for (Navigation nav in category.articles) {
      Widget item = RaisedButton(
        color: ColorConst.color_ccc.withAlpha(100),
        elevation: 0.0,
        highlightElevation: 0.0,
        onPressed: () {
          CommonUtils.push(
              context,
              WebViewPage(
                title: nav.title,
                url: nav.link,
              ));
        },
        child: Text(
          nav.title,
          style: TextStyle(color: Colors.deepOrangeAccent),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      );
      widgets.add(item);
    }
    return widgets;
  }

  //获取导航数据
  void _getList() {
    DioManager.singleton.get("navi/json").then((result) {
      if (result != null) {
        _pageStateController.changeState(PageState.LoadSuccess);
        setState(() {
          datas.clear();
          List<Category> list = Category.parseList(result.data);
          datas.addAll(list);
        });
      }else{
        _pageStateController.changeState(PageState.LoadFail);
      }
    });
  }
}
