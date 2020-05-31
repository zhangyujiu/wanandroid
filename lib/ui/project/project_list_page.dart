import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:wanandroid/model/base_list_data.dart';
import 'package:wanandroid/model/project.dart';
import 'package:wanandroid/net/dio_manager.dart';
import 'package:wanandroid/ui/webview_page.dart';
import 'package:wanandroid/utils/utils.dart';
import 'package:wanandroid/widget/custom_refresh.dart';
import 'package:wanandroid/widget/page_widget.dart';

class ProjectListPage extends StatefulWidget {
  int cid = 0;

  ProjectListPage({@required this.cid});

  @override
  State<StatefulWidget> createState() {
    return _ProjectListPageState();
  }
}

class _ProjectListPageState extends State<ProjectListPage> with AutomaticKeepAliveClientMixin{
  int pageIndex = 1;
  PageStateController _pageStateController;
  List<Project> projects = List();
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
      pageIndex = 1;
      getList(true);
    } else {
      pageIndex++;
      getList(false);
    }
  }

  void getList(bool isRefresh) {
    DioManager.singleton
        .get("project/list/${pageIndex}/json?cid=${widget.cid}")
        .then((result) {
      _easyRefreshKey.currentState.callRefreshFinish();
      _easyRefreshKey.currentState.callLoadMoreFinish();
      if (result != null) {
        _pageStateController.changeState(PageState.LoadSuccess);
        var baseListData = BaseListData.fromJson(result.data);
        if (pageIndex == 1) {
          projects.clear();
        }
        setState(() {
          projects.addAll(Project.parseList(baseListData.datas));
        });
        if (projects.length == 0) {
          _pageStateController.changeState(PageState.NoData);
        }
      } else {
        _pageStateController.changeState(PageState.LoadFail);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PageWidget(
      reload: () {
        getList(true);
      },
      controller: _pageStateController,
      child: CustomRefresh(
          easyRefreshKey: _easyRefreshKey,
          onRefresh: () {
            _onRefresh(true);
          },
          loadMore: () {
            _onRefresh(false);
          },
          child: ListView.builder(
              itemCount: projects.length,
              itemBuilder: (context, index) {
                return _buildItem(projects[index]);
              })),
    );
  }

  Widget _buildItem(Project project) {
    return GestureDetector(
      onTap: (){
        CommonUtils.push(
            context,
            WebViewPage(
              title: project.title,
              url: project.link,
            ));
      },
      child: Card(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              CachedNetworkImage(
                fit: BoxFit.fill,
                width: 100,
                height: 200,
                imageUrl: project.envelopePic,
                placeholder: (context,url)=>ImageIcon(AssetImage("assets/logo.png"),size: 100,),
                errorWidget: (context,url,error)=>Icon(Icons.info_outline),
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.only(left: 10),
                    height: 200,
                    alignment: Alignment.topLeft,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.android,
                              size: 18,
                              color: ColorConst.color_primary,
                            ),
                            Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "${project.title}",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: ColorConst.color_333,
                                        fontSize: TextSizeConst.middleTextSize),
                                  ),
                                )),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Text(
                                  project.author,
                                  maxLines: 1,
                                  style: TextStyle(color: ColorConst.color_555),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                project.niceDate,
                                style: TextStyle(color: ColorConst.color_555,fontSize: TextSizeConst.minTextSize),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              project.desc,
                              maxLines: 6,
                              style: TextStyle(color: ColorConst.color_555),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
