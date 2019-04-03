import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_ui/widget/flutter_ui.dart';
import 'package:wanandroid/generated/i18n.dart';
import 'package:wanandroid/model/article.dart';
import 'package:wanandroid/model/base_list_data.dart';
import 'package:wanandroid/net/dio_manager.dart';
import 'package:wanandroid/utils/utils.dart';
import 'package:wanandroid/widget/collection_article_widget.dart';
import 'package:wanandroid/widget/custom_refresh.dart';
import 'package:wanandroid/widget/page_widget.dart';
import 'package:wanandroid/widget/titlebar.dart';

class CollectionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CollectionPageState();
  }
}

class _CollectionPageState extends State<CollectionPage> {
  PageStateController _pageStateController;
  List<Article> articles = List();
  int pageIndex = 0;
  List<SlideButton> list = [];

  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();

  @override
  void initState() {
    super.initState();
    _pageStateController = PageStateController();
    getList(true);
  }

  void _onRefresh(bool up) {
    if (up) {
      pageIndex = 0;
      getList(true);
    } else {
      pageIndex++;
      getList(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar(
        isShowBack: true,
        title: S.of(context).my_collection,
      ),
      body: PageWidget(
        controller: _pageStateController,
        reload: () {
          getList(true);
        },
        child: CustomRefresh(
            easyRefreshKey: _easyRefreshKey,
            onRefresh: () {
              _onRefresh(true);
            },
            loadMore: () {
              _onRefresh(false);
            },
            child: ListView.builder(
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.all(5),
                    child: list[index],
                  );
                })),
      ),
    );
  }

  getCollectWidgets() {
    list.clear();
    for (var i = 0; i < articles.length; i++) {
      var article = articles[i];
      var key = GlobalKey<SlideButtonState>();
      var slide = SlideButton(
        key: key,
        singleButtonWidth: 85,
        onSlideStarted: () {
          list.forEach((slide) {
            if (slide.key != key) {
              slide.key.currentState?.close();
            }
          });
        },
        child: CollectionArticleWidget(article),
        buttons: <Widget>[
          buildAction(key, "取消收藏", Colors.red, () {
            key.currentState.close();
            _collect(article);
          }),
        ],
      );
      list.add(slide);
    }
  }

  ///取消收藏
  _collect(Article article) {
    CommonUtils.showLoadingDialog(context);
    DioManager.singleton
        .post("lg/uncollect/${article.id}/json",
            data: FormData.from({
              "originId": article.originId,
            }))
        .whenComplete(() {
      Navigator.pop(context);
    }).then((result) {
      if (result != null) {
        setState(() {
          articles.remove(article);
          getCollectWidgets();
        });
      }
    });
  }

  InkWell buildAction(GlobalKey<SlideButtonState> key, String text, Color color,
      GestureTapCallback tap) {
    return InkWell(
      onTap: tap,
      child: Container(
        alignment: Alignment.center,
        width: 85,
        color: color,
        child: Text(text,
            style: TextStyle(
              color: Colors.white,
            )),
      ),
    );
  }

  void getList(bool isRefresh) {
    DioManager.singleton
        .get("lg/collect/list/${pageIndex}/json")
        .then((result) {
      _easyRefreshKey.currentState.callRefreshFinish();
      _easyRefreshKey.currentState.callLoadMoreFinish();
      if (result != null) {
        _pageStateController.changeState(PageState.LoadSuccess);
        var listdata = BaseListData.fromJson(result.data);
        if (pageIndex == 0) {
          articles.clear();
        }
        setState(() {
          articles.addAll(Article.parseList(listdata.datas));
          getCollectWidgets();
        });
        if (articles.length == 0) {
          _pageStateController.changeState(PageState.NoData);
        }
      } else {
        _pageStateController.changeState(PageState.LoadFail);
      }
    });
  }
}
