class Article {
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

  Article({
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

  static Article fromJson(Map<String, dynamic> json) {
    var article = Article(
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
    article.tags = _parseTags(json['tags']);
    return article;
  }

  static List<Tag> _parseTags(List<dynamic> ts) {
    List<Tag> tags = List();
    for (var t in ts) {
      Tag tag = Tag(name: t["name"], url: t["url"]);
      tags.add(tag);
    }
    return tags;
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

class Tag {
  String name;
  String url;

  Tag({
    this.name,
    this.url,
  });

  static Tag fromJson(Map<String, dynamic> json) {
    return Tag(
      name: json['name'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'url': url,
      };
}
