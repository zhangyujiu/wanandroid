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
  static List<Tag> parseTags(List<dynamic> ts) {
    List<Tag> tags = List();
    if(ts!=null){
      for (var t in ts) {
        Tag tag = Tag(name: t["name"], url: t["url"]);
        tags.add(tag);
      }
    }
    return tags;
  }
}