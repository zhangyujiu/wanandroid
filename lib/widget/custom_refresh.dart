import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

///自定义刷新控件头部尾部
class CustomRefresh extends StatelessWidget {
  Widget child;
  GlobalKey<EasyRefreshState> easyRefreshKey;
  GlobalKey<RefreshHeaderState> headerKey;
  GlobalKey<RefreshFooterState> footerKey;

  Function onRefresh;
  Function loadMore;

  CustomRefresh(
      {@required this.child,
      this.onRefresh,
      this.loadMore,
      @required this.easyRefreshKey,
      @required this.headerKey,
      @required this.footerKey});

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      key: easyRefreshKey,
      autoLoad: false,
      onRefresh: onRefresh,
      loadMore: loadMore,
      behavior: ScrollOverBehavior(),
      refreshHeader: ClassicsHeader(
        key: headerKey,
        refreshText: "下拉刷新",
        refreshReadyText: "释放刷新",
        refreshingText: "刷新中...",
        refreshedText: "刷新完成",
        moreInfo: "更新时间 %T",
        bgColor: Colors.transparent,
        textColor: Colors.black87,
        moreInfoColor: Colors.black54,
        isFloat: false,
        showMore: true,
      ),
      refreshFooter: ClassicsFooter(
        key: footerKey,
        loadText: "上拉刷新",
        loadReadyText: "释放刷新",
        loadingText: "刷新中...",
        loadedText: "刷新完成",
        noMoreText: "刷新完成",
        moreInfo: "更新时间 %T",
        bgColor: Colors.transparent,
        textColor: Colors.black87,
        moreInfoColor: Colors.black54,
        isFloat: false,
        showMore: true,
      ),
      child: child,
    );
  }
}
