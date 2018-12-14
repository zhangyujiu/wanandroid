import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wanandroid/model/banner.dart';
import 'package:wanandroid/model/base_data.dart';
import 'package:wanandroid/net/dio_manager.dart';

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
    _controller.autoplay=true;
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
        itemCount: 10,
        itemBuilder: (context, index) {
          return index == 0
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: 180,
                  child: banners.length != 0
                      ? Swiper(
                          controller: _controller,
                          itemWidth: MediaQuery.of(context).size.width,
                          itemHeight: 180,
                          plugins: [
                            SwiperPagination(builder:SwiperPagination.dots )
                          ],
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

  @override
  bool get wantKeepAlive => true;
}
