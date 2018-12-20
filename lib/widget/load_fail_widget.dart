import 'package:flutter/material.dart';
import 'package:wanandroid/utils/textsize.dart';

//加载失败widget
class LoadFailWidget extends StatelessWidget {
  Function onTap;

  LoadFailWidget({this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTap();
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ImageIcon(
              AssetImage("assets/load_fail.png"),
              size: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "加载失败",
                style: TextStyle(fontSize: TextSizeConst.middleTextSize),
              ),
            )
          ],
        ),
      ),
    );
  }
}
