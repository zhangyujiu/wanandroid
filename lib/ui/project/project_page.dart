import 'package:flutter/material.dart';

class ProjectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProjectPageState();
  }
}

class _ProjectPageState extends State<ProjectPage> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('项目'),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
