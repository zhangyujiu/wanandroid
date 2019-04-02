import 'package:flutter/material.dart';
import 'package:wanandroid/model/article.dart';
import 'package:wanandroid/net/dio_manager.dart';
import 'package:wanandroid/ui/webview_page.dart';
import 'package:wanandroid/utils/color.dart';
import 'package:wanandroid/utils/common.dart';
import 'package:wanandroid/utils/textsize.dart';

//文章item
class CollectionArticleWidget extends StatefulWidget {
  Article article;

  CollectionArticleWidget(this.article);

  @override
  State<StatefulWidget> createState() {
    return _CollectionArticleWidgetState();
  }
}

class _CollectionArticleWidgetState extends State<CollectionArticleWidget> {
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
      child: Container(
        color: ColorConst.color_white,
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
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text(
                  "${article.title}",
                  style: TextStyle(
                      color: ColorConst.color_333,
                      fontSize: TextSizeConst.middleTextSize),
                ),
              ),
            ),
            Row(
              children: <Widget>[
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
