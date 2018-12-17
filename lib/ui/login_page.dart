import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wanandroid/net/dio_manager.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPage();
  }
}

class _LoginPage extends State<LoginPage> with TickerProviderStateMixin {
  bool isLogin = false;

  var _userController = TextEditingController();
  var _pwdController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  onLoginClick() async {
    if (_userController.text.toString().isEmpty) {
      Fluttertoast.showToast(msg: "用户名不能为空", toastLength: Toast.LENGTH_SHORT);
      return;
    }
    if (_pwdController.text.toString().isEmpty) {
      Fluttertoast.showToast(msg: "密码不能为空", toastLength: Toast.LENGTH_SHORT);
      return;
    }
    login();
  }

  loading(bool isLoading) {
    setState(() {
      isLogin = isLoading;
    });
  }

  login() async {
    loading(true);
    DioManager.singleton
        .post("user/login",
            data: FormData.from({
              "username": _userController.text.toString(),
              "password": _pwdController.text.toString(),
            }))
        .whenComplete(() {
      loading(false);
    }).then((result) {
      Fluttertoast.showToast(msg: "登录成功");
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    var loginButtonWidegt;
    if (isLogin) {
      AnimationController animationController = new AnimationController(
          vsync: this, duration: Duration(milliseconds: 2000));
      Animation<Color> animation =
          new Tween(begin: Colors.white, end: Colors.black)
              .animate(animationController);
      loginButtonWidegt = CircularProgressIndicator(
        backgroundColor: Colors.white,
        valueColor: animation,
      );
    } else {
      loginButtonWidegt = Text('登录', style: TextStyle(color: Colors.white));
    }
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: FlutterLogo(
          size: 80,
        ),
      ),
    );

    final userName = Container(
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(50.0)),
      child: TextField(
          keyboardType: TextInputType.text,
          controller: _userController,
          autofocus: false,
          obscureText: false,
          decoration: InputDecoration(
              hintText: '请输入用户名',
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              border: InputBorder.none)),
    );

    final password = Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(50.0)),
      child: TextField(
          controller: _pwdController,
          autofocus: false,
          obscureText: true,
          decoration: InputDecoration(
              hintText: '请输入密码',
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              border: InputBorder.none)),
    );

    final loginButton = SizedBox(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: RaisedButton(
          color: Colors.lightBlueAccent,
          onPressed: onLoginClick,
          child: loginButtonWidegt,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
      width: double.infinity,
      height: 80,
    );

    final forgotLabel = FlatButton(
      child: Text(
        '忘记密码?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {},
    );

    //TODO：使用GlobalKey键盘失效
    var globalKey = GlobalKey();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                logo,
                SizedBox(height: 48.0),
                userName,
                SizedBox(height: 8.0),
                password,
                SizedBox(height: 24.0),
                loginButton,
                forgotLabel,
              ],
            ),
          ),
          margin: EdgeInsets.fromLTRB(20, 100, 20, 0),
        ),
      ),
    );
  }
}
