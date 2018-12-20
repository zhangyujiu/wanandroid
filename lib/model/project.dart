import 'package:wanandroid/model/tag.dart';

class Project {
  String apkLink;
  String author;
  int chapterId;
  String chapterName;
  bool collect;
  int courseId;
  String desc;
  String envelopePic;
  bool fresh;
  int id;
  String link;
  String niceDate;
  String origin;
  String projectLink;
  int publishTime;
  int superChapterId;
  String superChapterName;
  List<Tag> tags;
  String title;
  int type;
  int userId;
  int visible;
  int zan;

  Project({
    this.apkLink,
    this.author,
    this.chapterId,
    this.chapterName,
    this.collect,
    this.courseId,
    this.desc,
    this.envelopePic,
    this.fresh,
    this.id,
    this.link,
    this.niceDate,
    this.origin,
    this.projectLink,
    this.publishTime,
    this.superChapterId,
    this.superChapterName,
    this.tags,
    this.title,
    this.type,
    this.userId,
    this.visible,
    this.zan,
  });

  static Project fromJson(Map<String, dynamic> json) {
    var project = Project(
      apkLink: json['apkLink'],
      author: json['author'],
      chapterId: json['chapterId'],
      chapterName: json['chapterName'],
      collect: json['collect'],
      courseId: json['courseId'],
      desc: json['desc'],
      envelopePic: json['envelopePic'],
      fresh: json['fresh'],
      id: json['id'],
      link: json['link'],
      niceDate: json['niceDate'],
      origin: json['origin'],
      projectLink: json['projectLink'],
      publishTime: json['publishTime'],
      superChapterId: json['superChapterId'],
      superChapterName: json['superChapterName'],
      title: json['title'],
      type: json['type'],
      userId: json['userId'],
      visible: json['visible'],
      zan: json['zan'],
    );
    project.tags = Tag.parseTags(json['tags']);
    return project;
  }
  static List<Project> parseList(List<dynamic> list){
    List<Project> projects = List();
    for (var p in list) {
      Project project = Project.fromJson(p);
      projects.add(project);
    }
    return projects;
  }

  Map<String, dynamic> toJson() => {
        'apkLink': apkLink,
        'author': author,
        'chapterId': chapterId,
        'chapterName': chapterName,
        'collect': collect,
        'courseId': courseId,
        'desc': desc,
        'envelopePic': envelopePic,
        'fresh': fresh,
        'id': id,
        'link': link,
        'niceDate': niceDate,
        'origin': origin,
        'projectLink': projectLink,
        'publishTime': publishTime,
        'superChapterId': superChapterId,
        'superChapterName': superChapterName,
        'tags': tags,
        'title': title,
        'type': type,
        'userId': userId,
        'visible': visible,
        'zan': zan,
      };
}
