import 'package:flutter/material.dart';
import 'package:wanandroid/model/category.dart';
import 'package:wanandroid/net/dio_manager.dart';
import 'package:wanandroid/utils/color.dart';
import 'package:wanandroid/utils/textsize.dart';

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

  @override
  void initState() {
    super.initState();
    _getList();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
            flex: 1,
            child: ListView.builder(
                itemCount: datas.length,
                itemBuilder: (context, index) {
                  return _bulidItem(index);
                })),
        Expanded(
          flex: 3,
          child: Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: Text(
                      datas.length > 0 ? datas[_selectPos].name : "",
                      style: TextStyle(
                          fontSize: TextSizeConst.middleTextSize,
                          color: ColorConst.color_333),
                    ),
                  ),
                  datas.length > 0
                      ? Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: _buildSortItem(datas[_selectPos]),
                  )
                      : Container()
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;

  Widget _bulidItem(int index) {
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
      Widget item = Container(
        decoration: BoxDecoration(
            color: ColorConst.color_ccc.withAlpha(100),
            borderRadius: BorderRadius.circular(20.0)),
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Text(
          nav.title,
          style: TextStyle(color: Colors.deepOrangeAccent),
        ),
      );
      widgets.add(item);
    }
    return widgets;
  }

  void _getList() {
    DioManager.singleton.get("navi/json").then((result) {
      if (result != null) {
        setState(() {
          datas.clear();
          List<Category> list = Category.parseList(result.data);
          datas.addAll(list);
        });
      }
    });
  }
}
