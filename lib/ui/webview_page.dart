import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:wanandroid/generated/i18n.dart';
import 'package:wanandroid/utils/utils.dart';
import 'package:wanandroid/widget/titlebar.dart';

class WebViewPage extends StatefulWidget {
  String url = "";
  String title = "";
  bool fullscreen = false;

  WebViewPage({this.fullscreen = false, this.title, this.url});

  @override
  State<StatefulWidget> createState() {
    return _WebViewPageState();
  }
}

class _WebViewPageState extends State<WebViewPage> {
  FlutterWebviewPlugin flutterWebViewPlugin = new FlutterWebviewPlugin();
  StreamSubscription<WebViewStateChanged> _onStateChanged;

  @override
  void initState() {
    super.initState();
    //flutterWebViewPlugin.close();
    _onStateChanged =
        flutterWebViewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      switch (state.type) {
        case WebViewState.shouldStart:
          // 准备加载
          print("准备加载");
          break;
        case WebViewState.startLoad:
          // 开始加载
          print("开始加载");
          break;
        case WebViewState.finishLoad:
          // 加载完成
          print("加载完成");
          break;
        case WebViewState.abortLoad:
          print("终止加载");
          break;
      }
    });
    //flutter_webview_plugin在0.3.0+2之前存在bug，当在网页中点击超链接后返回会一直停留在加载中的页面，在0.3.0+2后修改了此bug
    //flutter_webview_plugin在版本升级后若不删除下面代码，关闭页面会黑屏
    /*flutterWebViewPlugin.onDestroy.listen((_) {
      Navigator.of(context).pop();
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.fullscreen
          ? null
          : TitleBar(
              isShowBack: true,
              title: widget.title,
              rightButtons: <Widget>[
                TitleBar.textButton(S.of(context).copy,press: (){
                  ClipboardUtil.saveData2Clipboard(widget.url);
                  CommonUtils.toast(S.of(context).copy_success);
                })
              ],
            ),
      body: WebviewScaffold(
        url: widget.url,
        withZoom: false,
        withLocalStorage: true,
        hidden: true,
        withJavascript: true,
      ),
    );
  }

  @override
  void dispose() {
    _onStateChanged.cancel();
    flutterWebViewPlugin.close();
    super.dispose();
  }
}
