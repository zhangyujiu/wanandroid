import 'dart:convert' show json;

class HotWord {
  int id;
  int order;
  int visible;
  String link;
  String name;

  HotWord({
    this.id,
    this.link,
    this.name,
    this.order,
    this.visible,
  });

  static HotWord fromJson(Map<String, dynamic> json) {
    return HotWord(
      id: json['id'],
      link: json['link'],
      name: json['name'],
      order: json['order'],
      visible: json['visible'],
    );
  }

  static List<HotWord> parseList(List<dynamic> list) {
    List<HotWord> hotwords = List();
    for (var s in list) {
      HotWord hotWord = HotWord.fromJson(s);
      hotwords.add(hotWord);
    }
    return hotwords;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'link': link,
        'name': name,
        'order': order,
        'visible': visible,
      };

  @override
  String toString() {
    return '{"id": $id,"order": $order,"visible": $visible,"link": ${link != null ? '${json.encode(link)}' : 'null'},"name": ${name != null ? '${json.encode(name)}' : 'null'}}';
  }
}
