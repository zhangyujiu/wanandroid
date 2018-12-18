class Category {
  List<Navigation> articles;
  int cid;
  String name;

  Category({
    this.articles,
    this.cid,
    this.name,
  });

  static Category fromJson(Map<String, dynamic> json) {
    return Category(
      articles: Navigation.parseList(json['articles']),
      cid: json['cid'],
      name: json['name'],
    );
  }

  static List<Category> parseList(List<dynamic> list) {
    List<Category> categorys = List();
    for (var s in list) {
      Category category = Category.fromJson(s);
      categorys.add(category);
    }
    return categorys;
  }

  Map<String, dynamic> toJson() => {
        'articles': articles,
        'cid': cid,
        'name': name,
      };
}

class Navigation {
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
  List<dynamic> tags;
  String title;
  int type;
  int userId;
  int visible;
  int zan;

  Navigation({
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

  static List<Navigation> parseList(List<dynamic> list) {
    List<Navigation> navigations = List();
    for (var s in list) {
      Navigation navigation = Navigation.fromJson(s);
      navigations.add(navigation);
    }
    return navigations;
  }

  static Navigation fromJson(Map<String, dynamic> json) {
    return Navigation(
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
      tags: json['tags'],
      title: json['title'],
      type: json['type'],
      userId: json['userId'],
      visible: json['visible'],
      zan: json['zan'],
    );
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
