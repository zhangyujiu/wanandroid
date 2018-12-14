import 'package:flutter/material.dart';

class KnowledgePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _KnowledgePageState();
  }
}
class _KnowledgePageState extends State<KnowledgePage> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('知识体系'),);
  }

  @override
  bool get wantKeepAlive => true;
}