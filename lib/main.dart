import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:redux/redux.dart';
import 'package:wanandroid/flash_page.dart';
import 'package:wanandroid/generated/i18n.dart';
import 'package:wanandroid/main_page.dart';
import 'package:wanandroid/redux/main_redux.dart';
import 'package:wanandroid/utils/utils.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MyApp());
  if (Platform.isAndroid) {
  // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  final store =
      Store<MainRedux>(appReducer, initialState: MainRedux(user: null));

  @override
  Widget build(BuildContext context) {
    return StoreProvider<MainRedux>(
      store: store,
      child: MaterialApp(
        title: "玩Android",
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Color(ColorConst.primaryColor),
        ),
        localizationsDelegates: [
          S.delegate,
          // You need to add them if you are using the material library.
          // The material components usses this delegates to provide default
          // localization
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
//        localeListResolutionCallback:
//        S.delegate.listResolution(fallback: const Locale('zh', 'CN')),
        initialRoute: "/",
        routes: {
          "/": (context) => FlashPage(),
          "main": (context) => MainPage(),
        },
      ),
    );
  }
}
