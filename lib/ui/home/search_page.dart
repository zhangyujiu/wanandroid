import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wanandroid/model/hotword.dart';
import 'package:wanandroid/net/dio_manager.dart';
import 'package:wanandroid/ui/home/search_result_page.dart';
import 'package:wanandroid/utils/color.dart';
import 'package:wanandroid/utils/common.dart';
import 'package:wanandroid/utils/textsize.dart';
import 'package:wanandroid/widget/icon_text_widget.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _controller;
  List<HotWord> hotwords = List();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    getHotWord();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _title(context),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      "搜索热词",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: ColorConst.color_333),
                    ),
                  ),
                  hotwords.length > 0
                      ? Wrap(
                          spacing: 5,
                          runSpacing: 5,
                          children: _buildWrapItem(),
                        )
                      : SizedBox(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Padding _title(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Container(
        color: ColorConst.color_white,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5.0)),
                child: IconTextWidget(
                  icon: Icon(
                    Icons.search,
                    size: 20,
                    color: ColorConst.color_999,
                  ),
                  text: TextField(
                      controller: _controller,
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      obscureText: false,
                      style: TextStyle(fontSize: TextSizeConst.smallTextSize),
                      decoration: InputDecoration(
                          hintText: '请输入关键词',
                          contentPadding: EdgeInsets.all(4.0),
                          border: InputBorder.none)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: SizedBox(
                width: 60,
                height: 30,
                child: RaisedButton(
                  elevation: 0,
                  highlightElevation: 0,
                  color: ColorConst.color_primary,
                  child: Text(
                    "搜索",
                    style: TextStyle(color: ColorConst.color_white),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  onPressed: () {
                    var key = _controller.text.toString();
                    if (key.isEmpty) {
                      Fluttertoast.showToast(msg: "关键字不能为空");
                      return;
                    }
                    CommonUtils.push(context, SearchResultPage(key));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getHotWord() {
    DioManager.singleton.get("hotkey/json").then((result) {
      if (result != null) {
        List<HotWord> datas = HotWord.parseList(result.data);
        setState(() {
          hotwords.clear();
          hotwords.addAll(datas);
        });
      }
    });
  }

  _buildWrapItem() {
    List<Widget> items = List();
    for (var hotWord in hotwords) {
      Widget item = InkWell(
        onTap: () {
          CommonUtils.push(context, SearchResultPage(hotWord.name));
        },
        child: Container(
          constraints: BoxConstraints(minHeight: 30),
          padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: ColorConst.color_ccc.withAlpha(100),
          ),
          child: Text(
            hotWord.name,
            style: TextStyle(
                color: Colors.deepOrangeAccent,
                fontSize: TextSizeConst.smallTextSize),
          ),
        ),
      );
      items.add(item);
    }
    return items;
  }
}
