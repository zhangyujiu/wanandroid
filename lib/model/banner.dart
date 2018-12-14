class BannerItem{
  String desc;
  int id;
  String imagePath;
  int isVisible;
  int order;
  String title;
  int type;
  String url;

  BannerItem({
    this.desc,this.id,this.imagePath,this.isVisible,this.order,this.title,this.type,this.url,
  });

  static BannerItem fromJson(Map<String,dynamic> json){
    return BannerItem(
      desc: json['desc'],
      id: json['id'],
      imagePath: json['imagePath'],
      isVisible: json['isVisible'],
      order: json['order'],
      title: json['title'],
      type: json['type'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() => {
    'desc': desc,
    'id': id,
    'imagePath': imagePath,
    'isVisible': isVisible,
    'order': order,
    'title': title,
    'type': type,
    'url': url,
  };
}