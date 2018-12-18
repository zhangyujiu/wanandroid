import 'package:flutter/material.dart';
import 'package:wanandroid/model/article.dart';
import 'package:wanandroid/net/dio_manager.dart';
import 'package:wanandroid/ui/webview_page.dart';
import 'package:wanandroid/utils/color.dart';
import 'package:wanandroid/utils/common.dart';
import 'package:wanandroid/utils/textsize.dart';

//文章item
class ArticleWidget extends StatefulWidget {
  Article article;

  ArticleWidget(this.article);

  @override
  State<StatefulWidget> createState() {
    return _ArticleWidgetState();
  }
}

class _ArticleWidgetState extends State<ArticleWidget> {
  Article article;

  @override
  Widget build(BuildContext context) {
    article = widget.article;
    return GestureDetector(
      onTap: () {
        CommonUtils.push(
            context,
            WebViewPage(
              title: article.title,
              url: article.link,
            ));
      },
      child: Card(
        margin: EdgeInsets.all(5),
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.android,
                    color: ColorConst.color_primary,
                  ),
                  Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "${article.author}",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              color: ColorConst.color_333,
                              fontSize: TextSizeConst.smallTextSize),
                        ),
                      )),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "${article.chapterName}/${article.superChapterName}",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          color: ColorConst.color_primary,
                          fontSize: TextSizeConst.smallTextSize),
                    ),
                  )
                ],
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text(
                    "${article.title}",
                    style: TextStyle(
                        color: ColorConst.color_333,
                        fontSize: TextSizeConst.middleTextWhiteSize),
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  !article.collect
                      ? IconButton(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.all(0),
                          icon: Icon(
                            Icons.favorite_border,
                            color: Colors.black45,
                          ),
                          onPressed: () => _collect(),
                        )
                      : IconButton(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.all(0),
                          icon: Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                          onPressed: () => _collect(),
                        ),
                  Icon(
                    Icons.access_time,
                    color: Colors.black45,
                  ),
                  Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          "${article.niceDate}",
                          style: TextStyle(
                              color: ColorConst.color_555,
                              fontSize: TextSizeConst.smallTextSize),
                        ),
                      )),
                  Offstage(
                    offstage: !article.fresh,
                    child: Icon(
                      Icons.fiber_new,
                      color: ColorConst.color_primary,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  //收藏/取消收藏
  _collect() {
    String url = "";
    if (!article.collect) {
      url = "lg/collect/${article.id}/json";
    } else {
      url = "lg/uncollect_originId/${article.id}/json";
    }
    CommonUtils.showLoadingDialog(context);
    DioManager.singleton.post(url).whenComplete(() {
      Navigator.pop(context);
    }).then((result) {
      if (result != null) {
        setState(() {
          article.collect = !article.collect;
        });
      }
    });
  }
}
