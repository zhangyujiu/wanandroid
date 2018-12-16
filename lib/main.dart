import 'package:flutter/material.dart';
import 'package:wanandroid/flash.dart';
import 'package:wanandroid/ui/login_page.dart';
import 'package:wanandroid/ui/start_page.dart';
import 'package:wanandroid/utils/color.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color(ColorConst.primaryColor),
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => FlashPage(),
        "main": (context) => StartPage(),
      },
    );
  }
}


