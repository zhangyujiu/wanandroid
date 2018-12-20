class ProjectSort {
  List<dynamic> children;
  int courseId;
  int id;
  String name;
  int order;
  int parentChapterId;
  bool userControlSetTop;
  int visible;

  ProjectSort({
    this.children,
    this.courseId,
    this.id,
    this.name,
    this.order,
    this.parentChapterId,
    this.userControlSetTop,
    this.visible,
  });

  static ProjectSort fromJson(Map<String, dynamic> json) {
    return ProjectSort(
      children: json['children'],
      courseId: json['courseId'],
      id: json['id'],
      name: json['name'],
      order: json['order'],
      parentChapterId: json['parentChapterId'],
      userControlSetTop: json['userControlSetTop'],
      visible: json['visible'],
    );
  }

  static parseList(List<dynamic> list) {
    List<ProjectSort> sorts = List();
    for (var s in list) {
      ProjectSort sort = ProjectSort.fromJson(s);
      sorts.add(sort);
    }
    return sorts;
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
