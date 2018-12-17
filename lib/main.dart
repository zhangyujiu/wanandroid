import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:wanandroid/flash.dart';
import 'package:wanandroid/main_page.dart';
import 'package:wanandroid/redux/main_redux.dart';
import 'package:wanandroid/utils/color.dart';
import 'package:flutter_redux/flutter_redux.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final store = Store<MainRedux>(appReducer, initialState: MainRedux(user: null));
  @override
  Widget build(BuildContext context) {
    return StoreProvider<MainRedux>(
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Color(ColorConst.primaryColor),
        ),
        initialRoute: "/",
        routes: {
          "/": (context) => FlashPage(),
          "main": (context) => MainPage(),
        },
      ),
    );
  }
}


