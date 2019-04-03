import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/widget/flutter_ui.dart' as ui;
import 'package:wanandroid/generated/i18n.dart';
import 'package:wanandroid/net/dio_manager.dart';
import 'package:wanandroid/utils/utils.dart';
import 'package:wanandroid/widget/titlebar.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController accountController;
  TextEditingController pwdController;
  TextEditingController rePwdController;

  @override
  void initState() {
    super.initState();
    accountController = TextEditingController();
    pwdController = TextEditingController();
    rePwdController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final registerButton = SizedBox(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: RaisedButton(
          color: ColorConst.color_primary,
          onPressed: onRegisterClick,
          child: Text(S.of(context).register,
              style: TextStyle(color: Colors.white)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      width: double.infinity,
      height: 80,
    );

    return Scaffold(
      appBar: TitleBar(
        isShowBack: true,
        title: S.of(context).register_account,
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4.0)),
            child: Row(
              children: <Widget>[
                Container(
                  child: Icon(Icons.account_circle),
                  padding: EdgeInsets.only(left: 5),
                  alignment: Alignment.centerLeft,
                ),
                Expanded(
                  flex: 1,
                  child: ui.ClearTextField(
                    controller: accountController,
                    textStyle: TextStyle(color: Colors.black87, fontSize: 14),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: S.of(context).please_input_username,
                        contentPadding: EdgeInsets.all(10),
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14)),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4.0)),
            child: Row(
              children: <Widget>[
                Container(
                  child: Icon(Icons.blur_on),
                  padding: EdgeInsets.only(left: 5),
                  alignment: Alignment.centerLeft,
                ),
                Expanded(
                  flex: 1,
                  child: ui.ClearTextField(
                    controller: pwdController,
                    obscureText: true,
                    textStyle: TextStyle(color: Colors.black87, fontSize: 14),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: S.of(context).please_input_pwd,
                        contentPadding: EdgeInsets.all(10),
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14)),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4.0)),
            child: Row(
              children: <Widget>[
                Container(
                  child: Icon(Icons.blur_on),
                  padding: EdgeInsets.only(left: 5),
                  alignment: Alignment.centerLeft,
                ),
                Expanded(
                  flex: 1,
                  child: ui.ClearTextField(
                    controller: rePwdController,
                    obscureText: true,
                    textStyle: TextStyle(color: Colors.black87, fontSize: 14),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: S.of(context).please_input_pwd_again,
                        contentPadding: EdgeInsets.all(10),
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14)),
                  ),
                )
              ],
            ),
          ),
          registerButton,
        ],
      ),
    );
  }

  void onRegisterClick() {
    var account = accountController.text.toString();
    var pwd = pwdController.text.toString();
    var rePwd = rePwdController.text.toString();
    if (account.isEmpty) {
      CommonUtils.toast(S.of(context).username_can_not_be_empty);
      return;
    }
    if (pwd.isEmpty) {
      CommonUtils.toast(S.of(context).pwd_can_not_be_empty);
      return;
    }
    if (rePwd.isEmpty) {
      CommonUtils.toast(S.of(context).pwd_can_not_be_empty);
      return;
    }
    register(account, pwd, rePwd);
  }

  void register(String account, String pwd, String rePwd) {
    var data = FormData.from({
      "username": account,
      "password": pwd,
      "repassword": rePwd,
    });
    CommonUtils.showLoadingDialog(context);
    DioManager.singleton.post("user/register", data: data).whenComplete(() {
      Navigator.pop(context);
    }).then((result) {
      if (result != null) {
        CommonUtils.toast(S.of(context).register_success);
        Navigator.pop(context, {
          "username": account,
          "password": pwd,
        });
      }
    });
  }
}
