class KnowledgeSystem {
  var children;
  int courseId;
  int id;
  String name;
  int order;
  int parentChapterId;
  bool userControlSetTop;
  int visible;

  KnowledgeSystem({
    this.children,
    this.courseId,
    this.id,
    this.name,
    this.order,
    this.parentChapterId,
    this.userControlSetTop,
    this.visible,
  });

  static List<KnowledgeSystem> parseList(List<dynamic> list) {
    List<KnowledgeSystem> systems = List();
    for (var s in list) {
      KnowledgeSystem system = KnowledgeSystem.fromJson(s);
      systems.add(system);
    }
    return systems;
  }

  static KnowledgeSystem fromJson(Map<String, dynamic> json) {
    return KnowledgeSystem(
      //注意递归结束条件
      children: json['children'] == null ? null : parseList(json['children']),
      courseId: json['courseId'],
      id: json['id'],
      name: json['name'],
      order: json['order'],
      parentChapterId: json['parentChapterId'],
      userControlSetTop: json['userControlSetTop'],
      visible: json['visible'],
    );
  }

  Map<String, dynamic> toJson() => {
        'children': children,
        'courseId': courseId,
        'id': id,
        'name': name,
        'order': order,
        'parentChapterId': parentChapterId,
        'userControlSetTop': userControlSetTop,
        'visible': visible,
      };
}
