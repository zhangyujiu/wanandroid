import 'package:flutter/material.dart';
import 'package:wanandroid/widget/titlebar.dart';

class TodoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TodoPageState();
  }
}

class _TodoPageState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar(
        isShowBack: true,
        title: "TODO",
      ),
      body: Center(
        child: Text('Hello flutter !'),
      ),
    );
  }
}
