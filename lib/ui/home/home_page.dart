import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wanandroid/model/banner.dart';
import 'package:wanandroid/model/base_data.dart';
import 'package:wanandroid/net/dio_manager.dart';
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

  @override
  void initState() {
    super.initState();
    _controller.autoplay = true;
    getBanner();
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
        itemCount: 60,
        itemBuilder: (context, index) {
          return index == 0
              ? Container(
            margin: EdgeInsets.only(top: 5),
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: 180,
            child: banners.length != 0
                ? Swiper(
              controller: _controller,
              itemWidth: MediaQuery
                  .of(context)
                  .size
                  .width,
              itemHeight: 180,
              pagination: pagination(),
              itemBuilder: (BuildContext context, int index) {
                print(banners);
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
              : Text("item");
        });
  }

  SwiperPagination pagination() =>
      SwiperPagination(
          margin: EdgeInsets.all(0.0),
          builder: SwiperCustomPagination(builder:
              (BuildContext context,
              SwiperPluginConfig config) {
            return Container(
              color: Color(0x599E9E9E),
              height: 40,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(
                children: <Widget>[
                  Text(
                    "${banners[config.activeIndex].title}",
                    style: TextStyle(
                        fontSize: TextSizeConst.smallTextSize, color: ColorConst.color_white),
                  ),
                  Expanded(
                    flex: 1,
                    child: new Align(
                      alignment: Alignment.centerRight,
                      child: new DotSwiperPaginationBuilder(
                          color: Colors.black12,
                          activeColor: Color(
                              ColorConst.primaryColor),
                          size: 6.0,
                          activeSize: 6.0)
                          .build(context, config),
                    ),
                  )
                ],
              ),
            );
          }));
  @override
  bool get wantKeepAlive => true;
}


