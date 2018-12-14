
import 'package:flutter/material.dart';

class NavigationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NavigationPageState();
  }
}
class _NavigationPageState extends State<NavigationPage> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('导航'),);
  }

  @override
  bool get wantKeepAlive => true;
}