import 'package:flutter/material.dart';

class FlashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FlashPageState();
  }
}

class _FlashPageState extends State<FlashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4)).whenComplete(() {
      Navigator.pushReplacementNamed(context, 'main');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Image.network(
      'http://b.hiphotos.baidu.com/image/pic/item/0ff41bd5ad6eddc4802878ba34dbb6fd536633a0.jpg',
      fit: BoxFit.fitHeight,
    );
  }
}
