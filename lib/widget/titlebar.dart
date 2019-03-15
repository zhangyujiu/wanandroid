import 'package:flutter/material.dart';
import 'package:wanandroid/widget/marquee_widget.dart';

class TitleBar extends StatefulWidget implements PreferredSizeWidget {
  bool isShowBack = true;
  String title = "";
  Widget leftButton;
  List<Widget> rightButtons;

  TitleBar(
      {this.leftButton, this.isShowBack = true, this.title, this.rightButtons});

  @override
  State<StatefulWidget> createState() {
    return _TitleBarState();
  }

  @override
  Size get preferredSize => Size.fromHeight(56.0);

  static Widget textButton(
    String text, {
    Color color = Colors.white,
    Function() press,
  }) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(right: 5),
        padding: EdgeInsets.all(5),
        child: Text(
          text,
          style: TextStyle(color: color),
        ),
      ),
      onTap: press,
    );
  }

  static Widget iconButton(
      {IconData icon, Color color = Colors.white, Function() press}) {
    return IconButton(
        padding: EdgeInsets.all(2),
        icon: Icon(
          icon,
          color: color,
        ),
        onPressed: press);
  }
}

class _TitleBarState extends State<TitleBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xbf46be39), Color(0xff46be39)])),
      child: Stack(
        children: <Widget>[
          Offstage(
            offstage: !widget.isShowBack,
            child: Container(
              alignment: Alignment.centerLeft,
              child: widget.leftButton == null
                  ? IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  : widget.leftButton,
            ),
          ),
          /* Padding(
              child: Center(
                child: Text(
                  widget.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 45)), */
          Container(
            margin: EdgeInsets.symmetric(horizontal: 45),
            child: Center(
              child: MarqueeWidget(
                text: widget.title,
                height: 56,
                width: MediaQuery.of(context).size.width - 90,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
          Positioned(
            right: 0,
            height: 56,
            child: Container(
                child: widget.rightButtons != null
                    ? Row(
                        children: widget.rightButtons,
                      )
                    : null),
          )
        ],
      ),
    );
  }
}
