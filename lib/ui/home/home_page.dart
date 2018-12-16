import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wanandroid/model/article.dart';
import 'package:wanandroid/model/banner.dart';
import 'package:wanandroid/model/base_data.dart';
import 'package:wanandroid/model/base_list_data.dart';
import 'package:wanandroid/net/dio_manager.dart';
import 'package:wanandroid/ui/login_page.dart';
import 'package:wanandroid/utils/color.dart';
import 'package:wanandroid/utils/textsize.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  List<BannerItem> banners = List();
  SwiperController _controller = SwiperController();
  int pageIndex = 0;
  List<Article> articles = List();

  @override
  void initState() {
    super.initState();
    _controller.autoplay = true;
    getBanner();
    getList();
  }

  void getBanner() async {
    ResultData resultData = await DioManager.singleton.get("banner/json");
    setState(() {
      banners.clear();
      for (var item in resultData.data) {
        banners.add(BannerItem.fromJson(item));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: articles.length + 1,
        itemBuilder: (context, index) {
          return index == 0
              ? Container(
                  margin: EdgeInsets.only(top: 5),
                  width: MediaQuery.of(context).size.width,
                  height: 180,
                  child: banners.length != 0
                      ? Swiper(
                          controller: _controller,
                          itemWidth: MediaQuery.of(context).size.width,
                          itemHeight: 180,
                          pagination: pagination(),
                          itemBuilder: (BuildContext context, int index) {
                            return new Image.network(
                              banners[index].imagePath,
                              fit: BoxFit.fill,
                            );
                          },
                          itemCount: banners.length,
                          viewportFraction: 0.8,
                          scale: 0.9,
                        )
                      : SizedBox(
                          width: 0,
                          height: 0,
                        ),
                )
              : _builditem(index - 1);
        });
  }

  SwiperPagination pagination() => SwiperPagination(
      margin: EdgeInsets.all(0.0),
      builder: SwiperCustomPagination(
          builder: (BuildContext context, SwiperPluginConfig config) {
        return Container(
          color: Color(0x599E9E9E),
          height: 40,
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Row(
            children: <Widget>[
              Text(
                "${banners[config.activeIndex].title}",
                style: TextStyle(
                    fontSize: TextSizeConst.smallTextSize,
                    color: ColorConst.color_white),
              ),
              Expanded(
                flex: 1,
                child: new Align(
                  alignment: Alignment.centerRight,
                  child: new DotSwiperPaginationBuilder(
                          color: Colors.black12,
                          activeColor: ColorConst.color_primary,
                          size: 6.0,
                          activeSize: 6.0)
                      .build(context, config),
                ),
              )
            ],
          ),
        );
      }));

  Widget _builditem(int index) {
    Article article = articles[index];
    return GestureDetector(
      onTap: (){

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
                  article.zan == 0
                      ? IconButton(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(0),
                    icon: Icon(Icons.favorite_border),
                    onPressed: () => _like(index),
                  )
                      : IconButton(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(0),
                    icon: Icon(Icons.favorite,color: Colors.red,),
                    onPressed: () => _like(index),
                  ),
                  Icon(
                    Icons.access_time,
                    color: ColorConst.color_ccc,
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

  void getList() {
    DioManager.singleton.get("article/list/${pageIndex}/json").then((result) {
      BaseListData listdata = BaseListData.fromJson(result.data);
      if (pageIndex == 0) {
        articles.clear();
      }
      setState(() {
        for (var a in listdata.datas) {
          Article article = Article.fromJson(a);
          articles.add(article);
        }
      });
    });
  }

  @override
  bool get wantKeepAlive => true;

  //TODO:没有对接口,需要判断是否登录
  _like(int index) {
    Article article = articles[index];
    DioManager.singleton.post("lg/collect/${article.id}/json").then((result){
      if(result!=null){
        setState(() {
          article.zan = article.zan == 1 ? 0 : 1;
        });
      }
    });
  }
}
